trait Layout<T> {
    fn prepare_evaluation(
        trace_domain_size: felt252,
        interaction_elements: Array<felt252>
    ) -> T;

    fn eval_composition_polynomial(
        self: @T,
        mask_values: Array<felt252>,
        constraint_coefficients: Array<felt252>,
        point: felt252,
        trace_generator: felt252,
    ) -> felt252;
}
