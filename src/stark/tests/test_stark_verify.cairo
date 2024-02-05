use cairo_verifier::{
    stark::stark_verify::stark_verify, air::constants::{NUM_COLUMNS_FIRST, NUM_COLUMNS_SECOND},
    tests::stone_proof_fibonacci_keccak,
};

// test data from cairo0-verifier keccak-native run on stone-prover generated proof
#[test]
#[available_gas(9999999999)]
fn test_stark_verify() {
    let queries = stone_proof_fibonacci_keccak::queries::get().span();
    let commitment = stone_proof_fibonacci_keccak::stark::commitment::get();
    let witness = stone_proof_fibonacci_keccak::stark::witness::get();
    let stark_domains = stone_proof_fibonacci_keccak::stark::domains::get();

    stark_verify(
        NUM_COLUMNS_FIRST, NUM_COLUMNS_SECOND, queries, commitment, witness, stark_domains,
    )
}
