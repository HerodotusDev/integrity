use cairo_verifier::air::{layout::Layout, ec_point::EcPoint, ecdsa::EcdsaSigConfig};

struct SmallLayout {
    // Public input.
    trace_length: felt252,
    initial_pc: felt252,
    final_pc: felt252,
    initial_ap: felt252,
    final_ap: felt252,
    initial_pedersen_addr: felt252,
    initial_rc_addr: felt252,
    initial_ecdsa_addr: felt252,
    rc_min: felt252,
    rc_max: felt252,

    // Constants.
    offset_size: felt252,
    half_offset_size: felt252,
    pedersen_shift_point: EcPoint,
    ecdsa_sig_config: EcdsaSigConfig,

    // Periodic columns.
    pedersen_points_x: felt252,
    pedersen_points_y: felt252,
    ecdsa_generator_points_x: felt252,
    ecdsa_generator_points_y: felt252,

    // Interaction elements.
    memory_multi_column_perm_perm_interaction_elm: felt252,
    memory_multi_column_perm_hash_interaction_elm0: felt252,
    rc16_perm_interaction_elm: felt252,

    // Permutation products.
    memory_multi_column_perm_perm_public_memory_prod: felt252,
    rc16_perm_public_memory_prod: felt252,
}

impl SmallLayoutImpl of Layout<SmallLayout> {
    fn prepare_evaluation(
        trace_domain_size: felt252,
        interaction_elements: Array<felt252>
    ) -> SmallLayout {
        // return SmallLayout struct with all fields set to 0
        SmallLayout {
            trace_length: 0,
            initial_pc: 0,
            final_pc: 0,
            initial_ap: 0,
            final_ap: 0,
            initial_pedersen_addr: 0,
            initial_rc_addr: 0,
            initial_ecdsa_addr: 0,
            rc_min: 0,
            rc_max: 0,
            offset_size: 0,
            half_offset_size: 0,
            pedersen_shift_point: EcPoint {
                x: 0,
                y: 0
            },
            ecdsa_sig_config: EcdsaSigConfig {
                alpha: 0,
                beta: 0,
                shift_point: EcPoint {
                    x: 0,
                    y: 0
                }
            },
            pedersen_points_x: 0,
            pedersen_points_y: 0,
            ecdsa_generator_points_x: 0,
            ecdsa_generator_points_y: 0,
            memory_multi_column_perm_perm_interaction_elm: 0,
            memory_multi_column_perm_hash_interaction_elm0: 0,
            rc16_perm_interaction_elm: 0,
            memory_multi_column_perm_perm_public_memory_prod: 0,
            rc16_perm_public_memory_prod: 0
        }
    }

    fn eval_composition_polynomial(
        self: @SmallLayout,
        mask_values: Array<felt252>,
        constraint_coefficients: Array<felt252>,
        point: felt252,
        trace_generator: felt252
    ) -> felt252 {
        0
    }
}
