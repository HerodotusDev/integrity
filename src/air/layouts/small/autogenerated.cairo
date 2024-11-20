use integrity::{
    air::layouts::small::{
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
    let pow0 = pow(point, global_values.trace_length / 8192);
    let pow1 = pow0 * pow0; // pow(point, (safe_div(global_values.trace_length, 4096))).
    let pow2 = pow(point, global_values.trace_length / 512);
    let pow3 = pow2 * pow2; // pow(point, (safe_div(global_values.trace_length, 256))).
    let pow4 = pow3 * pow3; // pow(point, (safe_div(global_values.trace_length, 128))).
    let pow5 = pow(point, global_values.trace_length / 32);
    let pow6 = pow5 * pow5; // pow(point, (safe_div(global_values.trace_length, 16))).
    let pow7 = pow6 * pow6; // pow(point, (safe_div(global_values.trace_length, 8))).
    let pow8 = pow(point, global_values.trace_length / 2);
    let pow9 = pow8 * pow8; // pow(point, global_values.trace_length).
    let pow10 = pow(trace_generator, global_values.trace_length - 8192);
    let pow11 = pow(trace_generator, global_values.trace_length - 128);
    let pow12 = pow(trace_generator, global_values.trace_length - 1);
    let pow13 = pow(trace_generator, global_values.trace_length - 2);
    let pow14 = pow(trace_generator, global_values.trace_length - 16);
    let pow15 = pow(trace_generator, (251 * global_values.trace_length) / 256);
    let pow16 = pow(trace_generator, global_values.trace_length / 2);
    let pow17 = pow(trace_generator, (63 * global_values.trace_length) / 64);
    let pow18 = pow(trace_generator, (255 * global_values.trace_length) / 256);
    let pow19 = pow(trace_generator, (15 * global_values.trace_length) / 16);

    // Compute domains.
    let domain0 = pow9 - 1;
    let domain1 = pow8 - 1;
    let domain2 = pow7 - 1;
    let domain3 = pow6 - pow19;
    let domain4 = pow6 - 1;
    let domain5 = pow5 - 1;
    let domain6 = pow4 - 1;
    let domain7 = pow3 - 1;
    let domain8 = pow3 - pow18;
    let domain9 = pow3 - pow17;
    let domain10 = pow2 - pow16;
    let domain11 = pow2 - 1;
    let domain12 = pow1 - pow18;
    let domain13 = pow1 - pow15;
    let domain14 = pow1 - 1;
    let domain15 = pow0 - pow18;
    let domain16 = pow0 - pow15;
    let domain17 = pow0 - 1;
    let domain18 = point - pow14;
    let domain19 = point - 1;
    let domain20 = point - pow13;
    let domain21 = point - pow12;
    let domain22 = point - pow11;
    let domain23 = point - pow10;

    // Fetch mask variables.
    let [
        column0_row0,
        column0_row1,
        column0_row4,
        column0_row8,
        column0_row12,
        column0_row28,
        column0_row44,
        column0_row60,
        column0_row76,
        column0_row92,
        column0_row108,
        column0_row124,
        column1_row0,
        column1_row1,
        column1_row2,
        column1_row3,
        column1_row4,
        column1_row5,
        column1_row6,
        column1_row7,
        column1_row8,
        column1_row9,
        column1_row10,
        column1_row11,
        column1_row12,
        column1_row13,
        column1_row14,
        column1_row15,
        column2_row0,
        column2_row1,
        column3_row0,
        column3_row1,
        column3_row255,
        column3_row256,
        column3_row511,
        column4_row0,
        column4_row1,
        column4_row255,
        column4_row256,
        column5_row0,
        column5_row1,
        column5_row192,
        column5_row193,
        column5_row196,
        column5_row197,
        column5_row251,
        column5_row252,
        column5_row256,
        column6_row0,
        column6_row1,
        column6_row255,
        column6_row256,
        column6_row511,
        column7_row0,
        column7_row1,
        column7_row255,
        column7_row256,
        column8_row0,
        column8_row1,
        column8_row192,
        column8_row193,
        column8_row196,
        column8_row197,
        column8_row251,
        column8_row252,
        column8_row256,
        column9_row0,
        column9_row1,
        column9_row255,
        column9_row256,
        column9_row511,
        column10_row0,
        column10_row1,
        column10_row255,
        column10_row256,
        column11_row0,
        column11_row1,
        column11_row192,
        column11_row193,
        column11_row196,
        column11_row197,
        column11_row251,
        column11_row252,
        column11_row256,
        column12_row0,
        column12_row1,
        column12_row255,
        column12_row256,
        column12_row511,
        column13_row0,
        column13_row1,
        column13_row255,
        column13_row256,
        column14_row0,
        column14_row1,
        column14_row192,
        column14_row193,
        column14_row196,
        column14_row197,
        column14_row251,
        column14_row252,
        column14_row256,
        column15_row0,
        column15_row255,
        column16_row0,
        column16_row255,
        column17_row0,
        column17_row255,
        column18_row0,
        column18_row255,
        column19_row0,
        column19_row1,
        column19_row2,
        column19_row3,
        column19_row4,
        column19_row5,
        column19_row6,
        column19_row7,
        column19_row8,
        column19_row9,
        column19_row12,
        column19_row13,
        column19_row16,
        column19_row22,
        column19_row23,
        column19_row38,
        column19_row39,
        column19_row70,
        column19_row71,
        column19_row102,
        column19_row103,
        column19_row134,
        column19_row135,
        column19_row167,
        column19_row199,
        column19_row230,
        column19_row263,
        column19_row295,
        column19_row327,
        column19_row391,
        column19_row423,
        column19_row455,
        column19_row4118,
        column19_row4119,
        column19_row8214,
        column20_row0,
        column20_row1,
        column20_row2,
        column20_row3,
        column21_row0,
        column21_row1,
        column21_row2,
        column21_row3,
        column21_row4,
        column21_row5,
        column21_row6,
        column21_row7,
        column21_row8,
        column21_row9,
        column21_row10,
        column21_row11,
        column21_row12,
        column21_row13,
        column21_row14,
        column21_row15,
        column21_row16,
        column21_row17,
        column21_row21,
        column21_row22,
        column21_row23,
        column21_row24,
        column21_row25,
        column21_row30,
        column21_row31,
        column21_row39,
        column21_row47,
        column21_row55,
        column21_row4081,
        column21_row4083,
        column21_row4089,
        column21_row4091,
        column21_row4093,
        column21_row4102,
        column21_row4110,
        column21_row8167,
        column21_row8177,
        column21_row8179,
        column21_row8183,
        column21_row8185,
        column21_row8187,
        column21_row8191,
        column22_row0,
        column22_row16,
        column22_row80,
        column22_row144,
        column22_row208,
        column22_row8160,
        column23_inter1_row0,
        column23_inter1_row1,
        column24_inter1_row0,
        column24_inter1_row2
    ] =
        (*mask_values
        .multi_pop_front::<201>()
        .unwrap())
        .unbox();

    // Compute intermediate values.
    let cpu_decode_opcode_range_check_bit_0 = column1_row0 - (column1_row1 + column1_row1);
    let cpu_decode_opcode_range_check_bit_2 = column1_row2 - (column1_row3 + column1_row3);
    let cpu_decode_opcode_range_check_bit_4 = column1_row4 - (column1_row5 + column1_row5);
    let cpu_decode_opcode_range_check_bit_3 = column1_row3 - (column1_row4 + column1_row4);
    let cpu_decode_flag_op1_base_op0_0 = 1
        - (cpu_decode_opcode_range_check_bit_2
            + cpu_decode_opcode_range_check_bit_4
            + cpu_decode_opcode_range_check_bit_3);
    let cpu_decode_opcode_range_check_bit_5 = column1_row5 - (column1_row6 + column1_row6);
    let cpu_decode_opcode_range_check_bit_6 = column1_row6 - (column1_row7 + column1_row7);
    let cpu_decode_opcode_range_check_bit_9 = column1_row9 - (column1_row10 + column1_row10);
    let cpu_decode_flag_res_op1_0 = 1
        - (cpu_decode_opcode_range_check_bit_5
            + cpu_decode_opcode_range_check_bit_6
            + cpu_decode_opcode_range_check_bit_9);
    let cpu_decode_opcode_range_check_bit_7 = column1_row7 - (column1_row8 + column1_row8);
    let cpu_decode_opcode_range_check_bit_8 = column1_row8 - (column1_row9 + column1_row9);
    let cpu_decode_flag_pc_update_regular_0 = 1
        - (cpu_decode_opcode_range_check_bit_7
            + cpu_decode_opcode_range_check_bit_8
            + cpu_decode_opcode_range_check_bit_9);
    let cpu_decode_opcode_range_check_bit_12 = column1_row12 - (column1_row13 + column1_row13);
    let cpu_decode_opcode_range_check_bit_13 = column1_row13 - (column1_row14 + column1_row14);
    let cpu_decode_fp_update_regular_0 = 1
        - (cpu_decode_opcode_range_check_bit_12 + cpu_decode_opcode_range_check_bit_13);
    let cpu_decode_opcode_range_check_bit_1 = column1_row1 - (column1_row2 + column1_row2);
    let npc_reg_0 = column19_row0 + cpu_decode_opcode_range_check_bit_2 + 1;
    let cpu_decode_opcode_range_check_bit_10 = column1_row10 - (column1_row11 + column1_row11);
    let cpu_decode_opcode_range_check_bit_11 = column1_row11 - (column1_row12 + column1_row12);
    let cpu_decode_opcode_range_check_bit_14 = column1_row14 - (column1_row15 + column1_row15);
    let memory_address_diff_0 = column20_row2 - column20_row0;
    let range_check16_diff_0 = column2_row1 - column2_row0;
    let pedersen_hash0_ec_subset_sum_bit_0 = column5_row0 - (column5_row1 + column5_row1);
    let pedersen_hash0_ec_subset_sum_bit_neg_0 = 1 - pedersen_hash0_ec_subset_sum_bit_0;
    let pedersen_hash1_ec_subset_sum_bit_0 = column8_row0 - (column8_row1 + column8_row1);
    let pedersen_hash1_ec_subset_sum_bit_neg_0 = 1 - pedersen_hash1_ec_subset_sum_bit_0;
    let pedersen_hash2_ec_subset_sum_bit_0 = column11_row0 - (column11_row1 + column11_row1);
    let pedersen_hash2_ec_subset_sum_bit_neg_0 = 1 - pedersen_hash2_ec_subset_sum_bit_0;
    let pedersen_hash3_ec_subset_sum_bit_0 = column14_row0 - (column14_row1 + column14_row1);
    let pedersen_hash3_ec_subset_sum_bit_neg_0 = 1 - pedersen_hash3_ec_subset_sum_bit_0;
    let range_check_builtin_value0_0 = column0_row12;
    let range_check_builtin_value1_0 = range_check_builtin_value0_0 * global_values.offset_size
        + column0_row28;
    let range_check_builtin_value2_0 = range_check_builtin_value1_0 * global_values.offset_size
        + column0_row44;
    let range_check_builtin_value3_0 = range_check_builtin_value2_0 * global_values.offset_size
        + column0_row60;
    let range_check_builtin_value4_0 = range_check_builtin_value3_0 * global_values.offset_size
        + column0_row76;
    let range_check_builtin_value5_0 = range_check_builtin_value4_0 * global_values.offset_size
        + column0_row92;
    let range_check_builtin_value6_0 = range_check_builtin_value5_0 * global_values.offset_size
        + column0_row108;
    let range_check_builtin_value7_0 = range_check_builtin_value6_0 * global_values.offset_size
        + column0_row124;
    let ecdsa_signature0_doubling_key_x_squared = column21_row6 * column21_row6;
    let ecdsa_signature0_exponentiate_generator_bit_0 = column21_row15
        - (column21_row47 + column21_row47);
    let ecdsa_signature0_exponentiate_generator_bit_neg_0 = 1
        - ecdsa_signature0_exponentiate_generator_bit_0;
    let ecdsa_signature0_exponentiate_key_bit_0 = column21_row5 - (column21_row21 + column21_row21);
    let ecdsa_signature0_exponentiate_key_bit_neg_0 = 1 - ecdsa_signature0_exponentiate_key_bit_0;

    // Sum constraints.
    let total_sum = 0;

    // Constraint: cpu/decode/opcode_range_check/bit.
    let value = (cpu_decode_opcode_range_check_bit_0 * cpu_decode_opcode_range_check_bit_0
        - cpu_decode_opcode_range_check_bit_0)
        * domain3
        / domain0;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/decode/opcode_range_check/zero.
    let value = (column1_row0) / domain3;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/decode/opcode_range_check_input.
    let value = (column19_row1
        - (((column1_row0 * global_values.offset_size + column0_row4) * global_values.offset_size
            + column0_row8)
            * global_values.offset_size
            + column0_row0))
        / domain4;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/decode/flag_op1_base_op0_bit.
    let value = (cpu_decode_flag_op1_base_op0_0 * cpu_decode_flag_op1_base_op0_0
        - cpu_decode_flag_op1_base_op0_0)
        / domain4;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/decode/flag_res_op1_bit.
    let value = (cpu_decode_flag_res_op1_0 * cpu_decode_flag_res_op1_0 - cpu_decode_flag_res_op1_0)
        / domain4;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/decode/flag_pc_update_regular_bit.
    let value = (cpu_decode_flag_pc_update_regular_0 * cpu_decode_flag_pc_update_regular_0
        - cpu_decode_flag_pc_update_regular_0)
        / domain4;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/decode/fp_update_regular_bit.
    let value = (cpu_decode_fp_update_regular_0 * cpu_decode_fp_update_regular_0
        - cpu_decode_fp_update_regular_0)
        / domain4;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/operands/mem_dst_addr.
    let value = (column19_row8
        + global_values.half_offset_size
        - (cpu_decode_opcode_range_check_bit_0 * column21_row8
            + (1 - cpu_decode_opcode_range_check_bit_0) * column21_row0
            + column0_row0))
        / domain4;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/operands/mem0_addr.
    let value = (column19_row4
        + global_values.half_offset_size
        - (cpu_decode_opcode_range_check_bit_1 * column21_row8
            + (1 - cpu_decode_opcode_range_check_bit_1) * column21_row0
            + column0_row8))
        / domain4;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/operands/mem1_addr.
    let value = (column19_row12
        + global_values.half_offset_size
        - (cpu_decode_opcode_range_check_bit_2 * column19_row0
            + cpu_decode_opcode_range_check_bit_4 * column21_row0
            + cpu_decode_opcode_range_check_bit_3 * column21_row8
            + cpu_decode_flag_op1_base_op0_0 * column19_row5
            + column0_row4))
        / domain4;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/operands/ops_mul.
    let value = (column21_row4 - column19_row5 * column19_row13) / domain4;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/operands/res.
    let value = ((1 - cpu_decode_opcode_range_check_bit_9) * column21_row12
        - (cpu_decode_opcode_range_check_bit_5 * (column19_row5 + column19_row13)
            + cpu_decode_opcode_range_check_bit_6 * column21_row4
            + cpu_decode_flag_res_op1_0 * column19_row13))
        / domain4;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/update_registers/update_pc/tmp0.
    let value = (column21_row2 - cpu_decode_opcode_range_check_bit_9 * column19_row9)
        * domain18
        / domain4;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/update_registers/update_pc/tmp1.
    let value = (column21_row10 - column21_row2 * column21_row12) * domain18 / domain4;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/update_registers/update_pc/pc_cond_negative.
    let value = ((1 - cpu_decode_opcode_range_check_bit_9) * column19_row16
        + column21_row2 * (column19_row16 - (column19_row0 + column19_row13))
        - (cpu_decode_flag_pc_update_regular_0 * npc_reg_0
            + cpu_decode_opcode_range_check_bit_7 * column21_row12
            + cpu_decode_opcode_range_check_bit_8 * (column19_row0 + column21_row12)))
        * domain18
        / domain4;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/update_registers/update_pc/pc_cond_positive.
    let value = ((column21_row10 - cpu_decode_opcode_range_check_bit_9)
        * (column19_row16 - npc_reg_0))
        * domain18
        / domain4;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/update_registers/update_ap/ap_update.
    let value = (column21_row16
        - (column21_row0
            + cpu_decode_opcode_range_check_bit_10 * column21_row12
            + cpu_decode_opcode_range_check_bit_11
            + cpu_decode_opcode_range_check_bit_12 * 2))
        * domain18
        / domain4;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/update_registers/update_fp/fp_update.
    let value = (column21_row24
        - (cpu_decode_fp_update_regular_0 * column21_row8
            + cpu_decode_opcode_range_check_bit_13 * column19_row9
            + cpu_decode_opcode_range_check_bit_12 * (column21_row0 + 2)))
        * domain18
        / domain4;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/opcodes/call/push_fp.
    let value = (cpu_decode_opcode_range_check_bit_12 * (column19_row9 - column21_row8)) / domain4;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/opcodes/call/push_pc.
    let value = (cpu_decode_opcode_range_check_bit_12
        * (column19_row5 - (column19_row0 + cpu_decode_opcode_range_check_bit_2 + 1)))
        / domain4;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/opcodes/call/off0.
    let value = (cpu_decode_opcode_range_check_bit_12
        * (column0_row0 - global_values.half_offset_size))
        / domain4;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/opcodes/call/off1.
    let value = (cpu_decode_opcode_range_check_bit_12
        * (column0_row8 - (global_values.half_offset_size + 1)))
        / domain4;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/opcodes/call/flags.
    let value = (cpu_decode_opcode_range_check_bit_12
        * (cpu_decode_opcode_range_check_bit_12
            + cpu_decode_opcode_range_check_bit_12
            + 1
            + 1
            - (cpu_decode_opcode_range_check_bit_0 + cpu_decode_opcode_range_check_bit_1 + 4)))
        / domain4;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/opcodes/ret/off0.
    let value = (cpu_decode_opcode_range_check_bit_13
        * (column0_row0 + 2 - global_values.half_offset_size))
        / domain4;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/opcodes/ret/off2.
    let value = (cpu_decode_opcode_range_check_bit_13
        * (column0_row4 + 1 - global_values.half_offset_size))
        / domain4;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/opcodes/ret/flags.
    let value = (cpu_decode_opcode_range_check_bit_13
        * (cpu_decode_opcode_range_check_bit_7
            + cpu_decode_opcode_range_check_bit_0
            + cpu_decode_opcode_range_check_bit_3
            + cpu_decode_flag_res_op1_0
            - 4))
        / domain4;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/opcodes/assert_eq/assert_eq.
    let value = (cpu_decode_opcode_range_check_bit_14 * (column19_row9 - column21_row12)) / domain4;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: initial_ap.
    let value = (column21_row0 - global_values.initial_ap) / domain19;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: initial_fp.
    let value = (column21_row8 - global_values.initial_ap) / domain19;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: initial_pc.
    let value = (column19_row0 - global_values.initial_pc) / domain19;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: final_ap.
    let value = (column21_row0 - global_values.final_ap) / domain18;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: final_fp.
    let value = (column21_row8 - global_values.initial_ap) / domain18;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: final_pc.
    let value = (column19_row0 - global_values.final_pc) / domain18;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: memory/multi_column_perm/perm/init0.
    let value = ((global_values.memory_multi_column_perm_perm_interaction_elm
        - (column20_row0
            + global_values.memory_multi_column_perm_hash_interaction_elm0 * column20_row1))
        * column24_inter1_row0
        + column19_row0
        + global_values.memory_multi_column_perm_hash_interaction_elm0 * column19_row1
        - global_values.memory_multi_column_perm_perm_interaction_elm)
        / domain19;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: memory/multi_column_perm/perm/step0.
    let value = ((global_values.memory_multi_column_perm_perm_interaction_elm
        - (column20_row2
            + global_values.memory_multi_column_perm_hash_interaction_elm0 * column20_row3))
        * column24_inter1_row2
        - (global_values.memory_multi_column_perm_perm_interaction_elm
            - (column19_row2
                + global_values.memory_multi_column_perm_hash_interaction_elm0 * column19_row3))
            * column24_inter1_row0)
        * domain20
        / domain1;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: memory/multi_column_perm/perm/last.
    let value = (column24_inter1_row0
        - global_values.memory_multi_column_perm_perm_public_memory_prod)
        / domain20;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: memory/diff_is_bit.
    let value = (memory_address_diff_0 * memory_address_diff_0 - memory_address_diff_0)
        * domain20
        / domain1;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: memory/is_func.
    let value = ((memory_address_diff_0 - 1) * (column20_row1 - column20_row3))
        * domain20
        / domain1;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: memory/initial_addr.
    let value = (column20_row0 - 1) / domain19;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: public_memory_addr_zero.
    let value = (column19_row2) / domain2;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: public_memory_value_zero.
    let value = (column19_row3) / domain2;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: range_check16/perm/init0.
    let value = ((global_values.range_check16_perm_interaction_elm - column2_row0)
        * column23_inter1_row0
        + column0_row0
        - global_values.range_check16_perm_interaction_elm)
        / domain19;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: range_check16/perm/step0.
    let value = ((global_values.range_check16_perm_interaction_elm - column2_row1)
        * column23_inter1_row1
        - (global_values.range_check16_perm_interaction_elm - column0_row1) * column23_inter1_row0)
        * domain21
        / domain0;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: range_check16/perm/last.
    let value = (column23_inter1_row0 - global_values.range_check16_perm_public_memory_prod)
        / domain21;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: range_check16/diff_is_bit.
    let value = (range_check16_diff_0 * range_check16_diff_0 - range_check16_diff_0)
        * domain21
        / domain0;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: range_check16/minimum.
    let value = (column2_row0 - global_values.range_check_min) / domain19;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: range_check16/maximum.
    let value = (column2_row0 - global_values.range_check_max) / domain21;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash0/ec_subset_sum/bit_unpacking/last_one_is_zero.
    let value = (column16_row255 * (column5_row0 - (column5_row1 + column5_row1))) / domain7;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash0/ec_subset_sum/bit_unpacking/zeroes_between_ones0.
    let value = (column16_row255
        * (column5_row1
            - 3138550867693340381917894711603833208051177722232017256448 * column5_row192))
        / domain7;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash0/ec_subset_sum/bit_unpacking/cumulative_bit192.
    let value = (column16_row255
        - column15_row255 * (column5_row192 - (column5_row193 + column5_row193)))
        / domain7;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash0/ec_subset_sum/bit_unpacking/zeroes_between_ones192.
    let value = (column15_row255 * (column5_row193 - 8 * column5_row196)) / domain7;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash0/ec_subset_sum/bit_unpacking/cumulative_bit196.
    let value = (column15_row255
        - (column5_row251 - (column5_row252 + column5_row252))
            * (column5_row196 - (column5_row197 + column5_row197)))
        / domain7;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash0/ec_subset_sum/bit_unpacking/zeroes_between_ones196.
    let value = ((column5_row251 - (column5_row252 + column5_row252))
        * (column5_row197 - 18014398509481984 * column5_row251))
        / domain7;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash0/ec_subset_sum/booleanity_test.
    let value = (pedersen_hash0_ec_subset_sum_bit_0 * (pedersen_hash0_ec_subset_sum_bit_0 - 1))
        * domain8
        / domain0;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash0/ec_subset_sum/bit_extraction_end.
    let value = (column5_row0) / domain9;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash0/ec_subset_sum/zeros_tail.
    let value = (column5_row0) / domain8;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash0/ec_subset_sum/add_points/slope.
    let value = (pedersen_hash0_ec_subset_sum_bit_0
        * (column4_row0 - global_values.pedersen_points_y)
        - column15_row0 * (column3_row0 - global_values.pedersen_points_x))
        * domain8
        / domain0;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash0/ec_subset_sum/add_points/x.
    let value = (column15_row0 * column15_row0
        - pedersen_hash0_ec_subset_sum_bit_0
            * (column3_row0 + global_values.pedersen_points_x + column3_row1))
        * domain8
        / domain0;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash0/ec_subset_sum/add_points/y.
    let value = (pedersen_hash0_ec_subset_sum_bit_0 * (column4_row0 + column4_row1)
        - column15_row0 * (column3_row0 - column3_row1))
        * domain8
        / domain0;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash0/ec_subset_sum/copy_point/x.
    let value = (pedersen_hash0_ec_subset_sum_bit_neg_0 * (column3_row1 - column3_row0))
        * domain8
        / domain0;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash0/ec_subset_sum/copy_point/y.
    let value = (pedersen_hash0_ec_subset_sum_bit_neg_0 * (column4_row1 - column4_row0))
        * domain8
        / domain0;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash0/copy_point/x.
    let value = (column3_row256 - column3_row255) * domain10 / domain7;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash0/copy_point/y.
    let value = (column4_row256 - column4_row255) * domain10 / domain7;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash0/init/x.
    let value = (column3_row0 - global_values.pedersen_shift_point.x) / domain11;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash0/init/y.
    let value = (column4_row0 - global_values.pedersen_shift_point.y) / domain11;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash1/ec_subset_sum/bit_unpacking/last_one_is_zero.
    let value = (column18_row255 * (column8_row0 - (column8_row1 + column8_row1))) / domain7;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash1/ec_subset_sum/bit_unpacking/zeroes_between_ones0.
    let value = (column18_row255
        * (column8_row1
            - 3138550867693340381917894711603833208051177722232017256448 * column8_row192))
        / domain7;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash1/ec_subset_sum/bit_unpacking/cumulative_bit192.
    let value = (column18_row255
        - column17_row255 * (column8_row192 - (column8_row193 + column8_row193)))
        / domain7;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash1/ec_subset_sum/bit_unpacking/zeroes_between_ones192.
    let value = (column17_row255 * (column8_row193 - 8 * column8_row196)) / domain7;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash1/ec_subset_sum/bit_unpacking/cumulative_bit196.
    let value = (column17_row255
        - (column8_row251 - (column8_row252 + column8_row252))
            * (column8_row196 - (column8_row197 + column8_row197)))
        / domain7;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash1/ec_subset_sum/bit_unpacking/zeroes_between_ones196.
    let value = ((column8_row251 - (column8_row252 + column8_row252))
        * (column8_row197 - 18014398509481984 * column8_row251))
        / domain7;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash1/ec_subset_sum/booleanity_test.
    let value = (pedersen_hash1_ec_subset_sum_bit_0 * (pedersen_hash1_ec_subset_sum_bit_0 - 1))
        * domain8
        / domain0;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash1/ec_subset_sum/bit_extraction_end.
    let value = (column8_row0) / domain9;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash1/ec_subset_sum/zeros_tail.
    let value = (column8_row0) / domain8;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash1/ec_subset_sum/add_points/slope.
    let value = (pedersen_hash1_ec_subset_sum_bit_0
        * (column7_row0 - global_values.pedersen_points_y)
        - column16_row0 * (column6_row0 - global_values.pedersen_points_x))
        * domain8
        / domain0;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash1/ec_subset_sum/add_points/x.
    let value = (column16_row0 * column16_row0
        - pedersen_hash1_ec_subset_sum_bit_0
            * (column6_row0 + global_values.pedersen_points_x + column6_row1))
        * domain8
        / domain0;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash1/ec_subset_sum/add_points/y.
    let value = (pedersen_hash1_ec_subset_sum_bit_0 * (column7_row0 + column7_row1)
        - column16_row0 * (column6_row0 - column6_row1))
        * domain8
        / domain0;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash1/ec_subset_sum/copy_point/x.
    let value = (pedersen_hash1_ec_subset_sum_bit_neg_0 * (column6_row1 - column6_row0))
        * domain8
        / domain0;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash1/ec_subset_sum/copy_point/y.
    let value = (pedersen_hash1_ec_subset_sum_bit_neg_0 * (column7_row1 - column7_row0))
        * domain8
        / domain0;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash1/copy_point/x.
    let value = (column6_row256 - column6_row255) * domain10 / domain7;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash1/copy_point/y.
    let value = (column7_row256 - column7_row255) * domain10 / domain7;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash1/init/x.
    let value = (column6_row0 - global_values.pedersen_shift_point.x) / domain11;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash1/init/y.
    let value = (column7_row0 - global_values.pedersen_shift_point.y) / domain11;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash2/ec_subset_sum/bit_unpacking/last_one_is_zero.
    let value = (column22_row144 * (column11_row0 - (column11_row1 + column11_row1))) / domain7;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash2/ec_subset_sum/bit_unpacking/zeroes_between_ones0.
    let value = (column22_row144
        * (column11_row1
            - 3138550867693340381917894711603833208051177722232017256448 * column11_row192))
        / domain7;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash2/ec_subset_sum/bit_unpacking/cumulative_bit192.
    let value = (column22_row144
        - column22_row16 * (column11_row192 - (column11_row193 + column11_row193)))
        / domain7;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash2/ec_subset_sum/bit_unpacking/zeroes_between_ones192.
    let value = (column22_row16 * (column11_row193 - 8 * column11_row196)) / domain7;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash2/ec_subset_sum/bit_unpacking/cumulative_bit196.
    let value = (column22_row16
        - (column11_row251 - (column11_row252 + column11_row252))
            * (column11_row196 - (column11_row197 + column11_row197)))
        / domain7;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash2/ec_subset_sum/bit_unpacking/zeroes_between_ones196.
    let value = ((column11_row251 - (column11_row252 + column11_row252))
        * (column11_row197 - 18014398509481984 * column11_row251))
        / domain7;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash2/ec_subset_sum/booleanity_test.
    let value = (pedersen_hash2_ec_subset_sum_bit_0 * (pedersen_hash2_ec_subset_sum_bit_0 - 1))
        * domain8
        / domain0;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash2/ec_subset_sum/bit_extraction_end.
    let value = (column11_row0) / domain9;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash2/ec_subset_sum/zeros_tail.
    let value = (column11_row0) / domain8;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash2/ec_subset_sum/add_points/slope.
    let value = (pedersen_hash2_ec_subset_sum_bit_0
        * (column10_row0 - global_values.pedersen_points_y)
        - column17_row0 * (column9_row0 - global_values.pedersen_points_x))
        * domain8
        / domain0;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash2/ec_subset_sum/add_points/x.
    let value = (column17_row0 * column17_row0
        - pedersen_hash2_ec_subset_sum_bit_0
            * (column9_row0 + global_values.pedersen_points_x + column9_row1))
        * domain8
        / domain0;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash2/ec_subset_sum/add_points/y.
    let value = (pedersen_hash2_ec_subset_sum_bit_0 * (column10_row0 + column10_row1)
        - column17_row0 * (column9_row0 - column9_row1))
        * domain8
        / domain0;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash2/ec_subset_sum/copy_point/x.
    let value = (pedersen_hash2_ec_subset_sum_bit_neg_0 * (column9_row1 - column9_row0))
        * domain8
        / domain0;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash2/ec_subset_sum/copy_point/y.
    let value = (pedersen_hash2_ec_subset_sum_bit_neg_0 * (column10_row1 - column10_row0))
        * domain8
        / domain0;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash2/copy_point/x.
    let value = (column9_row256 - column9_row255) * domain10 / domain7;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash2/copy_point/y.
    let value = (column10_row256 - column10_row255) * domain10 / domain7;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash2/init/x.
    let value = (column9_row0 - global_values.pedersen_shift_point.x) / domain11;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash2/init/y.
    let value = (column10_row0 - global_values.pedersen_shift_point.y) / domain11;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash3/ec_subset_sum/bit_unpacking/last_one_is_zero.
    let value = (column22_row208 * (column14_row0 - (column14_row1 + column14_row1))) / domain7;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash3/ec_subset_sum/bit_unpacking/zeroes_between_ones0.
    let value = (column22_row208
        * (column14_row1
            - 3138550867693340381917894711603833208051177722232017256448 * column14_row192))
        / domain7;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash3/ec_subset_sum/bit_unpacking/cumulative_bit192.
    let value = (column22_row208
        - column22_row80 * (column14_row192 - (column14_row193 + column14_row193)))
        / domain7;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash3/ec_subset_sum/bit_unpacking/zeroes_between_ones192.
    let value = (column22_row80 * (column14_row193 - 8 * column14_row196)) / domain7;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash3/ec_subset_sum/bit_unpacking/cumulative_bit196.
    let value = (column22_row80
        - (column14_row251 - (column14_row252 + column14_row252))
            * (column14_row196 - (column14_row197 + column14_row197)))
        / domain7;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash3/ec_subset_sum/bit_unpacking/zeroes_between_ones196.
    let value = ((column14_row251 - (column14_row252 + column14_row252))
        * (column14_row197 - 18014398509481984 * column14_row251))
        / domain7;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash3/ec_subset_sum/booleanity_test.
    let value = (pedersen_hash3_ec_subset_sum_bit_0 * (pedersen_hash3_ec_subset_sum_bit_0 - 1))
        * domain8
        / domain0;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash3/ec_subset_sum/bit_extraction_end.
    let value = (column14_row0) / domain9;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash3/ec_subset_sum/zeros_tail.
    let value = (column14_row0) / domain8;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash3/ec_subset_sum/add_points/slope.
    let value = (pedersen_hash3_ec_subset_sum_bit_0
        * (column13_row0 - global_values.pedersen_points_y)
        - column18_row0 * (column12_row0 - global_values.pedersen_points_x))
        * domain8
        / domain0;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash3/ec_subset_sum/add_points/x.
    let value = (column18_row0 * column18_row0
        - pedersen_hash3_ec_subset_sum_bit_0
            * (column12_row0 + global_values.pedersen_points_x + column12_row1))
        * domain8
        / domain0;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash3/ec_subset_sum/add_points/y.
    let value = (pedersen_hash3_ec_subset_sum_bit_0 * (column13_row0 + column13_row1)
        - column18_row0 * (column12_row0 - column12_row1))
        * domain8
        / domain0;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash3/ec_subset_sum/copy_point/x.
    let value = (pedersen_hash3_ec_subset_sum_bit_neg_0 * (column12_row1 - column12_row0))
        * domain8
        / domain0;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash3/ec_subset_sum/copy_point/y.
    let value = (pedersen_hash3_ec_subset_sum_bit_neg_0 * (column13_row1 - column13_row0))
        * domain8
        / domain0;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash3/copy_point/x.
    let value = (column12_row256 - column12_row255) * domain10 / domain7;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash3/copy_point/y.
    let value = (column13_row256 - column13_row255) * domain10 / domain7;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash3/init/x.
    let value = (column12_row0 - global_values.pedersen_shift_point.x) / domain11;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash3/init/y.
    let value = (column13_row0 - global_values.pedersen_shift_point.y) / domain11;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/input0_value0.
    let value = (column19_row7 - column5_row0) / domain11;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/input0_value1.
    let value = (column19_row135 - column8_row0) / domain11;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/input0_value2.
    let value = (column19_row263 - column11_row0) / domain11;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/input0_value3.
    let value = (column19_row391 - column14_row0) / domain11;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/input0_addr.
    let value = (column19_row134 - (column19_row38 + 1)) * domain22 / domain6;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/init_addr.
    let value = (column19_row6 - global_values.initial_pedersen_addr) / domain19;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/input1_value0.
    let value = (column19_row71 - column5_row256) / domain11;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/input1_value1.
    let value = (column19_row199 - column8_row256) / domain11;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/input1_value2.
    let value = (column19_row327 - column11_row256) / domain11;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/input1_value3.
    let value = (column19_row455 - column14_row256) / domain11;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/input1_addr.
    let value = (column19_row70 - (column19_row6 + 1)) / domain6;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/output_value0.
    let value = (column19_row39 - column3_row511) / domain11;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/output_value1.
    let value = (column19_row167 - column6_row511) / domain11;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/output_value2.
    let value = (column19_row295 - column9_row511) / domain11;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/output_value3.
    let value = (column19_row423 - column12_row511) / domain11;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/output_addr.
    let value = (column19_row38 - (column19_row70 + 1)) / domain6;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: range_check_builtin/value.
    let value = (range_check_builtin_value7_0 - column19_row103) / domain6;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: range_check_builtin/addr_step.
    let value = (column19_row230 - (column19_row102 + 1)) * domain22 / domain6;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: range_check_builtin/init_addr.
    let value = (column19_row102 - global_values.initial_range_check_addr) / domain19;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/doubling_key/slope.
    let value = (ecdsa_signature0_doubling_key_x_squared
        + ecdsa_signature0_doubling_key_x_squared
        + ecdsa_signature0_doubling_key_x_squared
        + global_values.ecdsa_sig_config.alpha
        - (column21_row14 + column21_row14) * column21_row13)
        * domain12
        / domain4;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/doubling_key/x.
    let value = (column21_row13 * column21_row13 - (column21_row6 + column21_row6 + column21_row22))
        * domain12
        / domain4;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/doubling_key/y.
    let value = (column21_row14
        + column21_row30
        - column21_row13 * (column21_row6 - column21_row22))
        * domain12
        / domain4;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/exponentiate_generator/booleanity_test.
    let value = (ecdsa_signature0_exponentiate_generator_bit_0
        * (ecdsa_signature0_exponentiate_generator_bit_0 - 1))
        * domain15
        / domain5;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/exponentiate_generator/bit_extraction_end.
    let value = (column21_row15) / domain16;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/exponentiate_generator/zeros_tail.
    let value = (column21_row15) / domain15;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/exponentiate_generator/add_points/slope.
    let value = (ecdsa_signature0_exponentiate_generator_bit_0
        * (column21_row23 - global_values.ecdsa_generator_points_y)
        - column21_row31 * (column21_row7 - global_values.ecdsa_generator_points_x))
        * domain15
        / domain5;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/exponentiate_generator/add_points/x.
    let value = (column21_row31 * column21_row31
        - ecdsa_signature0_exponentiate_generator_bit_0
            * (column21_row7 + global_values.ecdsa_generator_points_x + column21_row39))
        * domain15
        / domain5;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/exponentiate_generator/add_points/y.
    let value = (ecdsa_signature0_exponentiate_generator_bit_0 * (column21_row23 + column21_row55)
        - column21_row31 * (column21_row7 - column21_row39))
        * domain15
        / domain5;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/exponentiate_generator/add_points/x_diff_inv.
    let value = (column22_row0 * (column21_row7 - global_values.ecdsa_generator_points_x) - 1)
        * domain15
        / domain5;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/exponentiate_generator/copy_point/x.
    let value = (ecdsa_signature0_exponentiate_generator_bit_neg_0
        * (column21_row39 - column21_row7))
        * domain15
        / domain5;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/exponentiate_generator/copy_point/y.
    let value = (ecdsa_signature0_exponentiate_generator_bit_neg_0
        * (column21_row55 - column21_row23))
        * domain15
        / domain5;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/exponentiate_key/booleanity_test.
    let value = (ecdsa_signature0_exponentiate_key_bit_0
        * (ecdsa_signature0_exponentiate_key_bit_0 - 1))
        * domain12
        / domain4;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/exponentiate_key/bit_extraction_end.
    let value = (column21_row5) / domain13;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/exponentiate_key/zeros_tail.
    let value = (column21_row5) / domain12;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/exponentiate_key/add_points/slope.
    let value = (ecdsa_signature0_exponentiate_key_bit_0 * (column21_row9 - column21_row14)
        - column21_row3 * (column21_row1 - column21_row6))
        * domain12
        / domain4;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/exponentiate_key/add_points/x.
    let value = (column21_row3 * column21_row3
        - ecdsa_signature0_exponentiate_key_bit_0
            * (column21_row1 + column21_row6 + column21_row17))
        * domain12
        / domain4;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/exponentiate_key/add_points/y.
    let value = (ecdsa_signature0_exponentiate_key_bit_0 * (column21_row9 + column21_row25)
        - column21_row3 * (column21_row1 - column21_row17))
        * domain12
        / domain4;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/exponentiate_key/add_points/x_diff_inv.
    let value = (column21_row11 * (column21_row1 - column21_row6) - 1) * domain12 / domain4;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/exponentiate_key/copy_point/x.
    let value = (ecdsa_signature0_exponentiate_key_bit_neg_0 * (column21_row17 - column21_row1))
        * domain12
        / domain4;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/exponentiate_key/copy_point/y.
    let value = (ecdsa_signature0_exponentiate_key_bit_neg_0 * (column21_row25 - column21_row9))
        * domain12
        / domain4;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/init_gen/x.
    let value = (column21_row7 - global_values.ecdsa_sig_config.shift_point.x) / domain17;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/init_gen/y.
    let value = (column21_row23 + global_values.ecdsa_sig_config.shift_point.y) / domain17;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/init_key/x.
    let value = (column21_row1 - global_values.ecdsa_sig_config.shift_point.x) / domain14;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/init_key/y.
    let value = (column21_row9 - global_values.ecdsa_sig_config.shift_point.y) / domain14;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/add_results/slope.
    let value = (column21_row8183
        - (column21_row4089 + column21_row8191 * (column21_row8167 - column21_row4081)))
        / domain17;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/add_results/x.
    let value = (column21_row8191 * column21_row8191
        - (column21_row8167 + column21_row4081 + column21_row4102))
        / domain17;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/add_results/y.
    let value = (column21_row8183
        + column21_row4110
        - column21_row8191 * (column21_row8167 - column21_row4102))
        / domain17;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/add_results/x_diff_inv.
    let value = (column22_row8160 * (column21_row8167 - column21_row4081) - 1) / domain17;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/extract_r/slope.
    let value = (column21_row8185
        + global_values.ecdsa_sig_config.shift_point.y
        - column21_row4083 * (column21_row8177 - global_values.ecdsa_sig_config.shift_point.x))
        / domain17;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/extract_r/x.
    let value = (column21_row4083 * column21_row4083
        - (column21_row8177 + global_values.ecdsa_sig_config.shift_point.x + column21_row5))
        / domain17;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/extract_r/x_diff_inv.
    let value = (column21_row8179
        * (column21_row8177 - global_values.ecdsa_sig_config.shift_point.x)
        - 1)
        / domain17;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/z_nonzero.
    let value = (column21_row15 * column21_row4091 - 1) / domain17;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/r_and_w_nonzero.
    let value = (column21_row5 * column21_row4093 - 1) / domain14;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/q_on_curve/x_squared.
    let value = (column21_row8187 - column21_row6 * column21_row6) / domain17;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/q_on_curve/on_curve.
    let value = (column21_row14 * column21_row14
        - (column21_row6 * column21_row8187
            + global_values.ecdsa_sig_config.alpha * column21_row6
            + global_values.ecdsa_sig_config.beta))
        / domain17;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/init_addr.
    let value = (column19_row22 - global_values.initial_ecdsa_addr) / domain19;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/message_addr.
    let value = (column19_row4118 - (column19_row22 + 1)) / domain17;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/pubkey_addr.
    let value = (column19_row8214 - (column19_row4118 + 1)) * domain23 / domain17;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/message_value0.
    let value = (column19_row4119 - column21_row15) / domain17;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/pubkey_value0.
    let value = (column19_row23 - column21_row6) / domain17;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

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
    let pow1 = pow(trace_generator, 8160);
    let pow2 = pow(trace_generator, 4081);
    let pow3 = pow(trace_generator, 1);
    let pow4 = pow3 * pow3; // pow(trace_generator, 2).
    let pow5 = pow2 * pow4; // pow(trace_generator, 4083).
    let pow6 = pow3 * pow4; // pow(trace_generator, 3).
    let pow7 = pow3 * pow6; // pow(trace_generator, 4).
    let pow8 = pow3 * pow7; // pow(trace_generator, 5).
    let pow9 = pow3 * pow8; // pow(trace_generator, 6).
    let pow10 = pow3 * pow9; // pow(trace_generator, 7).
    let pow11 = pow1 * pow10; // pow(trace_generator, 8167).
    let pow12 = pow3 * pow10; // pow(trace_generator, 8).
    let pow13 = pow2 * pow12; // pow(trace_generator, 4089).
    let pow14 = pow3 * pow12; // pow(trace_generator, 9).
    let pow15 = pow3 * pow14; // pow(trace_generator, 10).
    let pow16 = pow2 * pow15; // pow(trace_generator, 4091).
    let pow17 = pow3 * pow15; // pow(trace_generator, 11).
    let pow18 = pow3 * pow17; // pow(trace_generator, 12).
    let pow19 = pow3 * pow18; // pow(trace_generator, 13).
    let pow20 = pow3 * pow19; // pow(trace_generator, 14).
    let pow21 = pow3 * pow20; // pow(trace_generator, 15).
    let pow22 = pow2 * pow18; // pow(trace_generator, 4093).
    let pow23 = pow3 * pow21; // pow(trace_generator, 16).
    let pow24 = pow3 * pow23; // pow(trace_generator, 17).
    let pow25 = pow7 * pow24; // pow(trace_generator, 21).
    let pow26 = pow2 * pow25; // pow(trace_generator, 4102).
    let pow27 = pow1 * pow24; // pow(trace_generator, 8177).
    let pow28 = pow4 * pow27; // pow(trace_generator, 8179).
    let pow29 = pow12 * pow26; // pow(trace_generator, 4110).
    let pow30 = pow3 * pow25; // pow(trace_generator, 22).
    let pow31 = pow3 * pow30; // pow(trace_generator, 23).
    let pow32 = pow3 * pow31; // pow(trace_generator, 24).
    let pow33 = pow3 * pow32; // pow(trace_generator, 25).
    let pow34 = pow12 * pow29; // pow(trace_generator, 4118).
    let pow35 = pow1 * pow31; // pow(trace_generator, 8183).
    let pow36 = pow1 * pow33; // pow(trace_generator, 8185).
    let pow37 = pow4 * pow36; // pow(trace_generator, 8187).
    let pow38 = pow6 * pow33; // pow(trace_generator, 28).
    let pow39 = pow4 * pow38; // pow(trace_generator, 30).
    let pow40 = pow3 * pow39; // pow(trace_generator, 31).
    let pow41 = pow1 * pow40; // pow(trace_generator, 8191).
    let pow42 = pow10 * pow40; // pow(trace_generator, 38).
    let pow43 = pow2 * pow42; // pow(trace_generator, 4119).
    let pow44 = pow3 * pow42; // pow(trace_generator, 39).
    let pow45 = pow8 * pow44; // pow(trace_generator, 44).
    let pow46 = pow6 * pow45; // pow(trace_generator, 47).
    let pow47 = pow12 * pow46; // pow(trace_generator, 55).
    let pow48 = pow11 * pow46; // pow(trace_generator, 8214).
    let pow49 = pow8 * pow47; // pow(trace_generator, 60).
    let pow50 = pow15 * pow49; // pow(trace_generator, 70).
    let pow51 = pow3 * pow50; // pow(trace_generator, 71).
    let pow52 = pow8 * pow51; // pow(trace_generator, 76).
    let pow53 = pow7 * pow52; // pow(trace_generator, 80).
    let pow54 = pow18 * pow53; // pow(trace_generator, 92).
    let pow55 = pow15 * pow54; // pow(trace_generator, 102).
    let pow56 = pow3 * pow55; // pow(trace_generator, 103).
    let pow57 = pow8 * pow56; // pow(trace_generator, 108).
    let pow58 = pow23 * pow57; // pow(trace_generator, 124).
    let pow59 = pow15 * pow58; // pow(trace_generator, 134).
    let pow60 = pow3 * pow59; // pow(trace_generator, 135).
    let pow61 = pow14 * pow60; // pow(trace_generator, 144).
    let pow62 = pow31 * pow61; // pow(trace_generator, 167).
    let pow63 = pow33 * pow62; // pow(trace_generator, 192).
    let pow64 = pow3 * pow63; // pow(trace_generator, 193).
    let pow65 = pow6 * pow64; // pow(trace_generator, 196).
    let pow66 = pow3 * pow65; // pow(trace_generator, 197).
    let pow67 = pow4 * pow66; // pow(trace_generator, 199).
    let pow68 = pow14 * pow67; // pow(trace_generator, 208).
    let pow69 = pow30 * pow68; // pow(trace_generator, 230).
    let pow70 = pow25 * pow69; // pow(trace_generator, 251).
    let pow71 = pow3 * pow70; // pow(trace_generator, 252).
    let pow72 = pow6 * pow71; // pow(trace_generator, 255).
    let pow73 = pow3 * pow72; // pow(trace_generator, 256).
    let pow74 = pow72 * pow73; // pow(trace_generator, 511).
    let pow75 = pow44 * pow73; // pow(trace_generator, 295).
    let pow76 = pow10 * pow73; // pow(trace_generator, 263).
    let pow77 = pow63 * pow76; // pow(trace_generator, 455).
    let pow78 = pow62 * pow73; // pow(trace_generator, 423).
    let pow79 = pow60 * pow73; // pow(trace_generator, 391).
    let pow80 = pow51 * pow73; // pow(trace_generator, 327).

    // Fetch columns.
    let [
        column0,
        column1,
        column2,
        column3,
        column4,
        column5,
        column6,
        column7,
        column8,
        column9,
        column10,
        column11,
        column12,
        column13,
        column14,
        column15,
        column16,
        column17,
        column18,
        column19,
        column20,
        column21,
        column22,
        column23,
        column24
    ] =
        (*column_values
        .multi_pop_front::<25>()
        .unwrap())
        .unbox();

    // Sum the OODS constraints on the trace polynomials.
    let total_sum = 0;

    let value = (column0 - *oods_values.pop_front().unwrap()) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column0 - *oods_values.pop_front().unwrap()) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column0 - *oods_values.pop_front().unwrap()) / (point - pow7 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column0 - *oods_values.pop_front().unwrap()) / (point - pow12 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column0 - *oods_values.pop_front().unwrap()) / (point - pow18 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column0 - *oods_values.pop_front().unwrap()) / (point - pow38 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column0 - *oods_values.pop_front().unwrap()) / (point - pow45 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column0 - *oods_values.pop_front().unwrap()) / (point - pow49 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column0 - *oods_values.pop_front().unwrap()) / (point - pow52 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column0 - *oods_values.pop_front().unwrap()) / (point - pow54 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column0 - *oods_values.pop_front().unwrap()) / (point - pow57 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column0 - *oods_values.pop_front().unwrap()) / (point - pow58 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column1 - *oods_values.pop_front().unwrap()) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column1 - *oods_values.pop_front().unwrap()) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column1 - *oods_values.pop_front().unwrap()) / (point - pow4 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column1 - *oods_values.pop_front().unwrap()) / (point - pow6 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column1 - *oods_values.pop_front().unwrap()) / (point - pow7 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column1 - *oods_values.pop_front().unwrap()) / (point - pow8 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column1 - *oods_values.pop_front().unwrap()) / (point - pow9 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column1 - *oods_values.pop_front().unwrap()) / (point - pow10 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column1 - *oods_values.pop_front().unwrap()) / (point - pow12 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column1 - *oods_values.pop_front().unwrap()) / (point - pow14 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column1 - *oods_values.pop_front().unwrap()) / (point - pow15 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column1 - *oods_values.pop_front().unwrap()) / (point - pow17 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column1 - *oods_values.pop_front().unwrap()) / (point - pow18 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column1 - *oods_values.pop_front().unwrap()) / (point - pow19 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column1 - *oods_values.pop_front().unwrap()) / (point - pow20 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column1 - *oods_values.pop_front().unwrap()) / (point - pow21 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column2 - *oods_values.pop_front().unwrap()) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column2 - *oods_values.pop_front().unwrap()) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column3 - *oods_values.pop_front().unwrap()) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column3 - *oods_values.pop_front().unwrap()) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column3 - *oods_values.pop_front().unwrap()) / (point - pow72 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column3 - *oods_values.pop_front().unwrap()) / (point - pow73 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column3 - *oods_values.pop_front().unwrap()) / (point - pow74 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column4 - *oods_values.pop_front().unwrap()) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column4 - *oods_values.pop_front().unwrap()) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column4 - *oods_values.pop_front().unwrap()) / (point - pow72 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column4 - *oods_values.pop_front().unwrap()) / (point - pow73 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow63 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow64 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow65 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow66 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow70 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow71 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow73 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column6 - *oods_values.pop_front().unwrap()) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column6 - *oods_values.pop_front().unwrap()) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column6 - *oods_values.pop_front().unwrap()) / (point - pow72 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column6 - *oods_values.pop_front().unwrap()) / (point - pow73 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column6 - *oods_values.pop_front().unwrap()) / (point - pow74 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column7 - *oods_values.pop_front().unwrap()) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column7 - *oods_values.pop_front().unwrap()) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column7 - *oods_values.pop_front().unwrap()) / (point - pow72 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column7 - *oods_values.pop_front().unwrap()) / (point - pow73 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column8 - *oods_values.pop_front().unwrap()) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column8 - *oods_values.pop_front().unwrap()) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column8 - *oods_values.pop_front().unwrap()) / (point - pow63 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column8 - *oods_values.pop_front().unwrap()) / (point - pow64 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column8 - *oods_values.pop_front().unwrap()) / (point - pow65 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column8 - *oods_values.pop_front().unwrap()) / (point - pow66 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column8 - *oods_values.pop_front().unwrap()) / (point - pow70 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column8 - *oods_values.pop_front().unwrap()) / (point - pow71 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column8 - *oods_values.pop_front().unwrap()) / (point - pow73 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column9 - *oods_values.pop_front().unwrap()) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column9 - *oods_values.pop_front().unwrap()) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column9 - *oods_values.pop_front().unwrap()) / (point - pow72 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column9 - *oods_values.pop_front().unwrap()) / (point - pow73 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column9 - *oods_values.pop_front().unwrap()) / (point - pow74 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column10 - *oods_values.pop_front().unwrap()) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column10 - *oods_values.pop_front().unwrap()) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column10 - *oods_values.pop_front().unwrap()) / (point - pow72 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column10 - *oods_values.pop_front().unwrap()) / (point - pow73 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column11 - *oods_values.pop_front().unwrap()) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column11 - *oods_values.pop_front().unwrap()) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column11 - *oods_values.pop_front().unwrap()) / (point - pow63 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column11 - *oods_values.pop_front().unwrap()) / (point - pow64 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column11 - *oods_values.pop_front().unwrap()) / (point - pow65 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column11 - *oods_values.pop_front().unwrap()) / (point - pow66 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column11 - *oods_values.pop_front().unwrap()) / (point - pow70 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column11 - *oods_values.pop_front().unwrap()) / (point - pow71 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column11 - *oods_values.pop_front().unwrap()) / (point - pow73 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column12 - *oods_values.pop_front().unwrap()) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column12 - *oods_values.pop_front().unwrap()) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column12 - *oods_values.pop_front().unwrap()) / (point - pow72 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column12 - *oods_values.pop_front().unwrap()) / (point - pow73 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column12 - *oods_values.pop_front().unwrap()) / (point - pow74 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column13 - *oods_values.pop_front().unwrap()) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column13 - *oods_values.pop_front().unwrap()) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column13 - *oods_values.pop_front().unwrap()) / (point - pow72 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column13 - *oods_values.pop_front().unwrap()) / (point - pow73 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column14 - *oods_values.pop_front().unwrap()) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column14 - *oods_values.pop_front().unwrap()) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column14 - *oods_values.pop_front().unwrap()) / (point - pow63 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column14 - *oods_values.pop_front().unwrap()) / (point - pow64 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column14 - *oods_values.pop_front().unwrap()) / (point - pow65 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column14 - *oods_values.pop_front().unwrap()) / (point - pow66 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column14 - *oods_values.pop_front().unwrap()) / (point - pow70 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column14 - *oods_values.pop_front().unwrap()) / (point - pow71 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column14 - *oods_values.pop_front().unwrap()) / (point - pow73 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column15 - *oods_values.pop_front().unwrap()) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column15 - *oods_values.pop_front().unwrap()) / (point - pow72 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column16 - *oods_values.pop_front().unwrap()) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column16 - *oods_values.pop_front().unwrap()) / (point - pow72 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column17 - *oods_values.pop_front().unwrap()) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column17 - *oods_values.pop_front().unwrap()) / (point - pow72 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column18 - *oods_values.pop_front().unwrap()) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column18 - *oods_values.pop_front().unwrap()) / (point - pow72 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column19 - *oods_values.pop_front().unwrap()) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column19 - *oods_values.pop_front().unwrap()) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column19 - *oods_values.pop_front().unwrap()) / (point - pow4 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column19 - *oods_values.pop_front().unwrap()) / (point - pow6 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column19 - *oods_values.pop_front().unwrap()) / (point - pow7 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column19 - *oods_values.pop_front().unwrap()) / (point - pow8 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column19 - *oods_values.pop_front().unwrap()) / (point - pow9 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column19 - *oods_values.pop_front().unwrap()) / (point - pow10 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column19 - *oods_values.pop_front().unwrap()) / (point - pow12 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column19 - *oods_values.pop_front().unwrap()) / (point - pow14 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column19 - *oods_values.pop_front().unwrap()) / (point - pow18 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column19 - *oods_values.pop_front().unwrap()) / (point - pow19 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column19 - *oods_values.pop_front().unwrap()) / (point - pow23 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column19 - *oods_values.pop_front().unwrap()) / (point - pow30 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column19 - *oods_values.pop_front().unwrap()) / (point - pow31 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column19 - *oods_values.pop_front().unwrap()) / (point - pow42 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column19 - *oods_values.pop_front().unwrap()) / (point - pow44 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column19 - *oods_values.pop_front().unwrap()) / (point - pow50 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column19 - *oods_values.pop_front().unwrap()) / (point - pow51 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column19 - *oods_values.pop_front().unwrap()) / (point - pow55 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column19 - *oods_values.pop_front().unwrap()) / (point - pow56 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column19 - *oods_values.pop_front().unwrap()) / (point - pow59 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column19 - *oods_values.pop_front().unwrap()) / (point - pow60 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column19 - *oods_values.pop_front().unwrap()) / (point - pow62 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column19 - *oods_values.pop_front().unwrap()) / (point - pow67 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column19 - *oods_values.pop_front().unwrap()) / (point - pow69 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column19 - *oods_values.pop_front().unwrap()) / (point - pow76 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column19 - *oods_values.pop_front().unwrap()) / (point - pow75 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column19 - *oods_values.pop_front().unwrap()) / (point - pow80 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column19 - *oods_values.pop_front().unwrap()) / (point - pow79 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column19 - *oods_values.pop_front().unwrap()) / (point - pow78 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column19 - *oods_values.pop_front().unwrap()) / (point - pow77 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column19 - *oods_values.pop_front().unwrap()) / (point - pow34 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column19 - *oods_values.pop_front().unwrap()) / (point - pow43 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column19 - *oods_values.pop_front().unwrap()) / (point - pow48 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column20 - *oods_values.pop_front().unwrap()) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column20 - *oods_values.pop_front().unwrap()) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column20 - *oods_values.pop_front().unwrap()) / (point - pow4 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column20 - *oods_values.pop_front().unwrap()) / (point - pow6 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column21 - *oods_values.pop_front().unwrap()) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column21 - *oods_values.pop_front().unwrap()) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column21 - *oods_values.pop_front().unwrap()) / (point - pow4 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column21 - *oods_values.pop_front().unwrap()) / (point - pow6 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column21 - *oods_values.pop_front().unwrap()) / (point - pow7 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column21 - *oods_values.pop_front().unwrap()) / (point - pow8 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column21 - *oods_values.pop_front().unwrap()) / (point - pow9 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column21 - *oods_values.pop_front().unwrap()) / (point - pow10 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column21 - *oods_values.pop_front().unwrap()) / (point - pow12 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column21 - *oods_values.pop_front().unwrap()) / (point - pow14 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column21 - *oods_values.pop_front().unwrap()) / (point - pow15 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column21 - *oods_values.pop_front().unwrap()) / (point - pow17 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column21 - *oods_values.pop_front().unwrap()) / (point - pow18 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column21 - *oods_values.pop_front().unwrap()) / (point - pow19 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column21 - *oods_values.pop_front().unwrap()) / (point - pow20 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column21 - *oods_values.pop_front().unwrap()) / (point - pow21 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column21 - *oods_values.pop_front().unwrap()) / (point - pow23 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column21 - *oods_values.pop_front().unwrap()) / (point - pow24 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column21 - *oods_values.pop_front().unwrap()) / (point - pow25 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column21 - *oods_values.pop_front().unwrap()) / (point - pow30 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column21 - *oods_values.pop_front().unwrap()) / (point - pow31 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column21 - *oods_values.pop_front().unwrap()) / (point - pow32 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column21 - *oods_values.pop_front().unwrap()) / (point - pow33 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column21 - *oods_values.pop_front().unwrap()) / (point - pow39 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column21 - *oods_values.pop_front().unwrap()) / (point - pow40 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column21 - *oods_values.pop_front().unwrap()) / (point - pow44 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column21 - *oods_values.pop_front().unwrap()) / (point - pow46 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column21 - *oods_values.pop_front().unwrap()) / (point - pow47 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column21 - *oods_values.pop_front().unwrap()) / (point - pow2 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column21 - *oods_values.pop_front().unwrap()) / (point - pow5 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column21 - *oods_values.pop_front().unwrap()) / (point - pow13 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column21 - *oods_values.pop_front().unwrap()) / (point - pow16 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column21 - *oods_values.pop_front().unwrap()) / (point - pow22 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column21 - *oods_values.pop_front().unwrap()) / (point - pow26 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column21 - *oods_values.pop_front().unwrap()) / (point - pow29 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column21 - *oods_values.pop_front().unwrap()) / (point - pow11 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column21 - *oods_values.pop_front().unwrap()) / (point - pow27 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column21 - *oods_values.pop_front().unwrap()) / (point - pow28 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column21 - *oods_values.pop_front().unwrap()) / (point - pow35 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column21 - *oods_values.pop_front().unwrap()) / (point - pow36 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column21 - *oods_values.pop_front().unwrap()) / (point - pow37 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column21 - *oods_values.pop_front().unwrap()) / (point - pow41 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column22 - *oods_values.pop_front().unwrap()) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column22 - *oods_values.pop_front().unwrap()) / (point - pow23 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column22 - *oods_values.pop_front().unwrap()) / (point - pow53 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column22 - *oods_values.pop_front().unwrap()) / (point - pow61 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column22 - *oods_values.pop_front().unwrap()) / (point - pow68 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column22 - *oods_values.pop_front().unwrap()) / (point - pow1 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column23 - *oods_values.pop_front().unwrap()) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column23 - *oods_values.pop_front().unwrap()) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column24 - *oods_values.pop_front().unwrap()) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column24 - *oods_values.pop_front().unwrap()) / (point - pow4 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Sum the OODS boundary constraints on the composition polynomials.
    let oods_point_to_deg = pow(oods_point, CONSTRAINT_DEGREE.into());

    let value = (*column_values.pop_front().unwrap() - *oods_values.pop_front().unwrap())
        / (point - oods_point_to_deg);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (*column_values.pop_front().unwrap() - *oods_values.pop_front().unwrap())
        / (point - oods_point_to_deg);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    assert(203 == MASK_SIZE + CONSTRAINT_DEGREE, 'Autogenerated assert failed');
    total_sum
}

