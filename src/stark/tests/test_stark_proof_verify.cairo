use cairo_verifier::{stark::{StarkProof, StarkProofTrait}, tests::stone_proof_fibonacci_keccak};

// test data from cairo0-verifier keccak-native run on stone-prover generated proof
#[test]
#[available_gas(9999999999)]
fn test_stark_proof_fibonacci_verify() {
    let stark_proof = StarkProof {
        config: stone_proof_fibonacci_keccak::stark::config::get(),
        public_input: stone_proof_fibonacci_keccak::public_input::get(),
        unsent_commitment: stone_proof_fibonacci_keccak::stark::unsent_commitment::get(),
        witness: stone_proof_fibonacci_keccak::stark::witness::get(),
    };

    stark_proof.verify();
}
