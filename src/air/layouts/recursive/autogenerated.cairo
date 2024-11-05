use integrity::{
    air::layouts::recursive::{
        global_values::GlobalValues,
        constants::{CONSTRAINT_DEGREE, NUM_COLUMNS_FIRST, NUM_COLUMNS_SECOND, MASK_SIZE},
    },
    common::math::{Felt252Div, pow},
};

fn eval_composition_polynomial_inner(
    mut mask_values: Span<felt252>,
    mut constraint_coefficients: Span<felt252>,
    point: felt252,
    trace_generator: felt252,
    global_values: GlobalValues,
) -> felt252 {
    // Compute powers.
    let pow0 = pow(point, global_values.trace_length / 2048);
    let pow1 = pow0 * pow0; // pow(point, (safe_div(global_values.trace_length, 1024))).
    let pow2 = pow(point, global_values.trace_length / 128);
    let pow3 = pow(point, global_values.trace_length / 32);
    let pow4 = pow3 * pow3; // pow(point, (safe_div(global_values.trace_length, 16))).
    let pow5 = pow(point, global_values.trace_length / 4);
    let pow6 = pow5 * pow5; // pow(point, (safe_div(global_values.trace_length, 2))).
    let pow7 = pow6 * pow6; // pow(point, global_values.trace_length).
    let pow8 = pow(trace_generator, global_values.trace_length - 128);
    let pow9 = pow(trace_generator, global_values.trace_length - 2048);
    let pow10 = pow(trace_generator, global_values.trace_length - 1);
    let pow11 = pow(trace_generator, global_values.trace_length - 4);
    let pow12 = pow(trace_generator, global_values.trace_length - 2);
    let pow13 = pow(trace_generator, global_values.trace_length - 16);
    let pow14 = pow(trace_generator, global_values.trace_length / 2);
    let pow15 = pow(trace_generator, (255 * global_values.trace_length) / 256);
    let pow16 = pow(trace_generator, global_values.trace_length / 64);
    let pow17 = pow16 * pow16; // pow(trace_generator, (safe_div(global_values.trace_length, 32))).
    let pow18 = pow16
        * pow17; // pow(trace_generator, (safe_div((safe_mult(3, global_values.trace_length)), 64))).
    let pow19 = pow16 * pow18; // pow(trace_generator, (safe_div(global_values.trace_length, 16))).
    let pow20 = pow16
        * pow19; // pow(trace_generator, (safe_div((safe_mult(5, global_values.trace_length)), 64))).
    let pow21 = pow16
        * pow20; // pow(trace_generator, (safe_div((safe_mult(3, global_values.trace_length)), 32))).
    let pow22 = pow16
        * pow21; // pow(trace_generator, (safe_div((safe_mult(7, global_values.trace_length)), 64))).
    let pow23 = pow16 * pow22; // pow(trace_generator, (safe_div(global_values.trace_length, 8))).
    let pow24 = pow16
        * pow23; // pow(trace_generator, (safe_div((safe_mult(9, global_values.trace_length)), 64))).
    let pow25 = pow16
        * pow24; // pow(trace_generator, (safe_div((safe_mult(5, global_values.trace_length)), 32))).
    let pow26 = pow16
        * pow25; // pow(trace_generator, (safe_div((safe_mult(11, global_values.trace_length)), 64))).
    let pow27 = pow16
        * pow26; // pow(trace_generator, (safe_div((safe_mult(3, global_values.trace_length)), 16))).
    let pow28 = pow16
        * pow27; // pow(trace_generator, (safe_div((safe_mult(13, global_values.trace_length)), 64))).
    let pow29 = pow16
        * pow28; // pow(trace_generator, (safe_div((safe_mult(7, global_values.trace_length)), 32))).
    let pow30 = pow16
        * pow29; // pow(trace_generator, (safe_div((safe_mult(15, global_values.trace_length)), 64))).
    let pow31 = pow(trace_generator, (3 * global_values.trace_length) / 4);
    let pow32 = pow27
        * pow31; // pow(trace_generator, (safe_div((safe_mult(15, global_values.trace_length)), 16))).
    let pow33 = pow18
        * pow32; // pow(trace_generator, (safe_div((safe_mult(63, global_values.trace_length)), 64))).

    // Compute domains.
    let domain0 = pow7 - 1;
    let domain1 = pow6 - 1;
    let domain2 = pow5 - 1;
    let domain3 = pow4 - pow32;
    let domain4 = pow4 - 1;
    let domain5 = pow3 - 1;
    let domain6 = pow2 - 1;
    let domain7 = pow2 - pow31;
    let temp = pow2 - pow16;
    let temp = temp * (pow2 - pow17);
    let temp = temp * (pow2 - pow18);
    let temp = temp * (pow2 - pow19);
    let temp = temp * (pow2 - pow20);
    let temp = temp * (pow2 - pow21);
    let temp = temp * (pow2 - pow22);
    let temp = temp * (pow2 - pow23);
    let temp = temp * (pow2 - pow24);
    let temp = temp * (pow2 - pow25);
    let temp = temp * (pow2 - pow26);
    let temp = temp * (pow2 - pow27);
    let temp = temp * (pow2 - pow28);
    let temp = temp * (pow2 - pow29);
    let temp = temp * (pow2 - pow30);
    let domain8 = temp * (domain6);
    let domain9 = pow1 - 1;
    let domain10 = pow1 - pow15;
    let domain11 = pow1 - pow33;
    let domain12 = pow0 - pow14;
    let domain13 = pow0 - 1;
    let domain14 = point - pow13;
    let domain15 = point - 1;
    let domain16 = point - pow12;
    let domain17 = point - pow11;
    let domain18 = point - pow10;
    let domain19 = point - pow9;
    let domain20 = point - pow8;

    // Fetch mask variables.
    let [
        column0_row0,
        column0_row1,
        column0_row2,
        column0_row3,
        column0_row4,
        column0_row5,
        column0_row6,
        column0_row7,
        column0_row8,
        column0_row9,
        column0_row10,
        column0_row11,
        column0_row12,
        column0_row13,
        column0_row14,
        column0_row15,
        column1_row0,
        column1_row1,
        column1_row2,
        column1_row4,
        column1_row6,
        column1_row8,
        column1_row10,
        column1_row12,
        column1_row14,
        column1_row16,
        column1_row18,
        column1_row20,
        column1_row22,
        column1_row24,
        column1_row26,
        column1_row28,
        column1_row30,
        column1_row32,
        column1_row33,
        column1_row64,
        column1_row65,
        column1_row88,
        column1_row90,
        column1_row92,
        column1_row94,
        column1_row96,
        column1_row97,
        column1_row120,
        column1_row122,
        column1_row124,
        column1_row126,
        column2_row0,
        column2_row1,
        column3_row0,
        column3_row1,
        column3_row2,
        column3_row3,
        column3_row4,
        column3_row5,
        column3_row8,
        column3_row9,
        column3_row10,
        column3_row11,
        column3_row12,
        column3_row13,
        column3_row16,
        column3_row26,
        column3_row27,
        column3_row42,
        column3_row43,
        column3_row58,
        column3_row74,
        column3_row75,
        column3_row91,
        column3_row122,
        column3_row123,
        column3_row154,
        column3_row202,
        column3_row522,
        column3_row523,
        column3_row1034,
        column3_row1035,
        column3_row2058,
        column4_row0,
        column4_row1,
        column4_row2,
        column4_row3,
        column5_row0,
        column5_row1,
        column5_row2,
        column5_row3,
        column5_row4,
        column5_row5,
        column5_row6,
        column5_row7,
        column5_row8,
        column5_row12,
        column5_row28,
        column5_row44,
        column5_row60,
        column5_row76,
        column5_row92,
        column5_row108,
        column5_row124,
        column5_row1021,
        column5_row1023,
        column5_row1025,
        column5_row1027,
        column5_row2045,
        column6_row0,
        column6_row1,
        column6_row2,
        column6_row3,
        column6_row4,
        column6_row5,
        column6_row7,
        column6_row9,
        column6_row11,
        column6_row13,
        column6_row17,
        column6_row25,
        column6_row768,
        column6_row772,
        column6_row784,
        column6_row788,
        column6_row1004,
        column6_row1008,
        column6_row1022,
        column6_row1024,
        column7_inter1_row0,
        column7_inter1_row1,
        column8_inter1_row0,
        column8_inter1_row1,
        column9_inter1_row0,
        column9_inter1_row1,
        column9_inter1_row2,
        column9_inter1_row5
    ] =
        (*mask_values
        .multi_pop_front::<133>()
        .unwrap())
        .unbox();

    // Compute intermediate values.
    let cpu_decode_opcode_range_check_bit_0 = column0_row0 - (column0_row1 + column0_row1);
    let cpu_decode_opcode_range_check_bit_2 = column0_row2 - (column0_row3 + column0_row3);
    let cpu_decode_opcode_range_check_bit_4 = column0_row4 - (column0_row5 + column0_row5);
    let cpu_decode_opcode_range_check_bit_3 = column0_row3 - (column0_row4 + column0_row4);
    let cpu_decode_flag_op1_base_op0_0 = 1
        - (cpu_decode_opcode_range_check_bit_2
            + cpu_decode_opcode_range_check_bit_4
            + cpu_decode_opcode_range_check_bit_3);
    let cpu_decode_opcode_range_check_bit_5 = column0_row5 - (column0_row6 + column0_row6);
    let cpu_decode_opcode_range_check_bit_6 = column0_row6 - (column0_row7 + column0_row7);
    let cpu_decode_opcode_range_check_bit_9 = column0_row9 - (column0_row10 + column0_row10);
    let cpu_decode_flag_res_op1_0 = 1
        - (cpu_decode_opcode_range_check_bit_5
            + cpu_decode_opcode_range_check_bit_6
            + cpu_decode_opcode_range_check_bit_9);
    let cpu_decode_opcode_range_check_bit_7 = column0_row7 - (column0_row8 + column0_row8);
    let cpu_decode_opcode_range_check_bit_8 = column0_row8 - (column0_row9 + column0_row9);
    let cpu_decode_flag_pc_update_regular_0 = 1
        - (cpu_decode_opcode_range_check_bit_7
            + cpu_decode_opcode_range_check_bit_8
            + cpu_decode_opcode_range_check_bit_9);
    let cpu_decode_opcode_range_check_bit_12 = column0_row12 - (column0_row13 + column0_row13);
    let cpu_decode_opcode_range_check_bit_13 = column0_row13 - (column0_row14 + column0_row14);
    let cpu_decode_fp_update_regular_0 = 1
        - (cpu_decode_opcode_range_check_bit_12 + cpu_decode_opcode_range_check_bit_13);
    let cpu_decode_opcode_range_check_bit_1 = column0_row1 - (column0_row2 + column0_row2);
    let npc_reg_0 = column3_row0 + cpu_decode_opcode_range_check_bit_2 + 1;
    let cpu_decode_opcode_range_check_bit_10 = column0_row10 - (column0_row11 + column0_row11);
    let cpu_decode_opcode_range_check_bit_11 = column0_row11 - (column0_row12 + column0_row12);
    let cpu_decode_opcode_range_check_bit_14 = column0_row14 - (column0_row15 + column0_row15);
    let memory_address_diff_0 = column4_row2 - column4_row0;
    let range_check16_diff_0 = column5_row6 - column5_row2;
    let pedersen_hash0_ec_subset_sum_bit_0 = column6_row0 - (column6_row4 + column6_row4);
    let pedersen_hash0_ec_subset_sum_bit_neg_0 = 1 - pedersen_hash0_ec_subset_sum_bit_0;
    let range_check_builtin_value0_0 = column5_row12;
    let range_check_builtin_value1_0 = range_check_builtin_value0_0 * global_values.offset_size
        + column5_row28;
    let range_check_builtin_value2_0 = range_check_builtin_value1_0 * global_values.offset_size
        + column5_row44;
    let range_check_builtin_value3_0 = range_check_builtin_value2_0 * global_values.offset_size
        + column5_row60;
    let range_check_builtin_value4_0 = range_check_builtin_value3_0 * global_values.offset_size
        + column5_row76;
    let range_check_builtin_value5_0 = range_check_builtin_value4_0 * global_values.offset_size
        + column5_row92;
    let range_check_builtin_value6_0 = range_check_builtin_value5_0 * global_values.offset_size
        + column5_row108;
    let range_check_builtin_value7_0 = range_check_builtin_value6_0 * global_values.offset_size
        + column5_row124;
    let bitwise_sum_var_0_0 = column1_row0
        + column1_row2 * 2
        + column1_row4 * 4
        + column1_row6 * 8
        + column1_row8 * 18446744073709551616
        + column1_row10 * 36893488147419103232
        + column1_row12 * 73786976294838206464
        + column1_row14 * 147573952589676412928;
    let bitwise_sum_var_8_0 = column1_row16 * 340282366920938463463374607431768211456
        + column1_row18 * 680564733841876926926749214863536422912
        + column1_row20 * 1361129467683753853853498429727072845824
        + column1_row22 * 2722258935367507707706996859454145691648
        + column1_row24 * 6277101735386680763835789423207666416102355444464034512896
        + column1_row26 * 12554203470773361527671578846415332832204710888928069025792
        + column1_row28 * 25108406941546723055343157692830665664409421777856138051584
        + column1_row30 * 50216813883093446110686315385661331328818843555712276103168;

    // Sum constraints.

    let values = [
        (cpu_decode_opcode_range_check_bit_0 * cpu_decode_opcode_range_check_bit_0
            - cpu_decode_opcode_range_check_bit_0)
            * domain3
            / domain0, // Constraint: cpu/decode/opcode_range_check/bit.
        (column0_row0) / domain3, // Constraint: cpu/decode/opcode_range_check/zero.
        (column3_row1
            - (((column0_row0 * global_values.offset_size + column5_row4)
                * global_values.offset_size
                + column5_row8)
                * global_values.offset_size
                + column5_row0))
            / domain4, // Constraint: cpu/decode/opcode_range_check_input.
        (cpu_decode_flag_op1_base_op0_0 * cpu_decode_flag_op1_base_op0_0
            - cpu_decode_flag_op1_base_op0_0)
            / domain4, // Constraint: cpu/decode/flag_op1_base_op0_bit.
        (cpu_decode_flag_res_op1_0 * cpu_decode_flag_res_op1_0 - cpu_decode_flag_res_op1_0)
            / domain4, // Constraint: cpu/decode/flag_res_op1_bit.
        (cpu_decode_flag_pc_update_regular_0 * cpu_decode_flag_pc_update_regular_0
            - cpu_decode_flag_pc_update_regular_0)
            / domain4, // Constraint: cpu/decode/flag_pc_update_regular_bit.
        (cpu_decode_fp_update_regular_0 * cpu_decode_fp_update_regular_0
            - cpu_decode_fp_update_regular_0)
            / domain4, // Constraint: cpu/decode/fp_update_regular_bit.
        (column3_row8
            + global_values.half_offset_size
            - (cpu_decode_opcode_range_check_bit_0 * column6_row9
                + (1 - cpu_decode_opcode_range_check_bit_0) * column6_row1
                + column5_row0))
            / domain4, // Constraint: cpu/operands/mem_dst_addr.
        (column3_row4
            + global_values.half_offset_size
            - (cpu_decode_opcode_range_check_bit_1 * column6_row9
                + (1 - cpu_decode_opcode_range_check_bit_1) * column6_row1
                + column5_row8))
            / domain4, // Constraint: cpu/operands/mem0_addr.
        (column3_row12
            + global_values.half_offset_size
            - (cpu_decode_opcode_range_check_bit_2 * column3_row0
                + cpu_decode_opcode_range_check_bit_4 * column6_row1
                + cpu_decode_opcode_range_check_bit_3 * column6_row9
                + cpu_decode_flag_op1_base_op0_0 * column3_row5
                + column5_row4))
            / domain4, // Constraint: cpu/operands/mem1_addr.
        (column6_row5 - column3_row5 * column3_row13)
            / domain4, // Constraint: cpu/operands/ops_mul.
        ((1 - cpu_decode_opcode_range_check_bit_9) * column6_row13
            - (cpu_decode_opcode_range_check_bit_5 * (column3_row5 + column3_row13)
                + cpu_decode_opcode_range_check_bit_6 * column6_row5
                + cpu_decode_flag_res_op1_0 * column3_row13))
            / domain4, // Constraint: cpu/operands/res.
        (column6_row3 - cpu_decode_opcode_range_check_bit_9 * column3_row9)
            * domain14
            / domain4, // Constraint: cpu/update_registers/update_pc/tmp0.
        (column6_row11 - column6_row3 * column6_row13)
            * domain14
            / domain4, // Constraint: cpu/update_registers/update_pc/tmp1.
        ((1 - cpu_decode_opcode_range_check_bit_9) * column3_row16
            + column6_row3 * (column3_row16 - (column3_row0 + column3_row13))
            - (cpu_decode_flag_pc_update_regular_0 * npc_reg_0
                + cpu_decode_opcode_range_check_bit_7 * column6_row13
                + cpu_decode_opcode_range_check_bit_8 * (column3_row0 + column6_row13)))
            * domain14
            / domain4, // Constraint: cpu/update_registers/update_pc/pc_cond_negative.
        ((column6_row11 - cpu_decode_opcode_range_check_bit_9) * (column3_row16 - npc_reg_0))
            * domain14
            / domain4, // Constraint: cpu/update_registers/update_pc/pc_cond_positive.
        (column6_row17
            - (column6_row1
                + cpu_decode_opcode_range_check_bit_10 * column6_row13
                + cpu_decode_opcode_range_check_bit_11
                + cpu_decode_opcode_range_check_bit_12 * 2))
            * domain14
            / domain4, // Constraint: cpu/update_registers/update_ap/ap_update.
        (column6_row25
            - (cpu_decode_fp_update_regular_0 * column6_row9
                + cpu_decode_opcode_range_check_bit_13 * column3_row9
                + cpu_decode_opcode_range_check_bit_12 * (column6_row1 + 2)))
            * domain14
            / domain4, // Constraint: cpu/update_registers/update_fp/fp_update.
        (cpu_decode_opcode_range_check_bit_12 * (column3_row9 - column6_row9))
            / domain4, // Constraint: cpu/opcodes/call/push_fp.
        (cpu_decode_opcode_range_check_bit_12
            * (column3_row5 - (column3_row0 + cpu_decode_opcode_range_check_bit_2 + 1)))
            / domain4, // Constraint: cpu/opcodes/call/push_pc.
        (cpu_decode_opcode_range_check_bit_12 * (column5_row0 - global_values.half_offset_size))
            / domain4, // Constraint: cpu/opcodes/call/off0.
        (cpu_decode_opcode_range_check_bit_12
            * (column5_row8 - (global_values.half_offset_size + 1)))
            / domain4, // Constraint: cpu/opcodes/call/off1.
        (cpu_decode_opcode_range_check_bit_12
            * (cpu_decode_opcode_range_check_bit_12
                + cpu_decode_opcode_range_check_bit_12
                + 1
                + 1
                - (cpu_decode_opcode_range_check_bit_0 + cpu_decode_opcode_range_check_bit_1 + 4)))
            / domain4, // Constraint: cpu/opcodes/call/flags.
        (cpu_decode_opcode_range_check_bit_13 * (column5_row0 + 2 - global_values.half_offset_size))
            / domain4, // Constraint: cpu/opcodes/ret/off0.
        (cpu_decode_opcode_range_check_bit_13 * (column5_row4 + 1 - global_values.half_offset_size))
            / domain4, // Constraint: cpu/opcodes/ret/off2.
        (cpu_decode_opcode_range_check_bit_13
            * (cpu_decode_opcode_range_check_bit_7
                + cpu_decode_opcode_range_check_bit_0
                + cpu_decode_opcode_range_check_bit_3
                + cpu_decode_flag_res_op1_0
                - 4))
            / domain4, // Constraint: cpu/opcodes/ret/flags.
        (cpu_decode_opcode_range_check_bit_14 * (column3_row9 - column6_row13))
            / domain4, // Constraint: cpu/opcodes/assert_eq/assert_eq.
        (column6_row1 - global_values.initial_ap) / domain15, // Constraint: initial_ap.
        (column6_row9 - global_values.initial_ap) / domain15, // Constraint: initial_fp.
        (column3_row0 - global_values.initial_pc) / domain15, // Constraint: initial_pc.
        (column6_row1 - global_values.final_ap) / domain14, // Constraint: final_ap.
        (column6_row9 - global_values.initial_ap) / domain14, // Constraint: final_fp.
        (column3_row0 - global_values.final_pc) / domain14, // Constraint: final_pc.
        ((global_values.memory_multi_column_perm_perm_interaction_elm
            - (column4_row0
                + global_values.memory_multi_column_perm_hash_interaction_elm0 * column4_row1))
            * column9_inter1_row0
            + column3_row0
            + global_values.memory_multi_column_perm_hash_interaction_elm0 * column3_row1
            - global_values.memory_multi_column_perm_perm_interaction_elm)
            / domain15, // Constraint: memory/multi_column_perm/perm/init0.
        ((global_values.memory_multi_column_perm_perm_interaction_elm
            - (column4_row2
                + global_values.memory_multi_column_perm_hash_interaction_elm0 * column4_row3))
            * column9_inter1_row2
            - (global_values.memory_multi_column_perm_perm_interaction_elm
                - (column3_row2
                    + global_values.memory_multi_column_perm_hash_interaction_elm0 * column3_row3))
                * column9_inter1_row0)
            * domain16
            / domain1, // Constraint: memory/multi_column_perm/perm/step0.
        (column9_inter1_row0 - global_values.memory_multi_column_perm_perm_public_memory_prod)
            / domain16, // Constraint: memory/multi_column_perm/perm/last.
        (memory_address_diff_0 * memory_address_diff_0 - memory_address_diff_0)
            * domain16
            / domain1, // Constraint: memory/diff_is_bit.
        ((memory_address_diff_0 - 1) * (column4_row1 - column4_row3))
            * domain16
            / domain1, // Constraint: memory/is_func.
        (column4_row0 - 1) / domain15, // Constraint: memory/initial_addr.
        (column3_row2) / domain4, // Constraint: public_memory_addr_zero.
        (column3_row3) / domain4, // Constraint: public_memory_value_zero.
        ((global_values.range_check16_perm_interaction_elm - column5_row2) * column9_inter1_row1
            + column5_row0
            - global_values.range_check16_perm_interaction_elm)
            / domain15, // Constraint: range_check16/perm/init0.
        ((global_values.range_check16_perm_interaction_elm - column5_row6) * column9_inter1_row5
            - (global_values.range_check16_perm_interaction_elm - column5_row4)
                * column9_inter1_row1)
            * domain17
            / domain2, // Constraint: range_check16/perm/step0.
        (column9_inter1_row1 - global_values.range_check16_perm_public_memory_prod)
            / domain17, // Constraint: range_check16/perm/last.
        (range_check16_diff_0 * range_check16_diff_0 - range_check16_diff_0)
            * domain17
            / domain2, // Constraint: range_check16/diff_is_bit.
        (column5_row2 - global_values.range_check_min)
            / domain15, // Constraint: range_check16/minimum.
        (column5_row2 - global_values.range_check_max)
            / domain17, // Constraint: range_check16/maximum.
        ((global_values.diluted_check_permutation_interaction_elm - column2_row0)
            * column8_inter1_row0
            + column1_row0
            - global_values.diluted_check_permutation_interaction_elm)
            / domain15, // Constraint: diluted_check/permutation/init0.
        ((global_values.diluted_check_permutation_interaction_elm - column2_row1)
            * column8_inter1_row1
            - (global_values.diluted_check_permutation_interaction_elm - column1_row1)
                * column8_inter1_row0)
            * domain18
            / domain0, // Constraint: diluted_check/permutation/step0.
        (column8_inter1_row0 - global_values.diluted_check_permutation_public_memory_prod)
            / domain18, // Constraint: diluted_check/permutation/last.
        (column7_inter1_row0 - 1) / domain15, // Constraint: diluted_check/init.
        (column2_row0 - global_values.diluted_check_first_elm)
            / domain15, // Constraint: diluted_check/first_element.
        (column7_inter1_row1
            - (column7_inter1_row0
                * (1 + global_values.diluted_check_interaction_z * (column2_row1 - column2_row0))
                + global_values.diluted_check_interaction_alpha
                    * (column2_row1 - column2_row0)
                    * (column2_row1 - column2_row0)))
            * domain18
            / domain0, // Constraint: diluted_check/step.
        (column7_inter1_row0 - global_values.diluted_check_final_cum_val)
            / domain18, // Constraint: diluted_check/last.
        (column6_row7 * (column6_row0 - (column6_row4 + column6_row4)))
            / domain9, // Constraint: pedersen/hash0/ec_subset_sum/bit_unpacking/last_one_is_zero.
        (column6_row7
            * (column6_row4
                - 3138550867693340381917894711603833208051177722232017256448 * column6_row768))
            / domain9, // Constraint: pedersen/hash0/ec_subset_sum/bit_unpacking/zeroes_between_ones0.
        (column6_row7 - column6_row1022 * (column6_row768 - (column6_row772 + column6_row772)))
            / domain9, // Constraint: pedersen/hash0/ec_subset_sum/bit_unpacking/cumulative_bit192.
        (column6_row1022 * (column6_row772 - 8 * column6_row784))
            / domain9, // Constraint: pedersen/hash0/ec_subset_sum/bit_unpacking/zeroes_between_ones192.
        (column6_row1022
            - (column6_row1004 - (column6_row1008 + column6_row1008))
                * (column6_row784 - (column6_row788 + column6_row788)))
            / domain9, // Constraint: pedersen/hash0/ec_subset_sum/bit_unpacking/cumulative_bit196.
        ((column6_row1004 - (column6_row1008 + column6_row1008))
            * (column6_row788 - 18014398509481984 * column6_row1004))
            / domain9, // Constraint: pedersen/hash0/ec_subset_sum/bit_unpacking/zeroes_between_ones196.
        (pedersen_hash0_ec_subset_sum_bit_0 * (pedersen_hash0_ec_subset_sum_bit_0 - 1))
            * domain10
            / domain2, // Constraint: pedersen/hash0/ec_subset_sum/booleanity_test.
        (column6_row0) / domain11, // Constraint: pedersen/hash0/ec_subset_sum/bit_extraction_end.
        (column6_row0) / domain10, // Constraint: pedersen/hash0/ec_subset_sum/zeros_tail.
        (pedersen_hash0_ec_subset_sum_bit_0 * (column5_row3 - global_values.pedersen_points_y)
            - column6_row2 * (column5_row1 - global_values.pedersen_points_x))
            * domain10
            / domain2, // Constraint: pedersen/hash0/ec_subset_sum/add_points/slope.
        (column6_row2 * column6_row2
            - pedersen_hash0_ec_subset_sum_bit_0
                * (column5_row1 + global_values.pedersen_points_x + column5_row5))
            * domain10
            / domain2, // Constraint: pedersen/hash0/ec_subset_sum/add_points/x.
        (pedersen_hash0_ec_subset_sum_bit_0 * (column5_row3 + column5_row7)
            - column6_row2 * (column5_row1 - column5_row5))
            * domain10
            / domain2, // Constraint: pedersen/hash0/ec_subset_sum/add_points/y.
        (pedersen_hash0_ec_subset_sum_bit_neg_0 * (column5_row5 - column5_row1))
            * domain10
            / domain2, // Constraint: pedersen/hash0/ec_subset_sum/copy_point/x.
        (pedersen_hash0_ec_subset_sum_bit_neg_0 * (column5_row7 - column5_row3))
            * domain10
            / domain2, // Constraint: pedersen/hash0/ec_subset_sum/copy_point/y.
        (column5_row1025 - column5_row1021)
            * domain12
            / domain9, // Constraint: pedersen/hash0/copy_point/x.
        (column5_row1027 - column5_row1023)
            * domain12
            / domain9, // Constraint: pedersen/hash0/copy_point/y.
        (column5_row1 - global_values.pedersen_shift_point.x)
            / domain13, // Constraint: pedersen/hash0/init/x.
        (column5_row3 - global_values.pedersen_shift_point.y)
            / domain13, // Constraint: pedersen/hash0/init/y.
        (column3_row11 - column6_row0) / domain13, // Constraint: pedersen/input0_value0.
        (column3_row2058 - (column3_row522 + 1))
            * domain19
            / domain13, // Constraint: pedersen/input0_addr.
        (column3_row10 - global_values.initial_pedersen_addr)
            / domain15, // Constraint: pedersen/init_addr.
        (column3_row1035 - column6_row1024) / domain13, // Constraint: pedersen/input1_value0.
        (column3_row1034 - (column3_row10 + 1)) / domain13, // Constraint: pedersen/input1_addr.
        (column3_row523 - column5_row2045) / domain13, // Constraint: pedersen/output_value0.
        (column3_row522 - (column3_row1034 + 1)) / domain13, // Constraint: pedersen/output_addr.
        (range_check_builtin_value7_0 - column3_row75)
            / domain6, // Constraint: range_check_builtin/value.
        (column3_row202 - (column3_row74 + 1))
            * domain20
            / domain6, // Constraint: range_check_builtin/addr_step.
        (column3_row74 - global_values.initial_range_check_addr)
            / domain15, // Constraint: range_check_builtin/init_addr.
        (column3_row26 - global_values.initial_bitwise_addr)
            / domain15, // Constraint: bitwise/init_var_pool_addr.
        (column3_row58 - (column3_row26 + 1))
            * domain7
            / domain5, // Constraint: bitwise/step_var_pool_addr.
        (column3_row42 - (column3_row122 + 1)) / domain6, // Constraint: bitwise/x_or_y_addr.
        (column3_row154 - (column3_row42 + 1))
            * domain20
            / domain6, // Constraint: bitwise/next_var_pool_addr.
        (bitwise_sum_var_0_0 + bitwise_sum_var_8_0 - column3_row27)
            / domain5, // Constraint: bitwise/partition.
        (column3_row43 - (column3_row91 + column3_row123))
            / domain6, // Constraint: bitwise/or_is_and_plus_xor.
        (column1_row0 + column1_row32 - (column1_row96 + column1_row64 + column1_row64))
            / domain8, // Constraint: bitwise/addition_is_xor_with_and.
        ((column1_row88 + column1_row120) * 16 - column1_row1)
            / domain6, // Constraint: bitwise/unique_unpacking192.
        ((column1_row90 + column1_row122) * 16 - column1_row65)
            / domain6, // Constraint: bitwise/unique_unpacking193.
        ((column1_row92 + column1_row124) * 16 - column1_row33)
            / domain6, // Constraint: bitwise/unique_unpacking194.
        ((column1_row94 + column1_row126) * 256 - column1_row97)
            / domain6, // Constraint: bitwise/unique_unpacking195.
    ].span();

    let mut total_sum = 0;
    for value in values {
        total_sum += *constraint_coefficients.pop_front().unwrap() * *value;
    };

    total_sum
}

