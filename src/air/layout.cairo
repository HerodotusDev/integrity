#[derive(Drop)]
struct Layout {
    // Virtual functions.
    // Each should be a pointer to a function with the same interface as the function in this file.
    // eval_oods_polynomial: felt*,
    // Constants.
    // n_original_columns: felt252,
    // n_interaction_columns: felt252,
    n_interaction_elements: felt252,
}

#[derive(Drop)]
struct AirInstance {
    // Virtual functions.
    // Each should be a pointer to a function with the same interface as the function in this file.
    // public_input_hash: felt*,
    // public_input_validate: felt*,
    // traces_config_validate: felt*,
    // traces_commit: felt*,
    // traces_decommit: felt*,
    // traces_eval_composition_polynomial: felt*,
    // eval_oods_boundary_poly_at_points: felt*,
    // Constants.
    // n_dynamic_params: felt252,
    n_constraints: felt252,
    constraint_degree: felt252,
    mask_size: felt252,
}

#[derive(Drop)]
struct AirWithLayout {
    air: AirInstance,
    layout: Layout,
}
