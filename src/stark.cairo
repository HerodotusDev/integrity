mod stark_commit;
mod stark_verify;

#[cfg(test)]
mod tests;

use integrity::{
    air::{public_input::{PublicInput, get_public_input_hash},},
    channel::channel::{Channel, ChannelImpl},
    fri::{
        fri_config::{FriConfig, FriConfigTrait},
        fri::{
            FriUnsentCommitment, FriWitness, FriCommitment, FriVerificationStateConstant,
            FriVerificationStateVariable, FriLayerWitness, fri_verify_step, fri_verify_final
        }
    },
    queries::queries, domains::StarkDomainsImpl,
    table_commitment::table_commitment::{
        TableCommitmentConfig, TableCommitmentWitness, TableDecommitment, TableCommitment
    },
    proof_of_work::{
        config::{ProofOfWorkConfig, ProofOfWorkConfigTrait},
        proof_of_work::ProofOfWorkUnsentCommitment
    },
    vector_commitment::vector_commitment::VectorCommitmentConfigTrait, settings::VerifierSettings,
};
use starknet::ContractAddress;
#[cfg(feature: 'dex')]
use integrity::air::layouts::dex::{
    traces::{TracesConfig, TracesConfigTrait}, public_input::DexPublicInputImpl,
    traces::{TracesUnsentCommitment, TracesCommitment, TracesDecommitment, TracesWitness},
    constants::{NUM_COLUMNS_FIRST, NUM_COLUMNS_SECOND}
};
#[cfg(feature: 'recursive')]
use integrity::air::layouts::recursive::{
    traces::{TracesConfig, TracesConfigTrait}, public_input::RecursivePublicInputImpl,
    traces::{TracesUnsentCommitment, TracesCommitment, TracesDecommitment, TracesWitness},
    constants::{NUM_COLUMNS_FIRST, NUM_COLUMNS_SECOND},
};
#[cfg(feature: 'recursive_with_poseidon')]
use integrity::air::layouts::recursive_with_poseidon::{
    traces::{TracesConfig, TracesConfigTrait}, public_input::RecursiveWithPoseidonPublicInputImpl,
    traces::{TracesUnsentCommitment, TracesCommitment, TracesDecommitment, TracesWitness},
    constants::{NUM_COLUMNS_FIRST, NUM_COLUMNS_SECOND}
};
#[cfg(feature: 'small')]
use integrity::air::layouts::small::{
    traces::{TracesConfig, TracesConfigTrait}, public_input::SmallPublicInputImpl,
    traces::{TracesUnsentCommitment, TracesCommitment, TracesDecommitment, TracesWitness},
    constants::{NUM_COLUMNS_FIRST, NUM_COLUMNS_SECOND}
};
#[cfg(feature: 'starknet')]
use integrity::air::layouts::starknet::{
    traces::{TracesConfig, TracesConfigTrait}, public_input::StarknetPublicInputImpl,
    traces::{TracesUnsentCommitment, TracesCommitment, TracesDecommitment, TracesWitness},
    constants::{NUM_COLUMNS_FIRST, NUM_COLUMNS_SECOND}
};
#[cfg(feature: 'starknet_with_keccak')]
use integrity::air::layouts::starknet_with_keccak::{
    traces::{TracesConfig, TracesConfigTrait}, public_input::StarknetWithKeccakPublicInputImpl,
    traces::{TracesUnsentCommitment, TracesCommitment, TracesDecommitment, TracesWitness},
    constants::{NUM_COLUMNS_FIRST, NUM_COLUMNS_SECOND}
};

#[derive(Drop, Serde)]
struct StarkProof {
    config: StarkConfig,
    public_input: PublicInput,
    unsent_commitment: StarkUnsentCommitment,
    witness: StarkWitness,
}

#[generate_trait]
impl StarkProofImpl of StarkProofTrait {
    fn verify_initial(
        self: @StarkProof,
        composition_contract_address: ContractAddress,
        oods_contract_address: ContractAddress,
        settings: @VerifierSettings,
    ) -> (FriVerificationStateConstant, FriVerificationStateVariable, Span<felt252>, u32) {
        // Validate config.
        let security_bits = self.config.validate();

        // Validate the public input.
        let stark_domains = StarkDomainsImpl::new(
            *self.config.log_trace_domain_size, *self.config.log_n_cosets
        );
        self.public_input.validate(@stark_domains);

        // Compute the initial hash seed for the Fiat-Shamir channel.
        let digest = get_public_input_hash(
            self.public_input, *self.config.n_verifier_friendly_commitment_layers, settings
        );

        // Construct the channel.
        let mut channel = ChannelImpl::new(digest);

        // STARK commitment phase.
        let stark_commitment = stark_commit::stark_commit(
            ref channel,
            self.public_input,
            self.unsent_commitment,
            self.config,
            @stark_domains,
            composition_contract_address
        );

        let last_layer_coefficients = stark_commitment.fri.last_layer_coefficients;

        // Generate queries.
        let queries = queries::generate_queries(
            ref channel,
            (*self.config.n_queries).try_into().unwrap(),
            stark_domains.eval_domain_size.try_into().unwrap()
        );

        // STARK verify phase.
        let (con, var) = stark_verify::stark_verify(
            NUM_COLUMNS_FIRST,
            NUM_COLUMNS_SECOND,
            queries.span(),
            stark_commitment,
            *self.witness,
            stark_domains,
            oods_contract_address,
            settings,
        );
        (con, var, last_layer_coefficients, security_bits)
    }

