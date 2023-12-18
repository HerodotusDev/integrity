use cairo_verifier::air::global_values::{EcPoint, InteractionElements, GlobalValues};
use cairo_verifier::air::constants::{PUBLIC_MEMORY_STEP};
use cairo_verifier::air::public_input::{PublicInput, PublicInputTrait};
use cairo_verifier::common::felt252::{Felt252Div, Felt252PartialOrd};

fn eval_composition_polynomial(
    interaction_elements: InteractionElements,
    public_input: PublicInput,
    mask_values: Array<felt252>,
    constraint_coefficients: Array<felt252>,
    point: felt252,
    trace_domain_size: felt252,
    trace_generator: felt252
) -> felt252 {
    let memory_z = interaction_elements.memory_multi_column_perm_perm_interaction_elm;
    let memory_alpha = interaction_elements.memory_multi_column_perm_hash_interaction_elm0;

    let public_memory_column_size = trace_domain_size / PUBLIC_MEMORY_STEP;
    assert(public_memory_column_size >= 0, 'Invalid column size');

    let public_memory_prod_ratio = public_input.get_public_memory_product_ratio();

    // TODO diluted

    // TODO periodic cols

    let global_values = GlobalValues {
        trace_length: 0,
        initial_pc: 0,
        final_pc: 0,
        initial_ap: 0,
        final_ap: 0,
        initial_pedersen_addr: 0,
        initial_rc_addr: 0,
        initial_bitwise_addr: 0,
        rc_min: 0,
        rc_max: 0,
        offset_size: 0,
        half_offset_size: 0,
        pedersen_shift_point: EcPoint {
            x: 0,
            y: 0
        },
        pedersen_points_x: 0,
        pedersen_points_y: 0,
        memory_multi_column_perm_perm_interaction_elm: 0,
        memory_multi_column_perm_hash_interaction_elm0: 0,
        rc16_perm_interaction_elm: 0,
        diluted_check_permutation_interaction_elm: 0,
        diluted_check_interaction_z: 0,
        diluted_check_interaction_alpha: 0,
        memory_multi_column_perm_perm_public_memory_prod: 0,
        rc16_perm_public_memory_prod: 0,
        diluted_check_first_elm: 0,
        diluted_check_permutation_public_memory_prod: 0,
        diluted_check_final_cum_val: 0
    };

    0
}
