mod autogenerated;
mod constants;
mod global_values;
mod public_input;
mod traces;

use cairo_verifier::{
    air::{
        layouts::dynamic::{
            global_values::{
                InteractionElements, GlobalValues, EcPoint, EcdsaSigConfig, CurveConfig
            },
            autogenerated::{eval_oods_polynomial_inner, eval_composition_polynomial_inner},
            constants::{
                DynamicParams, segments, PUBLIC_MEMORY_FRACTION, ECDSA_BUILTIN_REPETITIONS,
                PEDERSEN_BUILTIN_REPETITIONS, DILUTED_N_BITS, DILUTED_SPACING
            }
        },
        constants::{SHIFT_POINT_X, SHIFT_POINT_Y, StarkCurve}, air::{AIRComposition, AIROods},
        diluted::get_diluted_product,
        periodic_columns::{
            eval_pedersen_x, eval_pedersen_y, eval_ecdsa_x, eval_ecdsa_y,
            eval_poseidon_poseidon_full_round_key0, eval_poseidon_poseidon_full_round_key1,
            eval_poseidon_poseidon_full_round_key2, eval_poseidon_poseidon_partial_round_key0,
            eval_poseidon_poseidon_partial_round_key1, eval_keccak_round_key0,
            eval_keccak_round_key1, eval_keccak_round_key3, eval_keccak_round_key7,
            eval_keccak_round_key15, eval_keccak_round_key31, eval_keccak_round_key63
        },
        public_input::{PublicInput, get_public_memory_product_ratio}
    },
    common::{math::{Felt252Div, Felt252PartialOrd, pow}, asserts::assert_range_u128}
};