    fn verify_step(
        stateConstant: FriVerificationStateConstant,
        stateVariable: FriVerificationStateVariable,
        witness: FriLayerWitness,
        settings: @VerifierSettings,
    ) -> (FriVerificationStateConstant, FriVerificationStateVariable) {
        fri_verify_step(stateConstant, stateVariable, witness, settings)
    }

    fn verify_final(
        stateConstant: FriVerificationStateConstant,
        stateVariable: FriVerificationStateVariable,
        last_layer_coefficients: Span<felt252>,
    ) -> (FriVerificationStateConstant, FriVerificationStateVariable) {
        fri_verify_final(stateConstant, stateVariable, last_layer_coefficients)
    }

    fn verify(
        self: @StarkProof,
        composition_contract_address: ContractAddress,
        oods_contract_address: ContractAddress,
        settings: @VerifierSettings,
    ) -> u32 {
        let (mut con, mut var, last_layer_coefficients, security_bits) = self
            .verify_initial(composition_contract_address, oods_contract_address, settings);

        let n = con.n_layers;
        let mut i = 0;
        loop {
            if i == n {
                break;
            }

            let (new_con, new_var) = Self::verify_step(
                con, var, *(*self.witness.fri_witness.layers).at(i), settings
            );
            var = new_var;
            con = new_con;

            i += 1;
        };

        let (_, new_var) = Self::verify_final(con, var, last_layer_coefficients);
        assert(new_var.iter.into() == n + 1, 'Verification not finalized');
        security_bits
    }
}

#[derive(Drop, Copy, Serde)]
struct StarkConfig {
    traces: TracesConfig,
    composition: TableCommitmentConfig,
    fri: FriConfig,
    proof_of_work: ProofOfWorkConfig,
    // Log2 of the trace domain size.
    log_trace_domain_size: felt252,
    // Number of queries to the last component, FRI.
    n_queries: felt252,
    // Log2 of the number of cosets composing the evaluation domain, where the coset size is the
    // trace length.
    log_n_cosets: felt252,
    // Number of layers that use a verifier friendly hash in each commitment.
    n_verifier_friendly_commitment_layers: felt252,
}

#[generate_trait]
impl StarkConfigImpl of StarkConfigTrait {
    fn validate(self: @StarkConfig) -> u32 {
        // Validate Proof of work config.
        self.proof_of_work.validate();

        // Validate traces config.
        let log_eval_domain_size = *self.log_trace_domain_size + *self.log_n_cosets;
        self.traces.validate(log_eval_domain_size, *self.n_verifier_friendly_commitment_layers);

        // Validate composition config.
        self
            .composition
            .vector
            .validate(log_eval_domain_size, *self.n_verifier_friendly_commitment_layers);

        // Validate Fri config.
        self.fri.validate(*self.log_n_cosets, *self.n_verifier_friendly_commitment_layers);

        // Security bits.
        let n_queries: u32 = (*self.n_queries).try_into().unwrap();
        let log_n_cosets: u32 = (*self.log_n_cosets).try_into().unwrap();
        let proof_of_work_bits: u32 = (*self.proof_of_work.n_bits).try_into().unwrap();

        n_queries * log_n_cosets + proof_of_work_bits
    }
}

// Protocol components:
// ======================
// The verifier is built from protocol components. Each component is responsible for commitment
// and decommitment phase. The decommitment part can be regarded as proving a statement with certain
// parameters that are known only after the commitment phase. The XDecommitment struct holds these
// parameters.
// The XWitness struct is the witness required to prove this statement.
//
// For example, VectorDecommitment holds some indices to the committed vector and the corresponding
// values.
// The VectorWitness struct has the authentication paths of the merkle tree, required to prove the
// validity of the values.
//
// The Stark protocol itself is a component, with the statement having no parameters known only
// after the commitment phase, and thus, there is no StarkDecommitment.
//
// The interface of a component named X is:
//
// Structs:
// * XConfig: Configuration for the component.
// * XUnsentCommitment: Commitment values (e.g. hashes), before sending in the channel.
//     Those values shouldn't be used directly (only by the channel).
//     Used by x_commit() to generate a commitment XCommitment.
// * XCommitment: Represents the commitment after it is read from the channel.
// * XDecommitment: Responses for queries.
// * XWitness: Auxiliary information for proving the decommitment.
//
// Functions:
// * x_commit() - The commitment phase. Takes XUnsentCommitment and returns XCommitment.
// * x_decommit() - The decommitment phase. Verifies a decommitment. Uses the commitment and the
//     witness.

// n_oods_values := air.mask_size + air.constraint_degree.

#[derive(Drop, Serde)]
struct StarkUnsentCommitment {
    traces: TracesUnsentCommitment,
    composition: felt252,
    // n_oods_values elements. The i-th value is the evaluation of the i-th mask item polynomial at
    // the OODS point, where the mask item polynomial is the interpolation polynomial of the
    // corresponding column shifted by the corresponding row_offset.
    oods_values: Span<felt252>,
    fri: FriUnsentCommitment,
    proof_of_work: ProofOfWorkUnsentCommitment,
}

#[derive(Drop, PartialEq, Serde)]
struct StarkCommitment {
    traces: TracesCommitment,
    composition: TableCommitment,
    interaction_after_composition: felt252,
    oods_values: Span<felt252>,
    interaction_after_oods: Span<felt252>,
    fri: FriCommitment,
}

#[derive(Drop, Copy, Serde)]
struct StarkWitness {
    traces_decommitment: TracesDecommitment,
    traces_witness: TracesWitness,
    composition_decommitment: TableDecommitment,
    composition_witness: TableCommitmentWitness,
    fri_witness: FriWitness,
}
