use integrity::{
    air::layouts::recursive_with_poseidon::{
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
    let pow0 = pow(point, global_values.trace_length / 4096);
    let pow1 = pow0 * pow0; // pow(point, (safe_div(global_values.trace_length, 2048))).
    let pow2 = pow1 * pow1; // pow(point, (safe_div(global_values.trace_length, 1024))).
    let pow3 = pow2 * pow2; // pow(point, (safe_div(global_values.trace_length, 512))).
    let pow4 = pow3 * pow3; // pow(point, (safe_div(global_values.trace_length, 256))).
    let pow5 = pow4 * pow4; // pow(point, (safe_div(global_values.trace_length, 128))).
    let pow6 = pow5 * pow5; // pow(point, (safe_div(global_values.trace_length, 64))).
    let pow7 = pow6 * pow6; // pow(point, (safe_div(global_values.trace_length, 32))).
    let pow8 = pow7 * pow7; // pow(point, (safe_div(global_values.trace_length, 16))).
    let pow9 = pow8 * pow8; // pow(point, (safe_div(global_values.trace_length, 8))).
    let pow10 = pow9 * pow9; // pow(point, (safe_div(global_values.trace_length, 4))).
    let pow11 = pow10 * pow10; // pow(point, (safe_div(global_values.trace_length, 2))).
    let pow12 = pow11 * pow11; // pow(point, global_values.trace_length).
    let pow13 = pow(trace_generator, global_values.trace_length - 512);
    let pow14 = pow(trace_generator, global_values.trace_length - 256);
    let pow15 = pow(trace_generator, global_values.trace_length - 4096);
    let pow16 = pow(trace_generator, global_values.trace_length - 4);
    let pow17 = pow(trace_generator, global_values.trace_length - 2);
    let pow18 = pow(trace_generator, global_values.trace_length - 16);
    let pow19 = pow(trace_generator, global_values.trace_length / 2);
    let pow20 = pow(trace_generator, (255 * global_values.trace_length) / 256);
    let pow21 = pow(trace_generator, global_values.trace_length / 64);
    let pow22 = pow21 * pow21; // pow(trace_generator, (safe_div(global_values.trace_length, 32))).
    let pow23 = pow21
        * pow22; // pow(trace_generator, (safe_div((safe_mult(3, global_values.trace_length)), 64))).
    let pow24 = pow21 * pow23; // pow(trace_generator, (safe_div(global_values.trace_length, 16))).
    let pow25 = pow21
        * pow24; // pow(trace_generator, (safe_div((safe_mult(5, global_values.trace_length)), 64))).
    let pow26 = pow21
        * pow25; // pow(trace_generator, (safe_div((safe_mult(3, global_values.trace_length)), 32))).
    let pow27 = pow19
        * pow26; // pow(trace_generator, (safe_div((safe_mult(19, global_values.trace_length)), 32))).
    let pow28 = pow21
        * pow26; // pow(trace_generator, (safe_div((safe_mult(7, global_values.trace_length)), 64))).
    let pow29 = pow21 * pow28; // pow(trace_generator, (safe_div(global_values.trace_length, 8))).
    let pow30 = pow19
        * pow29; // pow(trace_generator, (safe_div((safe_mult(5, global_values.trace_length)), 8))).
    let pow31 = pow21
        * pow29; // pow(trace_generator, (safe_div((safe_mult(9, global_values.trace_length)), 64))).
    let pow32 = pow21
        * pow31; // pow(trace_generator, (safe_div((safe_mult(5, global_values.trace_length)), 32))).
    let pow33 = pow19
        * pow32; // pow(trace_generator, (safe_div((safe_mult(21, global_values.trace_length)), 32))).
    let pow34 = pow21
        * pow32; // pow(trace_generator, (safe_div((safe_mult(11, global_values.trace_length)), 64))).
    let pow35 = pow21
        * pow34; // pow(trace_generator, (safe_div((safe_mult(3, global_values.trace_length)), 16))).
    let pow36 = pow19
        * pow35; // pow(trace_generator, (safe_div((safe_mult(11, global_values.trace_length)), 16))).
    let pow37 = pow21
        * pow35; // pow(trace_generator, (safe_div((safe_mult(13, global_values.trace_length)), 64))).
    let pow38 = pow21
        * pow37; // pow(trace_generator, (safe_div((safe_mult(7, global_values.trace_length)), 32))).
    let pow39 = pow19
        * pow38; // pow(trace_generator, (safe_div((safe_mult(23, global_values.trace_length)), 32))).
    let pow40 = pow21
        * pow38; // pow(trace_generator, (safe_div((safe_mult(15, global_values.trace_length)), 64))).
    let pow41 = pow22
        * pow39; // pow(trace_generator, (safe_div((safe_mult(3, global_values.trace_length)), 4))).
    let pow42 = pow22
        * pow41; // pow(trace_generator, (safe_div((safe_mult(25, global_values.trace_length)), 32))).
    let pow43 = pow22
        * pow42; // pow(trace_generator, (safe_div((safe_mult(13, global_values.trace_length)), 16))).
    let pow44 = pow22
        * pow43; // pow(trace_generator, (safe_div((safe_mult(27, global_values.trace_length)), 32))).
    let pow45 = pow22
        * pow44; // pow(trace_generator, (safe_div((safe_mult(7, global_values.trace_length)), 8))).
    let pow46 = pow22
        * pow45; // pow(trace_generator, (safe_div((safe_mult(29, global_values.trace_length)), 32))).
    let pow47 = pow22
        * pow46; // pow(trace_generator, (safe_div((safe_mult(15, global_values.trace_length)), 16))).
    let pow48 = pow21
        * pow47; // pow(trace_generator, (safe_div((safe_mult(61, global_values.trace_length)), 64))).
    let pow49 = pow21
        * pow48; // pow(trace_generator, (safe_div((safe_mult(31, global_values.trace_length)), 32))).
    let pow50 = pow21
        * pow49; // pow(trace_generator, (safe_div((safe_mult(63, global_values.trace_length)), 64))).

    // Compute domains.
    let domain0 = pow12 - 1;
    let domain1 = pow11 - 1;
    let domain2 = pow10 - 1;
    let domain3 = pow9 - 1;
    let domain4 = pow8 - pow47;
    let domain5 = pow8 - 1;
    let domain6 = pow7 - 1;
    let domain7 = pow6 - 1;
    let domain8 = pow5 - 1;
    let domain9 = pow4 - 1;
    let domain10 = pow4 - pow41;
    let temp = pow4 - pow21;
    let temp = temp * (pow4 - pow22);
    let temp = temp * (pow4 - pow23);
    let temp = temp * (pow4 - pow24);
    let temp = temp * (pow4 - pow25);
    let temp = temp * (pow4 - pow26);
    let temp = temp * (pow4 - pow28);
    let temp = temp * (pow4 - pow29);
    let temp = temp * (pow4 - pow31);
    let temp = temp * (pow4 - pow32);
    let temp = temp * (pow4 - pow34);
    let temp = temp * (pow4 - pow35);
    let temp = temp * (pow4 - pow37);
    let temp = temp * (pow4 - pow38);
    let temp = temp * (pow4 - pow40);
    let domain11 = temp * (domain9);
    let domain12 = pow3 - 1;
    let domain13 = pow3 - pow41;
    let domain14 = pow2 - pow49;
    let temp = pow2 - pow36;
    let temp = temp * (pow2 - pow39);
    let temp = temp * (pow2 - pow41);
    let temp = temp * (pow2 - pow42);
    let temp = temp * (pow2 - pow43);
    let temp = temp * (pow2 - pow44);
    let temp = temp * (pow2 - pow45);
    let temp = temp * (pow2 - pow46);
    let temp = temp * (pow2 - pow47);
    let domain15 = temp * (domain14);
    let domain16 = pow2 - 1;
    let temp = pow2 - pow48;
    let temp = temp * (pow2 - pow50);
    let domain17 = temp * (domain14);
    let temp = pow2 - pow27;
    let temp = temp * (pow2 - pow30);
    let temp = temp * (pow2 - pow33);
    let domain18 = temp * (domain15);
    let domain19 = pow1 - 1;
    let domain20 = pow1 - pow20;
    let domain21 = pow1 - pow50;
    let domain22 = pow0 - pow19;
    let domain23 = pow0 - 1;
    let domain24 = point - pow18;
    let domain25 = point - 1;
    let domain26 = point - pow17;
    let domain27 = point - pow16;
    let domain28 = point - pow15;
    let domain29 = point - pow14;
    let domain30 = point - pow13;

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
        column1_row3,
        column1_row4,
        column1_row5,
        column1_row8,
        column1_row9,
        column1_row10,
        column1_row11,
        column1_row12,
        column1_row13,
        column1_row16,
        column1_row42,
        column1_row43,
        column1_row74,
        column1_row75,
        column1_row106,
        column1_row138,
        column1_row139,
        column1_row171,
        column1_row202,
        column1_row203,
        column1_row234,
        column1_row235,
        column1_row266,
        column1_row267,
        column1_row298,
        column1_row394,
        column1_row458,
        column1_row459,
        column1_row714,
        column1_row715,
        column1_row778,
        column1_row779,
        column1_row970,
        column1_row971,
        column1_row1034,
        column1_row1035,
        column1_row2058,
        column1_row2059,
        column1_row4106,
        column2_row0,
        column2_row1,
        column2_row2,
        column2_row3,
        column3_row0,
        column3_row1,
        column3_row2,
        column3_row3,
        column3_row4,
        column3_row8,
        column3_row12,
        column3_row16,
        column3_row20,
        column3_row24,
        column3_row28,
        column3_row32,
        column3_row36,
        column3_row40,
        column3_row44,
        column3_row48,
        column3_row52,
        column3_row56,
        column3_row60,
        column3_row64,
        column3_row66,
        column3_row128,
        column3_row130,
        column3_row176,
        column3_row180,
        column3_row184,
        column3_row188,
        column3_row192,
        column3_row194,
        column3_row240,
        column3_row244,
        column3_row248,
        column3_row252,
        column4_row0,
        column4_row1,
        column4_row2,
        column4_row3,
        column4_row4,
        column4_row5,
        column4_row6,
        column4_row7,
        column4_row8,
        column4_row9,
        column4_row11,
        column4_row12,
        column4_row13,
        column4_row44,
        column4_row76,
        column4_row108,
        column4_row140,
        column4_row172,
        column4_row204,
        column4_row236,
        column4_row1539,
        column4_row1547,
        column4_row1571,
        column4_row1579,
        column4_row2011,
        column4_row2019,
        column4_row2041,
        column4_row2045,
        column4_row2047,
        column4_row2049,
        column4_row2051,
        column4_row2053,
        column4_row4089,
        column5_row0,
        column5_row1,
        column5_row2,
        column5_row4,
        column5_row6,
        column5_row8,
        column5_row9,
        column5_row10,
        column5_row12,
        column5_row14,
        column5_row16,
        column5_row17,
        column5_row22,
        column5_row24,
        column5_row25,
        column5_row30,
        column5_row33,
        column5_row38,
        column5_row41,
        column5_row46,
        column5_row49,
        column5_row54,
        column5_row57,
        column5_row65,
        column5_row73,
        column5_row81,
        column5_row89,
        column5_row97,
        column5_row105,
        column5_row137,
        column5_row169,
        column5_row201,
        column5_row393,
        column5_row409,
        column5_row425,
        column5_row457,
        column5_row473,
        column5_row489,
        column5_row521,
        column5_row553,
        column5_row585,
        column5_row609,
        column5_row625,
        column5_row641,
        column5_row657,
        column5_row673,
        column5_row689,
        column5_row905,
        column5_row921,
        column5_row937,
        column5_row969,
        column5_row982,
        column5_row985,
        column5_row998,
        column5_row1001,
        column5_row1014,
        column6_inter1_row0,
        column6_inter1_row1,
        column6_inter1_row2,
        column6_inter1_row3,
        column7_inter1_row0,
        column7_inter1_row1,
        column7_inter1_row2,
        column7_inter1_row5
    ] =
        (*mask_values
        .multi_pop_front::<192>()
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
    let npc_reg_0 = column1_row0 + cpu_decode_opcode_range_check_bit_2 + 1;
    let cpu_decode_opcode_range_check_bit_10 = column0_row10 - (column0_row11 + column0_row11);
    let cpu_decode_opcode_range_check_bit_11 = column0_row11 - (column0_row12 + column0_row12);
    let cpu_decode_opcode_range_check_bit_14 = column0_row14 - (column0_row15 + column0_row15);
    let memory_address_diff_0 = column2_row2 - column2_row0;
    let range_check16_diff_0 = column4_row6 - column4_row2;
    let pedersen_hash0_ec_subset_sum_bit_0 = column4_row3 - (column4_row11 + column4_row11);
    let pedersen_hash0_ec_subset_sum_bit_neg_0 = 1 - pedersen_hash0_ec_subset_sum_bit_0;
    let range_check_builtin_value0_0 = column4_row12;
    let range_check_builtin_value1_0 = range_check_builtin_value0_0 * global_values.offset_size
        + column4_row44;
    let range_check_builtin_value2_0 = range_check_builtin_value1_0 * global_values.offset_size
        + column4_row76;
    let range_check_builtin_value3_0 = range_check_builtin_value2_0 * global_values.offset_size
        + column4_row108;
    let range_check_builtin_value4_0 = range_check_builtin_value3_0 * global_values.offset_size
        + column4_row140;
    let range_check_builtin_value5_0 = range_check_builtin_value4_0 * global_values.offset_size
        + column4_row172;
    let range_check_builtin_value6_0 = range_check_builtin_value5_0 * global_values.offset_size
        + column4_row204;
    let range_check_builtin_value7_0 = range_check_builtin_value6_0 * global_values.offset_size
        + column4_row236;
    let bitwise_sum_var_0_0 = column3_row0
        + column3_row4 * 2
        + column3_row8 * 4
        + column3_row12 * 8
        + column3_row16 * 18446744073709551616
        + column3_row20 * 36893488147419103232
        + column3_row24 * 73786976294838206464
        + column3_row28 * 147573952589676412928;
    let bitwise_sum_var_8_0 = column3_row32 * 340282366920938463463374607431768211456
        + column3_row36 * 680564733841876926926749214863536422912
        + column3_row40 * 1361129467683753853853498429727072845824
        + column3_row44 * 2722258935367507707706996859454145691648
        + column3_row48 * 6277101735386680763835789423207666416102355444464034512896
        + column3_row52 * 12554203470773361527671578846415332832204710888928069025792
        + column3_row56 * 25108406941546723055343157692830665664409421777856138051584
        + column3_row60 * 50216813883093446110686315385661331328818843555712276103168;
    let poseidon_poseidon_full_rounds_state0_cubed_0 = column5_row9 * column5_row105;
    let poseidon_poseidon_full_rounds_state1_cubed_0 = column5_row73 * column5_row25;
    let poseidon_poseidon_full_rounds_state2_cubed_0 = column5_row41 * column5_row89;
    let poseidon_poseidon_full_rounds_state0_cubed_7 = column5_row905 * column5_row1001;
    let poseidon_poseidon_full_rounds_state1_cubed_7 = column5_row969 * column5_row921;
    let poseidon_poseidon_full_rounds_state2_cubed_7 = column5_row937 * column5_row985;
    let poseidon_poseidon_full_rounds_state0_cubed_3 = column5_row393 * column5_row489;
    let poseidon_poseidon_full_rounds_state1_cubed_3 = column5_row457 * column5_row409;
    let poseidon_poseidon_full_rounds_state2_cubed_3 = column5_row425 * column5_row473;
    let poseidon_poseidon_partial_rounds_state0_cubed_0 = column5_row6 * column5_row14;
    let poseidon_poseidon_partial_rounds_state0_cubed_1 = column5_row22 * column5_row30;
    let poseidon_poseidon_partial_rounds_state0_cubed_2 = column5_row38 * column5_row46;
    let poseidon_poseidon_partial_rounds_state1_cubed_0 = column5_row1 * column5_row17;
    let poseidon_poseidon_partial_rounds_state1_cubed_1 = column5_row33 * column5_row49;
    let poseidon_poseidon_partial_rounds_state1_cubed_2 = column5_row65 * column5_row81;
    let poseidon_poseidon_partial_rounds_state1_cubed_19 = column5_row609 * column5_row625;
    let poseidon_poseidon_partial_rounds_state1_cubed_20 = column5_row641 * column5_row657;
    let poseidon_poseidon_partial_rounds_state1_cubed_21 = column5_row673 * column5_row689;

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
    let value = (column1_row1
        - (((column0_row0 * global_values.offset_size + column4_row4) * global_values.offset_size
            + column4_row8)
            * global_values.offset_size
            + column4_row0))
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
    let value = (column1_row8
        + global_values.half_offset_size
        - (cpu_decode_opcode_range_check_bit_0 * column5_row8
            + (1 - cpu_decode_opcode_range_check_bit_0) * column5_row0
            + column4_row0))
        / domain5;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/operands/mem0_addr.
    let value = (column1_row4
        + global_values.half_offset_size
        - (cpu_decode_opcode_range_check_bit_1 * column5_row8
            + (1 - cpu_decode_opcode_range_check_bit_1) * column5_row0
            + column4_row8))
        / domain5;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/operands/mem1_addr.
    let value = (column1_row12
        + global_values.half_offset_size
        - (cpu_decode_opcode_range_check_bit_2 * column1_row0
            + cpu_decode_opcode_range_check_bit_4 * column5_row0
            + cpu_decode_opcode_range_check_bit_3 * column5_row8
            + cpu_decode_flag_op1_base_op0_0 * column1_row5
            + column4_row4))
        / domain5;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/operands/ops_mul.
    let value = (column5_row4 - column1_row5 * column1_row13) / domain5;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/operands/res.
    let value = ((1 - cpu_decode_opcode_range_check_bit_9) * column5_row12
        - (cpu_decode_opcode_range_check_bit_5 * (column1_row5 + column1_row13)
            + cpu_decode_opcode_range_check_bit_6 * column5_row4
            + cpu_decode_flag_res_op1_0 * column1_row13))
        / domain5;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/update_registers/update_pc/tmp0.
    let value = (column5_row2 - cpu_decode_opcode_range_check_bit_9 * column1_row9)
        * domain24
        / domain5;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/update_registers/update_pc/tmp1.
    let value = (column5_row10 - column5_row2 * column5_row12) * domain24 / domain5;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/update_registers/update_pc/pc_cond_negative.
    let value = ((1 - cpu_decode_opcode_range_check_bit_9) * column1_row16
        + column5_row2 * (column1_row16 - (column1_row0 + column1_row13))
        - (cpu_decode_flag_pc_update_regular_0 * npc_reg_0
            + cpu_decode_opcode_range_check_bit_7 * column5_row12
            + cpu_decode_opcode_range_check_bit_8 * (column1_row0 + column5_row12)))
        * domain24
        / domain5;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/update_registers/update_pc/pc_cond_positive.
    let value = ((column5_row10 - cpu_decode_opcode_range_check_bit_9)
        * (column1_row16 - npc_reg_0))
        * domain24
        / domain5;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/update_registers/update_ap/ap_update.
    let value = (column5_row16
        - (column5_row0
            + cpu_decode_opcode_range_check_bit_10 * column5_row12
            + cpu_decode_opcode_range_check_bit_11
            + cpu_decode_opcode_range_check_bit_12 * 2))
        * domain24
        / domain5;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/update_registers/update_fp/fp_update.
    let value = (column5_row24
        - (cpu_decode_fp_update_regular_0 * column5_row8
            + cpu_decode_opcode_range_check_bit_13 * column1_row9
            + cpu_decode_opcode_range_check_bit_12 * (column5_row0 + 2)))
        * domain24
        / domain5;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/opcodes/call/push_fp.
    let value = (cpu_decode_opcode_range_check_bit_12 * (column1_row9 - column5_row8)) / domain5;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/opcodes/call/push_pc.
    let value = (cpu_decode_opcode_range_check_bit_12
        * (column1_row5 - (column1_row0 + cpu_decode_opcode_range_check_bit_2 + 1)))
        / domain5;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/opcodes/call/off0.
    let value = (cpu_decode_opcode_range_check_bit_12
        * (column4_row0 - global_values.half_offset_size))
        / domain5;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/opcodes/call/off1.
    let value = (cpu_decode_opcode_range_check_bit_12
        * (column4_row8 - (global_values.half_offset_size + 1)))
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
        * (column4_row0 + 2 - global_values.half_offset_size))
        / domain5;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: cpu/opcodes/ret/off2.
    let value = (cpu_decode_opcode_range_check_bit_13
        * (column4_row4 + 1 - global_values.half_offset_size))
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
    let value = (cpu_decode_opcode_range_check_bit_14 * (column1_row9 - column5_row12)) / domain5;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: initial_ap.
    let value = (column5_row0 - global_values.initial_ap) / domain25;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: initial_fp.
    let value = (column5_row8 - global_values.initial_ap) / domain25;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: initial_pc.
    let value = (column1_row0 - global_values.initial_pc) / domain25;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: final_ap.
    let value = (column5_row0 - global_values.final_ap) / domain24;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: final_fp.
    let value = (column5_row8 - global_values.initial_ap) / domain24;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: final_pc.
    let value = (column1_row0 - global_values.final_pc) / domain24;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: memory/multi_column_perm/perm/init0.
    let value = ((global_values.memory_multi_column_perm_perm_interaction_elm
        - (column2_row0
            + global_values.memory_multi_column_perm_hash_interaction_elm0 * column2_row1))
        * column6_inter1_row0
        + column1_row0
        + global_values.memory_multi_column_perm_hash_interaction_elm0 * column1_row1
        - global_values.memory_multi_column_perm_perm_interaction_elm)
        / domain25;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: memory/multi_column_perm/perm/step0.
    let value = ((global_values.memory_multi_column_perm_perm_interaction_elm
        - (column2_row2
            + global_values.memory_multi_column_perm_hash_interaction_elm0 * column2_row3))
        * column6_inter1_row2
        - (global_values.memory_multi_column_perm_perm_interaction_elm
            - (column1_row2
                + global_values.memory_multi_column_perm_hash_interaction_elm0 * column1_row3))
            * column6_inter1_row0)
        * domain26
        / domain1;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: memory/multi_column_perm/perm/last.
    let value = (column6_inter1_row0
        - global_values.memory_multi_column_perm_perm_public_memory_prod)
        / domain26;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: memory/diff_is_bit.
    let value = (memory_address_diff_0 * memory_address_diff_0 - memory_address_diff_0)
        * domain26
        / domain1;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: memory/is_func.
    let value = ((memory_address_diff_0 - 1) * (column2_row1 - column2_row3)) * domain26 / domain1;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: memory/initial_addr.
    let value = (column2_row0 - 1) / domain25;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: public_memory_addr_zero.
    let value = (column1_row2) / domain5;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: public_memory_value_zero.
    let value = (column1_row3) / domain5;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: range_check16/perm/init0.
    let value = ((global_values.range_check16_perm_interaction_elm - column4_row2)
        * column7_inter1_row1
        + column4_row0
        - global_values.range_check16_perm_interaction_elm)
        / domain25;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: range_check16/perm/step0.
    let value = ((global_values.range_check16_perm_interaction_elm - column4_row6)
        * column7_inter1_row5
        - (global_values.range_check16_perm_interaction_elm - column4_row4) * column7_inter1_row1)
        * domain27
        / domain2;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: range_check16/perm/last.
    let value = (column7_inter1_row1 - global_values.range_check16_perm_public_memory_prod)
        / domain27;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: range_check16/diff_is_bit.
    let value = (range_check16_diff_0 * range_check16_diff_0 - range_check16_diff_0)
        * domain27
        / domain2;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: range_check16/minimum.
    let value = (column4_row2 - global_values.range_check_min) / domain25;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: range_check16/maximum.
    let value = (column4_row2 - global_values.range_check_max) / domain27;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: diluted_check/permutation/init0.
    let value = ((global_values.diluted_check_permutation_interaction_elm - column3_row1)
        * column7_inter1_row0
        + column3_row0
        - global_values.diluted_check_permutation_interaction_elm)
        / domain25;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: diluted_check/permutation/step0.
    let value = ((global_values.diluted_check_permutation_interaction_elm - column3_row3)
        * column7_inter1_row2
        - (global_values.diluted_check_permutation_interaction_elm - column3_row2)
            * column7_inter1_row0)
        * domain26
        / domain1;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: diluted_check/permutation/last.
    let value = (column7_inter1_row0 - global_values.diluted_check_permutation_public_memory_prod)
        / domain26;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: diluted_check/init.
    let value = (column6_inter1_row1 - 1) / domain25;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: diluted_check/first_element.
    let value = (column3_row1 - global_values.diluted_check_first_elm) / domain25;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: diluted_check/step.
    let value = (column6_inter1_row3
        - (column6_inter1_row1
            * (1 + global_values.diluted_check_interaction_z * (column3_row3 - column3_row1))
            + global_values.diluted_check_interaction_alpha
                * (column3_row3 - column3_row1)
                * (column3_row3 - column3_row1)))
        * domain26
        / domain1;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: diluted_check/last.
    let value = (column6_inter1_row1 - global_values.diluted_check_final_cum_val) / domain26;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash0/ec_subset_sum/bit_unpacking/last_one_is_zero.
    let value = (column5_row57 * (column4_row3 - (column4_row11 + column4_row11))) / domain19;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash0/ec_subset_sum/bit_unpacking/zeroes_between_ones0.
    let value = (column5_row57
        * (column4_row11
            - 3138550867693340381917894711603833208051177722232017256448 * column4_row1539))
        / domain19;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash0/ec_subset_sum/bit_unpacking/cumulative_bit192.
    let value = (column5_row57
        - column4_row2047 * (column4_row1539 - (column4_row1547 + column4_row1547)))
        / domain19;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash0/ec_subset_sum/bit_unpacking/zeroes_between_ones192.
    let value = (column4_row2047 * (column4_row1547 - 8 * column4_row1571)) / domain19;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash0/ec_subset_sum/bit_unpacking/cumulative_bit196.
    let value = (column4_row2047
        - (column4_row2011 - (column4_row2019 + column4_row2019))
            * (column4_row1571 - (column4_row1579 + column4_row1579)))
        / domain19;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash0/ec_subset_sum/bit_unpacking/zeroes_between_ones196.
    let value = ((column4_row2011 - (column4_row2019 + column4_row2019))
        * (column4_row1579 - 18014398509481984 * column4_row2011))
        / domain19;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash0/ec_subset_sum/booleanity_test.
    let value = (pedersen_hash0_ec_subset_sum_bit_0 * (pedersen_hash0_ec_subset_sum_bit_0 - 1))
        * domain20
        / domain3;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash0/ec_subset_sum/bit_extraction_end.
    let value = (column4_row3) / domain21;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash0/ec_subset_sum/zeros_tail.
    let value = (column4_row3) / domain20;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash0/ec_subset_sum/add_points/slope.
    let value = (pedersen_hash0_ec_subset_sum_bit_0
        * (column4_row5 - global_values.pedersen_points_y)
        - column4_row7 * (column4_row1 - global_values.pedersen_points_x))
        * domain20
        / domain3;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash0/ec_subset_sum/add_points/x.
    let value = (column4_row7 * column4_row7
        - pedersen_hash0_ec_subset_sum_bit_0
            * (column4_row1 + global_values.pedersen_points_x + column4_row9))
        * domain20
        / domain3;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash0/ec_subset_sum/add_points/y.
    let value = (pedersen_hash0_ec_subset_sum_bit_0 * (column4_row5 + column4_row13)
        - column4_row7 * (column4_row1 - column4_row9))
        * domain20
        / domain3;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash0/ec_subset_sum/copy_point/x.
    let value = (pedersen_hash0_ec_subset_sum_bit_neg_0 * (column4_row9 - column4_row1))
        * domain20
        / domain3;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash0/ec_subset_sum/copy_point/y.
    let value = (pedersen_hash0_ec_subset_sum_bit_neg_0 * (column4_row13 - column4_row5))
        * domain20
        / domain3;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash0/copy_point/x.
    let value = (column4_row2049 - column4_row2041) * domain22 / domain19;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash0/copy_point/y.
    let value = (column4_row2053 - column4_row2045) * domain22 / domain19;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash0/init/x.
    let value = (column4_row1 - global_values.pedersen_shift_point.x) / domain23;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/hash0/init/y.
    let value = (column4_row5 - global_values.pedersen_shift_point.y) / domain23;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/input0_value0.
    let value = (column1_row11 - column4_row3) / domain23;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/input0_addr.
    let value = (column1_row4106 - (column1_row1034 + 1)) * domain28 / domain23;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/init_addr.
    let value = (column1_row10 - global_values.initial_pedersen_addr) / domain25;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/input1_value0.
    let value = (column1_row2059 - column4_row2051) / domain23;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/input1_addr.
    let value = (column1_row2058 - (column1_row10 + 1)) / domain23;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/output_value0.
    let value = (column1_row1035 - column4_row4089) / domain23;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: pedersen/output_addr.
    let value = (column1_row1034 - (column1_row2058 + 1)) / domain23;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: range_check_builtin/value.
    let value = (range_check_builtin_value7_0 - column1_row139) / domain9;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: range_check_builtin/addr_step.
    let value = (column1_row394 - (column1_row138 + 1)) * domain29 / domain9;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: range_check_builtin/init_addr.
    let value = (column1_row138 - global_values.initial_range_check_addr) / domain25;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: bitwise/init_var_pool_addr.
    let value = (column1_row42 - global_values.initial_bitwise_addr) / domain25;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: bitwise/step_var_pool_addr.
    let value = (column1_row106 - (column1_row42 + 1)) * domain10 / domain7;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: bitwise/x_or_y_addr.
    let value = (column1_row74 - (column1_row234 + 1)) / domain9;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: bitwise/next_var_pool_addr.
    let value = (column1_row298 - (column1_row74 + 1)) * domain29 / domain9;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: bitwise/partition.
    let value = (bitwise_sum_var_0_0 + bitwise_sum_var_8_0 - column1_row43) / domain7;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: bitwise/or_is_and_plus_xor.
    let value = (column1_row75 - (column1_row171 + column1_row235)) / domain9;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: bitwise/addition_is_xor_with_and.
    let value = (column3_row0 + column3_row64 - (column3_row192 + column3_row128 + column3_row128))
        / domain11;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: bitwise/unique_unpacking192.
    let value = ((column3_row176 + column3_row240) * 16 - column3_row2) / domain9;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: bitwise/unique_unpacking193.
    let value = ((column3_row180 + column3_row244) * 16 - column3_row130) / domain9;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: bitwise/unique_unpacking194.
    let value = ((column3_row184 + column3_row248) * 16 - column3_row66) / domain9;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: bitwise/unique_unpacking195.
    let value = ((column3_row188 + column3_row252) * 256 - column3_row194) / domain9;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: poseidon/param_0/init_input_output_addr.
    let value = (column1_row266 - global_values.initial_poseidon_addr) / domain25;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: poseidon/param_0/addr_input_output_step.
    let value = (column1_row778 - (column1_row266 + 3)) * domain30 / domain12;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: poseidon/param_1/init_input_output_addr.
    let value = (column1_row202 - (global_values.initial_poseidon_addr + 1)) / domain25;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: poseidon/param_1/addr_input_output_step.
    let value = (column1_row714 - (column1_row202 + 3)) * domain30 / domain12;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: poseidon/param_2/init_input_output_addr.
    let value = (column1_row458 - (global_values.initial_poseidon_addr + 2)) / domain25;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: poseidon/param_2/addr_input_output_step.
    let value = (column1_row970 - (column1_row458 + 3)) * domain30 / domain12;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: poseidon/poseidon/full_rounds_state0_squaring.
    let value = (column5_row9 * column5_row9 - column5_row105) / domain8;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: poseidon/poseidon/full_rounds_state1_squaring.
    let value = (column5_row73 * column5_row73 - column5_row25) / domain8;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: poseidon/poseidon/full_rounds_state2_squaring.
    let value = (column5_row41 * column5_row41 - column5_row89) / domain8;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: poseidon/poseidon/partial_rounds_state0_squaring.
    let value = (column5_row6 * column5_row6 - column5_row14) / domain5;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: poseidon/poseidon/partial_rounds_state1_squaring.
    let value = (column5_row1 * column5_row1 - column5_row17) * domain15 / domain6;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: poseidon/poseidon/add_first_round_key0.
    let value = (column1_row267
        + 2950795762459345168613727575620414179244544320470208355568817838579231751791
        - column5_row9)
        / domain16;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: poseidon/poseidon/add_first_round_key1.
    let value = (column1_row203
        + 1587446564224215276866294500450702039420286416111469274423465069420553242820
        - column5_row73)
        / domain16;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: poseidon/poseidon/add_first_round_key2.
    let value = (column1_row459
        + 1645965921169490687904413452218868659025437693527479459426157555728339600137
        - column5_row41)
        / domain16;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: poseidon/poseidon/full_round0.
    let value = (column5_row137
        - (poseidon_poseidon_full_rounds_state0_cubed_0
            + poseidon_poseidon_full_rounds_state0_cubed_0
            + poseidon_poseidon_full_rounds_state0_cubed_0
            + poseidon_poseidon_full_rounds_state1_cubed_0
            + poseidon_poseidon_full_rounds_state2_cubed_0
            + global_values.poseidon_poseidon_full_round_key0))
        * domain13
        / domain8;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: poseidon/poseidon/full_round1.
    let value = (column5_row201
        + poseidon_poseidon_full_rounds_state1_cubed_0
        - (poseidon_poseidon_full_rounds_state0_cubed_0
            + poseidon_poseidon_full_rounds_state2_cubed_0
            + global_values.poseidon_poseidon_full_round_key1))
        * domain13
        / domain8;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: poseidon/poseidon/full_round2.
    let value = (column5_row169
        + poseidon_poseidon_full_rounds_state2_cubed_0
        + poseidon_poseidon_full_rounds_state2_cubed_0
        - (poseidon_poseidon_full_rounds_state0_cubed_0
            + poseidon_poseidon_full_rounds_state1_cubed_0
            + global_values.poseidon_poseidon_full_round_key2))
        * domain13
        / domain8;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: poseidon/poseidon/last_full_round0.
    let value = (column1_row779
        - (poseidon_poseidon_full_rounds_state0_cubed_7
            + poseidon_poseidon_full_rounds_state0_cubed_7
            + poseidon_poseidon_full_rounds_state0_cubed_7
            + poseidon_poseidon_full_rounds_state1_cubed_7
            + poseidon_poseidon_full_rounds_state2_cubed_7))
        / domain16;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: poseidon/poseidon/last_full_round1.
    let value = (column1_row715
        + poseidon_poseidon_full_rounds_state1_cubed_7
        - (poseidon_poseidon_full_rounds_state0_cubed_7
            + poseidon_poseidon_full_rounds_state2_cubed_7))
        / domain16;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: poseidon/poseidon/last_full_round2.
    let value = (column1_row971
        + poseidon_poseidon_full_rounds_state2_cubed_7
        + poseidon_poseidon_full_rounds_state2_cubed_7
        - (poseidon_poseidon_full_rounds_state0_cubed_7
            + poseidon_poseidon_full_rounds_state1_cubed_7))
        / domain16;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: poseidon/poseidon/copy_partial_rounds0_i0.
    let value = (column5_row982 - column5_row1) / domain16;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: poseidon/poseidon/copy_partial_rounds0_i1.
    let value = (column5_row998 - column5_row33) / domain16;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: poseidon/poseidon/copy_partial_rounds0_i2.
    let value = (column5_row1014 - column5_row65) / domain16;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: poseidon/poseidon/margin_full_to_partial0.
    let value = (column5_row6
        + poseidon_poseidon_full_rounds_state2_cubed_3
        + poseidon_poseidon_full_rounds_state2_cubed_3
        - (poseidon_poseidon_full_rounds_state0_cubed_3
            + poseidon_poseidon_full_rounds_state1_cubed_3
            + 2121140748740143694053732746913428481442990369183417228688865837805149503386))
        / domain16;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: poseidon/poseidon/margin_full_to_partial1.
    let value = (column5_row22
        - (3618502788666131213697322783095070105623107215331596699973092056135872020477
            * poseidon_poseidon_full_rounds_state1_cubed_3
            + 10 * poseidon_poseidon_full_rounds_state2_cubed_3
            + 4 * column5_row6
            + 3618502788666131213697322783095070105623107215331596699973092056135872020479
                * poseidon_poseidon_partial_rounds_state0_cubed_0
            + 2006642341318481906727563724340978325665491359415674592697055778067937914672))
        / domain16;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: poseidon/poseidon/margin_full_to_partial2.
    let value = (column5_row38
        - (8 * poseidon_poseidon_full_rounds_state2_cubed_3
            + 4 * column5_row6
            + 6 * poseidon_poseidon_partial_rounds_state0_cubed_0
            + column5_row22
            + column5_row22
            + 3618502788666131213697322783095070105623107215331596699973092056135872020479
                * poseidon_poseidon_partial_rounds_state0_cubed_1
            + 427751140904099001132521606468025610873158555767197326325930641757709538586))
        / domain16;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: poseidon/poseidon/partial_round0.
    let value = (column5_row54
        - (8 * poseidon_poseidon_partial_rounds_state0_cubed_0
            + 4 * column5_row22
            + 6 * poseidon_poseidon_partial_rounds_state0_cubed_1
            + column5_row38
            + column5_row38
            + 3618502788666131213697322783095070105623107215331596699973092056135872020479
                * poseidon_poseidon_partial_rounds_state0_cubed_2
            + global_values.poseidon_poseidon_partial_round_key0))
        * domain17
        / domain5;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: poseidon/poseidon/partial_round1.
    let value = (column5_row97
        - (8 * poseidon_poseidon_partial_rounds_state1_cubed_0
            + 4 * column5_row33
            + 6 * poseidon_poseidon_partial_rounds_state1_cubed_1
            + column5_row65
            + column5_row65
            + 3618502788666131213697322783095070105623107215331596699973092056135872020479
                * poseidon_poseidon_partial_rounds_state1_cubed_2
            + global_values.poseidon_poseidon_partial_round_key1))
        * domain18
        / domain6;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: poseidon/poseidon/margin_partial_to_full0.
    let value = (column5_row521
        - (16 * poseidon_poseidon_partial_rounds_state1_cubed_19
            + 8 * column5_row641
            + 16 * poseidon_poseidon_partial_rounds_state1_cubed_20
            + 6 * column5_row673
            + poseidon_poseidon_partial_rounds_state1_cubed_21
            + 560279373700919169769089400651532183647886248799764942664266404650165812023))
        / domain16;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: poseidon/poseidon/margin_partial_to_full1.
    let value = (column5_row585
        - (4 * poseidon_poseidon_partial_rounds_state1_cubed_20
            + column5_row673
            + column5_row673
            + poseidon_poseidon_partial_rounds_state1_cubed_21
            + 1401754474293352309994371631695783042590401941592571735921592823982231996415))
        / domain16;
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Constraint: poseidon/poseidon/margin_partial_to_full2.
    let value = (column5_row553
        - (8 * poseidon_poseidon_partial_rounds_state1_cubed_19
            + 4 * column5_row641
            + 6 * poseidon_poseidon_partial_rounds_state1_cubed_20
            + column5_row673
            + column5_row673
            + 3618502788666131213697322783095070105623107215331596699973092056135872020479
                * poseidon_poseidon_partial_rounds_state1_cubed_21
            + 1246177936547655338400308396717835700699368047388302793172818304164989556526))
        / domain16;
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
    let pow1 = pow(trace_generator, 4089);
    let pow2 = pow(trace_generator, 2011);
    let pow3 = pow(trace_generator, 1539);
    let pow4 = pow(trace_generator, 1);
    let pow5 = pow4 * pow4; // pow(trace_generator, 2).
    let pow6 = pow4 * pow5; // pow(trace_generator, 3).
    let pow7 = pow4 * pow6; // pow(trace_generator, 4).
    let pow8 = pow4 * pow7; // pow(trace_generator, 5).
    let pow9 = pow4 * pow8; // pow(trace_generator, 6).
    let pow10 = pow4 * pow9; // pow(trace_generator, 7).
    let pow11 = pow4 * pow10; // pow(trace_generator, 8).
    let pow12 = pow3 * pow11; // pow(trace_generator, 1547).
    let pow13 = pow4 * pow11; // pow(trace_generator, 9).
    let pow14 = pow4 * pow13; // pow(trace_generator, 10).
    let pow15 = pow4 * pow14; // pow(trace_generator, 11).
    let pow16 = pow4 * pow15; // pow(trace_generator, 12).
    let pow17 = pow4 * pow16; // pow(trace_generator, 13).
    let pow18 = pow4 * pow17; // pow(trace_generator, 14).
    let pow19 = pow4 * pow18; // pow(trace_generator, 15).
    let pow20 = pow4 * pow19; // pow(trace_generator, 16).
    let pow21 = pow4 * pow20; // pow(trace_generator, 17).
    let pow22 = pow6 * pow21; // pow(trace_generator, 20).
    let pow23 = pow5 * pow22; // pow(trace_generator, 22).
    let pow24 = pow5 * pow23; // pow(trace_generator, 24).
    let pow25 = pow4 * pow24; // pow(trace_generator, 25).
    let pow26 = pow6 * pow25; // pow(trace_generator, 28).
    let pow27 = pow5 * pow26; // pow(trace_generator, 30).
    let pow28 = pow5 * pow27; // pow(trace_generator, 32).
    let pow29 = pow4 * pow28; // pow(trace_generator, 33).
    let pow30 = pow3 * pow28; // pow(trace_generator, 1571).
    let pow31 = pow6 * pow29; // pow(trace_generator, 36).
    let pow32 = pow5 * pow31; // pow(trace_generator, 38).
    let pow33 = pow5 * pow32; // pow(trace_generator, 40).
    let pow34 = pow4 * pow33; // pow(trace_generator, 41).
    let pow35 = pow4 * pow34; // pow(trace_generator, 42).
    let pow36 = pow4 * pow35; // pow(trace_generator, 43).
    let pow37 = pow4 * pow36; // pow(trace_generator, 44).
    let pow38 = pow5 * pow37; // pow(trace_generator, 46).
    let pow39 = pow5 * pow38; // pow(trace_generator, 48).
    let pow40 = pow4 * pow39; // pow(trace_generator, 49).
    let pow41 = pow6 * pow40; // pow(trace_generator, 52).
    let pow42 = pow5 * pow41; // pow(trace_generator, 54).
    let pow43 = pow5 * pow42; // pow(trace_generator, 56).
    let pow44 = pow4 * pow43; // pow(trace_generator, 57).
    let pow45 = pow6 * pow44; // pow(trace_generator, 60).
    let pow46 = pow7 * pow45; // pow(trace_generator, 64).
    let pow47 = pow4 * pow46; // pow(trace_generator, 65).
    let pow48 = pow4 * pow47; // pow(trace_generator, 66).
    let pow49 = pow10 * pow48; // pow(trace_generator, 73).
    let pow50 = pow4 * pow49; // pow(trace_generator, 74).
    let pow51 = pow4 * pow50; // pow(trace_generator, 75).
    let pow52 = pow4 * pow51; // pow(trace_generator, 76).
    let pow53 = pow8 * pow52; // pow(trace_generator, 81).
    let pow54 = pow11 * pow53; // pow(trace_generator, 89).
    let pow55 = pow11 * pow54; // pow(trace_generator, 97).
    let pow56 = pow11 * pow55; // pow(trace_generator, 105).
    let pow57 = pow4 * pow56; // pow(trace_generator, 106).
    let pow58 = pow5 * pow57; // pow(trace_generator, 108).
    let pow59 = pow22 * pow58; // pow(trace_generator, 128).
    let pow60 = pow5 * pow59; // pow(trace_generator, 130).
    let pow61 = pow10 * pow60; // pow(trace_generator, 137).
    let pow62 = pow4 * pow61; // pow(trace_generator, 138).
    let pow63 = pow4 * pow62; // pow(trace_generator, 139).
    let pow64 = pow27 * pow63; // pow(trace_generator, 169).
    let pow65 = pow5 * pow64; // pow(trace_generator, 171).
    let pow66 = pow4 * pow63; // pow(trace_generator, 140).
    let pow67 = pow4 * pow65; // pow(trace_generator, 172).
    let pow68 = pow7 * pow67; // pow(trace_generator, 176).
    let pow69 = pow7 * pow68; // pow(trace_generator, 180).
    let pow70 = pow7 * pow69; // pow(trace_generator, 184).
    let pow71 = pow7 * pow70; // pow(trace_generator, 188).
    let pow72 = pow7 * pow71; // pow(trace_generator, 192).
    let pow73 = pow5 * pow72; // pow(trace_generator, 194).
    let pow74 = pow10 * pow73; // pow(trace_generator, 201).
    let pow75 = pow4 * pow74; // pow(trace_generator, 202).
    let pow76 = pow4 * pow75; // pow(trace_generator, 203).
    let pow77 = pow72 * pow74; // pow(trace_generator, 393).
    let pow78 = pow4 * pow76; // pow(trace_generator, 204).
    let pow79 = pow27 * pow78; // pow(trace_generator, 234).
    let pow80 = pow4 * pow79; // pow(trace_generator, 235).
    let pow81 = pow4 * pow80; // pow(trace_generator, 236).
    let pow82 = pow7 * pow81; // pow(trace_generator, 240).
    let pow83 = pow7 * pow82; // pow(trace_generator, 244).
    let pow84 = pow7 * pow83; // pow(trace_generator, 248).
    let pow85 = pow7 * pow84; // pow(trace_generator, 252).
    let pow86 = pow18 * pow85; // pow(trace_generator, 266).
    let pow87 = pow4 * pow86; // pow(trace_generator, 267).
    let pow88 = pow4 * pow77; // pow(trace_generator, 394).
    let pow89 = pow19 * pow88; // pow(trace_generator, 409).
    let pow90 = pow20 * pow89; // pow(trace_generator, 425).
    let pow91 = pow28 * pow90; // pow(trace_generator, 457).
    let pow92 = pow4 * pow91; // pow(trace_generator, 458).
    let pow93 = pow4 * pow92; // pow(trace_generator, 459).
    let pow94 = pow18 * pow93; // pow(trace_generator, 473).
    let pow95 = pow20 * pow94; // pow(trace_generator, 489).
    let pow96 = pow28 * pow95; // pow(trace_generator, 521).
    let pow97 = pow28 * pow96; // pow(trace_generator, 553).
    let pow98 = pow28 * pow97; // pow(trace_generator, 585).
    let pow99 = pow24 * pow98; // pow(trace_generator, 609).
    let pow100 = pow20 * pow99; // pow(trace_generator, 625).
    let pow101 = pow20 * pow100; // pow(trace_generator, 641).
    let pow102 = pow20 * pow101; // pow(trace_generator, 657).
    let pow103 = pow84 * pow102; // pow(trace_generator, 905).
    let pow104 = pow20 * pow102; // pow(trace_generator, 673).
    let pow105 = pow20 * pow103; // pow(trace_generator, 921).
    let pow106 = pow20 * pow104; // pow(trace_generator, 689).
    let pow107 = pow20 * pow105; // pow(trace_generator, 937).
    let pow108 = pow28 * pow107; // pow(trace_generator, 969).
    let pow109 = pow25 * pow106; // pow(trace_generator, 714).
    let pow110 = pow46 * pow109; // pow(trace_generator, 778).
    let pow111 = pow4 * pow108; // pow(trace_generator, 970).
    let pow112 = pow3 * pow33; // pow(trace_generator, 1579).
    let pow113 = pow4 * pow109; // pow(trace_generator, 715).
    let pow114 = pow4 * pow110; // pow(trace_generator, 779).
    let pow115 = pow28 * pow86; // pow(trace_generator, 298).
    let pow116 = pow4 * pow111; // pow(trace_generator, 971).
    let pow117 = pow15 * pow116; // pow(trace_generator, 982).
    let pow118 = pow6 * pow117; // pow(trace_generator, 985).
    let pow119 = pow17 * pow118; // pow(trace_generator, 998).
    let pow120 = pow6 * pow119; // pow(trace_generator, 1001).
    let pow121 = pow17 * pow120; // pow(trace_generator, 1014).
    let pow122 = pow22 * pow121; // pow(trace_generator, 1034).
    let pow123 = pow2 * pow11; // pow(trace_generator, 2019).
    let pow124 = pow2 * pow27; // pow(trace_generator, 2041).
    let pow125 = pow7 * pow124; // pow(trace_generator, 2045).
    let pow126 = pow2 * pow31; // pow(trace_generator, 2047).
    let pow127 = pow4 * pow122; // pow(trace_generator, 1035).
    let pow128 = pow2 * pow32; // pow(trace_generator, 2049).
    let pow129 = pow2 * pow33; // pow(trace_generator, 2051).
    let pow130 = pow2 * pow35; // pow(trace_generator, 2053).
    let pow131 = pow8 * pow130; // pow(trace_generator, 2058).
    let pow132 = pow2 * pow39; // pow(trace_generator, 2059).
    let pow133 = pow1 * pow21; // pow(trace_generator, 4106).

    // Fetch columns.
    let [column0, column1, column2, column3, column4, column5, column6, column7] = (*column_values
        .multi_pop_front::<8>()
        .unwrap())
        .unbox();

    // Sum the OODS constraints on the trace polynomials.
    let total_sum = 0;

    let value = (column0 - *oods_values.pop_front().unwrap()) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column0 - *oods_values.pop_front().unwrap()) / (point - pow4 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column0 - *oods_values.pop_front().unwrap()) / (point - pow5 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column0 - *oods_values.pop_front().unwrap()) / (point - pow6 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column0 - *oods_values.pop_front().unwrap()) / (point - pow7 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column0 - *oods_values.pop_front().unwrap()) / (point - pow8 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column0 - *oods_values.pop_front().unwrap()) / (point - pow9 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column0 - *oods_values.pop_front().unwrap()) / (point - pow10 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column0 - *oods_values.pop_front().unwrap()) / (point - pow11 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column0 - *oods_values.pop_front().unwrap()) / (point - pow13 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column0 - *oods_values.pop_front().unwrap()) / (point - pow14 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column0 - *oods_values.pop_front().unwrap()) / (point - pow15 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column0 - *oods_values.pop_front().unwrap()) / (point - pow16 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column0 - *oods_values.pop_front().unwrap()) / (point - pow17 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column0 - *oods_values.pop_front().unwrap()) / (point - pow18 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column0 - *oods_values.pop_front().unwrap()) / (point - pow19 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column1 - *oods_values.pop_front().unwrap()) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column1 - *oods_values.pop_front().unwrap()) / (point - pow4 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column1 - *oods_values.pop_front().unwrap()) / (point - pow5 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column1 - *oods_values.pop_front().unwrap()) / (point - pow6 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column1 - *oods_values.pop_front().unwrap()) / (point - pow7 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column1 - *oods_values.pop_front().unwrap()) / (point - pow8 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column1 - *oods_values.pop_front().unwrap()) / (point - pow11 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column1 - *oods_values.pop_front().unwrap()) / (point - pow13 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column1 - *oods_values.pop_front().unwrap()) / (point - pow14 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column1 - *oods_values.pop_front().unwrap()) / (point - pow15 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column1 - *oods_values.pop_front().unwrap()) / (point - pow16 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column1 - *oods_values.pop_front().unwrap()) / (point - pow17 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column1 - *oods_values.pop_front().unwrap()) / (point - pow20 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column1 - *oods_values.pop_front().unwrap()) / (point - pow35 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column1 - *oods_values.pop_front().unwrap()) / (point - pow36 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column1 - *oods_values.pop_front().unwrap()) / (point - pow50 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column1 - *oods_values.pop_front().unwrap()) / (point - pow51 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column1 - *oods_values.pop_front().unwrap()) / (point - pow57 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column1 - *oods_values.pop_front().unwrap()) / (point - pow62 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column1 - *oods_values.pop_front().unwrap()) / (point - pow63 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column1 - *oods_values.pop_front().unwrap()) / (point - pow65 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column1 - *oods_values.pop_front().unwrap()) / (point - pow75 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column1 - *oods_values.pop_front().unwrap()) / (point - pow76 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column1 - *oods_values.pop_front().unwrap()) / (point - pow79 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column1 - *oods_values.pop_front().unwrap()) / (point - pow80 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column1 - *oods_values.pop_front().unwrap()) / (point - pow86 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column1 - *oods_values.pop_front().unwrap()) / (point - pow87 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column1 - *oods_values.pop_front().unwrap()) / (point - pow115 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column1 - *oods_values.pop_front().unwrap()) / (point - pow88 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column1 - *oods_values.pop_front().unwrap()) / (point - pow92 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column1 - *oods_values.pop_front().unwrap()) / (point - pow93 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column1 - *oods_values.pop_front().unwrap()) / (point - pow109 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column1 - *oods_values.pop_front().unwrap()) / (point - pow113 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column1 - *oods_values.pop_front().unwrap()) / (point - pow110 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column1 - *oods_values.pop_front().unwrap()) / (point - pow114 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column1 - *oods_values.pop_front().unwrap()) / (point - pow111 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column1 - *oods_values.pop_front().unwrap()) / (point - pow116 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column1 - *oods_values.pop_front().unwrap()) / (point - pow122 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column1 - *oods_values.pop_front().unwrap()) / (point - pow127 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column1 - *oods_values.pop_front().unwrap()) / (point - pow131 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column1 - *oods_values.pop_front().unwrap()) / (point - pow132 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column1 - *oods_values.pop_front().unwrap()) / (point - pow133 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column2 - *oods_values.pop_front().unwrap()) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column2 - *oods_values.pop_front().unwrap()) / (point - pow4 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column2 - *oods_values.pop_front().unwrap()) / (point - pow5 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column2 - *oods_values.pop_front().unwrap()) / (point - pow6 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column3 - *oods_values.pop_front().unwrap()) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column3 - *oods_values.pop_front().unwrap()) / (point - pow4 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column3 - *oods_values.pop_front().unwrap()) / (point - pow5 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column3 - *oods_values.pop_front().unwrap()) / (point - pow6 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column3 - *oods_values.pop_front().unwrap()) / (point - pow7 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column3 - *oods_values.pop_front().unwrap()) / (point - pow11 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column3 - *oods_values.pop_front().unwrap()) / (point - pow16 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column3 - *oods_values.pop_front().unwrap()) / (point - pow20 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column3 - *oods_values.pop_front().unwrap()) / (point - pow22 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column3 - *oods_values.pop_front().unwrap()) / (point - pow24 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column3 - *oods_values.pop_front().unwrap()) / (point - pow26 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column3 - *oods_values.pop_front().unwrap()) / (point - pow28 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column3 - *oods_values.pop_front().unwrap()) / (point - pow31 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column3 - *oods_values.pop_front().unwrap()) / (point - pow33 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column3 - *oods_values.pop_front().unwrap()) / (point - pow37 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column3 - *oods_values.pop_front().unwrap()) / (point - pow39 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column3 - *oods_values.pop_front().unwrap()) / (point - pow41 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column3 - *oods_values.pop_front().unwrap()) / (point - pow43 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column3 - *oods_values.pop_front().unwrap()) / (point - pow45 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column3 - *oods_values.pop_front().unwrap()) / (point - pow46 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column3 - *oods_values.pop_front().unwrap()) / (point - pow48 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column3 - *oods_values.pop_front().unwrap()) / (point - pow59 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column3 - *oods_values.pop_front().unwrap()) / (point - pow60 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column3 - *oods_values.pop_front().unwrap()) / (point - pow68 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column3 - *oods_values.pop_front().unwrap()) / (point - pow69 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column3 - *oods_values.pop_front().unwrap()) / (point - pow70 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column3 - *oods_values.pop_front().unwrap()) / (point - pow71 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column3 - *oods_values.pop_front().unwrap()) / (point - pow72 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column3 - *oods_values.pop_front().unwrap()) / (point - pow73 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column3 - *oods_values.pop_front().unwrap()) / (point - pow82 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column3 - *oods_values.pop_front().unwrap()) / (point - pow83 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column3 - *oods_values.pop_front().unwrap()) / (point - pow84 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column3 - *oods_values.pop_front().unwrap()) / (point - pow85 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column4 - *oods_values.pop_front().unwrap()) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column4 - *oods_values.pop_front().unwrap()) / (point - pow4 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column4 - *oods_values.pop_front().unwrap()) / (point - pow5 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column4 - *oods_values.pop_front().unwrap()) / (point - pow6 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column4 - *oods_values.pop_front().unwrap()) / (point - pow7 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column4 - *oods_values.pop_front().unwrap()) / (point - pow8 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column4 - *oods_values.pop_front().unwrap()) / (point - pow9 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column4 - *oods_values.pop_front().unwrap()) / (point - pow10 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column4 - *oods_values.pop_front().unwrap()) / (point - pow11 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column4 - *oods_values.pop_front().unwrap()) / (point - pow13 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column4 - *oods_values.pop_front().unwrap()) / (point - pow15 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column4 - *oods_values.pop_front().unwrap()) / (point - pow16 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column4 - *oods_values.pop_front().unwrap()) / (point - pow17 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column4 - *oods_values.pop_front().unwrap()) / (point - pow37 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column4 - *oods_values.pop_front().unwrap()) / (point - pow52 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column4 - *oods_values.pop_front().unwrap()) / (point - pow58 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column4 - *oods_values.pop_front().unwrap()) / (point - pow66 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column4 - *oods_values.pop_front().unwrap()) / (point - pow67 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column4 - *oods_values.pop_front().unwrap()) / (point - pow78 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column4 - *oods_values.pop_front().unwrap()) / (point - pow81 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column4 - *oods_values.pop_front().unwrap()) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column4 - *oods_values.pop_front().unwrap()) / (point - pow12 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column4 - *oods_values.pop_front().unwrap()) / (point - pow30 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column4 - *oods_values.pop_front().unwrap()) / (point - pow112 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column4 - *oods_values.pop_front().unwrap()) / (point - pow2 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column4 - *oods_values.pop_front().unwrap()) / (point - pow123 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column4 - *oods_values.pop_front().unwrap()) / (point - pow124 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column4 - *oods_values.pop_front().unwrap()) / (point - pow125 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column4 - *oods_values.pop_front().unwrap()) / (point - pow126 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column4 - *oods_values.pop_front().unwrap()) / (point - pow128 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column4 - *oods_values.pop_front().unwrap()) / (point - pow129 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column4 - *oods_values.pop_front().unwrap()) / (point - pow130 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column4 - *oods_values.pop_front().unwrap()) / (point - pow1 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow4 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow5 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow7 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow9 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow11 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow13 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow14 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow16 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow18 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow20 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow21 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow23 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow24 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow25 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow27 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow29 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow32 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow34 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow38 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow40 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow42 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow44 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow47 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow49 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow53 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow54 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow55 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow56 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow61 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow64 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow74 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow77 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow89 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow90 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow91 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow94 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow95 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow96 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow97 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow98 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow99 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow100 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow101 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow102 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow104 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow106 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow103 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow105 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow107 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow108 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow117 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow118 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow119 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow120 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column5 - *oods_values.pop_front().unwrap()) / (point - pow121 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column6 - *oods_values.pop_front().unwrap()) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column6 - *oods_values.pop_front().unwrap()) / (point - pow4 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column6 - *oods_values.pop_front().unwrap()) / (point - pow5 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column6 - *oods_values.pop_front().unwrap()) / (point - pow6 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column7 - *oods_values.pop_front().unwrap()) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column7 - *oods_values.pop_front().unwrap()) / (point - pow4 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column7 - *oods_values.pop_front().unwrap()) / (point - pow5 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (column7 - *oods_values.pop_front().unwrap()) / (point - pow8 * oods_point);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Sum the OODS boundary constraints on the composition polynomials.
    let oods_point_to_deg = pow(oods_point, CONSTRAINT_DEGREE.into());

    let value = (*column_values.pop_front().unwrap() - *oods_values.pop_front().unwrap())
        / (point - oods_point_to_deg);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (*column_values.pop_front().unwrap() - *oods_values.pop_front().unwrap())
        / (point - oods_point_to_deg);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    assert(194 == MASK_SIZE + CONSTRAINT_DEGREE, 'Autogenerated assert failed');
    total_sum
}

