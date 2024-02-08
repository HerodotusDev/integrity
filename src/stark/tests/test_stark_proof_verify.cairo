use cairo_verifier::{stark::{StarkProof, StarkProofTrait}, tests::stone_proof_fibonacci,};

// test data from cairo0-verifier run on stone-prover generated proof
#[test]
#[available_gas(99999999999)]
fn test_stark_proof_fibonacci_verify() {
    let stark_proof = StarkProof {
        config: stone_proof_fibonacci::stark::config::get(),
        public_input: stone_proof_fibonacci::public_input::get(),
        unsent_commitment: stone_proof_fibonacci::stark::unsent_commitment::get(),
        witness: stone_proof_fibonacci::stark::witness::get(),
    };

    stark_proof.verify();
}
