use cairo_verifier::{
    domains::StarkDomains,
    air::layouts::dynamic::{
        global_values::GlobalValues, constants::{CONSTRAINT_DEGREE, MASK_SIZE, DynamicParams}
    },
    common::math::{Felt252Div, pow},
};

fn eval_composition_polynomial_inner(
    mut mask_values: Span<felt252>,
    mut constraint_coefficients: Span<felt252>,
    point: felt252,
    trace_generator: felt252,
    global_values: GlobalValues
) -> felt252 { // TODO REWRITE
    0
}

fn eval_oods_polynomial_inner(
    mut column_values: Span<felt252>,
    mut oods_values: Span<felt252>,
    mut constraint_coefficients: Span<felt252>,
    point: felt252,
    oods_point: felt252,
    trace_generator: felt252,
) -> felt252 { // TODO REWRITE
    0
}

fn check_asserts(dynamic_params: @DynamicParams, stark_domains: @StarkDomains) {}
