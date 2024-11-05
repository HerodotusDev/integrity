use integrity::{
    air::layouts::dex::{
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
    let pow8 = pow7 * pow7; // pow(point, (safe_div(global_values.trace_length, 4))).
    let pow9 = pow8 * pow8; // pow(point, (safe_div(global_values.trace_length, 2))).
    let pow10 = pow9 * pow9; // pow(point, global_values.trace_length).
    let pow11 = pow(trace_generator, global_values.trace_length - 8192);
    let pow12 = pow(trace_generator, global_values.trace_length - 128);
    let pow13 = pow(trace_generator, global_values.trace_length - 4);
    let pow14 = pow(trace_generator, global_values.trace_length - 2);
    let pow15 = pow(trace_generator, global_values.trace_length - 16);
    let pow16 = pow(trace_generator, (251 * global_values.trace_length) / 256);
    let pow17 = pow(trace_generator, global_values.trace_length / 2);
    let pow18 = pow(trace_generator, (63 * global_values.trace_length) / 64);
    let pow19 = pow(trace_generator, (255 * global_values.trace_length) / 256);
    let pow20 = pow(trace_generator, (15 * global_values.trace_length) / 16);

    // Compute domains.
    let domain0 = pow10 - 1;
    let domain1 = pow9 - 1;
    let domain2 = pow8 - 1;
    let domain3 = pow7 - 1;
    let domain4 = pow6 - pow20;
    let domain5 = pow6 - 1;
    let domain6 = pow5 - 1;
    let domain7 = pow4 - 1;
    let domain8 = pow3 - 1;
    let domain9 = pow3 - pow19;
    let domain10 = pow3 - pow18;
    let domain11 = pow2 - pow17;
    let domain12 = pow2 - 1;
    let domain13 = pow1 - pow19;
    let domain14 = pow1 - pow16;
    let domain15 = pow1 - 1;
    let domain16 = pow0 - pow19;
    let domain17 = pow0 - pow16;
    let domain18 = pow0 - 1;
    let domain19 = point - pow15;
    let domain20 = point - 1;
    let domain21 = point - pow14;
    let domain22 = point - pow13;
    let domain23 = point - pow12;
    let domain24 = point - pow11;

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
        column1_row255,
        column1_row256,
        column1_row511,
        column2_row0,
        column2_row1,
        column2_row255,
        column2_row256,
        column3_row0,
        column3_row1,
        column3_row192,
        column3_row193,
        column3_row196,
        column3_row197,
        column3_row251,
        column3_row252,
        column3_row256,
        column4_row0,
        column4_row1,
        column4_row255,
        column4_row256,
        column4_row511,
        column5_row0,
        column5_row1,
        column5_row255,
        column5_row256,
        column6_row0,
        column6_row1,
        column6_row192,
        column6_row193,
        column6_row196,
        column6_row197,
        column6_row251,
        column6_row252,
        column6_row256,
        column7_row0,
        column7_row1,
        column7_row255,
        column7_row256,
        column7_row511,
        column8_row0,
        column8_row1,
        column8_row255,
        column8_row256,
        column9_row0,
        column9_row1,
        column9_row192,
        column9_row193,
        column9_row196,
        column9_row197,
        column9_row251,
        column9_row252,
        column9_row256,
        column10_row0,
        column10_row1,
        column10_row255,
        column10_row256,
        column10_row511,
        column11_row0,
        column11_row1,
        column11_row255,
        column11_row256,
        column12_row0,
        column12_row1,
        column12_row192,
        column12_row193,
        column12_row196,
        column12_row197,
        column12_row251,
        column12_row252,
        column12_row256,
        column13_row0,
        column13_row255,
        column14_row0,
        column14_row255,
        column15_row0,
        column15_row255,
        column16_row0,
        column16_row255,
        column17_row0,
        column17_row1,
        column17_row2,
        column17_row3,
        column17_row4,
        column17_row5,
        column17_row6,
        column17_row7,
        column17_row8,
        column17_row9,
        column17_row12,
        column17_row13,
        column17_row16,
        column17_row22,
        column17_row23,
        column17_row38,
        column17_row39,
        column17_row70,
        column17_row71,
        column17_row102,
        column17_row103,
        column17_row134,
        column17_row135,
        column17_row167,
        column17_row199,
        column17_row230,
        column17_row263,
        column17_row295,
        column17_row327,
        column17_row391,
        column17_row423,
        column17_row455,
        column17_row4118,
        column17_row4119,
        column17_row8214,
        column18_row0,
        column18_row1,
        column18_row2,
        column18_row3,
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
        column19_row11,
        column19_row12,
        column19_row13,
        column19_row15,
        column19_row17,
        column19_row23,
        column19_row25,
        column19_row28,
        column19_row31,
        column19_row44,
        column19_row60,
        column19_row76,
        column19_row92,
        column19_row108,
        column19_row124,
        column19_row4103,
        column19_row4111,
        column20_row0,
        column20_row1,
        column20_row2,
        column20_row4,
        column20_row6,
        column20_row8,
        column20_row10,
        column20_row12,
        column20_row14,
        column20_row16,
        column20_row17,
        column20_row20,
        column20_row22,
        column20_row24,
        column20_row30,
        column20_row38,
        column20_row46,
        column20_row54,
        column20_row81,
        column20_row145,
        column20_row209,
        column20_row4080,
        column20_row4082,
        column20_row4088,
        column20_row4090,
        column20_row4092,
        column20_row8161,
        column20_row8166,
        column20_row8176,
        column20_row8178,
        column20_row8182,
        column20_row8184,
        column20_row8186,
        column20_row8190,
        column21_inter1_row0,
        column21_inter1_row1,
        column21_inter1_row2,
        column21_inter1_row5
    ] =
        (*mask_values
        .multi_pop_front::<200>()
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
    let npc_reg_0 = column17_row0 + cpu_decode_opcode_range_check_bit_2 + 1;
    let cpu_decode_opcode_range_check_bit_10 = column0_row10 - (column0_row11 + column0_row11);
    let cpu_decode_opcode_range_check_bit_11 = column0_row11 - (column0_row12 + column0_row12);
    let cpu_decode_opcode_range_check_bit_14 = column0_row14 - (column0_row15 + column0_row15);
    let memory_address_diff_0 = column18_row2 - column18_row0;
    let range_check16_diff_0 = column19_row6 - column19_row2;
    let pedersen_hash0_ec_subset_sum_bit_0 = column3_row0 - (column3_row1 + column3_row1);
    let pedersen_hash0_ec_subset_sum_bit_neg_0 = 1 - pedersen_hash0_ec_subset_sum_bit_0;
    let pedersen_hash1_ec_subset_sum_bit_0 = column6_row0 - (column6_row1 + column6_row1);
    let pedersen_hash1_ec_subset_sum_bit_neg_0 = 1 - pedersen_hash1_ec_subset_sum_bit_0;
    let pedersen_hash2_ec_subset_sum_bit_0 = column9_row0 - (column9_row1 + column9_row1);
    let pedersen_hash2_ec_subset_sum_bit_neg_0 = 1 - pedersen_hash2_ec_subset_sum_bit_0;
    let pedersen_hash3_ec_subset_sum_bit_0 = column12_row0 - (column12_row1 + column12_row1);
    let pedersen_hash3_ec_subset_sum_bit_neg_0 = 1 - pedersen_hash3_ec_subset_sum_bit_0;
    let range_check_builtin_value0_0 = column19_row12;
    let range_check_builtin_value1_0 = range_check_builtin_value0_0 * global_values.offset_size
        + column19_row28;
    let range_check_builtin_value2_0 = range_check_builtin_value1_0 * global_values.offset_size
        + column19_row44;
    let range_check_builtin_value3_0 = range_check_builtin_value2_0 * global_values.offset_size
        + column19_row60;
    let range_check_builtin_value4_0 = range_check_builtin_value3_0 * global_values.offset_size
        + column19_row76;
    let range_check_builtin_value5_0 = range_check_builtin_value4_0 * global_values.offset_size
        + column19_row92;
    let range_check_builtin_value6_0 = range_check_builtin_value5_0 * global_values.offset_size
        + column19_row108;
    let range_check_builtin_value7_0 = range_check_builtin_value6_0 * global_values.offset_size
        + column19_row124;
    let ecdsa_signature0_doubling_key_x_squared = column19_row7 * column19_row7;
    let ecdsa_signature0_exponentiate_generator_bit_0 = column20_row14
        - (column20_row46 + column20_row46);
    let ecdsa_signature0_exponentiate_generator_bit_neg_0 = 1
        - ecdsa_signature0_exponentiate_generator_bit_0;
    let ecdsa_signature0_exponentiate_key_bit_0 = column20_row4 - (column20_row20 + column20_row20);
    let ecdsa_signature0_exponentiate_key_bit_neg_0 = 1 - ecdsa_signature0_exponentiate_key_bit_0;

    // Sum constraints.
    let total_sum = 0;

    // Constraint: cpu/decode/opcode_range_check/bit.
    let value = (cpu_decode_opcode_range_check_bit_0 * cpu_decode_opcode_range_check_bit_0
        - cpu_decode_opcode_range_check_bit_0)
        * domain4
        / domain0;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/decode/opcode_range_check/zero.
    let value = (column0_row0) / domain4;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/decode/opcode_range_check_input.
    let value = (column17_row1
        - (((column0_row0 * global_values.offset_size + column19_row4) * global_values.offset_size
            + column19_row8)
            * global_values.offset_size
            + column19_row0))
        / domain5;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/decode/flag_op1_base_op0_bit.
    let value = (cpu_decode_flag_op1_base_op0_0 * cpu_decode_flag_op1_base_op0_0
        - cpu_decode_flag_op1_base_op0_0)
        / domain5;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/decode/flag_res_op1_bit.
    let value = (cpu_decode_flag_res_op1_0 * cpu_decode_flag_res_op1_0 - cpu_decode_flag_res_op1_0)
        / domain5;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/decode/flag_pc_update_regular_bit.
    let value = (cpu_decode_flag_pc_update_regular_0 * cpu_decode_flag_pc_update_regular_0
        - cpu_decode_flag_pc_update_regular_0)
        / domain5;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/decode/fp_update_regular_bit.
    let value = (cpu_decode_fp_update_regular_0 * cpu_decode_fp_update_regular_0
        - cpu_decode_fp_update_regular_0)
        / domain5;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/operands/mem_dst_addr.
    let value = (column17_row8
        + global_values.half_offset_size
        - (cpu_decode_opcode_range_check_bit_0 * column19_row9
            + (1 - cpu_decode_opcode_range_check_bit_0) * column19_row1
            + column19_row0))
        / domain5;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/operands/mem0_addr.
    let value = (column17_row4
        + global_values.half_offset_size
        - (cpu_decode_opcode_range_check_bit_1 * column19_row9
            + (1 - cpu_decode_opcode_range_check_bit_1) * column19_row1
            + column19_row8))
        / domain5;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/operands/mem1_addr.
    let value = (column17_row12
        + global_values.half_offset_size
        - (cpu_decode_opcode_range_check_bit_2 * column17_row0
            + cpu_decode_opcode_range_check_bit_4 * column19_row1
            + cpu_decode_opcode_range_check_bit_3 * column19_row9
            + cpu_decode_flag_op1_base_op0_0 * column17_row5
            + column19_row4))
        / domain5;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/operands/ops_mul.
    let value = (column19_row5 - column17_row5 * column17_row13) / domain5;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/operands/res.
    let value = ((1 - cpu_decode_opcode_range_check_bit_9) * column19_row13
        - (cpu_decode_opcode_range_check_bit_5 * (column17_row5 + column17_row13)
            + cpu_decode_opcode_range_check_bit_6 * column19_row5
            + cpu_decode_flag_res_op1_0 * column17_row13))
        / domain5;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/update_registers/update_pc/tmp0.
    let value = (column19_row3 - cpu_decode_opcode_range_check_bit_9 * column17_row9)
        * domain19
        / domain5;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/update_registers/update_pc/tmp1.
    let value = (column19_row11 - column19_row3 * column19_row13) * domain19 / domain5;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/update_registers/update_pc/pc_cond_negative.
    let value = ((1 - cpu_decode_opcode_range_check_bit_9) * column17_row16
        + column19_row3 * (column17_row16 - (column17_row0 + column17_row13))
        - (cpu_decode_flag_pc_update_regular_0 * npc_reg_0
            + cpu_decode_opcode_range_check_bit_7 * column19_row13
            + cpu_decode_opcode_range_check_bit_8 * (column17_row0 + column19_row13)))
        * domain19
        / domain5;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/update_registers/update_pc/pc_cond_positive.
    let value = ((column19_row11 - cpu_decode_opcode_range_check_bit_9)
        * (column17_row16 - npc_reg_0))
        * domain19
        / domain5;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/update_registers/update_ap/ap_update.
    let value = (column19_row17
        - (column19_row1
            + cpu_decode_opcode_range_check_bit_10 * column19_row13
            + cpu_decode_opcode_range_check_bit_11
            + cpu_decode_opcode_range_check_bit_12 * 2))
        * domain19
        / domain5;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/update_registers/update_fp/fp_update.
    let value = (column19_row25
        - (cpu_decode_fp_update_regular_0 * column19_row9
            + cpu_decode_opcode_range_check_bit_13 * column17_row9
            + cpu_decode_opcode_range_check_bit_12 * (column19_row1 + 2)))
        * domain19
        / domain5;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/opcodes/call/push_fp.
    let value = (cpu_decode_opcode_range_check_bit_12 * (column17_row9 - column19_row9)) / domain5;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/opcodes/call/push_pc.
    let value = (cpu_decode_opcode_range_check_bit_12
        * (column17_row5 - (column17_row0 + cpu_decode_opcode_range_check_bit_2 + 1)))
        / domain5;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/opcodes/call/off0.
    let value = (cpu_decode_opcode_range_check_bit_12
        * (column19_row0 - global_values.half_offset_size))
        / domain5;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/opcodes/call/off1.
    let value = (cpu_decode_opcode_range_check_bit_12
        * (column19_row8 - (global_values.half_offset_size + 1)))
        / domain5;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/opcodes/call/flags.
    let value = (cpu_decode_opcode_range_check_bit_12
        * (cpu_decode_opcode_range_check_bit_12
            + cpu_decode_opcode_range_check_bit_12
            + 1
            + 1
            - (cpu_decode_opcode_range_check_bit_0 + cpu_decode_opcode_range_check_bit_1 + 4)))
        / domain5;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/opcodes/ret/off0.
    let value = (cpu_decode_opcode_range_check_bit_13
        * (column19_row0 + 2 - global_values.half_offset_size))
        / domain5;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/opcodes/ret/off2.
    let value = (cpu_decode_opcode_range_check_bit_13
        * (column19_row4 + 1 - global_values.half_offset_size))
        / domain5;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/opcodes/ret/flags.
    let value = (cpu_decode_opcode_range_check_bit_13
        * (cpu_decode_opcode_range_check_bit_7
            + cpu_decode_opcode_range_check_bit_0
            + cpu_decode_opcode_range_check_bit_3
            + cpu_decode_flag_res_op1_0
            - 4))
        / domain5;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/opcodes/assert_eq/assert_eq.
    let value = (cpu_decode_opcode_range_check_bit_14 * (column17_row9 - column19_row13)) / domain5;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: initial_ap.
    let value = (column19_row1 - global_values.initial_ap) / domain20;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: initial_fp.
    let value = (column19_row9 - global_values.initial_ap) / domain20;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: initial_pc.
    let value = (column17_row0 - global_values.initial_pc) / domain20;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: final_ap.
    let value = (column19_row1 - global_values.final_ap) / domain19;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: final_fp.
    let value = (column19_row9 - global_values.initial_ap) / domain19;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: final_pc.
    let value = (column17_row0 - global_values.final_pc) / domain19;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: memory/multi_column_perm/perm/init0.
    let value = ((global_values.memory_multi_column_perm_perm_interaction_elm
        - (column18_row0
            + global_values.memory_multi_column_perm_hash_interaction_elm0 * column18_row1))
        * column21_inter1_row0
        + column17_row0
        + global_values.memory_multi_column_perm_hash_interaction_elm0 * column17_row1
        - global_values.memory_multi_column_perm_perm_interaction_elm)
        / domain20;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: memory/multi_column_perm/perm/step0.
    let value = ((global_values.memory_multi_column_perm_perm_interaction_elm
        - (column18_row2
            + global_values.memory_multi_column_perm_hash_interaction_elm0 * column18_row3))
        * column21_inter1_row2
        - (global_values.memory_multi_column_perm_perm_interaction_elm
            - (column17_row2
                + global_values.memory_multi_column_perm_hash_interaction_elm0 * column17_row3))
            * column21_inter1_row0)
        * domain21
        / domain1;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: memory/multi_column_perm/perm/last.
    let value = (column21_inter1_row0
        - global_values.memory_multi_column_perm_perm_public_memory_prod)
        / domain21;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: memory/diff_is_bit.
    let value = (memory_address_diff_0 * memory_address_diff_0 - memory_address_diff_0)
        * domain21
        / domain1;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: memory/is_func.
    let value = ((memory_address_diff_0 - 1) * (column18_row1 - column18_row3))
        * domain21
        / domain1;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: memory/initial_addr.
    let value = (column18_row0 - 1) / domain20;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: public_memory_addr_zero.
    let value = (column17_row2) / domain3;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: public_memory_value_zero.
    let value = (column17_row3) / domain3;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: range_check16/perm/init0.
    let value = ((global_values.range_check16_perm_interaction_elm - column19_row2)
        * column21_inter1_row1
        + column19_row0
        - global_values.range_check16_perm_interaction_elm)
        / domain20;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: range_check16/perm/step0.
    let value = ((global_values.range_check16_perm_interaction_elm - column19_row6)
        * column21_inter1_row5
        - (global_values.range_check16_perm_interaction_elm - column19_row4) * column21_inter1_row1)
        * domain22
        / domain2;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: range_check16/perm/last.
    let value = (column21_inter1_row1 - global_values.range_check16_perm_public_memory_prod)
        / domain22;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: range_check16/diff_is_bit.
    let value = (range_check16_diff_0 * range_check16_diff_0 - range_check16_diff_0)
        * domain22
        / domain2;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: range_check16/minimum.
    let value = (column19_row2 - global_values.range_check_min) / domain20;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: range_check16/maximum.
    let value = (column19_row2 - global_values.range_check_max) / domain22;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash0/ec_subset_sum/bit_unpacking/last_one_is_zero.
    let value = (column14_row255 * (column3_row0 - (column3_row1 + column3_row1))) / domain8;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash0/ec_subset_sum/bit_unpacking/zeroes_between_ones0.
    let value = (column14_row255
        * (column3_row1
            - 3138550867693340381917894711603833208051177722232017256448 * column3_row192))
        / domain8;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash0/ec_subset_sum/bit_unpacking/cumulative_bit192.
    let value = (column14_row255
        - column13_row255 * (column3_row192 - (column3_row193 + column3_row193)))
        / domain8;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash0/ec_subset_sum/bit_unpacking/zeroes_between_ones192.
    let value = (column13_row255 * (column3_row193 - 8 * column3_row196)) / domain8;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash0/ec_subset_sum/bit_unpacking/cumulative_bit196.
    let value = (column13_row255
        - (column3_row251 - (column3_row252 + column3_row252))
            * (column3_row196 - (column3_row197 + column3_row197)))
        / domain8;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash0/ec_subset_sum/bit_unpacking/zeroes_between_ones196.
    let value = ((column3_row251 - (column3_row252 + column3_row252))
        * (column3_row197 - 18014398509481984 * column3_row251))
        / domain8;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash0/ec_subset_sum/booleanity_test.
    let value = (pedersen_hash0_ec_subset_sum_bit_0 * (pedersen_hash0_ec_subset_sum_bit_0 - 1))
        * domain9
        / domain0;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash0/ec_subset_sum/bit_extraction_end.
    let value = (column3_row0) / domain10;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash0/ec_subset_sum/zeros_tail.
    let value = (column3_row0) / domain9;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash0/ec_subset_sum/add_points/slope.
    let value = (pedersen_hash0_ec_subset_sum_bit_0
        * (column2_row0 - global_values.pedersen_points_y)
        - column13_row0 * (column1_row0 - global_values.pedersen_points_x))
        * domain9
        / domain0;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash0/ec_subset_sum/add_points/x.
    let value = (column13_row0 * column13_row0
        - pedersen_hash0_ec_subset_sum_bit_0
            * (column1_row0 + global_values.pedersen_points_x + column1_row1))
        * domain9
        / domain0;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash0/ec_subset_sum/add_points/y.
    let value = (pedersen_hash0_ec_subset_sum_bit_0 * (column2_row0 + column2_row1)
        - column13_row0 * (column1_row0 - column1_row1))
        * domain9
        / domain0;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash0/ec_subset_sum/copy_point/x.
    let value = (pedersen_hash0_ec_subset_sum_bit_neg_0 * (column1_row1 - column1_row0))
        * domain9
        / domain0;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash0/ec_subset_sum/copy_point/y.
    let value = (pedersen_hash0_ec_subset_sum_bit_neg_0 * (column2_row1 - column2_row0))
        * domain9
        / domain0;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash0/copy_point/x.
    let value = (column1_row256 - column1_row255) * domain11 / domain8;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash0/copy_point/y.
    let value = (column2_row256 - column2_row255) * domain11 / domain8;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash0/init/x.
    let value = (column1_row0 - global_values.pedersen_shift_point.x) / domain12;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash0/init/y.
    let value = (column2_row0 - global_values.pedersen_shift_point.y) / domain12;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash1/ec_subset_sum/bit_unpacking/last_one_is_zero.
    let value = (column16_row255 * (column6_row0 - (column6_row1 + column6_row1))) / domain8;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash1/ec_subset_sum/bit_unpacking/zeroes_between_ones0.
    let value = (column16_row255
        * (column6_row1
            - 3138550867693340381917894711603833208051177722232017256448 * column6_row192))
        / domain8;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash1/ec_subset_sum/bit_unpacking/cumulative_bit192.
    let value = (column16_row255
        - column15_row255 * (column6_row192 - (column6_row193 + column6_row193)))
        / domain8;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash1/ec_subset_sum/bit_unpacking/zeroes_between_ones192.
    let value = (column15_row255 * (column6_row193 - 8 * column6_row196)) / domain8;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash1/ec_subset_sum/bit_unpacking/cumulative_bit196.
    let value = (column15_row255
        - (column6_row251 - (column6_row252 + column6_row252))
            * (column6_row196 - (column6_row197 + column6_row197)))
        / domain8;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash1/ec_subset_sum/bit_unpacking/zeroes_between_ones196.
    let value = ((column6_row251 - (column6_row252 + column6_row252))
        * (column6_row197 - 18014398509481984 * column6_row251))
        / domain8;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash1/ec_subset_sum/booleanity_test.
    let value = (pedersen_hash1_ec_subset_sum_bit_0 * (pedersen_hash1_ec_subset_sum_bit_0 - 1))
        * domain9
        / domain0;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash1/ec_subset_sum/bit_extraction_end.
    let value = (column6_row0) / domain10;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash1/ec_subset_sum/zeros_tail.
    let value = (column6_row0) / domain9;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash1/ec_subset_sum/add_points/slope.
    let value = (pedersen_hash1_ec_subset_sum_bit_0
        * (column5_row0 - global_values.pedersen_points_y)
        - column14_row0 * (column4_row0 - global_values.pedersen_points_x))
        * domain9
        / domain0;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash1/ec_subset_sum/add_points/x.
    let value = (column14_row0 * column14_row0
        - pedersen_hash1_ec_subset_sum_bit_0
            * (column4_row0 + global_values.pedersen_points_x + column4_row1))
        * domain9
        / domain0;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash1/ec_subset_sum/add_points/y.
    let value = (pedersen_hash1_ec_subset_sum_bit_0 * (column5_row0 + column5_row1)
        - column14_row0 * (column4_row0 - column4_row1))
        * domain9
        / domain0;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash1/ec_subset_sum/copy_point/x.
    let value = (pedersen_hash1_ec_subset_sum_bit_neg_0 * (column4_row1 - column4_row0))
        * domain9
        / domain0;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash1/ec_subset_sum/copy_point/y.
    let value = (pedersen_hash1_ec_subset_sum_bit_neg_0 * (column5_row1 - column5_row0))
        * domain9
        / domain0;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash1/copy_point/x.
    let value = (column4_row256 - column4_row255) * domain11 / domain8;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash1/copy_point/y.
    let value = (column5_row256 - column5_row255) * domain11 / domain8;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash1/init/x.
    let value = (column4_row0 - global_values.pedersen_shift_point.x) / domain12;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash1/init/y.
    let value = (column5_row0 - global_values.pedersen_shift_point.y) / domain12;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash2/ec_subset_sum/bit_unpacking/last_one_is_zero.
    let value = (column20_row145 * (column9_row0 - (column9_row1 + column9_row1))) / domain8;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash2/ec_subset_sum/bit_unpacking/zeroes_between_ones0.
    let value = (column20_row145
        * (column9_row1
            - 3138550867693340381917894711603833208051177722232017256448 * column9_row192))
        / domain8;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash2/ec_subset_sum/bit_unpacking/cumulative_bit192.
    let value = (column20_row145
        - column20_row17 * (column9_row192 - (column9_row193 + column9_row193)))
        / domain8;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash2/ec_subset_sum/bit_unpacking/zeroes_between_ones192.
    let value = (column20_row17 * (column9_row193 - 8 * column9_row196)) / domain8;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash2/ec_subset_sum/bit_unpacking/cumulative_bit196.
    let value = (column20_row17
        - (column9_row251 - (column9_row252 + column9_row252))
            * (column9_row196 - (column9_row197 + column9_row197)))
        / domain8;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash2/ec_subset_sum/bit_unpacking/zeroes_between_ones196.
    let value = ((column9_row251 - (column9_row252 + column9_row252))
        * (column9_row197 - 18014398509481984 * column9_row251))
        / domain8;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash2/ec_subset_sum/booleanity_test.
    let value = (pedersen_hash2_ec_subset_sum_bit_0 * (pedersen_hash2_ec_subset_sum_bit_0 - 1))
        * domain9
        / domain0;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash2/ec_subset_sum/bit_extraction_end.
    let value = (column9_row0) / domain10;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash2/ec_subset_sum/zeros_tail.
    let value = (column9_row0) / domain9;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash2/ec_subset_sum/add_points/slope.
    let value = (pedersen_hash2_ec_subset_sum_bit_0
        * (column8_row0 - global_values.pedersen_points_y)
        - column15_row0 * (column7_row0 - global_values.pedersen_points_x))
        * domain9
        / domain0;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash2/ec_subset_sum/add_points/x.
    let value = (column15_row0 * column15_row0
        - pedersen_hash2_ec_subset_sum_bit_0
            * (column7_row0 + global_values.pedersen_points_x + column7_row1))
        * domain9
        / domain0;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash2/ec_subset_sum/add_points/y.
    let value = (pedersen_hash2_ec_subset_sum_bit_0 * (column8_row0 + column8_row1)
        - column15_row0 * (column7_row0 - column7_row1))
        * domain9
        / domain0;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash2/ec_subset_sum/copy_point/x.
    let value = (pedersen_hash2_ec_subset_sum_bit_neg_0 * (column7_row1 - column7_row0))
        * domain9
        / domain0;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash2/ec_subset_sum/copy_point/y.
    let value = (pedersen_hash2_ec_subset_sum_bit_neg_0 * (column8_row1 - column8_row0))
        * domain9
        / domain0;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash2/copy_point/x.
    let value = (column7_row256 - column7_row255) * domain11 / domain8;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash2/copy_point/y.
    let value = (column8_row256 - column8_row255) * domain11 / domain8;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash2/init/x.
    let value = (column7_row0 - global_values.pedersen_shift_point.x) / domain12;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash2/init/y.
    let value = (column8_row0 - global_values.pedersen_shift_point.y) / domain12;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash3/ec_subset_sum/bit_unpacking/last_one_is_zero.
    let value = (column20_row209 * (column12_row0 - (column12_row1 + column12_row1))) / domain8;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash3/ec_subset_sum/bit_unpacking/zeroes_between_ones0.
    let value = (column20_row209
        * (column12_row1
            - 3138550867693340381917894711603833208051177722232017256448 * column12_row192))
        / domain8;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash3/ec_subset_sum/bit_unpacking/cumulative_bit192.
    let value = (column20_row209
        - column20_row81 * (column12_row192 - (column12_row193 + column12_row193)))
        / domain8;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash3/ec_subset_sum/bit_unpacking/zeroes_between_ones192.
    let value = (column20_row81 * (column12_row193 - 8 * column12_row196)) / domain8;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash3/ec_subset_sum/bit_unpacking/cumulative_bit196.
    let value = (column20_row81
        - (column12_row251 - (column12_row252 + column12_row252))
            * (column12_row196 - (column12_row197 + column12_row197)))
        / domain8;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash3/ec_subset_sum/bit_unpacking/zeroes_between_ones196.
    let value = ((column12_row251 - (column12_row252 + column12_row252))
        * (column12_row197 - 18014398509481984 * column12_row251))
        / domain8;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash3/ec_subset_sum/booleanity_test.
    let value = (pedersen_hash3_ec_subset_sum_bit_0 * (pedersen_hash3_ec_subset_sum_bit_0 - 1))
        * domain9
        / domain0;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash3/ec_subset_sum/bit_extraction_end.
    let value = (column12_row0) / domain10;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash3/ec_subset_sum/zeros_tail.
    let value = (column12_row0) / domain9;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash3/ec_subset_sum/add_points/slope.
    let value = (pedersen_hash3_ec_subset_sum_bit_0
        * (column11_row0 - global_values.pedersen_points_y)
        - column16_row0 * (column10_row0 - global_values.pedersen_points_x))
        * domain9
        / domain0;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash3/ec_subset_sum/add_points/x.
    let value = (column16_row0 * column16_row0
        - pedersen_hash3_ec_subset_sum_bit_0
            * (column10_row0 + global_values.pedersen_points_x + column10_row1))
        * domain9
        / domain0;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash3/ec_subset_sum/add_points/y.
    let value = (pedersen_hash3_ec_subset_sum_bit_0 * (column11_row0 + column11_row1)
        - column16_row0 * (column10_row0 - column10_row1))
        * domain9
        / domain0;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash3/ec_subset_sum/copy_point/x.
    let value = (pedersen_hash3_ec_subset_sum_bit_neg_0 * (column10_row1 - column10_row0))
        * domain9
        / domain0;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash3/ec_subset_sum/copy_point/y.
    let value = (pedersen_hash3_ec_subset_sum_bit_neg_0 * (column11_row1 - column11_row0))
        * domain9
        / domain0;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash3/copy_point/x.
    let value = (column10_row256 - column10_row255) * domain11 / domain8;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash3/copy_point/y.
    let value = (column11_row256 - column11_row255) * domain11 / domain8;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash3/init/x.
    let value = (column10_row0 - global_values.pedersen_shift_point.x) / domain12;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash3/init/y.
    let value = (column11_row0 - global_values.pedersen_shift_point.y) / domain12;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/input0_value0.
    let value = (column17_row7 - column3_row0) / domain12;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/input0_value1.
    let value = (column17_row135 - column6_row0) / domain12;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/input0_value2.
    let value = (column17_row263 - column9_row0) / domain12;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/input0_value3.
    let value = (column17_row391 - column12_row0) / domain12;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/input0_addr.
    let value = (column17_row134 - (column17_row38 + 1)) * domain23 / domain7;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/init_addr.
    let value = (column17_row6 - global_values.initial_pedersen_addr) / domain20;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/input1_value0.
    let value = (column17_row71 - column3_row256) / domain12;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/input1_value1.
    let value = (column17_row199 - column6_row256) / domain12;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/input1_value2.
    let value = (column17_row327 - column9_row256) / domain12;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/input1_value3.
    let value = (column17_row455 - column12_row256) / domain12;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/input1_addr.
    let value = (column17_row70 - (column17_row6 + 1)) / domain7;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/output_value0.
    let value = (column17_row39 - column1_row511) / domain12;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/output_value1.
    let value = (column17_row167 - column4_row511) / domain12;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/output_value2.
    let value = (column17_row295 - column7_row511) / domain12;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/output_value3.
    let value = (column17_row423 - column10_row511) / domain12;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/output_addr.
    let value = (column17_row38 - (column17_row70 + 1)) / domain7;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: range_check_builtin/value.
    let value = (range_check_builtin_value7_0 - column17_row103) / domain7;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: range_check_builtin/addr_step.
    let value = (column17_row230 - (column17_row102 + 1)) * domain23 / domain7;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: range_check_builtin/init_addr.
    let value = (column17_row102 - global_values.initial_range_check_addr) / domain20;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/doubling_key/slope.
    let value = (ecdsa_signature0_doubling_key_x_squared
        + ecdsa_signature0_doubling_key_x_squared
        + ecdsa_signature0_doubling_key_x_squared
        + global_values.ecdsa_sig_config.alpha
        - (column19_row15 + column19_row15) * column20_row12)
        * domain13
        / domain5;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/doubling_key/x.
    let value = (column20_row12 * column20_row12 - (column19_row7 + column19_row7 + column19_row23))
        * domain13
        / domain5;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/doubling_key/y.
    let value = (column19_row15
        + column19_row31
        - column20_row12 * (column19_row7 - column19_row23))
        * domain13
        / domain5;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/exponentiate_generator/booleanity_test.
    let value = (ecdsa_signature0_exponentiate_generator_bit_0
        * (ecdsa_signature0_exponentiate_generator_bit_0 - 1))
        * domain16
        / domain6;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/exponentiate_generator/bit_extraction_end.
    let value = (column20_row14) / domain17;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/exponentiate_generator/zeros_tail.
    let value = (column20_row14) / domain16;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/exponentiate_generator/add_points/slope.
    let value = (ecdsa_signature0_exponentiate_generator_bit_0
        * (column20_row22 - global_values.ecdsa_generator_points_y)
        - column20_row30 * (column20_row6 - global_values.ecdsa_generator_points_x))
        * domain16
        / domain6;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/exponentiate_generator/add_points/x.
    let value = (column20_row30 * column20_row30
        - ecdsa_signature0_exponentiate_generator_bit_0
            * (column20_row6 + global_values.ecdsa_generator_points_x + column20_row38))
        * domain16
        / domain6;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/exponentiate_generator/add_points/y.
    let value = (ecdsa_signature0_exponentiate_generator_bit_0 * (column20_row22 + column20_row54)
        - column20_row30 * (column20_row6 - column20_row38))
        * domain16
        / domain6;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/exponentiate_generator/add_points/x_diff_inv.
    let value = (column20_row1 * (column20_row6 - global_values.ecdsa_generator_points_x) - 1)
        * domain16
        / domain6;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/exponentiate_generator/copy_point/x.
    let value = (ecdsa_signature0_exponentiate_generator_bit_neg_0
        * (column20_row38 - column20_row6))
        * domain16
        / domain6;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/exponentiate_generator/copy_point/y.
    let value = (ecdsa_signature0_exponentiate_generator_bit_neg_0
        * (column20_row54 - column20_row22))
        * domain16
        / domain6;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/exponentiate_key/booleanity_test.
    let value = (ecdsa_signature0_exponentiate_key_bit_0
        * (ecdsa_signature0_exponentiate_key_bit_0 - 1))
        * domain13
        / domain5;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/exponentiate_key/bit_extraction_end.
    let value = (column20_row4) / domain14;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/exponentiate_key/zeros_tail.
    let value = (column20_row4) / domain13;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/exponentiate_key/add_points/slope.
    let value = (ecdsa_signature0_exponentiate_key_bit_0 * (column20_row8 - column19_row15)
        - column20_row2 * (column20_row0 - column19_row7))
        * domain13
        / domain5;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/exponentiate_key/add_points/x.
    let value = (column20_row2 * column20_row2
        - ecdsa_signature0_exponentiate_key_bit_0
            * (column20_row0 + column19_row7 + column20_row16))
        * domain13
        / domain5;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/exponentiate_key/add_points/y.
    let value = (ecdsa_signature0_exponentiate_key_bit_0 * (column20_row8 + column20_row24)
        - column20_row2 * (column20_row0 - column20_row16))
        * domain13
        / domain5;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/exponentiate_key/add_points/x_diff_inv.
    let value = (column20_row10 * (column20_row0 - column19_row7) - 1) * domain13 / domain5;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/exponentiate_key/copy_point/x.
    let value = (ecdsa_signature0_exponentiate_key_bit_neg_0 * (column20_row16 - column20_row0))
        * domain13
        / domain5;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/exponentiate_key/copy_point/y.
    let value = (ecdsa_signature0_exponentiate_key_bit_neg_0 * (column20_row24 - column20_row8))
        * domain13
        / domain5;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/init_gen/x.
    let value = (column20_row6 - global_values.ecdsa_sig_config.shift_point.x) / domain18;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/init_gen/y.
    let value = (column20_row22 + global_values.ecdsa_sig_config.shift_point.y) / domain18;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/init_key/x.
    let value = (column20_row0 - global_values.ecdsa_sig_config.shift_point.x) / domain15;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/init_key/y.
    let value = (column20_row8 - global_values.ecdsa_sig_config.shift_point.y) / domain15;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/add_results/slope.
    let value = (column20_row8182
        - (column20_row4088 + column20_row8190 * (column20_row8166 - column20_row4080)))
        / domain18;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/add_results/x.
    let value = (column20_row8190 * column20_row8190
        - (column20_row8166 + column20_row4080 + column19_row4103))
        / domain18;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/add_results/y.
    let value = (column20_row8182
        + column19_row4111
        - column20_row8190 * (column20_row8166 - column19_row4103))
        / domain18;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/add_results/x_diff_inv.
    let value = (column20_row8161 * (column20_row8166 - column20_row4080) - 1) / domain18;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/extract_r/slope.
    let value = (column20_row8184
        + global_values.ecdsa_sig_config.shift_point.y
        - column20_row4082 * (column20_row8176 - global_values.ecdsa_sig_config.shift_point.x))
        / domain18;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/extract_r/x.
    let value = (column20_row4082 * column20_row4082
        - (column20_row8176 + global_values.ecdsa_sig_config.shift_point.x + column20_row4))
        / domain18;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/extract_r/x_diff_inv.
    let value = (column20_row8178
        * (column20_row8176 - global_values.ecdsa_sig_config.shift_point.x)
        - 1)
        / domain18;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/z_nonzero.
    let value = (column20_row14 * column20_row4090 - 1) / domain18;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/r_and_w_nonzero.
    let value = (column20_row4 * column20_row4092 - 1) / domain15;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/q_on_curve/x_squared.
    let value = (column20_row8186 - column19_row7 * column19_row7) / domain18;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/signature0/q_on_curve/on_curve.
    let value = (column19_row15 * column19_row15
        - (column19_row7 * column20_row8186
            + global_values.ecdsa_sig_config.alpha * column19_row7
            + global_values.ecdsa_sig_config.beta))
        / domain18;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/init_addr.
    let value = (column17_row22 - global_values.initial_ecdsa_addr) / domain20;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/message_addr.
    let value = (column17_row4118 - (column17_row22 + 1)) / domain18;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/pubkey_addr.
    let value = (column17_row8214 - (column17_row4118 + 1)) * domain24 / domain18;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/message_value0.
    let value = (column17_row4119 - column20_row14) / domain18;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: ecdsa/pubkey_value0.
    let value = (column17_row23 - column19_row7) / domain18;
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
    let pow1 = pow(trace_generator, 8161);
    let pow2 = pow(trace_generator, 4080);
    let pow3 = pow(trace_generator, 1);
    let pow4 = pow3 * pow3; // pow(trace_generator, 2).
    let pow5 = pow2 * pow4; // pow(trace_generator, 4082).
    let pow6 = pow3 * pow4; // pow(trace_generator, 3).
    let pow7 = pow3 * pow6; // pow(trace_generator, 4).
    let pow8 = pow3 * pow7; // pow(trace_generator, 5).
    let pow9 = pow1 * pow8; // pow(trace_generator, 8166).
    let pow10 = pow3 * pow8; // pow(trace_generator, 6).
    let pow11 = pow3 * pow10; // pow(trace_generator, 7).
    let pow12 = pow3 * pow11; // pow(trace_generator, 8).
    let pow13 = pow2 * pow12; // pow(trace_generator, 4088).
    let pow14 = pow3 * pow12; // pow(trace_generator, 9).
    let pow15 = pow3 * pow14; // pow(trace_generator, 10).
    let pow16 = pow2 * pow15; // pow(trace_generator, 4090).
    let pow17 = pow3 * pow15; // pow(trace_generator, 11).
    let pow18 = pow3 * pow17; // pow(trace_generator, 12).
    let pow19 = pow3 * pow18; // pow(trace_generator, 13).
    let pow20 = pow3 * pow19; // pow(trace_generator, 14).
    let pow21 = pow3 * pow20; // pow(trace_generator, 15).
    let pow22 = pow3 * pow21; // pow(trace_generator, 16).
    let pow23 = pow3 * pow22; // pow(trace_generator, 17).
    let pow24 = pow6 * pow23; // pow(trace_generator, 20).
    let pow25 = pow4 * pow24; // pow(trace_generator, 22).
    let pow26 = pow3 * pow25; // pow(trace_generator, 23).
    let pow27 = pow3 * pow26; // pow(trace_generator, 24).
    let pow28 = pow3 * pow27; // pow(trace_generator, 25).
    let pow29 = pow6 * pow28; // pow(trace_generator, 28).
    let pow30 = pow4 * pow29; // pow(trace_generator, 30).
    let pow31 = pow3 * pow30; // pow(trace_generator, 31).
    let pow32 = pow1 * pow21; // pow(trace_generator, 8176).
    let pow33 = pow1 * pow23; // pow(trace_generator, 8178).
    let pow34 = pow11 * pow31; // pow(trace_generator, 38).
    let pow35 = pow3 * pow34; // pow(trace_generator, 39).
    let pow36 = pow8 * pow35; // pow(trace_generator, 44).
    let pow37 = pow4 * pow36; // pow(trace_generator, 46).
    let pow38 = pow12 * pow37; // pow(trace_generator, 54).
    let pow39 = pow10 * pow38; // pow(trace_generator, 60).
    let pow40 = pow15 * pow39; // pow(trace_generator, 70).
    let pow41 = pow3 * pow40; // pow(trace_generator, 71).
    let pow42 = pow8 * pow41; // pow(trace_generator, 76).
    let pow43 = pow8 * pow42; // pow(trace_generator, 81).
    let pow44 = pow17 * pow43; // pow(trace_generator, 92).
    let pow45 = pow15 * pow44; // pow(trace_generator, 102).
    let pow46 = pow3 * pow45; // pow(trace_generator, 103).
    let pow47 = pow8 * pow46; // pow(trace_generator, 108).
    let pow48 = pow22 * pow47; // pow(trace_generator, 124).
    let pow49 = pow15 * pow48; // pow(trace_generator, 134).
    let pow50 = pow3 * pow49; // pow(trace_generator, 135).
    let pow51 = pow15 * pow50; // pow(trace_generator, 145).
    let pow52 = pow25 * pow51; // pow(trace_generator, 167).
    let pow53 = pow28 * pow52; // pow(trace_generator, 192).
    let pow54 = pow3 * pow53; // pow(trace_generator, 193).
    let pow55 = pow6 * pow54; // pow(trace_generator, 196).
    let pow56 = pow3 * pow55; // pow(trace_generator, 197).
    let pow57 = pow38 * pow56; // pow(trace_generator, 251).
    let pow58 = pow4 * pow56; // pow(trace_generator, 199).
    let pow59 = pow31 * pow58; // pow(trace_generator, 230).
    let pow60 = pow3 * pow57; // pow(trace_generator, 252).
    let pow61 = pow2 * pow18; // pow(trace_generator, 4092).
    let pow62 = pow7 * pow33; // pow(trace_generator, 8182).
    let pow63 = pow1 * pow26; // pow(trace_generator, 8184).
    let pow64 = pow1 * pow28; // pow(trace_generator, 8186).
    let pow65 = pow7 * pow64; // pow(trace_generator, 8190).
    let pow66 = pow2 * pow26; // pow(trace_generator, 4103).
    let pow67 = pow2 * pow31; // pow(trace_generator, 4111).
    let pow68 = pow27 * pow65; // pow(trace_generator, 8214).
    let pow69 = pow2 * pow34; // pow(trace_generator, 4118).
    let pow70 = pow2 * pow35; // pow(trace_generator, 4119).
    let pow71 = pow15 * pow58; // pow(trace_generator, 209).
    let pow72 = pow6 * pow60; // pow(trace_generator, 255).
    let pow73 = pow3 * pow72; // pow(trace_generator, 256).
    let pow74 = pow72 * pow73; // pow(trace_generator, 511).
    let pow75 = pow52 * pow73; // pow(trace_generator, 423).
    let pow76 = pow50 * pow73; // pow(trace_generator, 391).
    let pow77 = pow41 * pow73; // pow(trace_generator, 327).
    let pow78 = pow35 * pow73; // pow(trace_generator, 295).
    let pow79 = pow11 * pow73; // pow(trace_generator, 263).
    let pow80 = pow53 * pow79; // pow(trace_generator, 455).

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
        column21
    ] =
        (*column_values
        .multi_pop_front::<22>()
        .unwrap())
        .unbox();

    // Sum the OODS constraints on the trace polynomials.
    let total_sum = 0;

    let value = (column0 - *oods_values.pop_front().unwrap()) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column0 - *oods_values.pop_front().unwrap()) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column0 - *oods_values.pop_front().unwrap()) / (point - pow4 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column0 - *oods_values.pop_front().unwrap()) / (point - pow6 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column0 - *oods_values.pop_front().unwrap()) / (point - pow7 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column0 - *oods_values.pop_front().unwrap()) / (point - pow8 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column0 - *oods_values.pop_front().unwrap()) / (point - pow10 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column0 - *oods_values.pop_front().unwrap()) / (point - pow11 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column0 - *oods_values.pop_front().unwrap()) / (point - pow12 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column0 - *oods_values.pop_front().unwrap()) / (point - pow14 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column0 - *oods_values.pop_front().unwrap()) / (point - pow15 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column0 - *oods_values.pop_front().unwrap()) / (point - pow17 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column0 - *oods_values.pop_front().unwrap()) / (point - pow18 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column0 - *oods_values.pop_front().unwrap()) / (point - pow19 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column0 - *oods_values.pop_front().unwrap()) / (point - pow20 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column0 - *oods_values.pop_front().unwrap()) / (point - pow21 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column1 - *oods_values.pop_front().unwrap()) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column1 - *oods_values.pop_front().unwrap()) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column1 - *oods_values.pop_front().unwrap()) / (point - pow72 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column1 - *oods_values.pop_front().unwrap()) / (point - pow73 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column1 - *oods_values.pop_front().unwrap()) / (point - pow74 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column2 - *oods_values.pop_front().unwrap()) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column2 - *oods_values.pop_front().unwrap()) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column2 - *oods_values.pop_front().unwrap()) / (point - pow72 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column2 - *oods_values.pop_front().unwrap()) / (point - pow73 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column3 - *oods_values.pop_front().unwrap()) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column3 - *oods_values.pop_front().unwrap()) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column3 - *oods_values.pop_front().unwrap()) / (point - pow53 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column3 - *oods_values.pop_front().unwrap()) / (point - pow54 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column3 - *oods_values.pop_front().unwrap()) / (point - pow55 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column3 - *oods_values.pop_front().unwrap()) / (point - pow56 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column3 - *oods_values.pop_front().unwrap()) / (point - pow57 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column3 - *oods_values.pop_front().unwrap()) / (point - pow60 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column3 - *oods_values.pop_front().unwrap()) / (point - pow73 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column4 - *oods_values.pop_front().unwrap()) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column4 - *oods_values.pop_front().unwrap()) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column4 - *oods_values.pop_front().unwrap()) / (point - pow72 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column4 - *oods_values.pop_front().unwrap()) / (point - pow73 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column4 - *oods_values.pop_front().unwrap()) / (point - pow74 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow72 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow73 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column6 - *oods_values.pop_front().unwrap()) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column6 - *oods_values.pop_front().unwrap()) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column6 - *oods_values.pop_front().unwrap()) / (point - pow53 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column6 - *oods_values.pop_front().unwrap()) / (point - pow54 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column6 - *oods_values.pop_front().unwrap()) / (point - pow55 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column6 - *oods_values.pop_front().unwrap()) / (point - pow56 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column6 - *oods_values.pop_front().unwrap()) / (point - pow57 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column6 - *oods_values.pop_front().unwrap()) / (point - pow60 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column6 - *oods_values.pop_front().unwrap()) / (point - pow73 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column7 - *oods_values.pop_front().unwrap()) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column7 - *oods_values.pop_front().unwrap()) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column7 - *oods_values.pop_front().unwrap()) / (point - pow72 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column7 - *oods_values.pop_front().unwrap()) / (point - pow73 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column7 - *oods_values.pop_front().unwrap()) / (point - pow74 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column8 - *oods_values.pop_front().unwrap()) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column8 - *oods_values.pop_front().unwrap()) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column8 - *oods_values.pop_front().unwrap()) / (point - pow72 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column8 - *oods_values.pop_front().unwrap()) / (point - pow73 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column9 - *oods_values.pop_front().unwrap()) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column9 - *oods_values.pop_front().unwrap()) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column9 - *oods_values.pop_front().unwrap()) / (point - pow53 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column9 - *oods_values.pop_front().unwrap()) / (point - pow54 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column9 - *oods_values.pop_front().unwrap()) / (point - pow55 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column9 - *oods_values.pop_front().unwrap()) / (point - pow56 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column9 - *oods_values.pop_front().unwrap()) / (point - pow57 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column9 - *oods_values.pop_front().unwrap()) / (point - pow60 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column9 - *oods_values.pop_front().unwrap()) / (point - pow73 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column10 - *oods_values.pop_front().unwrap()) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column10 - *oods_values.pop_front().unwrap()) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column10 - *oods_values.pop_front().unwrap()) / (point - pow72 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column10 - *oods_values.pop_front().unwrap()) / (point - pow73 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column10 - *oods_values.pop_front().unwrap()) / (point - pow74 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column11 - *oods_values.pop_front().unwrap()) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column11 - *oods_values.pop_front().unwrap()) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column11 - *oods_values.pop_front().unwrap()) / (point - pow72 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column11 - *oods_values.pop_front().unwrap()) / (point - pow73 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column12 - *oods_values.pop_front().unwrap()) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column12 - *oods_values.pop_front().unwrap()) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column12 - *oods_values.pop_front().unwrap()) / (point - pow53 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column12 - *oods_values.pop_front().unwrap()) / (point - pow54 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column12 - *oods_values.pop_front().unwrap()) / (point - pow55 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column12 - *oods_values.pop_front().unwrap()) / (point - pow56 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column12 - *oods_values.pop_front().unwrap()) / (point - pow57 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column12 - *oods_values.pop_front().unwrap()) / (point - pow60 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column12 - *oods_values.pop_front().unwrap()) / (point - pow73 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column13 - *oods_values.pop_front().unwrap()) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column13 - *oods_values.pop_front().unwrap()) / (point - pow72 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column14 - *oods_values.pop_front().unwrap()) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column14 - *oods_values.pop_front().unwrap()) / (point - pow72 * oods_point);
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

    let value = (column17 - *oods_values.pop_front().unwrap()) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column17 - *oods_values.pop_front().unwrap()) / (point - pow4 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column17 - *oods_values.pop_front().unwrap()) / (point - pow6 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column17 - *oods_values.pop_front().unwrap()) / (point - pow7 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column17 - *oods_values.pop_front().unwrap()) / (point - pow8 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column17 - *oods_values.pop_front().unwrap()) / (point - pow10 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column17 - *oods_values.pop_front().unwrap()) / (point - pow11 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column17 - *oods_values.pop_front().unwrap()) / (point - pow12 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column17 - *oods_values.pop_front().unwrap()) / (point - pow14 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column17 - *oods_values.pop_front().unwrap()) / (point - pow18 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column17 - *oods_values.pop_front().unwrap()) / (point - pow19 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column17 - *oods_values.pop_front().unwrap()) / (point - pow22 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column17 - *oods_values.pop_front().unwrap()) / (point - pow25 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column17 - *oods_values.pop_front().unwrap()) / (point - pow26 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column17 - *oods_values.pop_front().unwrap()) / (point - pow34 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column17 - *oods_values.pop_front().unwrap()) / (point - pow35 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column17 - *oods_values.pop_front().unwrap()) / (point - pow40 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column17 - *oods_values.pop_front().unwrap()) / (point - pow41 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column17 - *oods_values.pop_front().unwrap()) / (point - pow45 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column17 - *oods_values.pop_front().unwrap()) / (point - pow46 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column17 - *oods_values.pop_front().unwrap()) / (point - pow49 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column17 - *oods_values.pop_front().unwrap()) / (point - pow50 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column17 - *oods_values.pop_front().unwrap()) / (point - pow52 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column17 - *oods_values.pop_front().unwrap()) / (point - pow58 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column17 - *oods_values.pop_front().unwrap()) / (point - pow59 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column17 - *oods_values.pop_front().unwrap()) / (point - pow79 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column17 - *oods_values.pop_front().unwrap()) / (point - pow78 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column17 - *oods_values.pop_front().unwrap()) / (point - pow77 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column17 - *oods_values.pop_front().unwrap()) / (point - pow76 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column17 - *oods_values.pop_front().unwrap()) / (point - pow75 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column17 - *oods_values.pop_front().unwrap()) / (point - pow80 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column17 - *oods_values.pop_front().unwrap()) / (point - pow69 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column17 - *oods_values.pop_front().unwrap()) / (point - pow70 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column17 - *oods_values.pop_front().unwrap()) / (point - pow68 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column18 - *oods_values.pop_front().unwrap()) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column18 - *oods_values.pop_front().unwrap()) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column18 - *oods_values.pop_front().unwrap()) / (point - pow4 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column18 - *oods_values.pop_front().unwrap()) / (point - pow6 * oods_point);
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

    let value = (column19 - *oods_values.pop_front().unwrap()) / (point - pow10 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column19 - *oods_values.pop_front().unwrap()) / (point - pow11 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column19 - *oods_values.pop_front().unwrap()) / (point - pow12 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column19 - *oods_values.pop_front().unwrap()) / (point - pow14 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column19 - *oods_values.pop_front().unwrap()) / (point - pow17 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column19 - *oods_values.pop_front().unwrap()) / (point - pow18 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column19 - *oods_values.pop_front().unwrap()) / (point - pow19 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column19 - *oods_values.pop_front().unwrap()) / (point - pow21 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column19 - *oods_values.pop_front().unwrap()) / (point - pow23 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column19 - *oods_values.pop_front().unwrap()) / (point - pow26 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column19 - *oods_values.pop_front().unwrap()) / (point - pow28 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column19 - *oods_values.pop_front().unwrap()) / (point - pow29 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column19 - *oods_values.pop_front().unwrap()) / (point - pow31 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column19 - *oods_values.pop_front().unwrap()) / (point - pow36 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column19 - *oods_values.pop_front().unwrap()) / (point - pow39 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column19 - *oods_values.pop_front().unwrap()) / (point - pow42 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column19 - *oods_values.pop_front().unwrap()) / (point - pow44 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column19 - *oods_values.pop_front().unwrap()) / (point - pow47 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column19 - *oods_values.pop_front().unwrap()) / (point - pow48 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column19 - *oods_values.pop_front().unwrap()) / (point - pow66 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column19 - *oods_values.pop_front().unwrap()) / (point - pow67 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column20 - *oods_values.pop_front().unwrap()) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column20 - *oods_values.pop_front().unwrap()) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column20 - *oods_values.pop_front().unwrap()) / (point - pow4 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column20 - *oods_values.pop_front().unwrap()) / (point - pow7 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column20 - *oods_values.pop_front().unwrap()) / (point - pow10 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column20 - *oods_values.pop_front().unwrap()) / (point - pow12 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column20 - *oods_values.pop_front().unwrap()) / (point - pow15 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column20 - *oods_values.pop_front().unwrap()) / (point - pow18 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column20 - *oods_values.pop_front().unwrap()) / (point - pow20 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column20 - *oods_values.pop_front().unwrap()) / (point - pow22 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column20 - *oods_values.pop_front().unwrap()) / (point - pow23 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column20 - *oods_values.pop_front().unwrap()) / (point - pow24 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column20 - *oods_values.pop_front().unwrap()) / (point - pow25 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column20 - *oods_values.pop_front().unwrap()) / (point - pow27 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column20 - *oods_values.pop_front().unwrap()) / (point - pow30 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column20 - *oods_values.pop_front().unwrap()) / (point - pow34 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column20 - *oods_values.pop_front().unwrap()) / (point - pow37 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column20 - *oods_values.pop_front().unwrap()) / (point - pow38 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column20 - *oods_values.pop_front().unwrap()) / (point - pow43 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column20 - *oods_values.pop_front().unwrap()) / (point - pow51 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column20 - *oods_values.pop_front().unwrap()) / (point - pow71 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column20 - *oods_values.pop_front().unwrap()) / (point - pow2 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column20 - *oods_values.pop_front().unwrap()) / (point - pow5 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column20 - *oods_values.pop_front().unwrap()) / (point - pow13 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column20 - *oods_values.pop_front().unwrap()) / (point - pow16 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column20 - *oods_values.pop_front().unwrap()) / (point - pow61 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column20 - *oods_values.pop_front().unwrap()) / (point - pow1 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column20 - *oods_values.pop_front().unwrap()) / (point - pow9 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column20 - *oods_values.pop_front().unwrap()) / (point - pow32 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column20 - *oods_values.pop_front().unwrap()) / (point - pow33 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column20 - *oods_values.pop_front().unwrap()) / (point - pow62 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column20 - *oods_values.pop_front().unwrap()) / (point - pow63 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column20 - *oods_values.pop_front().unwrap()) / (point - pow64 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column20 - *oods_values.pop_front().unwrap()) / (point - pow65 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column21 - *oods_values.pop_front().unwrap()) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column21 - *oods_values.pop_front().unwrap()) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column21 - *oods_values.pop_front().unwrap()) / (point - pow4 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column21 - *oods_values.pop_front().unwrap()) / (point - pow8 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Sum the OODS boundary constraints on the composition polynomials.
    let oods_point_to_deg = pow(oods_point, CONSTRAINT_DEGREE.into());

    let value = (*column_values.pop_front().unwrap() - *oods_values.pop_front().unwrap())
        / (point - oods_point_to_deg);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (*column_values.pop_front().unwrap() - *oods_values.pop_front().unwrap())
        / (point - oods_point_to_deg);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    assert(202 == MASK_SIZE + CONSTRAINT_DEGREE, 'Autogenerated assert failed');
    total_sum
}

