use cairo_verifier::deserialization::stark::StarkProofWithSerde;

#[starknet::interface]
trait ICairoVerifier<TContractState> {
    fn verify_proof(self: @TContractState, stark_proof: StarkProofWithSerde) -> (u256, u256);
}

#[starknet::component]
mod CairoVerifier {
    use cairo_verifier::{
        deserialization::stark::StarkProofWithSerde, stark::{StarkProof, StarkProofImpl}
    };

    #[storage]
    struct Storage {}

    #[embeddable_as(CairoVerifierImpl)]
    impl CairoVerifier<
        TContractState, +HasComponent<TContractState>
    > of super::ICairoVerifier<ComponentState<TContractState>> {
        fn verify_proof(
            self: @ComponentState<TContractState>, stark_proof: StarkProofWithSerde
        ) -> (u256, u256) {
            let stark_proof: StarkProof = stark_proof.into();
            stark_proof.verify()
        }
    }
}