fn eval_oods_polynomial_inner(
    mut column_values: Span<felt252>,
    mut oods_values: Span<felt252>,
    mut constraint_coefficients: Span<felt252>,
    point: felt252,
    oods_point: felt252,
    trace_generator: felt252,
) -> felt252 {
    // Compute powers.
    let pow0 = pow(trace_generator, 0);
    let pow1 = pow(trace_generator, 1004);
    let pow2 = pow(trace_generator, 768);
    let pow3 = pow(trace_generator, 522);
    let pow4 = pow(trace_generator, 1);
    let pow5 = pow3 * pow4; // pow(trace_generator, 523).
    let pow6 = pow4 * pow4; // pow(trace_generator, 2).
    let pow7 = pow4 * pow6; // pow(trace_generator, 3).
    let pow8 = pow4 * pow7; // pow(trace_generator, 4).
    let pow9 = pow1 * pow8; // pow(trace_generator, 1008).
    let pow10 = pow2 * pow8; // pow(trace_generator, 772).
    let pow11 = pow4 * pow8; // pow(trace_generator, 5).
    let pow12 = pow4 * pow11; // pow(trace_generator, 6).
    let pow13 = pow4 * pow12; // pow(trace_generator, 7).
    let pow14 = pow4 * pow13; // pow(trace_generator, 8).
    let pow15 = pow4 * pow14; // pow(trace_generator, 9).
    let pow16 = pow4 * pow15; // pow(trace_generator, 10).
    let pow17 = pow4 * pow16; // pow(trace_generator, 11).
    let pow18 = pow4 * pow17; // pow(trace_generator, 12).
    let pow19 = pow4 * pow18; // pow(trace_generator, 13).
    let pow20 = pow4 * pow19; // pow(trace_generator, 14).
    let pow21 = pow4 * pow20; // pow(trace_generator, 15).
    let pow22 = pow4 * pow21; // pow(trace_generator, 16).
    let pow23 = pow2 * pow22; // pow(trace_generator, 784).
    let pow24 = pow4 * pow22; // pow(trace_generator, 17).
    let pow25 = pow1 * pow24; // pow(trace_generator, 1021).
    let pow26 = pow4 * pow24; // pow(trace_generator, 18).
    let pow27 = pow1 * pow26; // pow(trace_generator, 1022).
    let pow28 = pow4 * pow27; // pow(trace_generator, 1023).
    let pow29 = pow6 * pow26; // pow(trace_generator, 20).
    let pow30 = pow6 * pow29; // pow(trace_generator, 22).
    let pow31 = pow6 * pow30; // pow(trace_generator, 24).
    let pow32 = pow4 * pow31; // pow(trace_generator, 25).
    let pow33 = pow4 * pow32; // pow(trace_generator, 26).
    let pow34 = pow1 * pow29; // pow(trace_generator, 1024).
    let pow35 = pow25 * pow34; // pow(trace_generator, 2045).
    let pow36 = pow4 * pow34; // pow(trace_generator, 1025).
    let pow37 = pow6 * pow36; // pow(trace_generator, 1027).
    let pow38 = pow4 * pow33; // pow(trace_generator, 27).
    let pow39 = pow4 * pow38; // pow(trace_generator, 28).
    let pow40 = pow6 * pow39; // pow(trace_generator, 30).
    let pow41 = pow6 * pow40; // pow(trace_generator, 32).
    let pow42 = pow4 * pow41; // pow(trace_generator, 33).
    let pow43 = pow1 * pow40; // pow(trace_generator, 1034).
    let pow44 = pow4 * pow43; // pow(trace_generator, 1035).
    let pow45 = pow19 * pow35; // pow(trace_generator, 2058).
    let pow46 = pow15 * pow42; // pow(trace_generator, 42).
    let pow47 = pow4 * pow46; // pow(trace_generator, 43).
    let pow48 = pow4 * pow47; // pow(trace_generator, 44).
    let pow49 = pow20 * pow48; // pow(trace_generator, 58).
    let pow50 = pow6 * pow49; // pow(trace_generator, 60).
    let pow51 = pow2 * pow29; // pow(trace_generator, 788).
    let pow52 = pow8 * pow50; // pow(trace_generator, 64).
    let pow53 = pow4 * pow52; // pow(trace_generator, 65).
    let pow54 = pow15 * pow53; // pow(trace_generator, 74).
    let pow55 = pow4 * pow54; // pow(trace_generator, 75).
    let pow56 = pow4 * pow55; // pow(trace_generator, 76).
    let pow57 = pow18 * pow56; // pow(trace_generator, 88).
    let pow58 = pow6 * pow57; // pow(trace_generator, 90).
    let pow59 = pow4 * pow58; // pow(trace_generator, 91).
    let pow60 = pow4 * pow59; // pow(trace_generator, 92).
    let pow61 = pow6 * pow60; // pow(trace_generator, 94).
    let pow62 = pow6 * pow61; // pow(trace_generator, 96).
    let pow63 = pow4 * pow62; // pow(trace_generator, 97).
    let pow64 = pow17 * pow63; // pow(trace_generator, 108).
    let pow65 = pow18 * pow64; // pow(trace_generator, 120).
    let pow66 = pow6 * pow65; // pow(trace_generator, 122).
    let pow67 = pow4 * pow66; // pow(trace_generator, 123).
    let pow68 = pow4 * pow67; // pow(trace_generator, 124).
    let pow69 = pow6 * pow68; // pow(trace_generator, 126).
    let pow70 = pow56 * pow69; // pow(trace_generator, 202).
    let pow71 = pow39 * pow69; // pow(trace_generator, 154).

    // Fetch columns.
    let [column0, column1, column2, column3, column4, column5, column6, column7, column8, column9] =
        (*column_values
        .multi_pop_front::<10>()
        .unwrap())
        .unbox();

    // Sum the OODS constraints on the trace polynomials.

    let values = [
        (column0 - *oods_values.pop_front().unwrap()) / (point - pow0 * oods_point),
        (column0 - *oods_values.pop_front().unwrap()) / (point - pow4 * oods_point),
        (column0 - *oods_values.pop_front().unwrap()) / (point - pow6 * oods_point),
        (column0 - *oods_values.pop_front().unwrap()) / (point - pow7 * oods_point),
        (column0 - *oods_values.pop_front().unwrap()) / (point - pow8 * oods_point),
        (column0 - *oods_values.pop_front().unwrap()) / (point - pow11 * oods_point),
        (column0 - *oods_values.pop_front().unwrap()) / (point - pow12 * oods_point),
        (column0 - *oods_values.pop_front().unwrap()) / (point - pow13 * oods_point),
        (column0 - *oods_values.pop_front().unwrap()) / (point - pow14 * oods_point),
        (column0 - *oods_values.pop_front().unwrap()) / (point - pow15 * oods_point),
        (column0 - *oods_values.pop_front().unwrap()) / (point - pow16 * oods_point),
        (column0 - *oods_values.pop_front().unwrap()) / (point - pow17 * oods_point),
        (column0 - *oods_values.pop_front().unwrap()) / (point - pow18 * oods_point),
        (column0 - *oods_values.pop_front().unwrap()) / (point - pow19 * oods_point),
        (column0 - *oods_values.pop_front().unwrap()) / (point - pow20 * oods_point),
        (column0 - *oods_values.pop_front().unwrap()) / (point - pow21 * oods_point),
        (column1 - *oods_values.pop_front().unwrap()) / (point - pow0 * oods_point),
        (column1 - *oods_values.pop_front().unwrap()) / (point - pow4 * oods_point),
        (column1 - *oods_values.pop_front().unwrap()) / (point - pow6 * oods_point),
        (column1 - *oods_values.pop_front().unwrap()) / (point - pow8 * oods_point),
        (column1 - *oods_values.pop_front().unwrap()) / (point - pow12 * oods_point),
        (column1 - *oods_values.pop_front().unwrap()) / (point - pow14 * oods_point),
        (column1 - *oods_values.pop_front().unwrap()) / (point - pow16 * oods_point),
        (column1 - *oods_values.pop_front().unwrap()) / (point - pow18 * oods_point),
        (column1 - *oods_values.pop_front().unwrap()) / (point - pow20 * oods_point),
        (column1 - *oods_values.pop_front().unwrap()) / (point - pow22 * oods_point),
        (column1 - *oods_values.pop_front().unwrap()) / (point - pow26 * oods_point),
        (column1 - *oods_values.pop_front().unwrap()) / (point - pow29 * oods_point),
        (column1 - *oods_values.pop_front().unwrap()) / (point - pow30 * oods_point),
        (column1 - *oods_values.pop_front().unwrap()) / (point - pow31 * oods_point),
        (column1 - *oods_values.pop_front().unwrap()) / (point - pow33 * oods_point),
        (column1 - *oods_values.pop_front().unwrap()) / (point - pow39 * oods_point),
        (column1 - *oods_values.pop_front().unwrap()) / (point - pow40 * oods_point),
        (column1 - *oods_values.pop_front().unwrap()) / (point - pow41 * oods_point),
        (column1 - *oods_values.pop_front().unwrap()) / (point - pow42 * oods_point),
        (column1 - *oods_values.pop_front().unwrap()) / (point - pow52 * oods_point),
        (column1 - *oods_values.pop_front().unwrap()) / (point - pow53 * oods_point),
        (column1 - *oods_values.pop_front().unwrap()) / (point - pow57 * oods_point),
        (column1 - *oods_values.pop_front().unwrap()) / (point - pow58 * oods_point),
        (column1 - *oods_values.pop_front().unwrap()) / (point - pow60 * oods_point),
        (column1 - *oods_values.pop_front().unwrap()) / (point - pow61 * oods_point),
        (column1 - *oods_values.pop_front().unwrap()) / (point - pow62 * oods_point),
        (column1 - *oods_values.pop_front().unwrap()) / (point - pow63 * oods_point),
        (column1 - *oods_values.pop_front().unwrap()) / (point - pow65 * oods_point),
        (column1 - *oods_values.pop_front().unwrap()) / (point - pow66 * oods_point),
        (column1 - *oods_values.pop_front().unwrap()) / (point - pow68 * oods_point),
        (column1 - *oods_values.pop_front().unwrap()) / (point - pow69 * oods_point),
        (column2 - *oods_values.pop_front().unwrap()) / (point - pow0 * oods_point),
        (column2 - *oods_values.pop_front().unwrap()) / (point - pow4 * oods_point),
        (column3 - *oods_values.pop_front().unwrap()) / (point - pow0 * oods_point),
        (column3 - *oods_values.pop_front().unwrap()) / (point - pow4 * oods_point),
        (column3 - *oods_values.pop_front().unwrap()) / (point - pow6 * oods_point),
        (column3 - *oods_values.pop_front().unwrap()) / (point - pow7 * oods_point),
        (column3 - *oods_values.pop_front().unwrap()) / (point - pow8 * oods_point),
        (column3 - *oods_values.pop_front().unwrap()) / (point - pow11 * oods_point),
        (column3 - *oods_values.pop_front().unwrap()) / (point - pow14 * oods_point),
        (column3 - *oods_values.pop_front().unwrap()) / (point - pow15 * oods_point),
        (column3 - *oods_values.pop_front().unwrap()) / (point - pow16 * oods_point),
        (column3 - *oods_values.pop_front().unwrap()) / (point - pow17 * oods_point),
        (column3 - *oods_values.pop_front().unwrap()) / (point - pow18 * oods_point),
        (column3 - *oods_values.pop_front().unwrap()) / (point - pow19 * oods_point),
        (column3 - *oods_values.pop_front().unwrap()) / (point - pow22 * oods_point),
        (column3 - *oods_values.pop_front().unwrap()) / (point - pow33 * oods_point),
        (column3 - *oods_values.pop_front().unwrap()) / (point - pow38 * oods_point),
        (column3 - *oods_values.pop_front().unwrap()) / (point - pow46 * oods_point),
        (column3 - *oods_values.pop_front().unwrap()) / (point - pow47 * oods_point),
        (column3 - *oods_values.pop_front().unwrap()) / (point - pow49 * oods_point),
        (column3 - *oods_values.pop_front().unwrap()) / (point - pow54 * oods_point),
        (column3 - *oods_values.pop_front().unwrap()) / (point - pow55 * oods_point),
        (column3 - *oods_values.pop_front().unwrap()) / (point - pow59 * oods_point),
        (column3 - *oods_values.pop_front().unwrap()) / (point - pow66 * oods_point),
        (column3 - *oods_values.pop_front().unwrap()) / (point - pow67 * oods_point),
        (column3 - *oods_values.pop_front().unwrap()) / (point - pow71 * oods_point),
        (column3 - *oods_values.pop_front().unwrap()) / (point - pow70 * oods_point),
        (column3 - *oods_values.pop_front().unwrap()) / (point - pow3 * oods_point),
        (column3 - *oods_values.pop_front().unwrap()) / (point - pow5 * oods_point),
        (column3 - *oods_values.pop_front().unwrap()) / (point - pow43 * oods_point),
        (column3 - *oods_values.pop_front().unwrap()) / (point - pow44 * oods_point),
        (column3 - *oods_values.pop_front().unwrap()) / (point - pow45 * oods_point),
        (column4 - *oods_values.pop_front().unwrap()) / (point - pow0 * oods_point),
        (column4 - *oods_values.pop_front().unwrap()) / (point - pow4 * oods_point),
        (column4 - *oods_values.pop_front().unwrap()) / (point - pow6 * oods_point),
        (column4 - *oods_values.pop_front().unwrap()) / (point - pow7 * oods_point),
        (column5 - *oods_values.pop_front().unwrap()) / (point - pow0 * oods_point),
        (column5 - *oods_values.pop_front().unwrap()) / (point - pow4 * oods_point),
        (column5 - *oods_values.pop_front().unwrap()) / (point - pow6 * oods_point),
        (column5 - *oods_values.pop_front().unwrap()) / (point - pow7 * oods_point),
        (column5 - *oods_values.pop_front().unwrap()) / (point - pow8 * oods_point),
        (column5 - *oods_values.pop_front().unwrap()) / (point - pow11 * oods_point),
        (column5 - *oods_values.pop_front().unwrap()) / (point - pow12 * oods_point),
        (column5 - *oods_values.pop_front().unwrap()) / (point - pow13 * oods_point),
        (column5 - *oods_values.pop_front().unwrap()) / (point - pow14 * oods_point),
        (column5 - *oods_values.pop_front().unwrap()) / (point - pow18 * oods_point),
        (column5 - *oods_values.pop_front().unwrap()) / (point - pow39 * oods_point),
        (column5 - *oods_values.pop_front().unwrap()) / (point - pow48 * oods_point),
        (column5 - *oods_values.pop_front().unwrap()) / (point - pow50 * oods_point),
        (column5 - *oods_values.pop_front().unwrap()) / (point - pow56 * oods_point),
        (column5 - *oods_values.pop_front().unwrap()) / (point - pow60 * oods_point),
        (column5 - *oods_values.pop_front().unwrap()) / (point - pow64 * oods_point),
        (column5 - *oods_values.pop_front().unwrap()) / (point - pow68 * oods_point),
        (column5 - *oods_values.pop_front().unwrap()) / (point - pow25 * oods_point),
        (column5 - *oods_values.pop_front().unwrap()) / (point - pow28 * oods_point),
        (column5 - *oods_values.pop_front().unwrap()) / (point - pow36 * oods_point),
        (column5 - *oods_values.pop_front().unwrap()) / (point - pow37 * oods_point),
        (column5 - *oods_values.pop_front().unwrap()) / (point - pow35 * oods_point),
        (column6 - *oods_values.pop_front().unwrap()) / (point - pow0 * oods_point),
        (column6 - *oods_values.pop_front().unwrap()) / (point - pow4 * oods_point),
        (column6 - *oods_values.pop_front().unwrap()) / (point - pow6 * oods_point),
        (column6 - *oods_values.pop_front().unwrap()) / (point - pow7 * oods_point),
        (column6 - *oods_values.pop_front().unwrap()) / (point - pow8 * oods_point),
        (column6 - *oods_values.pop_front().unwrap()) / (point - pow11 * oods_point),
        (column6 - *oods_values.pop_front().unwrap()) / (point - pow13 * oods_point),
        (column6 - *oods_values.pop_front().unwrap()) / (point - pow15 * oods_point),
        (column6 - *oods_values.pop_front().unwrap()) / (point - pow17 * oods_point),
        (column6 - *oods_values.pop_front().unwrap()) / (point - pow19 * oods_point),
        (column6 - *oods_values.pop_front().unwrap()) / (point - pow24 * oods_point),
        (column6 - *oods_values.pop_front().unwrap()) / (point - pow32 * oods_point),
        (column6 - *oods_values.pop_front().unwrap()) / (point - pow2 * oods_point),
        (column6 - *oods_values.pop_front().unwrap()) / (point - pow10 * oods_point),
        (column6 - *oods_values.pop_front().unwrap()) / (point - pow23 * oods_point),
        (column6 - *oods_values.pop_front().unwrap()) / (point - pow51 * oods_point),
        (column6 - *oods_values.pop_front().unwrap()) / (point - pow1 * oods_point),
        (column6 - *oods_values.pop_front().unwrap()) / (point - pow9 * oods_point),
        (column6 - *oods_values.pop_front().unwrap()) / (point - pow27 * oods_point),
        (column6 - *oods_values.pop_front().unwrap()) / (point - pow34 * oods_point),
        (column7 - *oods_values.pop_front().unwrap()) / (point - pow0 * oods_point),
        (column7 - *oods_values.pop_front().unwrap()) / (point - pow4 * oods_point),
        (column8 - *oods_values.pop_front().unwrap()) / (point - pow0 * oods_point),
        (column8 - *oods_values.pop_front().unwrap()) / (point - pow4 * oods_point),
        (column9 - *oods_values.pop_front().unwrap()) / (point - pow0 * oods_point),
        (column9 - *oods_values.pop_front().unwrap()) / (point - pow4 * oods_point),
        (column9 - *oods_values.pop_front().unwrap()) / (point - pow6 * oods_point),
        (column9 - *oods_values.pop_front().unwrap()) / (point - pow11 * oods_point),
    ].span();

    let mut total_sum = 0;
    for value in values {
        total_sum += *constraint_coefficients.pop_front().unwrap() * *value;
    };

    // Sum the OODS boundary constraints on the composition polynomials.
    let oods_point_to_deg = pow(oods_point, CONSTRAINT_DEGREE.into());

    let value = (*column_values.pop_front().unwrap() - *oods_values.pop_front().unwrap())
        / (point - oods_point_to_deg);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (*column_values.pop_front().unwrap() - *oods_values.pop_front().unwrap())
        / (point - oods_point_to_deg);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    assert(135 == MASK_SIZE + CONSTRAINT_DEGREE, 'Autogenerated assert failed');
    total_sum
}

