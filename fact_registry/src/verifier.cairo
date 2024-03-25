use cairo_verifier::stark::StarkProof;

#[starknet::interface]
trait ICairoVerifier<TContractState> {
    fn verify_proof(ref self: TContractState, stark_proof: StarkProof) -> (felt252, felt252);
}

#[starknet::component]
mod CairoVerifier {
    use cairo_verifier::{PublicInputImpl, stark::{StarkProof, StarkProofImpl}};

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

    const SECURITY_BITS: felt252 = 50;

    impl CairoVerifierImpl<
        TContractState, +HasComponent<TContractState>
    > of super::ICairoVerifier<ComponentState<TContractState>> {
        fn verify_proof(
            ref self: ComponentState<TContractState>, stark_proof: StarkProof
        ) -> (felt252, felt252) {
            stark_proof.verify(SECURITY_BITS);
            let (program_hash, output_hash) = stark_proof.public_input.verify();
            self.emit(ProofVerified { program_hash, output_hash });
            (program_hash, output_hash)
        }
    }
}
