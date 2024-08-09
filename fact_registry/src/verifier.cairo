use cairo_verifier::{StarkProof, CairoVersion, fri::fri::{FriLayerWitness, FriVerificationStateConstant, FriVerificationStateVariable}};

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
    // fn verify_proof(
    //     ref self: TContractState, stark_proof: StarkProof, cairo_version: CairoVersion
    // ) -> (felt252, felt252);

    fn verify_proof_initial(
        ref self: TContractState,
        stark_proof: StarkProof,
        cairo_version: CairoVersion,
    ) -> InitResult;

    fn verify_proof_step(
        ref self: TContractState,
        fact: felt252,
        state_constant: FriVerificationStateConstant,
        state_variable: FriVerificationStateVariable,
        witness: FriLayerWitness,
    ) -> (FriVerificationStateVariable, u32);

    fn verify_proof_final(
        ref self: TContractState,
        fact: felt252,
        state_constant: FriVerificationStateConstant,
        state_variable: FriVerificationStateVariable,
        last_layer_coefficients: Span<felt252>,   
    );
}

#[starknet::component]
mod CairoVerifier {
    use cairo_verifier::{
        CairoVersion, PublicInputImpl,
        stark::{StarkProof, StarkProofImpl},
        fri::fri::{FriLayerWitness, FriVerificationStateConstant, FriVerificationStateVariable, hash_constant, hash_variable},
    };
    use core::poseidon::{Poseidon, PoseidonImpl, HashStateImpl};
    use super::InitResult;

    #[storage]
    struct Storage {
        state_constant: LegacyMap<felt252, Option<felt252>>,
        state_variable: LegacyMap<felt252, Option<felt252>>,
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        ProofVerified: ProofVerified,
    }

    #[derive(Drop, starknet::Event)]
    struct ProofVerified {
        // #[key]
        // program_hash: felt252,
        // #[key]
        // output_hash: felt252,
        #[key]
        fact: felt252,
    }

    const SECURITY_BITS: felt252 = 50;

    impl CairoVerifierImpl<
        TContractState, +HasComponent<TContractState>
    > of super::ICairoVerifier<ComponentState<TContractState>> {
        fn verify_proof_initial(
            ref self: ComponentState<TContractState>,
            stark_proof: StarkProof,
            cairo_version: CairoVersion,
        ) -> InitResult {
            let (program_hash, output_hash) = match cairo_version {
                CairoVersion::Cairo0 => stark_proof.public_input.verify_cairo0(),
                CairoVersion::Cairo1 => stark_proof.public_input.verify_cairo1(),
            };
            let fact = PoseidonImpl::new().update(program_hash).update(output_hash).finalize();

            let (con, var, last_layer_coefficients) = stark_proof.verify_initial(SECURITY_BITS);
            self.state_constant.write(fact, Option::Some(hash_constant(@con)));
            self.state_variable.write(fact, Option::Some(hash_variable(@var)));

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
            ref self: ComponentState<TContractState>,
            fact: felt252,
            state_constant: FriVerificationStateConstant,
            state_variable: FriVerificationStateVariable,
            witness: FriLayerWitness,
        ) -> (FriVerificationStateVariable, u32) {
            assert(hash_constant(@state_constant) == self.state_constant.read(fact).unwrap(), 'Invalid state (constant)');
            assert(hash_variable(@state_variable) == self.state_variable.read(fact).unwrap(), 'Invalid state (variable)');

            let (con, var) = StarkProofImpl::verify_step(state_constant, state_variable, witness);
            self.state_variable.write(fact, Option::Some(hash_variable(@var)));

            let layers_left = con.n_layers - var.iter;

            (var, layers_left)
        }

        fn verify_proof_final(
            ref self: ComponentState<TContractState>,
            fact: felt252,
            state_constant: FriVerificationStateConstant,
            state_variable: FriVerificationStateVariable,
            last_layer_coefficients: Span<felt252>,   
        ) {
            assert(hash_constant(@state_constant) == self.state_constant.read(fact).unwrap(), 'Invalid state (constant)');
            assert(hash_variable(@state_variable) == self.state_variable.read(fact).unwrap(), 'Invalid state (variable)');

            let (new_con, new_var) = StarkProofImpl::verify_final(state_constant, state_variable, last_layer_coefficients);
            assert(new_var.iter.into() == new_con.n_layers + 1, 'Verification not finalized');

            self.state_variable.write(fact, Option::None);
            self.state_constant.write(fact, Option::None);

            self.emit(ProofVerified { fact });
        }
    }
}
