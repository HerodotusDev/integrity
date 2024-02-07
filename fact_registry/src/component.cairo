use cairo_verifier::deserialization::stark::StarkProofWithSerde;

#[starknet::interface]
trait ICairoVerifier<TContractState> {
    fn verify_proof(
        ref self: TContractState, stark_proof: StarkProofWithSerde
    ) -> (felt252, felt252);
}

#[starknet::component]
mod CairoVerifier {
    use cairo_verifier::{
        deserialization::stark::StarkProofWithSerde, stark::{StarkProof, StarkProofImpl}
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

    #[embeddable_as(CairoVerifierImpl)]
    impl CairoVerifier<
        TContractState, +HasComponent<TContractState>
    > of super::ICairoVerifier<ComponentState<TContractState>> {
        fn verify_proof(
            ref self: ComponentState<TContractState>, stark_proof: StarkProofWithSerde
        ) -> (felt252, felt252) {
            let stark_proof: StarkProof = stark_proof.into();
            let (program_hash, output_hash) = stark_proof.verify();
            self.emit(ProofVerified { program_hash, output_hash });
            (program_hash, output_hash)
        }
    }
}
