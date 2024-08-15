use cairo_verifier::{StarkProof, CairoVersion, StarkProofWithSerde, fri::fri::{FriLayerWitness, FriVerificationStateConstant, FriVerificationStateVariable}};

#[derive(Drop, Serde)]
struct InitResult {
    program_hash: felt252,
    output_hash: felt252,
    fact: felt252,
    last_layer_coefficients: Span<felt252>,
    state_constant: FriVerificationStateConstant,
    state_variable: FriVerificationStateVariable,
    layers_left: u32,
}

#[starknet::interface]
trait ICairoVerifier<TContractState> {
    fn verify_proof_initial(
        ref self: TContractState,
        job_id: felt252,
        stark_proof_serde: StarkProofWithSerde,
        cairo_version: CairoVersion,
    ) -> InitResult;

    fn verify_proof_step(
        ref self: TContractState,
        job_id: felt252,
        state_constant: FriVerificationStateConstant,
        state_variable: FriVerificationStateVariable,
        witness: FriLayerWitness,
    ) -> (FriVerificationStateVariable, u32);

    fn verify_proof_final(
        ref self: TContractState,
        job_id: felt252,
        state_constant: FriVerificationStateConstant,
        state_variable: FriVerificationStateVariable,
        last_layer_coefficients: Span<felt252>,   
    );
}

#[starknet::contract]
mod CairoVerifier {
    use starknet::ContractAddress;
    use cairo_verifier::{
        CairoVersion, PublicInputImpl, StarkProofWithSerde,
        stark::{StarkProof, StarkProofImpl},
        fri::fri::{FriLayerWitness, FriVerificationStateConstant, FriVerificationStateVariable, hash_constant, hash_variable},
    };
    use core::poseidon::{Poseidon, PoseidonImpl, HashStateImpl};
    use super::{InitResult, ICairoVerifier};

    #[storage]
    struct Storage {
        contract_address_1: ContractAddress,
        contract_address_2: ContractAddress,

        state_constant: LegacyMap<felt252, Option<felt252>>, // job_id => hash(constant state)
        state_variable: LegacyMap<felt252, Option<felt252>>, // job_id => hash(variable state)
        state_fact: LegacyMap<felt252, Option<felt252>>,     // job_id => fact_hash
    }

    #[constructor]
    fn constructor(ref self: ContractState, contract_address_1: ContractAddress, contract_address_2: ContractAddress) {
        self.contract_address_1.write(contract_address_1);
        self.contract_address_2.write(contract_address_2);
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        ProofVerified: ProofVerified,
    }

    #[derive(Drop, starknet::Event)]
    struct ProofVerified {
        #[key]
        job_id: felt252,
        #[key]
        fact: felt252,
    }

    const SECURITY_BITS: felt252 = 50;

    #[abi(embed_v0)]
    impl CairoVerifier of ICairoVerifier<ContractState> {
        fn verify_proof_initial(
            ref self: ContractState,
            job_id: felt252,
            stark_proof_serde: StarkProofWithSerde,
            cairo_version: CairoVersion,
        ) -> InitResult {
            assert(self.state_constant.read(job_id).is_none(), 'job_id already exists');

            let stark_proof: StarkProof = stark_proof_serde.into();
            let (program_hash, output_hash) = match cairo_version {
                CairoVersion::Cairo0 => stark_proof.public_input.verify_cairo0(),
                CairoVersion::Cairo1 => stark_proof.public_input.verify_cairo1(),
            };

            let fact = PoseidonImpl::new().update(program_hash).update(output_hash).finalize();

            let (con, var, last_layer_coefficients) = stark_proof.verify_initial(
                SECURITY_BITS, self.contract_address_1.read(), self.contract_address_2.read()
            );
            self.state_constant.write(job_id, Option::Some(hash_constant(@con)));
            self.state_variable.write(job_id, Option::Some(hash_variable(@var)));
            self.state_fact.write(job_id, Option::Some(fact));

            let layers_left = con.n_layers - var.iter;

            InitResult {
                program_hash,
                output_hash,
                fact,
                last_layer_coefficients,
                state_constant: con,
                state_variable: var,
                layers_left,
            }
        }

        fn verify_proof_step(
            ref self: ContractState,
            job_id: felt252,
            state_constant: FriVerificationStateConstant,
            state_variable: FriVerificationStateVariable,
            witness: FriLayerWitness,
        ) -> (FriVerificationStateVariable, u32) {
            assert(hash_constant(@state_constant) == self.state_constant.read(job_id).expect('No state (constant) saved'), 'Invalid state (constant)');
            assert(hash_variable(@state_variable) == self.state_variable.read(job_id).expect('No state (variable) saved'), 'Invalid state (variable)');

            let (con, var) = StarkProofImpl::verify_step(state_constant, state_variable, witness);
            self.state_variable.write(job_id, Option::Some(hash_variable(@var)));

            let layers_left = con.n_layers - var.iter;

            (var, layers_left)
        }

        fn verify_proof_final(
            ref self: ContractState,
            job_id: felt252,
            state_constant: FriVerificationStateConstant,
            state_variable: FriVerificationStateVariable,
            last_layer_coefficients: Span<felt252>,
        ) {
            assert(hash_constant(@state_constant) == self.state_constant.read(job_id).unwrap(), 'Invalid state (constant)');
            assert(hash_variable(@state_variable) == self.state_variable.read(job_id).unwrap(), 'Invalid state (variable)');
            let fact = self.state_fact.read(job_id).expect('No fact saved');

            let (new_con, new_var) = StarkProofImpl::verify_final(state_constant, state_variable, last_layer_coefficients);
            assert(new_var.iter.into() == new_con.n_layers + 1, 'Verification not finalized');

            self.state_variable.write(job_id, Option::None);
            self.state_constant.write(job_id, Option::None);
            self.state_fact.write(job_id, Option::None);

            self.emit(ProofVerified { job_id, fact });
        }
    }
}
