use integrity::{
    queries::queries::queries_to_points, domains::StarkDomains,
    fri::fri::{
        FriDecommitment, fri_verify_initial, FriVerificationStateConstant,
        FriVerificationStateVariable
    },
    stark::{StarkUnsentCommitment, StarkWitness, StarkCommitment},
    table_commitment::table_commitment::table_decommit,
    oods::{OodsEvaluationInfo, eval_oods_boundary_poly_at_points}, settings::VerifierSettings,
};
use starknet::ContractAddress;
#[cfg(feature: 'dex')]
use integrity::air::layouts::dex::traces::traces_decommit;
#[cfg(feature: 'recursive')]
use integrity::air::layouts::recursive::traces::traces_decommit;
#[cfg(feature: 'recursive_with_poseidon')]
use integrity::air::layouts::recursive_with_poseidon::traces::traces_decommit;
#[cfg(feature: 'small')]
use integrity::air::layouts::small::traces::traces_decommit;
#[cfg(feature: 'starknet')]
use integrity::air::layouts::starknet::traces::traces_decommit;
#[cfg(feature: 'starknet_with_keccak')]
use integrity::air::layouts::starknet_with_keccak::traces::traces_decommit;

// STARK verify phase.
// NOTICE: when using splitted verifier, witness.fri_witness may be ommited (empty array)
fn stark_verify(
    n_original_columns: u32,
    n_interaction_columns: u32,
    queries: Span<felt252>,
    commitment: StarkCommitment,
    witness: StarkWitness,
    stark_domains: StarkDomains,
    contract_address_2: ContractAddress,
    settings: @VerifierSettings,
) -> (FriVerificationStateConstant, FriVerificationStateVariable) {
    // First layer decommit.
    traces_decommit(
        queries, commitment.traces, witness.traces_decommitment, witness.traces_witness, settings,
    );

    table_decommit(
        commitment.composition,
        queries,
        witness.composition_decommitment,
        witness.composition_witness,
        settings,
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
        n_original_columns,
        n_interaction_columns,
        eval_info,
        points.span(),
        witness.traces_decommitment,
        witness.composition_decommitment,
        contract_address_2,
    );

    // Decommit FRI.
    let fri_decommitment = FriDecommitment {
        values: oods_poly_evals.span(), points: points.span(),
    };
    fri_verify_initial(
        queries: queries, commitment: commitment.fri, decommitment: fri_decommitment,
    )
}
