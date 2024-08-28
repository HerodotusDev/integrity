use cairo_verifier::{
    stark::stark_verify::stark_verify,
    air::layouts::recursive::constants::{NUM_COLUMNS_FIRST, NUM_COLUMNS_SECOND},
    tests::stone_proof_fibonacci_keccak,
};

fn bench_stark_verify() {
    let public_input = stone_proof_fibonacci_keccak::public_input::get();
    let queries = stone_proof_fibonacci_keccak::queries::get().span();
    let commitment = stone_proof_fibonacci_keccak::stark::commitment::get();
    let witness = stone_proof_fibonacci_keccak::stark::witness::get();
    let stark_domains = stone_proof_fibonacci_keccak::stark::domains::get();

    stark_verify(
        NUM_COLUMNS_FIRST,
        NUM_COLUMNS_SECOND,
        @public_input,
        queries,
        commitment,
        witness,
        stark_domains,
    )
}
