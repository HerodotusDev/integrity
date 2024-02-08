use cairo_verifier::{
    table_commitment::table_commitment::table_decommit, tests::stone_proof_fibonacci_keccak
};

// test data from cairo0-verifier keccak-native run on stone-prover generated proof
#[test]
#[available_gas(9999999999)]
fn test_table_commitment_decommit() {
    let commitment = stone_proof_fibonacci_keccak::traces::commitment::get().original;
    let queries = stone_proof_fibonacci_keccak::queries::get().span();
    let decommitment = stone_proof_fibonacci_keccak::traces::decommitment::get().original;
    let witness = stone_proof_fibonacci_keccak::traces::witness::get().original;

    table_decommit(commitment, queries, decommitment, witness);
}
