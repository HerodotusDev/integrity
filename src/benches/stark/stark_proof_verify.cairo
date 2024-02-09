use cairo_verifier::{stark::{StarkProof, StarkProofTrait}, tests::stone_proof_fibonacci};

fn bench_stark_proof_verify() {
    let stark_proof = StarkProof {
        config: stone_proof_fibonacci::stark::config::get(),
        public_input: stone_proof_fibonacci::public_input::get(),
        unsent_commitment: stone_proof_fibonacci::stark::unsent_commitment::get(),
        witness: stone_proof_fibonacci::stark::witness::get(),
    };

    stark_proof.verify();
}