impl StarknetAIRCompositionImpl of AIRComposition<InteractionElements, PublicInput> {
    fn eval_composition_polynomial(
        interaction_elements: InteractionElements,
        public_input: @PublicInput,
        mask_values: Span<felt252>,
        constraint_coefficients: Span<felt252>,
        point: felt252,
        trace_domain_size: felt252,
        trace_generator: felt252
    ) -> felt252 {
        let mut dynamic_params_span = public_input.dynamic_params.span();
        let dynamic_params = Serde::<DynamicParams>::deserialize(ref dynamic_params_span).unwrap();

        let memory_z = interaction_elements.memory_multi_column_perm_perm_interaction_elm;
        let memory_alpha = interaction_elements.memory_multi_column_perm_hash_interaction_elm0;

        // Public memory
        let public_memory_column_size = trace_domain_size
            / (PUBLIC_MEMORY_FRACTION * dynamic_params.memory_units_row_ratio.into());
        assert_range_u128(public_memory_column_size);
        let public_memory_prod_ratio = get_public_memory_product_ratio(
            public_input, memory_z, memory_alpha, public_memory_column_size
        );

        // Diluted
        let diluted_z = interaction_elements.diluted_check_interaction_z;
        let diluted_alpha = interaction_elements.diluted_check_interaction_alpha;
        let diluted_prod = get_diluted_product(
            DILUTED_N_BITS, DILUTED_SPACING, diluted_z, diluted_alpha
        );

        // Periodic columns.
        let (pedersen_points_x, pedersen_points_y) = if dynamic_params.uses_pedersen_builtin == 0 {
            (0, 0)
        } else {
            let n_pedersen_hash_copies = trace_domain_size
                / (PEDERSEN_BUILTIN_REPETITIONS * dynamic_params.pedersen_builtin_row_ratio.into());
            assert_range_u128(n_pedersen_hash_copies);
            let pedersen_point = pow(point, n_pedersen_hash_copies);
            (eval_pedersen_x(pedersen_point), eval_pedersen_y(pedersen_point))
        };

        let (ecdsa_generator_points_x, ecdsa_generator_points_y) = if dynamic_params
            .uses_ecdsa_builtin == 0 {
            (0, 0)
        } else {
            let n_ecdsa_signature_copies = trace_domain_size
                / (ECDSA_BUILTIN_REPETITIONS * dynamic_params.ecdsa_builtin_row_ratio.into());
            assert_range_u128(n_ecdsa_signature_copies);
            let ecdsa_point = pow(point, n_ecdsa_signature_copies);
            (eval_ecdsa_x(ecdsa_point), eval_ecdsa_y(ecdsa_point))
        };

        let (
            keccak_keccak_keccak_round_key0,
            keccak_keccak_keccak_round_key1,
            keccak_keccak_keccak_round_key3,
            keccak_keccak_keccak_round_key7,
            keccak_keccak_keccak_round_key15,
            keccak_keccak_keccak_round_key31,
            keccak_keccak_keccak_round_key63,
        ) =
            if dynamic_params
            .uses_keccak_builtin == 0 {
            (0, 0, 0, 0, 0, 0, 0)
        } else {
            let n_keccak_component_copies = trace_domain_size
                / (DILUTED_N_BITS * dynamic_params.keccak_row_ratio.into());
            // The following assert enforces that the number of keccak instances is divisible by
            // KECCAK_PERMUTATIONS_PER_INSTANCE.
            assert_range_u128(n_keccak_component_copies);
            let n_keccak_periodic_columns_copies = 2048 * n_keccak_component_copies;
            let keccak_point = pow(point, n_keccak_periodic_columns_copies);
            (
                eval_keccak_round_key0(keccak_point),
                eval_keccak_round_key1(keccak_point),
                eval_keccak_round_key3(keccak_point),
                eval_keccak_round_key7(keccak_point),
                eval_keccak_round_key15(keccak_point),
                eval_keccak_round_key31(keccak_point),
                eval_keccak_round_key63(keccak_point)
            )
        };

        let (
            poseidon_poseidon_full_round_key0,
            poseidon_poseidon_full_round_key1,
            poseidon_poseidon_full_round_key2,
            poseidon_poseidon_partial_round_key0,
            poseidon_poseidon_partial_round_key1
        ) =
            if dynamic_params
            .uses_poseidon_builtin == 0 {
            (0, 0, 0, 0, 0)
        } else {
            let n_poseidon_copies = trace_domain_size / dynamic_params.poseidon_row_ratio.into();
            assert_range_u128(n_poseidon_copies);
            let poseidon_point = pow(point, n_poseidon_copies);
            (
                eval_poseidon_poseidon_full_round_key0(poseidon_point),
                eval_poseidon_poseidon_full_round_key1(poseidon_point),
                eval_poseidon_poseidon_full_round_key2(poseidon_point),
                eval_poseidon_poseidon_partial_round_key0(poseidon_point),
                eval_poseidon_poseidon_partial_round_key1(poseidon_point)
            )
        };

        let global_values = GlobalValues {
            trace_length: trace_domain_size,
            initial_pc: *public_input.segments.at(segments::PROGRAM).begin_addr,
            final_pc: *public_input.segments.at(segments::PROGRAM).stop_ptr,
            initial_ap: *public_input.segments.at(segments::EXECUTION).begin_addr,
            final_ap: *public_input.segments.at(segments::EXECUTION).stop_ptr,
            initial_pedersen_addr: *public_input.segments.at(segments::PEDERSEN).begin_addr,
            initial_range_check_addr: *public_input.segments.at(segments::RANGE_CHECK).begin_addr,
            initial_ecdsa_addr: *public_input.segments.at(segments::ECDSA).begin_addr,
            initial_bitwise_addr: *public_input.segments.at(segments::BITWISE).begin_addr,
            initial_ec_op_addr: *public_input.segments.at(segments::EC_OP).begin_addr,
            initial_keccak_addr: *public_input.segments.at(segments::KECCAK).begin_addr,
            initial_poseidon_addr: *public_input.segments.at(segments::POSEIDON).begin_addr,
            initial_range_check96_addr: *public_input
                .segments
                .at(segments::RANGE_CHECK96)
                .begin_addr,
            add_mod_initial_mod_addr: *public_input.segments.at(segments::ADD_MOD).begin_addr,
            mul_mod_initial_mod_addr: *public_input.segments.at(segments::MUL_MOD).begin_addr,
            range_check_min: *public_input.range_check_min,
            range_check_max: *public_input.range_check_max,
            offset_size: 0x10000, // 2**16
            half_offset_size: 0x8000, // 2**15
            pedersen_shift_point: EcPoint { x: SHIFT_POINT_X, y: SHIFT_POINT_Y },
            ecdsa_sig_config: EcdsaSigConfig {
                alpha: StarkCurve::ALPHA,
                beta: StarkCurve::BETA,
                shift_point: EcPoint { x: SHIFT_POINT_X, y: SHIFT_POINT_Y },
            },
            ec_op_curve_config: CurveConfig { alpha: StarkCurve::ALPHA, beta: StarkCurve::BETA },
            pedersen_points_x,
            pedersen_points_y,
            ecdsa_generator_points_x,
            ecdsa_generator_points_y,
            keccak_keccak_keccak_round_key0,
            keccak_keccak_keccak_round_key1,
            keccak_keccak_keccak_round_key3,
            keccak_keccak_keccak_round_key7,
            keccak_keccak_keccak_round_key15,
            keccak_keccak_keccak_round_key31,
            keccak_keccak_keccak_round_key63,
            poseidon_poseidon_full_round_key0,
            poseidon_poseidon_full_round_key1,
            poseidon_poseidon_full_round_key2,
            poseidon_poseidon_partial_round_key0,
            poseidon_poseidon_partial_round_key1,
            memory_multi_column_perm_perm_interaction_elm: memory_z,
            memory_multi_column_perm_hash_interaction_elm0: memory_alpha,
            range_check16_perm_interaction_elm: interaction_elements
                .range_check16_perm_interaction_elm,
            diluted_check_permutation_interaction_elm: interaction_elements
                .diluted_check_permutation_interaction_elm,
            diluted_check_interaction_z: diluted_z,
            diluted_check_interaction_alpha: diluted_alpha,
            add_mod_interaction_elm: interaction_elements.add_mod_interaction_elm,
            mul_mod_interaction_elm: interaction_elements.mul_mod_interaction_elm,
            memory_multi_column_perm_perm_public_memory_prod: public_memory_prod_ratio,
            range_check16_perm_public_memory_prod: 1,
            diluted_check_first_elm: 0,
            diluted_check_permutation_public_memory_prod: 1,
            diluted_check_final_cum_val: diluted_prod,
            dynamic_params: dynamic_params,
        };

        eval_composition_polynomial_inner(
            mask_values, constraint_coefficients, point, trace_generator, global_values
        )
    }
}

impl StarknetAIROodsImpl of AIROods {
    fn eval_oods_polynomial(
        column_values: Span<felt252>,
        oods_values: Span<felt252>,
        constraint_coefficients: Span<felt252>,
        point: felt252,
        oods_point: felt252,
        trace_generator: felt252,
    ) -> felt252 {
        eval_oods_polynomial_inner(
            column_values, oods_values, constraint_coefficients, point, oods_point, trace_generator,
        )
    }
}
