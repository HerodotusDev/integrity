use cairo_verifier::{
    air::public_input::PublicInput, queries::queries::queries_to_points, domains::StarkDomains,
    fri::fri::{FriDecommitment, fri_verify},
    stark::{StarkUnsentCommitment, StarkWitness, StarkCommitment},
    // === DEX BEGIN ===
    // air::layouts::dex::traces::traces_decommit, // === DEX END ===
    // === RECURSIVE BEGIN ===
    air::layouts::recursive::traces::traces_decommit,
    // === RECURSIVE END ===
    // === RECURSIVE_WITH_POSEIDON BEGIN ===
    // air::layouts::recursive_with_poseidon::traces::traces_decommit,
    // === RECURSIVE_WITH_POSEIDON END ===
    // === SMALL BEGIN ===
    // air::layouts::small::traces::traces_decommit,
    // === SMALL END ===
    // === STARKNET BEGIN ===
    // air::layouts::starknet::traces::traces_decommit,
    // === STARKNET END ===
    // === STARKNET_WITH_KECCAK BEGIN ===
    // air::layouts::starknet_with_keccak::traces::traces_decommit,
    // === STARKNET_WITH_KECCAK END ===
    // === DYNAMIC BEGIN ===
    // air::layouts::dynamic::traces::traces_decommit,
    // === DYNAMIC END ===
    table_commitment::table_commitment::table_decommit,
    oods::{OodsEvaluationInfo, eval_oods_boundary_poly_at_points},
};

// STARK verify phase.
fn stark_verify(
    public_input: @PublicInput,
    queries: Span<felt252>,
    commitment: StarkCommitment,
    witness: StarkWitness,
    stark_domains: StarkDomains,
) {
    // First layer decommit.
    traces_decommit(
        queries, commitment.traces, witness.traces_decommitment, witness.traces_witness
    );

    table_decommit(
        commitment.composition,
        queries,
        witness.composition_decommitment,
        witness.composition_witness,
    );

    // Compute query points.
    let points = queries_to_points(queries, @stark_domains);

    // Evaluate the FRI input layer at query points.
    let eval_info = OodsEvaluationInfo {
        oods_values: commitment.oods_values,
        oods_point: commitment.interaction_after_composition,
        trace_generator: stark_domains.trace_generator,
        constraint_coefficients: commitment.interaction_after_oods,
    };
    let oods_poly_evals = eval_oods_boundary_poly_at_points(
        public_input,
        eval_info,
        points.span(),
        witness.traces_decommitment,
        witness.composition_decommitment,
    );

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
