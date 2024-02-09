use cairo_verifier::{
    stark::stark_verify::stark_verify, air::constants::{NUM_COLUMNS_FIRST, NUM_COLUMNS_SECOND},
    tests::stone_proof_fibonacci,
};

fn bench_stark_verify() {
    let queries = stone_proof_fibonacci::queries::get().span();
    let commitment = stone_proof_fibonacci::stark::commitment::get();
    let witness = stone_proof_fibonacci::stark::witness::get();
    let stark_domains = stone_proof_fibonacci::stark::domains::get();

    stark_verify(
        NUM_COLUMNS_FIRST, NUM_COLUMNS_SECOND, queries, commitment, witness, stark_domains,
    )
}
