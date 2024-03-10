trait AIRComposition<IE, PI> {
    fn eval_composition_polynomial(
        interaction_elements: IE,
        public_input: @PI,
        mask_values: Span<felt252>,
        constraint_coefficients: Span<felt252>,
        point: felt252,
        trace_domain_size: felt252,
        trace_generator: felt252
    ) -> felt252;
}

trait AIROods {
    fn eval_oods_polynomial(
        column_values: Span<felt252>,
        oods_values: Span<felt252>,
        constraint_coefficients: Span<felt252>,
        point: felt252,
        oods_point: felt252,
        trace_generator: felt252,
    ) -> felt252;
}
