use cairo_verifier::queries::queries::queries_to_points;
use cairo_verifier::domains::StarkDomains;
use cairo_verifier::fri::fri::{FriDecommitment, fri_verify};
use cairo_verifier::stark::{StarkUnsentCommitment, StarkWitness, StarkCommitment};

// STARK decommitment phase.
fn stark_verify(
    queries: Span<felt252>,
    commitment: StarkCommitment,
    witness: StarkWitness,
    stark_domains: StarkDomains,
) {
    // First layer decommit.

    // Compute query points.
    let points = queries_to_points(queries, @stark_domains);

    // Evaluate the FRI input layer at query points.
    let eval_info = 0;
    let oods_poly_evals = ArrayTrait::<felt252>::new();

    // Decommit FRI.
    let fri_decommitment = FriDecommitment {
        values: oods_poly_evals.span(), points: points.span(),
    };
    fri_verify(
        queries: queries,
        commitment: commitment.fri,
        decommitment: fri_decommitment,
        witness: witness.fri_witness,
    )
}
