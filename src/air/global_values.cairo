#[derive(Drop, Copy)]
struct EcPoint {
    x: felt252,
    y: felt252,
}

// Accumulation of member expressions for auto generated composition polynomial code.
#[derive(Drop, Copy)]
struct GlobalValues {
    // Public input.
    trace_length: felt252,
    initial_pc: felt252,
    final_pc: felt252,
    initial_ap: felt252,
    final_ap: felt252,
    initial_pedersen_addr: felt252,
    initial_range_check_addr: felt252,
    initial_bitwise_addr: felt252,
    range_check_min: felt252,
    range_check_max: felt252,
    // Constants.
    offset_size: felt252,
    half_offset_size: felt252,
    pedersen_shift_point: EcPoint,
    // Periodic columns.
    pedersen_points_x: felt252,
    pedersen_points_y: felt252,
    // Interaction elements.
    memory_multi_column_perm_perm_interaction_elm: felt252,
    memory_multi_column_perm_hash_interaction_elm0: felt252,
    range_check16_perm_interaction_elm: felt252,
    diluted_check_permutation_interaction_elm: felt252,
    diluted_check_interaction_z: felt252,
    diluted_check_interaction_alpha: felt252,
    // Permutation products.
    memory_multi_column_perm_perm_public_memory_prod: felt252,
    range_check16_perm_public_memory_prod: felt252,
    diluted_check_first_elm: felt252,
    diluted_check_permutation_public_memory_prod: felt252,
    diluted_check_final_cum_val: felt252
}

// Elements that are sent from the prover after the commitment on the original trace.
// Used for components after the first interaction, e.g., memory and range check.
#[derive(Drop, Copy, PartialEq)]
struct InteractionElements {
    memory_multi_column_perm_perm_interaction_elm: felt252,
    memory_multi_column_perm_hash_interaction_elm0: felt252,
    range_check16_perm_interaction_elm: felt252,
    diluted_check_permutation_interaction_elm: felt252,
    diluted_check_interaction_z: felt252,
    diluted_check_interaction_alpha: felt252
}
