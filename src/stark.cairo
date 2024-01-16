use cairo_verifier::air::public_input::PublicInputTrait;
use cairo_verifier::{
    air::{
        traces_config::{TracesConfig, TracesConfigTrait}, public_input::PublicInput,
        traces::{TracesUnsentCommitment, TracesCommitment, TracesDecommitment, TracesWitness}
    },
    channel::channel::{Channel, ChannelImpl},
    fri::{
        fri_config::{FriConfig, FriConfigTrait},
        fri::{FriUnsentCommitment, FriWitness, FriCommitment}
    },
    domains::StarkDomainsImpl,
    table_commitment::table_commitment::{
        TableCommitmentConfig, TableCommitmentWitness, TableDecommitment, TableCommitment
    },
    proof_of_work::{
        config::{ProofOfWorkConfig, ProofOfWorkConfigTrait},
        proof_of_work::ProofOfWorkUnsentCommitment
    },
    vector_commitment::vector_commitment::VectorCommitmentConfigTrait,
};

mod stark_commit;
mod stark_verify;

#[cfg(test)]
mod tests;

const SECURITY_BITS: felt252 = 9;


#[derive(Drop)]
struct StarkProof {
    config: StarkConfig,
    public_input: PublicInput,
    unsent_commitment: StarkUnsentCommitment,
    witness: StarkWitness,
}

#[generate_trait]
impl StarkProofImpl of StarkProofTrait {
    fn verify(self: @StarkProof) {
        self.config.validate(SECURITY_BITS);
        let stark_domains = StarkDomainsImpl::new(self.config);

        let digest = self.public_input.get_public_input_hash();
        let mut channel = ChannelImpl::new(digest);

        stark_commit::stark_commit(
            ref channel, self.public_input, self.unsent_commitment, self.config, @stark_domains,
        );
    }
}

#[derive(Drop, Copy)]
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
    fn validate(self: @StarkConfig, security_bits: felt252) {
        self.proof_of_work.config_validate();

        let log_eval_domain_size = *self.log_trace_domain_size + *self.log_n_cosets;
        self.traces.validate(log_eval_domain_size, security_bits);

        self
            .composition
            .vector
            .validate(log_eval_domain_size, *self.n_verifier_friendly_commitment_layers);

        self.fri.validate(*self.log_n_cosets, *self.n_verifier_friendly_commitment_layers);
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

#[derive(Drop)]
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

#[derive(Drop)]
struct StarkCommitment {
    traces: TracesCommitment,
    composition: TableCommitment,
    interaction_after_composition: felt252,
    oods_values: Span<felt252>,
    interaction_after_oods: Span<felt252>,
    fri: FriCommitment,
}

#[derive(Drop, Copy)]
struct StarkWitness {
    traces_decommitment: TracesDecommitment,
    traces_witness: TracesWitness,
    composition_decommitment: TableDecommitment,
    composition_witness: TableCommitmentWitness,
    fri_witness: FriWitness,
}
