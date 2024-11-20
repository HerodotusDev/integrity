use integrity::{
    fri::fri::fri_verify_initial, tests::{stone_proof_fibonacci, stone_proof_fibonacci_keccak}
};

#[cfg(feature: 'blake2s')]
#[test]
#[available_gas(9999999999)]
fn test_fri_verify() {
    let queries = stone_proof_fibonacci::queries::get().span();
    let commitment = stone_proof_fibonacci::fri::commitment::get();
    let decommitment = stone_proof_fibonacci::fri::decommitment::get();
    let _witness = stone_proof_fibonacci::fri::witness::get();

    fri_verify_initial(queries, commitment, decommitment);
    // TODO: next steps
}

#[cfg(feature: 'keccak')]
#[test]
#[available_gas(9999999999)]
fn test_fri_verify() {
    let queries = stone_proof_fibonacci_keccak::queries::get().span();
    let commitment = stone_proof_fibonacci_keccak::fri::commitment::get();
    let decommitment = stone_proof_fibonacci_keccak::fri::decommitment::get();
    let _witness = stone_proof_fibonacci_keccak::fri::witness::get();

    fri_verify_initial(queries, commitment, decommitment);
    // TODO: next steps
}
