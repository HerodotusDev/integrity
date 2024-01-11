use core::array::ArrayTrait;
use cairo_verifier::common::array_extend::ArrayExtendTrait;
use core::array::SpanTrait;
use cairo_verifier::air::composition::{eval_composition_polynomial, eval_oods_polynomial};
use cairo_verifier::air::global_values::InteractionElements;
use cairo_verifier::air::public_input::PublicInput;
use cairo_verifier::air::traces::TracesDecommitment;
use cairo_verifier::table_commitment::TableDecommitment;
use cairo_verifier::air::constants::CONSTRAINT_DEGREE;

#[derive(Drop)]
struct OodsValues {
    mask_values: Array<felt252>,
    split_polynomials: Array<felt252>
}

#[derive(Drop)]
struct OodsEvaluationInfo {
    oods_values: Span<felt252>,
    oods_point: felt252,
    trace_generator: felt252,
    constraint_coefficients: Span<felt252>,
}

fn verify_oods(
    oods: OodsValues,
    interaction_elements: InteractionElements,
    public_input: PublicInput,
    constraint_coefficients: Array<felt252>,
    oods_point: felt252,
    trace_domain_size: felt252,
    trace_generator: felt252
) {
    let composition_from_trace = eval_composition_polynomial(
        interaction_elements,
        public_input,
        oods.mask_values,
        constraint_coefficients,
        oods_point,
        trace_domain_size,
        trace_generator
    );

    // TODO support degree > 2?
    let claimed_composition = *oods.split_polynomials.at(0)
        + *oods.split_polynomials.at(1) * oods_point;

    assert(composition_from_trace == claimed_composition, 'Invalid OODS');
}

fn eval_oods_boundary_poly_at_points(
    n_original_columns: u32,
    n_interaction_columns: u32,
    eval_info: OodsEvaluationInfo,
    points: Span<felt252>,
    decommitment: TracesDecommitment,
    composition_decommitment: TableDecommitment,
) -> Array<felt252> {
    assert(n_original_columns == decommitment.original.values.len(), 'Invalid value');
    assert(
        decommitment.interaction.values.len() == points.len() * n_interaction_columns,
        'Invalid value'
    );
    assert(
        composition_decommitment.values.len() == points.len() * CONSTRAINT_DEGREE, 'Invalid value'
    );

    let mut evaluations = ArrayTrait::<felt252>::new();

    let mut i: u32 = 0;
    loop {
        if i == points.len() {
            break;
        }

        let mut column_values = ArrayTrait::<felt252>::new();

        column_values
            .extend(
                decommitment
                    .original
                    .values
                    .slice(i * n_original_columns, (i + 1) * n_original_columns)
            );
        column_values
            .extend(
                decommitment
                    .interaction
                    .values
                    .slice(i * n_interaction_columns, (i + 1) * n_interaction_columns)
            );
        column_values
            .extend(
                composition_decommitment
                    .values
                    .slice(i * CONSTRAINT_DEGREE, (i + 1) * CONSTRAINT_DEGREE)
            );

        evaluations
            .append(
                eval_oods_polynomial(
                    column_values.span(),
                    eval_info.oods_values,
                    eval_info.constraint_coefficients,
                    *points.at(i),
                    eval_info.oods_point,
                    eval_info.trace_generator,
                )
            );

        i += 1;
    };

    evaluations
}
