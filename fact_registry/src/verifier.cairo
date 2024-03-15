use cairo_verifier::stark::StarkProof;

#[starknet::interface]
trait ICairoVerifier<TContractState> {
    fn verify_proof(ref self: TContractState, stark_proof: StarkProof) -> (felt252, felt252);
}

#[starknet::component]
mod CairoVerifier {
    use cairo_verifier::{
        stark::{StarkProof, StarkProofImpl},
        air::layouts::recursive::public_input::RecursivePublicInputImpl,
    };

    #[storage]
    struct Storage {}

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        ProofVerified: ProofVerified,
    }

    #[derive(Drop, starknet::Event)]
    struct ProofVerified {
        #[key]
        program_hash: felt252,
        #[key]
        output_hash: felt252,
    }

    impl CairoVerifierImpl<
        TContractState, +HasComponent<TContractState>
    > of super::ICairoVerifier<ComponentState<TContractState>> {
        fn verify_proof(
            ref self: ComponentState<TContractState>, stark_proof: StarkProof
        ) -> (felt252, felt252) {
            stark_proof.verify(50);
            let (program_hash, output_hash) = stark_proof.public_input.verify();
            self.emit(ProofVerified { program_hash, output_hash });
            (program_hash, output_hash)
        }
    }
}
