use integrity::{
    air::layouts::starknet::{
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
    let pow0 = pow(point, global_values.trace_length / 32768);
    let pow1 = pow0 * pow0; // pow(point, (safe_div(global_values.trace_length, 16384))).
    let pow2 = pow(point, global_values.trace_length / 1024);
    let pow3 = pow2 * pow2; // pow(point, (safe_div(global_values.trace_length, 512))).
    let pow4 = pow3 * pow3; // pow(point, (safe_div(global_values.trace_length, 256))).
    let pow5 = pow4 * pow4; // pow(point, (safe_div(global_values.trace_length, 128))).
    let pow6 = pow5 * pow5; // pow(point, (safe_div(global_values.trace_length, 64))).
    let pow7 = pow(point, global_values.trace_length / 16);
    let pow8 = pow7 * pow7; // pow(point, (safe_div(global_values.trace_length, 8))).
    let pow9 = pow8 * pow8; // pow(point, (safe_div(global_values.trace_length, 4))).
    let pow10 = pow9 * pow9; // pow(point, (safe_div(global_values.trace_length, 2))).
    let pow11 = pow10 * pow10; // pow(point, global_values.trace_length).
    let pow12 = pow(trace_generator, global_values.trace_length - 16384);
    let pow13 = pow(trace_generator, global_values.trace_length - 1024);
    let pow14 = pow(trace_generator, global_values.trace_length - 32768);
    let pow15 = pow(trace_generator, global_values.trace_length - 256);
    let pow16 = pow(trace_generator, global_values.trace_length - 512);
    let pow17 = pow(trace_generator, global_values.trace_length - 8);
    let pow18 = pow(trace_generator, global_values.trace_length - 4);
    let pow19 = pow(trace_generator, global_values.trace_length - 2);
    let pow20 = pow(trace_generator, global_values.trace_length - 16);
    let pow21 = pow(trace_generator, (251 * global_values.trace_length) / 256);
    let pow22 = pow(trace_generator, global_values.trace_length / 64);
    let pow23 = pow22 * pow22; // pow(trace_generator, (safe_div(global_values.trace_length, 32))).
    let pow24 = pow22
        * pow23; // pow(trace_generator, (safe_div((safe_mult(3, global_values.trace_length)), 64))).
    let pow25 = pow22 * pow24; // pow(trace_generator, (safe_div(global_values.trace_length, 16))).
    let pow26 = pow22
        * pow25; // pow(trace_generator, (safe_div((safe_mult(5, global_values.trace_length)), 64))).
    let pow27 = pow22
        * pow26; // pow(trace_generator, (safe_div((safe_mult(3, global_values.trace_length)), 32))).
    let pow28 = pow22
        * pow27; // pow(trace_generator, (safe_div((safe_mult(7, global_values.trace_length)), 64))).
    let pow29 = pow22 * pow28; // pow(trace_generator, (safe_div(global_values.trace_length, 8))).
    let pow30 = pow22
        * pow29; // pow(trace_generator, (safe_div((safe_mult(9, global_values.trace_length)), 64))).
    let pow31 = pow22
        * pow30; // pow(trace_generator, (safe_div((safe_mult(5, global_values.trace_length)), 32))).
    let pow32 = pow22
        * pow31; // pow(trace_generator, (safe_div((safe_mult(11, global_values.trace_length)), 64))).
    let pow33 = pow22
        * pow32; // pow(trace_generator, (safe_div((safe_mult(3, global_values.trace_length)), 16))).
    let pow34 = pow22
        * pow33; // pow(trace_generator, (safe_div((safe_mult(13, global_values.trace_length)), 64))).
    let pow35 = pow22
        * pow34; // pow(trace_generator, (safe_div((safe_mult(7, global_values.trace_length)), 32))).
    let pow36 = pow22
        * pow35; // pow(trace_generator, (safe_div((safe_mult(15, global_values.trace_length)), 64))).
    let pow37 = pow(trace_generator, global_values.trace_length / 2);
    let pow38 = pow27
        * pow37; // pow(trace_generator, (safe_div((safe_mult(19, global_values.trace_length)), 32))).
    let pow39 = pow23
        * pow38; // pow(trace_generator, (safe_div((safe_mult(5, global_values.trace_length)), 8))).
    let pow40 = pow23
        * pow39; // pow(trace_generator, (safe_div((safe_mult(21, global_values.trace_length)), 32))).
    let pow41 = pow23
        * pow40; // pow(trace_generator, (safe_div((safe_mult(11, global_values.trace_length)), 16))).
    let pow42 = pow23
        * pow41; // pow(trace_generator, (safe_div((safe_mult(23, global_values.trace_length)), 32))).
    let pow43 = pow23
        * pow42; // pow(trace_generator, (safe_div((safe_mult(3, global_values.trace_length)), 4))).
    let pow44 = pow23
        * pow43; // pow(trace_generator, (safe_div((safe_mult(25, global_values.trace_length)), 32))).
    let pow45 = pow23
        * pow44; // pow(trace_generator, (safe_div((safe_mult(13, global_values.trace_length)), 16))).
    let pow46 = pow23
        * pow45; // pow(trace_generator, (safe_div((safe_mult(27, global_values.trace_length)), 32))).
    let pow47 = pow23
        * pow46; // pow(trace_generator, (safe_div((safe_mult(7, global_values.trace_length)), 8))).
    let pow48 = pow23
        * pow47; // pow(trace_generator, (safe_div((safe_mult(29, global_values.trace_length)), 32))).
    let pow49 = pow21
        * pow22; // pow(trace_generator, (safe_div((safe_mult(255, global_values.trace_length)), 256))).
    let pow50 = pow23
        * pow48; // pow(trace_generator, (safe_div((safe_mult(15, global_values.trace_length)), 16))).
    let pow51 = pow22
        * pow50; // pow(trace_generator, (safe_div((safe_mult(61, global_values.trace_length)), 64))).
    let pow52 = pow22
        * pow51; // pow(trace_generator, (safe_div((safe_mult(31, global_values.trace_length)), 32))).
    let pow53 = pow22
        * pow52; // pow(trace_generator, (safe_div((safe_mult(63, global_values.trace_length)), 64))).

    // Compute domains.
    let domain0 = pow11 - 1;
    let domain1 = pow10 - 1;
    let domain2 = pow9 - 1;
    let domain3 = pow8 - 1;
    let domain4 = pow7 - pow50;
    let domain5 = pow7 - 1;
    let domain6 = pow6 - 1;
    let domain7 = pow5 - 1;
    let domain8 = pow4 - 1;
    let domain9 = pow4 - pow49;
    let domain10 = pow4 - pow53;
    let domain11 = pow4 - pow43;
    let domain12 = pow3 - pow37;
    let domain13 = pow3 - 1;
    let domain14 = pow3 - pow52;
    let temp = pow3 - pow41;
    let temp = temp * (pow3 - pow42);
    let temp = temp * (pow3 - pow43);
    let temp = temp * (pow3 - pow44);
    let temp = temp * (pow3 - pow45);
    let temp = temp * (pow3 - pow46);
    let temp = temp * (pow3 - pow47);
    let temp = temp * (pow3 - pow48);
    let temp = temp * (pow3 - pow50);
    let domain15 = temp * (domain14);
    let temp = pow3 - pow51;
    let temp = temp * (pow3 - pow53);
    let domain16 = temp * (domain14);
    let temp = pow3 - pow38;
    let temp = temp * (pow3 - pow39);
    let temp = temp * (pow3 - pow40);
    let domain17 = temp * (domain15);
    let domain18 = pow2 - pow43;
    let domain19 = pow2 - 1;
    let temp = pow2 - pow22;
    let temp = temp * (pow2 - pow23);
    let temp = temp * (pow2 - pow24);
    let temp = temp * (pow2 - pow25);
    let temp = temp * (pow2 - pow26);
    let temp = temp * (pow2 - pow27);
    let temp = temp * (pow2 - pow28);
    let temp = temp * (pow2 - pow29);
    let temp = temp * (pow2 - pow30);
    let temp = temp * (pow2 - pow31);
    let temp = temp * (pow2 - pow32);
    let temp = temp * (pow2 - pow33);
    let temp = temp * (pow2 - pow34);
    let temp = temp * (pow2 - pow35);
    let temp = temp * (pow2 - pow36);
    let domain20 = temp * (domain19);
    let domain21 = pow1 - pow49;
    let domain22 = pow1 - pow21;
    let domain23 = pow1 - 1;
    let domain24 = pow1 - pow53;
    let domain25 = pow0 - pow49;
    let domain26 = pow0 - pow21;
    let domain27 = pow0 - 1;
    let domain28 = point - pow20;
    let domain29 = point - 1;
    let domain30 = point - pow19;
    let domain31 = point - pow18;
    let domain32 = point - pow17;
    let domain33 = point - pow16;
    let domain34 = point - pow15;
    let domain35 = point - pow14;
    let domain36 = point - pow13;
    let domain37 = point - pow12;

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
        column4_row255,
        column5_row0,
        column5_row1,
        column5_row2,
        column5_row3,
        column5_row4,
        column5_row5,
        column5_row6,
        column5_row7,
        column5_row8,
        column5_row9,
        column5_row12,
        column5_row13,
        column5_row16,
        column5_row38,
        column5_row39,
        column5_row70,
        column5_row71,
        column5_row102,
        column5_row103,
        column5_row134,
        column5_row135,
        column5_row166,
        column5_row167,
        column5_row198,
        column5_row199,
        column5_row262,
        column5_row263,
        column5_row294,
        column5_row295,
        column5_row326,
        column5_row358,
        column5_row359,
        column5_row390,
        column5_row391,
        column5_row422,
        column5_row423,
        column5_row454,
        column5_row518,
        column5_row711,
        column5_row902,
        column5_row903,
        column5_row966,
        column5_row967,
        column5_row1222,
        column5_row2438,
        column5_row2439,
        column5_row4486,
        column5_row4487,
        column5_row6534,
        column5_row6535,
        column5_row8582,
        column5_row8583,
        column5_row10630,
        column5_row10631,
        column5_row12678,
        column5_row12679,
        column5_row14726,
        column5_row14727,
        column5_row16774,
        column5_row16775,
        column5_row24966,
        column5_row33158,
        column6_row0,
        column6_row1,
        column6_row2,
        column6_row3,
        column7_row0,
        column7_row1,
        column7_row2,
        column7_row3,
        column7_row4,
        column7_row5,
        column7_row6,
        column7_row7,
        column7_row8,
        column7_row9,
        column7_row11,
        column7_row12,
        column7_row13,
        column7_row15,
        column7_row17,
        column7_row19,
        column7_row23,
        column7_row27,
        column7_row33,
        column7_row44,
        column7_row49,
        column7_row65,
        column7_row76,
        column7_row81,
        column7_row97,
        column7_row108,
        column7_row113,
        column7_row129,
        column7_row140,
        column7_row145,
        column7_row161,
        column7_row172,
        column7_row177,
        column7_row193,
        column7_row204,
        column7_row209,
        column7_row225,
        column7_row236,
        column7_row241,
        column7_row257,
        column7_row265,
        column7_row491,
        column7_row499,
        column7_row507,
        column7_row513,
        column7_row521,
        column7_row705,
        column7_row721,
        column7_row737,
        column7_row753,
        column7_row769,
        column7_row777,
        column7_row961,
        column7_row977,
        column7_row993,
        column7_row1009,
        column8_row0,
        column8_row1,
        column8_row2,
        column8_row3,
        column8_row4,
        column8_row5,
        column8_row6,
        column8_row7,
        column8_row8,
        column8_row9,
        column8_row10,
        column8_row11,
        column8_row12,
        column8_row13,
        column8_row14,
        column8_row16,
        column8_row17,
        column8_row19,
        column8_row21,
        column8_row22,
        column8_row24,
        column8_row25,
        column8_row27,
        column8_row29,
        column8_row30,
        column8_row33,
        column8_row35,
        column8_row37,
        column8_row38,
        column8_row41,
        column8_row43,
        column8_row45,
        column8_row46,
        column8_row49,
        column8_row51,
        column8_row53,
        column8_row54,
        column8_row57,
        column8_row59,
        column8_row61,
        column8_row65,
        column8_row69,
        column8_row71,
        column8_row73,
        column8_row77,
        column8_row81,
        column8_row85,
        column8_row89,
        column8_row91,
        column8_row97,
        column8_row101,
        column8_row105,
        column8_row109,
        column8_row113,
        column8_row117,
        column8_row123,
        column8_row155,
        column8_row187,
        column8_row195,
        column8_row205,
        column8_row219,
        column8_row221,
        column8_row237,
        column8_row245,
        column8_row253,
        column8_row269,
        column8_row301,
        column8_row309,
        column8_row310,
        column8_row318,
        column8_row326,
        column8_row334,
        column8_row342,
        column8_row350,
        column8_row451,
        column8_row461,
        column8_row477,
        column8_row493,
        column8_row501,
        column8_row509,
        column8_row12309,
        column8_row12373,
        column8_row12565,
        column8_row12629,
        column8_row16085,
        column8_row16149,
        column8_row16325,
        column8_row16331,
        column8_row16337,
        column8_row16339,
        column8_row16355,
        column8_row16357,
        column8_row16363,
        column8_row16369,
        column8_row16371,
        column8_row16385,
        column8_row16417,
        column8_row32647,
        column8_row32667,
        column8_row32715,
        column8_row32721,
        column8_row32731,
        column8_row32747,
        column8_row32753,
        column8_row32763,
        column9_inter1_row0,
        column9_inter1_row1,
        column9_inter1_row2,
        column9_inter1_row3,
        column9_inter1_row5,
        column9_inter1_row7,
        column9_inter1_row11,
        column9_inter1_row15
    ] =
        (*mask_values
        .multi_pop_front::<271>()
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
    let npc_reg_0 = column5_row0 + cpu_decode_opcode_range_check_bit_2 + 1;
    let cpu_decode_opcode_range_check_bit_10 = column0_row10 - (column0_row11 + column0_row11);
    let cpu_decode_opcode_range_check_bit_11 = column0_row11 - (column0_row12 + column0_row12);
    let cpu_decode_opcode_range_check_bit_14 = column0_row14 - (column0_row15 + column0_row15);
    let memory_address_diff_0 = column6_row2 - column6_row0;
    let range_check16_diff_0 = column7_row6 - column7_row2;
    let pedersen_hash0_ec_subset_sum_bit_0 = column3_row0 - (column3_row1 + column3_row1);
    let pedersen_hash0_ec_subset_sum_bit_neg_0 = 1 - pedersen_hash0_ec_subset_sum_bit_0;
    let range_check_builtin_value0_0 = column7_row12;
    let range_check_builtin_value1_0 = range_check_builtin_value0_0 * global_values.offset_size
        + column7_row44;
    let range_check_builtin_value2_0 = range_check_builtin_value1_0 * global_values.offset_size
        + column7_row76;
    let range_check_builtin_value3_0 = range_check_builtin_value2_0 * global_values.offset_size
        + column7_row108;
    let range_check_builtin_value4_0 = range_check_builtin_value3_0 * global_values.offset_size
        + column7_row140;
    let range_check_builtin_value5_0 = range_check_builtin_value4_0 * global_values.offset_size
        + column7_row172;
    let range_check_builtin_value6_0 = range_check_builtin_value5_0 * global_values.offset_size
        + column7_row204;
    let range_check_builtin_value7_0 = range_check_builtin_value6_0 * global_values.offset_size
        + column7_row236;
    let ecdsa_signature0_doubling_key_x_squared = column8_row1 * column8_row1;
    let ecdsa_signature0_exponentiate_generator_bit_0 = column8_row59
        - (column8_row187 + column8_row187);
    let ecdsa_signature0_exponentiate_generator_bit_neg_0 = 1
        - ecdsa_signature0_exponentiate_generator_bit_0;
    let ecdsa_signature0_exponentiate_key_bit_0 = column8_row9 - (column8_row73 + column8_row73);
    let ecdsa_signature0_exponentiate_key_bit_neg_0 = 1 - ecdsa_signature0_exponentiate_key_bit_0;
    let bitwise_sum_var_0_0 = column7_row1
        + column7_row17 * 2
        + column7_row33 * 4
        + column7_row49 * 8
        + column7_row65 * 18446744073709551616
        + column7_row81 * 36893488147419103232
        + column7_row97 * 73786976294838206464
        + column7_row113 * 147573952589676412928;
    let bitwise_sum_var_8_0 = column7_row129 * 340282366920938463463374607431768211456
        + column7_row145 * 680564733841876926926749214863536422912
        + column7_row161 * 1361129467683753853853498429727072845824
        + column7_row177 * 2722258935367507707706996859454145691648
        + column7_row193 * 6277101735386680763835789423207666416102355444464034512896
        + column7_row209 * 12554203470773361527671578846415332832204710888928069025792
        + column7_row225 * 25108406941546723055343157692830665664409421777856138051584
        + column7_row241 * 50216813883093446110686315385661331328818843555712276103168;
    let ec_op_doubling_q_x_squared_0 = column8_row41 * column8_row41;
    let ec_op_ec_subset_sum_bit_0 = column8_row21 - (column8_row85 + column8_row85);
    let ec_op_ec_subset_sum_bit_neg_0 = 1 - ec_op_ec_subset_sum_bit_0;
    let poseidon_poseidon_full_rounds_state0_cubed_0 = column8_row53 * column8_row29;
    let poseidon_poseidon_full_rounds_state1_cubed_0 = column8_row13 * column8_row61;
    let poseidon_poseidon_full_rounds_state2_cubed_0 = column8_row45 * column8_row3;
    let poseidon_poseidon_full_rounds_state0_cubed_7 = column8_row501 * column8_row477;
    let poseidon_poseidon_full_rounds_state1_cubed_7 = column8_row461 * column8_row509;
    let poseidon_poseidon_full_rounds_state2_cubed_7 = column8_row493 * column8_row451;
    let poseidon_poseidon_full_rounds_state0_cubed_3 = column8_row245 * column8_row221;
    let poseidon_poseidon_full_rounds_state1_cubed_3 = column8_row205 * column8_row253;
    let poseidon_poseidon_full_rounds_state2_cubed_3 = column8_row237 * column8_row195;
    let poseidon_poseidon_partial_rounds_state0_cubed_0 = column7_row3 * column7_row7;
    let poseidon_poseidon_partial_rounds_state0_cubed_1 = column7_row11 * column7_row15;
    let poseidon_poseidon_partial_rounds_state0_cubed_2 = column7_row19 * column7_row23;
    let poseidon_poseidon_partial_rounds_state1_cubed_0 = column8_row6 * column8_row14;
    let poseidon_poseidon_partial_rounds_state1_cubed_1 = column8_row22 * column8_row30;
    let poseidon_poseidon_partial_rounds_state1_cubed_2 = column8_row38 * column8_row46;
    let poseidon_poseidon_partial_rounds_state1_cubed_19 = column8_row310 * column8_row318;
    let poseidon_poseidon_partial_rounds_state1_cubed_20 = column8_row326 * column8_row334;
    let poseidon_poseidon_partial_rounds_state1_cubed_21 = column8_row342 * column8_row350;

    // Sum constraints.

    let values = [
        (cpu_decode_opcode_range_check_bit_0 * cpu_decode_opcode_range_check_bit_0
            - cpu_decode_opcode_range_check_bit_0)
            * domain4
            / domain0, // Constraint: cpu/decode/opcode_range_check/bit.
        (column0_row0) / domain4, // Constraint: cpu/decode/opcode_range_check/zero.
        (column5_row1
            - (((column0_row0 * global_values.offset_size + column7_row4)
                * global_values.offset_size
                + column7_row8)
                * global_values.offset_size
                + column7_row0))
            / domain5, // Constraint: cpu/decode/opcode_range_check_input.
        (cpu_decode_flag_op1_base_op0_0 * cpu_decode_flag_op1_base_op0_0
            - cpu_decode_flag_op1_base_op0_0)
            / domain5, // Constraint: cpu/decode/flag_op1_base_op0_bit.
        (cpu_decode_flag_res_op1_0 * cpu_decode_flag_res_op1_0 - cpu_decode_flag_res_op1_0)
            / domain5, // Constraint: cpu/decode/flag_res_op1_bit.
        (cpu_decode_flag_pc_update_regular_0 * cpu_decode_flag_pc_update_regular_0
            - cpu_decode_flag_pc_update_regular_0)
            / domain5, // Constraint: cpu/decode/flag_pc_update_regular_bit.
        (cpu_decode_fp_update_regular_0 * cpu_decode_fp_update_regular_0
            - cpu_decode_fp_update_regular_0)
            / domain5, // Constraint: cpu/decode/fp_update_regular_bit.
        (column5_row8
            + global_values.half_offset_size
            - (cpu_decode_opcode_range_check_bit_0 * column8_row8
                + (1 - cpu_decode_opcode_range_check_bit_0) * column8_row0
                + column7_row0))
            / domain5, // Constraint: cpu/operands/mem_dst_addr.
        (column5_row4
            + global_values.half_offset_size
            - (cpu_decode_opcode_range_check_bit_1 * column8_row8
                + (1 - cpu_decode_opcode_range_check_bit_1) * column8_row0
                + column7_row8))
            / domain5, // Constraint: cpu/operands/mem0_addr.
        (column5_row12
            + global_values.half_offset_size
            - (cpu_decode_opcode_range_check_bit_2 * column5_row0
                + cpu_decode_opcode_range_check_bit_4 * column8_row0
                + cpu_decode_opcode_range_check_bit_3 * column8_row8
                + cpu_decode_flag_op1_base_op0_0 * column5_row5
                + column7_row4))
            / domain5, // Constraint: cpu/operands/mem1_addr.
        (column8_row4 - column5_row5 * column5_row13)
            / domain5, // Constraint: cpu/operands/ops_mul.
        ((1 - cpu_decode_opcode_range_check_bit_9) * column8_row12
            - (cpu_decode_opcode_range_check_bit_5 * (column5_row5 + column5_row13)
                + cpu_decode_opcode_range_check_bit_6 * column8_row4
                + cpu_decode_flag_res_op1_0 * column5_row13))
            / domain5, // Constraint: cpu/operands/res.
        (column8_row2 - cpu_decode_opcode_range_check_bit_9 * column5_row9)
            * domain28
            / domain5, // Constraint: cpu/update_registers/update_pc/tmp0.
        (column8_row10 - column8_row2 * column8_row12)
            * domain28
            / domain5, // Constraint: cpu/update_registers/update_pc/tmp1.
        ((1 - cpu_decode_opcode_range_check_bit_9) * column5_row16
            + column8_row2 * (column5_row16 - (column5_row0 + column5_row13))
            - (cpu_decode_flag_pc_update_regular_0 * npc_reg_0
                + cpu_decode_opcode_range_check_bit_7 * column8_row12
                + cpu_decode_opcode_range_check_bit_8 * (column5_row0 + column8_row12)))
            * domain28
            / domain5, // Constraint: cpu/update_registers/update_pc/pc_cond_negative.
        ((column8_row10 - cpu_decode_opcode_range_check_bit_9) * (column5_row16 - npc_reg_0))
            * domain28
            / domain5, // Constraint: cpu/update_registers/update_pc/pc_cond_positive.
        (column8_row16
            - (column8_row0
                + cpu_decode_opcode_range_check_bit_10 * column8_row12
                + cpu_decode_opcode_range_check_bit_11
                + cpu_decode_opcode_range_check_bit_12 * 2))
            * domain28
            / domain5, // Constraint: cpu/update_registers/update_ap/ap_update.
        (column8_row24
            - (cpu_decode_fp_update_regular_0 * column8_row8
                + cpu_decode_opcode_range_check_bit_13 * column5_row9
                + cpu_decode_opcode_range_check_bit_12 * (column8_row0 + 2)))
            * domain28
            / domain5, // Constraint: cpu/update_registers/update_fp/fp_update.
        (cpu_decode_opcode_range_check_bit_12 * (column5_row9 - column8_row8))
            / domain5, // Constraint: cpu/opcodes/call/push_fp.
        (cpu_decode_opcode_range_check_bit_12
            * (column5_row5 - (column5_row0 + cpu_decode_opcode_range_check_bit_2 + 1)))
            / domain5, // Constraint: cpu/opcodes/call/push_pc.
        (cpu_decode_opcode_range_check_bit_12 * (column7_row0 - global_values.half_offset_size))
            / domain5, // Constraint: cpu/opcodes/call/off0.
        (cpu_decode_opcode_range_check_bit_12
            * (column7_row8 - (global_values.half_offset_size + 1)))
            / domain5, // Constraint: cpu/opcodes/call/off1.
        (cpu_decode_opcode_range_check_bit_12
            * (cpu_decode_opcode_range_check_bit_12
                + cpu_decode_opcode_range_check_bit_12
                + 1
                + 1
                - (cpu_decode_opcode_range_check_bit_0 + cpu_decode_opcode_range_check_bit_1 + 4)))
            / domain5, // Constraint: cpu/opcodes/call/flags.
        (cpu_decode_opcode_range_check_bit_13 * (column7_row0 + 2 - global_values.half_offset_size))
            / domain5, // Constraint: cpu/opcodes/ret/off0.
        (cpu_decode_opcode_range_check_bit_13 * (column7_row4 + 1 - global_values.half_offset_size))
            / domain5, // Constraint: cpu/opcodes/ret/off2.
        (cpu_decode_opcode_range_check_bit_13
            * (cpu_decode_opcode_range_check_bit_7
                + cpu_decode_opcode_range_check_bit_0
                + cpu_decode_opcode_range_check_bit_3
                + cpu_decode_flag_res_op1_0
                - 4))
            / domain5, // Constraint: cpu/opcodes/ret/flags.
        (cpu_decode_opcode_range_check_bit_14 * (column5_row9 - column8_row12))
            / domain5, // Constraint: cpu/opcodes/assert_eq/assert_eq.
        (column8_row0 - global_values.initial_ap) / domain29, // Constraint: initial_ap.
        (column8_row8 - global_values.initial_ap) / domain29, // Constraint: initial_fp.
        (column5_row0 - global_values.initial_pc) / domain29, // Constraint: initial_pc.
        (column8_row0 - global_values.final_ap) / domain28, // Constraint: final_ap.
        (column8_row8 - global_values.initial_ap) / domain28, // Constraint: final_fp.
        (column5_row0 - global_values.final_pc) / domain28, // Constraint: final_pc.
        ((global_values.memory_multi_column_perm_perm_interaction_elm
            - (column6_row0
                + global_values.memory_multi_column_perm_hash_interaction_elm0 * column6_row1))
            * column9_inter1_row0
            + column5_row0
            + global_values.memory_multi_column_perm_hash_interaction_elm0 * column5_row1
            - global_values.memory_multi_column_perm_perm_interaction_elm)
            / domain29, // Constraint: memory/multi_column_perm/perm/init0.
        ((global_values.memory_multi_column_perm_perm_interaction_elm
            - (column6_row2
                + global_values.memory_multi_column_perm_hash_interaction_elm0 * column6_row3))
            * column9_inter1_row2
            - (global_values.memory_multi_column_perm_perm_interaction_elm
                - (column5_row2
                    + global_values.memory_multi_column_perm_hash_interaction_elm0 * column5_row3))
                * column9_inter1_row0)
            * domain30
            / domain1, // Constraint: memory/multi_column_perm/perm/step0.
        (column9_inter1_row0 - global_values.memory_multi_column_perm_perm_public_memory_prod)
            / domain30, // Constraint: memory/multi_column_perm/perm/last.
        (memory_address_diff_0 * memory_address_diff_0 - memory_address_diff_0)
            * domain30
            / domain1, // Constraint: memory/diff_is_bit.
        ((memory_address_diff_0 - 1) * (column6_row1 - column6_row3))
            * domain30
            / domain1, // Constraint: memory/is_func.
        (column6_row0 - 1) / domain29, // Constraint: memory/initial_addr.
        (column5_row2) / domain3, // Constraint: public_memory_addr_zero.
        (column5_row3) / domain3, // Constraint: public_memory_value_zero.
        ((global_values.range_check16_perm_interaction_elm - column7_row2) * column9_inter1_row1
            + column7_row0
            - global_values.range_check16_perm_interaction_elm)
            / domain29, // Constraint: range_check16/perm/init0.
        ((global_values.range_check16_perm_interaction_elm - column7_row6) * column9_inter1_row5
            - (global_values.range_check16_perm_interaction_elm - column7_row4)
                * column9_inter1_row1)
            * domain31
            / domain2, // Constraint: range_check16/perm/step0.
        (column9_inter1_row1 - global_values.range_check16_perm_public_memory_prod)
            / domain31, // Constraint: range_check16/perm/last.
        (range_check16_diff_0 * range_check16_diff_0 - range_check16_diff_0)
            * domain31
            / domain2, // Constraint: range_check16/diff_is_bit.
        (column7_row2 - global_values.range_check_min)
            / domain29, // Constraint: range_check16/minimum.
        (column7_row2 - global_values.range_check_max)
            / domain31, // Constraint: range_check16/maximum.
        ((global_values.diluted_check_permutation_interaction_elm - column7_row5)
            * column9_inter1_row7
            + column7_row1
            - global_values.diluted_check_permutation_interaction_elm)
            / domain29, // Constraint: diluted_check/permutation/init0.
        ((global_values.diluted_check_permutation_interaction_elm - column7_row13)
            * column9_inter1_row15
            - (global_values.diluted_check_permutation_interaction_elm - column7_row9)
                * column9_inter1_row7)
            * domain32
            / domain3, // Constraint: diluted_check/permutation/step0.
        (column9_inter1_row7 - global_values.diluted_check_permutation_public_memory_prod)
            / domain32, // Constraint: diluted_check/permutation/last.
        (column9_inter1_row3 - 1) / domain29, // Constraint: diluted_check/init.
        (column7_row5 - global_values.diluted_check_first_elm)
            / domain29, // Constraint: diluted_check/first_element.
        (column9_inter1_row11
            - (column9_inter1_row3
                * (1 + global_values.diluted_check_interaction_z * (column7_row13 - column7_row5))
                + global_values.diluted_check_interaction_alpha
                    * (column7_row13 - column7_row5)
                    * (column7_row13 - column7_row5)))
            * domain32
            / domain3, // Constraint: diluted_check/step.
        (column9_inter1_row3 - global_values.diluted_check_final_cum_val)
            / domain32, // Constraint: diluted_check/last.
        (column8_row71 * (column3_row0 - (column3_row1 + column3_row1)))
            / domain8, // Constraint: pedersen/hash0/ec_subset_sum/bit_unpacking/last_one_is_zero.
        (column8_row71
            * (column3_row1
                - 3138550867693340381917894711603833208051177722232017256448 * column3_row192))
            / domain8, // Constraint: pedersen/hash0/ec_subset_sum/bit_unpacking/zeroes_between_ones0.
        (column8_row71 - column4_row255 * (column3_row192 - (column3_row193 + column3_row193)))
            / domain8, // Constraint: pedersen/hash0/ec_subset_sum/bit_unpacking/cumulative_bit192.
        (column4_row255 * (column3_row193 - 8 * column3_row196))
            / domain8, // Constraint: pedersen/hash0/ec_subset_sum/bit_unpacking/zeroes_between_ones192.
        (column4_row255
            - (column3_row251 - (column3_row252 + column3_row252))
                * (column3_row196 - (column3_row197 + column3_row197)))
            / domain8, // Constraint: pedersen/hash0/ec_subset_sum/bit_unpacking/cumulative_bit196.
        ((column3_row251 - (column3_row252 + column3_row252))
            * (column3_row197 - 18014398509481984 * column3_row251))
            / domain8, // Constraint: pedersen/hash0/ec_subset_sum/bit_unpacking/zeroes_between_ones196.
        (pedersen_hash0_ec_subset_sum_bit_0 * (pedersen_hash0_ec_subset_sum_bit_0 - 1))
            * domain9
            / domain0, // Constraint: pedersen/hash0/ec_subset_sum/booleanity_test.
        (column3_row0) / domain10, // Constraint: pedersen/hash0/ec_subset_sum/bit_extraction_end.
        (column3_row0) / domain9, // Constraint: pedersen/hash0/ec_subset_sum/zeros_tail.
        (pedersen_hash0_ec_subset_sum_bit_0 * (column2_row0 - global_values.pedersen_points_y)
            - column4_row0 * (column1_row0 - global_values.pedersen_points_x))
            * domain9
            / domain0, // Constraint: pedersen/hash0/ec_subset_sum/add_points/slope.
        (column4_row0 * column4_row0
            - pedersen_hash0_ec_subset_sum_bit_0
                * (column1_row0 + global_values.pedersen_points_x + column1_row1))
            * domain9
            / domain0, // Constraint: pedersen/hash0/ec_subset_sum/add_points/x.
        (pedersen_hash0_ec_subset_sum_bit_0 * (column2_row0 + column2_row1)
            - column4_row0 * (column1_row0 - column1_row1))
            * domain9
            / domain0, // Constraint: pedersen/hash0/ec_subset_sum/add_points/y.
        (pedersen_hash0_ec_subset_sum_bit_neg_0 * (column1_row1 - column1_row0))
            * domain9
            / domain0, // Constraint: pedersen/hash0/ec_subset_sum/copy_point/x.
        (pedersen_hash0_ec_subset_sum_bit_neg_0 * (column2_row1 - column2_row0))
            * domain9
            / domain0, // Constraint: pedersen/hash0/ec_subset_sum/copy_point/y.
        (column1_row256 - column1_row255)
            * domain12
            / domain8, // Constraint: pedersen/hash0/copy_point/x.
        (column2_row256 - column2_row255)
            * domain12
            / domain8, // Constraint: pedersen/hash0/copy_point/y.
        (column1_row0 - global_values.pedersen_shift_point.x)
            / domain13, // Constraint: pedersen/hash0/init/x.
        (column2_row0 - global_values.pedersen_shift_point.y)
            / domain13, // Constraint: pedersen/hash0/init/y.
        (column5_row7 - column3_row0) / domain13, // Constraint: pedersen/input0_value0.
        (column5_row518 - (column5_row134 + 1))
            * domain33
            / domain13, // Constraint: pedersen/input0_addr.
        (column5_row6 - global_values.initial_pedersen_addr)
            / domain29, // Constraint: pedersen/init_addr.
        (column5_row263 - column3_row256) / domain13, // Constraint: pedersen/input1_value0.
        (column5_row262 - (column5_row6 + 1)) / domain13, // Constraint: pedersen/input1_addr.
        (column5_row135 - column1_row511) / domain13, // Constraint: pedersen/output_value0.
        (column5_row134 - (column5_row262 + 1)) / domain13, // Constraint: pedersen/output_addr.
        (range_check_builtin_value7_0 - column5_row71)
            / domain8, // Constraint: range_check_builtin/value.
        (column5_row326 - (column5_row70 + 1))
            * domain34
            / domain8, // Constraint: range_check_builtin/addr_step.
        (column5_row70 - global_values.initial_range_check_addr)
            / domain29, // Constraint: range_check_builtin/init_addr.
        (ecdsa_signature0_doubling_key_x_squared
            + ecdsa_signature0_doubling_key_x_squared
            + ecdsa_signature0_doubling_key_x_squared
            + global_values.ecdsa_sig_config.alpha
            - (column8_row33 + column8_row33) * column8_row35)
            * domain21
            / domain6, // Constraint: ecdsa/signature0/doubling_key/slope.
        (column8_row35 * column8_row35 - (column8_row1 + column8_row1 + column8_row65))
            * domain21
            / domain6, // Constraint: ecdsa/signature0/doubling_key/x.
        (column8_row33 + column8_row97 - column8_row35 * (column8_row1 - column8_row65))
            * domain21
            / domain6, // Constraint: ecdsa/signature0/doubling_key/y.
        (ecdsa_signature0_exponentiate_generator_bit_0
            * (ecdsa_signature0_exponentiate_generator_bit_0 - 1))
            * domain25
            / domain7, // Constraint: ecdsa/signature0/exponentiate_generator/booleanity_test.
        (column8_row59)
            / domain26, // Constraint: ecdsa/signature0/exponentiate_generator/bit_extraction_end.
        (column8_row59)
            / domain25, // Constraint: ecdsa/signature0/exponentiate_generator/zeros_tail.
        (ecdsa_signature0_exponentiate_generator_bit_0
            * (column8_row91 - global_values.ecdsa_generator_points_y)
            - column8_row123 * (column8_row27 - global_values.ecdsa_generator_points_x))
            * domain25
            / domain7, // Constraint: ecdsa/signature0/exponentiate_generator/add_points/slope.
        (column8_row123 * column8_row123
            - ecdsa_signature0_exponentiate_generator_bit_0
                * (column8_row27 + global_values.ecdsa_generator_points_x + column8_row155))
            * domain25
            / domain7, // Constraint: ecdsa/signature0/exponentiate_generator/add_points/x.
        (ecdsa_signature0_exponentiate_generator_bit_0 * (column8_row91 + column8_row219)
            - column8_row123 * (column8_row27 - column8_row155))
            * domain25
            / domain7, // Constraint: ecdsa/signature0/exponentiate_generator/add_points/y.
        (column8_row7 * (column8_row27 - global_values.ecdsa_generator_points_x) - 1)
            * domain25
            / domain7, // Constraint: ecdsa/signature0/exponentiate_generator/add_points/x_diff_inv.
        (ecdsa_signature0_exponentiate_generator_bit_neg_0 * (column8_row155 - column8_row27))
            * domain25
            / domain7, // Constraint: ecdsa/signature0/exponentiate_generator/copy_point/x.
        (ecdsa_signature0_exponentiate_generator_bit_neg_0 * (column8_row219 - column8_row91))
            * domain25
            / domain7, // Constraint: ecdsa/signature0/exponentiate_generator/copy_point/y.
        (ecdsa_signature0_exponentiate_key_bit_0 * (ecdsa_signature0_exponentiate_key_bit_0 - 1))
            * domain21
            / domain6, // Constraint: ecdsa/signature0/exponentiate_key/booleanity_test.
        (column8_row9)
            / domain22, // Constraint: ecdsa/signature0/exponentiate_key/bit_extraction_end.
        (column8_row9) / domain21, // Constraint: ecdsa/signature0/exponentiate_key/zeros_tail.
        (ecdsa_signature0_exponentiate_key_bit_0 * (column8_row49 - column8_row33)
            - column8_row19 * (column8_row17 - column8_row1))
            * domain21
            / domain6, // Constraint: ecdsa/signature0/exponentiate_key/add_points/slope.
        (column8_row19 * column8_row19
            - ecdsa_signature0_exponentiate_key_bit_0
                * (column8_row17 + column8_row1 + column8_row81))
            * domain21
            / domain6, // Constraint: ecdsa/signature0/exponentiate_key/add_points/x.
        (ecdsa_signature0_exponentiate_key_bit_0 * (column8_row49 + column8_row113)
            - column8_row19 * (column8_row17 - column8_row81))
            * domain21
            / domain6, // Constraint: ecdsa/signature0/exponentiate_key/add_points/y.
        (column8_row51 * (column8_row17 - column8_row1) - 1)
            * domain21
            / domain6, // Constraint: ecdsa/signature0/exponentiate_key/add_points/x_diff_inv.
        (ecdsa_signature0_exponentiate_key_bit_neg_0 * (column8_row81 - column8_row17))
            * domain21
            / domain6, // Constraint: ecdsa/signature0/exponentiate_key/copy_point/x.
        (ecdsa_signature0_exponentiate_key_bit_neg_0 * (column8_row113 - column8_row49))
            * domain21
            / domain6, // Constraint: ecdsa/signature0/exponentiate_key/copy_point/y.
        (column8_row27 - global_values.ecdsa_sig_config.shift_point.x)
            / domain27, // Constraint: ecdsa/signature0/init_gen/x.
        (column8_row91 + global_values.ecdsa_sig_config.shift_point.y)
            / domain27, // Constraint: ecdsa/signature0/init_gen/y.
        (column8_row17 - global_values.ecdsa_sig_config.shift_point.x)
            / domain23, // Constraint: ecdsa/signature0/init_key/x.
        (column8_row49 - global_values.ecdsa_sig_config.shift_point.y)
            / domain23, // Constraint: ecdsa/signature0/init_key/y.
        (column8_row32731
            - (column8_row16369 + column8_row32763 * (column8_row32667 - column8_row16337)))
            / domain27, // Constraint: ecdsa/signature0/add_results/slope.
        (column8_row32763 * column8_row32763
            - (column8_row32667 + column8_row16337 + column8_row16385))
            / domain27, // Constraint: ecdsa/signature0/add_results/x.
        (column8_row32731
            + column8_row16417
            - column8_row32763 * (column8_row32667 - column8_row16385))
            / domain27, // Constraint: ecdsa/signature0/add_results/y.
        (column8_row32647 * (column8_row32667 - column8_row16337) - 1)
            / domain27, // Constraint: ecdsa/signature0/add_results/x_diff_inv.
        (column8_row32753
            + global_values.ecdsa_sig_config.shift_point.y
            - column8_row16331 * (column8_row32721 - global_values.ecdsa_sig_config.shift_point.x))
            / domain27, // Constraint: ecdsa/signature0/extract_r/slope.
        (column8_row16331 * column8_row16331
            - (column8_row32721 + global_values.ecdsa_sig_config.shift_point.x + column8_row9))
            / domain27, // Constraint: ecdsa/signature0/extract_r/x.
        (column8_row32715 * (column8_row32721 - global_values.ecdsa_sig_config.shift_point.x) - 1)
            / domain27, // Constraint: ecdsa/signature0/extract_r/x_diff_inv.
        (column8_row59 * column8_row16363 - 1)
            / domain27, // Constraint: ecdsa/signature0/z_nonzero.
        (column8_row9 * column8_row16355 - 1)
            / domain23, // Constraint: ecdsa/signature0/r_and_w_nonzero.
        (column8_row32747 - column8_row1 * column8_row1)
            / domain27, // Constraint: ecdsa/signature0/q_on_curve/x_squared.
        (column8_row33 * column8_row33
            - (column8_row1 * column8_row32747
                + global_values.ecdsa_sig_config.alpha * column8_row1
                + global_values.ecdsa_sig_config.beta))
            / domain27, // Constraint: ecdsa/signature0/q_on_curve/on_curve.
        (column5_row390 - global_values.initial_ecdsa_addr)
            / domain29, // Constraint: ecdsa/init_addr.
        (column5_row16774 - (column5_row390 + 1)) / domain27, // Constraint: ecdsa/message_addr.
        (column5_row33158 - (column5_row16774 + 1))
            * domain35
            / domain27, // Constraint: ecdsa/pubkey_addr.
        (column5_row16775 - column8_row59) / domain27, // Constraint: ecdsa/message_value0.
        (column5_row391 - column8_row1) / domain27, // Constraint: ecdsa/pubkey_value0.
        (column5_row198 - global_values.initial_bitwise_addr)
            / domain29, // Constraint: bitwise/init_var_pool_addr.
        (column5_row454 - (column5_row198 + 1))
            * domain18
            / domain8, // Constraint: bitwise/step_var_pool_addr.
        (column5_row902 - (column5_row966 + 1)) / domain19, // Constraint: bitwise/x_or_y_addr.
        (column5_row1222 - (column5_row902 + 1))
            * domain36
            / domain19, // Constraint: bitwise/next_var_pool_addr.
        (bitwise_sum_var_0_0 + bitwise_sum_var_8_0 - column5_row199)
            / domain8, // Constraint: bitwise/partition.
        (column5_row903 - (column5_row711 + column5_row967))
            / domain19, // Constraint: bitwise/or_is_and_plus_xor.
        (column7_row1 + column7_row257 - (column7_row769 + column7_row513 + column7_row513))
            / domain20, // Constraint: bitwise/addition_is_xor_with_and.
        ((column7_row705 + column7_row961) * 16 - column7_row9)
            / domain19, // Constraint: bitwise/unique_unpacking192.
        ((column7_row721 + column7_row977) * 16 - column7_row521)
            / domain19, // Constraint: bitwise/unique_unpacking193.
        ((column7_row737 + column7_row993) * 16 - column7_row265)
            / domain19, // Constraint: bitwise/unique_unpacking194.
        ((column7_row753 + column7_row1009) * 256 - column7_row777)
            / domain19, // Constraint: bitwise/unique_unpacking195.
        (column5_row8582 - global_values.initial_ec_op_addr)
            / domain29, // Constraint: ec_op/init_addr.
        (column5_row24966 - (column5_row8582 + 7))
            * domain37
            / domain23, // Constraint: ec_op/p_x_addr.
        (column5_row4486 - (column5_row8582 + 1)) / domain23, // Constraint: ec_op/p_y_addr.
        (column5_row12678 - (column5_row4486 + 1)) / domain23, // Constraint: ec_op/q_x_addr.
        (column5_row2438 - (column5_row12678 + 1)) / domain23, // Constraint: ec_op/q_y_addr.
        (column5_row10630 - (column5_row2438 + 1)) / domain23, // Constraint: ec_op/m_addr.
        (column5_row6534 - (column5_row10630 + 1)) / domain23, // Constraint: ec_op/r_x_addr.
        (column5_row14726 - (column5_row6534 + 1)) / domain23, // Constraint: ec_op/r_y_addr.
        (ec_op_doubling_q_x_squared_0
            + ec_op_doubling_q_x_squared_0
            + ec_op_doubling_q_x_squared_0
            + global_values.ec_op_curve_config.alpha
            - (column8_row25 + column8_row25) * column8_row57)
            * domain21
            / domain6, // Constraint: ec_op/doubling_q/slope.
        (column8_row57 * column8_row57 - (column8_row41 + column8_row41 + column8_row105))
            * domain21
            / domain6, // Constraint: ec_op/doubling_q/x.
        (column8_row25 + column8_row89 - column8_row57 * (column8_row41 - column8_row105))
            * domain21
            / domain6, // Constraint: ec_op/doubling_q/y.
        (column5_row12679 - column8_row41) / domain23, // Constraint: ec_op/get_q_x.
        (column5_row2439 - column8_row25) / domain23, // Constraint: ec_op/get_q_y.
        (column8_row16371 * (column8_row21 - (column8_row85 + column8_row85)))
            / domain23, // Constraint: ec_op/ec_subset_sum/bit_unpacking/last_one_is_zero.
        (column8_row16371
            * (column8_row85
                - 3138550867693340381917894711603833208051177722232017256448 * column8_row12309))
            / domain23, // Constraint: ec_op/ec_subset_sum/bit_unpacking/zeroes_between_ones0.
        (column8_row16371
            - column8_row16339 * (column8_row12309 - (column8_row12373 + column8_row12373)))
            / domain23, // Constraint: ec_op/ec_subset_sum/bit_unpacking/cumulative_bit192.
        (column8_row16339 * (column8_row12373 - 8 * column8_row12565))
            / domain23, // Constraint: ec_op/ec_subset_sum/bit_unpacking/zeroes_between_ones192.
        (column8_row16339
            - (column8_row16085 - (column8_row16149 + column8_row16149))
                * (column8_row12565 - (column8_row12629 + column8_row12629)))
            / domain23, // Constraint: ec_op/ec_subset_sum/bit_unpacking/cumulative_bit196.
        ((column8_row16085 - (column8_row16149 + column8_row16149))
            * (column8_row12629 - 18014398509481984 * column8_row16085))
            / domain23, // Constraint: ec_op/ec_subset_sum/bit_unpacking/zeroes_between_ones196.
        (ec_op_ec_subset_sum_bit_0 * (ec_op_ec_subset_sum_bit_0 - 1))
            * domain21
            / domain6, // Constraint: ec_op/ec_subset_sum/booleanity_test.
        (column8_row21) / domain24, // Constraint: ec_op/ec_subset_sum/bit_extraction_end.
        (column8_row21) / domain21, // Constraint: ec_op/ec_subset_sum/zeros_tail.
        (ec_op_ec_subset_sum_bit_0 * (column8_row37 - column8_row25)
            - column8_row11 * (column8_row5 - column8_row41))
            * domain21
            / domain6, // Constraint: ec_op/ec_subset_sum/add_points/slope.
        (column8_row11 * column8_row11
            - ec_op_ec_subset_sum_bit_0 * (column8_row5 + column8_row41 + column8_row69))
            * domain21
            / domain6, // Constraint: ec_op/ec_subset_sum/add_points/x.
        (ec_op_ec_subset_sum_bit_0 * (column8_row37 + column8_row101)
            - column8_row11 * (column8_row5 - column8_row69))
            * domain21
            / domain6, // Constraint: ec_op/ec_subset_sum/add_points/y.
        (column8_row43 * (column8_row5 - column8_row41) - 1)
            * domain21
            / domain6, // Constraint: ec_op/ec_subset_sum/add_points/x_diff_inv.
        (ec_op_ec_subset_sum_bit_neg_0 * (column8_row69 - column8_row5))
            * domain21
            / domain6, // Constraint: ec_op/ec_subset_sum/copy_point/x.
        (ec_op_ec_subset_sum_bit_neg_0 * (column8_row101 - column8_row37))
            * domain21
            / domain6, // Constraint: ec_op/ec_subset_sum/copy_point/y.
        (column8_row21 - column5_row10631) / domain23, // Constraint: ec_op/get_m.
        (column5_row8583 - column8_row5) / domain23, // Constraint: ec_op/get_p_x.
        (column5_row4487 - column8_row37) / domain23, // Constraint: ec_op/get_p_y.
        (column5_row6535 - column8_row16325) / domain23, // Constraint: ec_op/set_r_x.
        (column5_row14727 - column8_row16357) / domain23, // Constraint: ec_op/set_r_y.
        (column5_row38 - global_values.initial_poseidon_addr)
            / domain29, // Constraint: poseidon/param_0/init_input_output_addr.
        (column5_row294 - (column5_row38 + 3))
            * domain34
            / domain8, // Constraint: poseidon/param_0/addr_input_output_step.
        (column5_row166 - (global_values.initial_poseidon_addr + 1))
            / domain29, // Constraint: poseidon/param_1/init_input_output_addr.
        (column5_row422 - (column5_row166 + 3))
            * domain34
            / domain8, // Constraint: poseidon/param_1/addr_input_output_step.
        (column5_row102 - (global_values.initial_poseidon_addr + 2))
            / domain29, // Constraint: poseidon/param_2/init_input_output_addr.
        (column5_row358 - (column5_row102 + 3))
            * domain34
            / domain8, // Constraint: poseidon/param_2/addr_input_output_step.
        (column8_row53 * column8_row53 - column8_row29)
            / domain6, // Constraint: poseidon/poseidon/full_rounds_state0_squaring.
        (column8_row13 * column8_row13 - column8_row61)
            / domain6, // Constraint: poseidon/poseidon/full_rounds_state1_squaring.
        (column8_row45 * column8_row45 - column8_row3)
            / domain6, // Constraint: poseidon/poseidon/full_rounds_state2_squaring.
        (column7_row3 * column7_row3 - column7_row7)
            / domain3, // Constraint: poseidon/poseidon/partial_rounds_state0_squaring.
        (column8_row6 * column8_row6 - column8_row14)
            * domain15
            / domain5, // Constraint: poseidon/poseidon/partial_rounds_state1_squaring.
        (column5_row39
            + 2950795762459345168613727575620414179244544320470208355568817838579231751791
            - column8_row53)
            / domain13, // Constraint: poseidon/poseidon/add_first_round_key0.
        (column5_row167
            + 1587446564224215276866294500450702039420286416111469274423465069420553242820
            - column8_row13)
            / domain13, // Constraint: poseidon/poseidon/add_first_round_key1.
        (column5_row103
            + 1645965921169490687904413452218868659025437693527479459426157555728339600137
            - column8_row45)
            / domain13, // Constraint: poseidon/poseidon/add_first_round_key2.
        (column8_row117
            - (poseidon_poseidon_full_rounds_state0_cubed_0
                + poseidon_poseidon_full_rounds_state0_cubed_0
                + poseidon_poseidon_full_rounds_state0_cubed_0
                + poseidon_poseidon_full_rounds_state1_cubed_0
                + poseidon_poseidon_full_rounds_state2_cubed_0
                + global_values.poseidon_poseidon_full_round_key0))
            * domain11
            / domain6, // Constraint: poseidon/poseidon/full_round0.
        (column8_row77
            + poseidon_poseidon_full_rounds_state1_cubed_0
            - (poseidon_poseidon_full_rounds_state0_cubed_0
                + poseidon_poseidon_full_rounds_state2_cubed_0
                + global_values.poseidon_poseidon_full_round_key1))
            * domain11
            / domain6, // Constraint: poseidon/poseidon/full_round1.
        (column8_row109
            + poseidon_poseidon_full_rounds_state2_cubed_0
            + poseidon_poseidon_full_rounds_state2_cubed_0
            - (poseidon_poseidon_full_rounds_state0_cubed_0
                + poseidon_poseidon_full_rounds_state1_cubed_0
                + global_values.poseidon_poseidon_full_round_key2))
            * domain11
            / domain6, // Constraint: poseidon/poseidon/full_round2.
        (column5_row295
            - (poseidon_poseidon_full_rounds_state0_cubed_7
                + poseidon_poseidon_full_rounds_state0_cubed_7
                + poseidon_poseidon_full_rounds_state0_cubed_7
                + poseidon_poseidon_full_rounds_state1_cubed_7
                + poseidon_poseidon_full_rounds_state2_cubed_7))
            / domain13, // Constraint: poseidon/poseidon/last_full_round0.
        (column5_row423
            + poseidon_poseidon_full_rounds_state1_cubed_7
            - (poseidon_poseidon_full_rounds_state0_cubed_7
                + poseidon_poseidon_full_rounds_state2_cubed_7))
            / domain13, // Constraint: poseidon/poseidon/last_full_round1.
        (column5_row359
            + poseidon_poseidon_full_rounds_state2_cubed_7
            + poseidon_poseidon_full_rounds_state2_cubed_7
            - (poseidon_poseidon_full_rounds_state0_cubed_7
                + poseidon_poseidon_full_rounds_state1_cubed_7))
            / domain13, // Constraint: poseidon/poseidon/last_full_round2.
        (column7_row491 - column8_row6)
            / domain13, // Constraint: poseidon/poseidon/copy_partial_rounds0_i0.
        (column7_row499 - column8_row22)
            / domain13, // Constraint: poseidon/poseidon/copy_partial_rounds0_i1.
        (column7_row507 - column8_row38)
            / domain13, // Constraint: poseidon/poseidon/copy_partial_rounds0_i2.
        (column7_row3
            + poseidon_poseidon_full_rounds_state2_cubed_3
            + poseidon_poseidon_full_rounds_state2_cubed_3
            - (poseidon_poseidon_full_rounds_state0_cubed_3
                + poseidon_poseidon_full_rounds_state1_cubed_3
                + 2121140748740143694053732746913428481442990369183417228688865837805149503386))
            / domain13, // Constraint: poseidon/poseidon/margin_full_to_partial0.
        (column7_row11
            - (3618502788666131213697322783095070105623107215331596699973092056135872020477
                * poseidon_poseidon_full_rounds_state1_cubed_3
                + 10 * poseidon_poseidon_full_rounds_state2_cubed_3
                + 4 * column7_row3
                + 3618502788666131213697322783095070105623107215331596699973092056135872020479
                    * poseidon_poseidon_partial_rounds_state0_cubed_0
                + 2006642341318481906727563724340978325665491359415674592697055778067937914672))
            / domain13, // Constraint: poseidon/poseidon/margin_full_to_partial1.
        (column7_row19
            - (8 * poseidon_poseidon_full_rounds_state2_cubed_3
                + 4 * column7_row3
                + 6 * poseidon_poseidon_partial_rounds_state0_cubed_0
                + column7_row11
                + column7_row11
                + 3618502788666131213697322783095070105623107215331596699973092056135872020479
                    * poseidon_poseidon_partial_rounds_state0_cubed_1
                + 427751140904099001132521606468025610873158555767197326325930641757709538586))
            / domain13, // Constraint: poseidon/poseidon/margin_full_to_partial2.
        (column7_row27
            - (8 * poseidon_poseidon_partial_rounds_state0_cubed_0
                + 4 * column7_row11
                + 6 * poseidon_poseidon_partial_rounds_state0_cubed_1
                + column7_row19
                + column7_row19
                + 3618502788666131213697322783095070105623107215331596699973092056135872020479
                    * poseidon_poseidon_partial_rounds_state0_cubed_2
                + global_values.poseidon_poseidon_partial_round_key0))
            * domain16
            / domain3, // Constraint: poseidon/poseidon/partial_round0.
        (column8_row54
            - (8 * poseidon_poseidon_partial_rounds_state1_cubed_0
                + 4 * column8_row22
                + 6 * poseidon_poseidon_partial_rounds_state1_cubed_1
                + column8_row38
                + column8_row38
                + 3618502788666131213697322783095070105623107215331596699973092056135872020479
                    * poseidon_poseidon_partial_rounds_state1_cubed_2
                + global_values.poseidon_poseidon_partial_round_key1))
            * domain17
            / domain5, // Constraint: poseidon/poseidon/partial_round1.
        (column8_row309
            - (16 * poseidon_poseidon_partial_rounds_state1_cubed_19
                + 8 * column8_row326
                + 16 * poseidon_poseidon_partial_rounds_state1_cubed_20
                + 6 * column8_row342
                + poseidon_poseidon_partial_rounds_state1_cubed_21
                + 560279373700919169769089400651532183647886248799764942664266404650165812023))
            / domain13, // Constraint: poseidon/poseidon/margin_partial_to_full0.
        (column8_row269
            - (4 * poseidon_poseidon_partial_rounds_state1_cubed_20
                + column8_row342
                + column8_row342
                + poseidon_poseidon_partial_rounds_state1_cubed_21
                + 1401754474293352309994371631695783042590401941592571735921592823982231996415))
            / domain13, // Constraint: poseidon/poseidon/margin_partial_to_full1.
        (column8_row301
            - (8 * poseidon_poseidon_partial_rounds_state1_cubed_19
                + 4 * column8_row326
                + 6 * poseidon_poseidon_partial_rounds_state1_cubed_20
                + column8_row342
                + column8_row342
                + 3618502788666131213697322783095070105623107215331596699973092056135872020479
                    * poseidon_poseidon_partial_rounds_state1_cubed_21
                + 1246177936547655338400308396717835700699368047388302793172818304164989556526))
            / domain13, // Constraint: poseidon/poseidon/margin_partial_to_full2.
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
    let pow1 = pow(trace_generator, 32715);
    let pow2 = pow(trace_generator, 32667);
    let pow3 = pow(trace_generator, 32647);
    let pow4 = pow(trace_generator, 16325);
    let pow5 = pow(trace_generator, 16149);
    let pow6 = pow(trace_generator, 16085);
    let pow7 = pow(trace_generator, 12373);
    let pow8 = pow(trace_generator, 12309);
    let pow9 = pow(trace_generator, 24966);
    let pow10 = pow(trace_generator, 16774);
    let pow11 = pow(trace_generator, 14726);
    let pow12 = pow(trace_generator, 10630);
    let pow13 = pow(trace_generator, 8582);
    let pow14 = pow(trace_generator, 6534);
    let pow15 = pow(trace_generator, 4486);
    let pow16 = pow(trace_generator, 2438);
    let pow17 = pow(trace_generator, 1);
    let pow18 = pow11 * pow17; // pow(trace_generator, 14727).
    let pow19 = pow12 * pow17; // pow(trace_generator, 10631).
    let pow20 = pow13 * pow17; // pow(trace_generator, 8583).
    let pow21 = pow14 * pow17; // pow(trace_generator, 6535).
    let pow22 = pow15 * pow17; // pow(trace_generator, 4487).
    let pow23 = pow16 * pow17; // pow(trace_generator, 2439).
    let pow24 = pow17 * pow17; // pow(trace_generator, 2).
    let pow25 = pow17 * pow24; // pow(trace_generator, 3).
    let pow26 = pow17 * pow25; // pow(trace_generator, 4).
    let pow27 = pow17 * pow26; // pow(trace_generator, 5).
    let pow28 = pow17 * pow27; // pow(trace_generator, 6).
    let pow29 = pow4 * pow28; // pow(trace_generator, 16331).
    let pow30 = pow17 * pow28; // pow(trace_generator, 7).
    let pow31 = pow17 * pow30; // pow(trace_generator, 8).
    let pow32 = pow17 * pow31; // pow(trace_generator, 9).
    let pow33 = pow17 * pow32; // pow(trace_generator, 10).
    let pow34 = pow17 * pow33; // pow(trace_generator, 11).
    let pow35 = pow17 * pow34; // pow(trace_generator, 12).
    let pow36 = pow17 * pow35; // pow(trace_generator, 13).
    let pow37 = pow17 * pow36; // pow(trace_generator, 14).
    let pow38 = pow17 * pow37; // pow(trace_generator, 15).
    let pow39 = pow17 * pow38; // pow(trace_generator, 16).
    let pow40 = pow17 * pow39; // pow(trace_generator, 17).
    let pow41 = pow24 * pow40; // pow(trace_generator, 19).
    let pow42 = pow24 * pow41; // pow(trace_generator, 21).
    let pow43 = pow17 * pow42; // pow(trace_generator, 22).
    let pow44 = pow17 * pow43; // pow(trace_generator, 23).
    let pow45 = pow17 * pow44; // pow(trace_generator, 24).
    let pow46 = pow17 * pow45; // pow(trace_generator, 25).
    let pow47 = pow24 * pow46; // pow(trace_generator, 27).
    let pow48 = pow24 * pow47; // pow(trace_generator, 29).
    let pow49 = pow17 * pow48; // pow(trace_generator, 30).
    let pow50 = pow25 * pow49; // pow(trace_generator, 33).
    let pow51 = pow24 * pow50; // pow(trace_generator, 35).
    let pow52 = pow24 * pow51; // pow(trace_generator, 37).
    let pow53 = pow17 * pow52; // pow(trace_generator, 38).
    let pow54 = pow17 * pow53; // pow(trace_generator, 39).
    let pow55 = pow24 * pow54; // pow(trace_generator, 41).
    let pow56 = pow24 * pow55; // pow(trace_generator, 43).
    let pow57 = pow17 * pow56; // pow(trace_generator, 44).
    let pow58 = pow17 * pow57; // pow(trace_generator, 45).
    let pow59 = pow17 * pow58; // pow(trace_generator, 46).
    let pow60 = pow25 * pow59; // pow(trace_generator, 49).
    let pow61 = pow24 * pow60; // pow(trace_generator, 51).
    let pow62 = pow24 * pow61; // pow(trace_generator, 53).
    let pow63 = pow17 * pow62; // pow(trace_generator, 54).
    let pow64 = pow1 * pow28; // pow(trace_generator, 32721).
    let pow65 = pow1 * pow39; // pow(trace_generator, 32731).
    let pow66 = pow39 * pow65; // pow(trace_generator, 32747).
    let pow67 = pow1 * pow53; // pow(trace_generator, 32753).
    let pow68 = pow33 * pow67; // pow(trace_generator, 32763).
    let pow69 = pow25 * pow63; // pow(trace_generator, 57).
    let pow70 = pow24 * pow69; // pow(trace_generator, 59).
    let pow71 = pow24 * pow70; // pow(trace_generator, 61).
    let pow72 = pow26 * pow71; // pow(trace_generator, 65).
    let pow73 = pow26 * pow72; // pow(trace_generator, 69).
    let pow74 = pow17 * pow73; // pow(trace_generator, 70).
    let pow75 = pow17 * pow74; // pow(trace_generator, 71).
    let pow76 = pow24 * pow75; // pow(trace_generator, 73).
    let pow77 = pow25 * pow76; // pow(trace_generator, 76).
    let pow78 = pow17 * pow77; // pow(trace_generator, 77).
    let pow79 = pow26 * pow78; // pow(trace_generator, 81).
    let pow80 = pow26 * pow79; // pow(trace_generator, 85).
    let pow81 = pow26 * pow80; // pow(trace_generator, 89).
    let pow82 = pow24 * pow81; // pow(trace_generator, 91).
    let pow83 = pow28 * pow82; // pow(trace_generator, 97).
    let pow84 = pow26 * pow83; // pow(trace_generator, 101).
    let pow85 = pow17 * pow84; // pow(trace_generator, 102).
    let pow86 = pow17 * pow85; // pow(trace_generator, 103).
    let pow87 = pow24 * pow86; // pow(trace_generator, 105).
    let pow88 = pow25 * pow87; // pow(trace_generator, 108).
    let pow89 = pow17 * pow88; // pow(trace_generator, 109).
    let pow90 = pow26 * pow89; // pow(trace_generator, 113).
    let pow91 = pow26 * pow90; // pow(trace_generator, 117).
    let pow92 = pow28 * pow91; // pow(trace_generator, 123).
    let pow93 = pow28 * pow92; // pow(trace_generator, 129).
    let pow94 = pow27 * pow93; // pow(trace_generator, 134).
    let pow95 = pow17 * pow94; // pow(trace_generator, 135).
    let pow96 = pow27 * pow95; // pow(trace_generator, 140).
    let pow97 = pow27 * pow96; // pow(trace_generator, 145).
    let pow98 = pow33 * pow97; // pow(trace_generator, 155).
    let pow99 = pow28 * pow98; // pow(trace_generator, 161).
    let pow100 = pow27 * pow99; // pow(trace_generator, 166).
    let pow101 = pow17 * pow100; // pow(trace_generator, 167).
    let pow102 = pow27 * pow101; // pow(trace_generator, 172).
    let pow103 = pow27 * pow102; // pow(trace_generator, 177).
    let pow104 = pow33 * pow103; // pow(trace_generator, 187).
    let pow105 = pow27 * pow104; // pow(trace_generator, 192).
    let pow106 = pow17 * pow105; // pow(trace_generator, 193).
    let pow107 = pow24 * pow106; // pow(trace_generator, 195).
    let pow108 = pow17 * pow107; // pow(trace_generator, 196).
    let pow109 = pow17 * pow108; // pow(trace_generator, 197).
    let pow110 = pow17 * pow109; // pow(trace_generator, 198).
    let pow111 = pow17 * pow110; // pow(trace_generator, 199).
    let pow112 = pow27 * pow111; // pow(trace_generator, 204).
    let pow113 = pow17 * pow112; // pow(trace_generator, 205).
    let pow114 = pow26 * pow113; // pow(trace_generator, 209).
    let pow115 = pow33 * pow114; // pow(trace_generator, 219).
    let pow116 = pow24 * pow115; // pow(trace_generator, 221).
    let pow117 = pow26 * pow116; // pow(trace_generator, 225).
    let pow118 = pow34 * pow117; // pow(trace_generator, 236).
    let pow119 = pow17 * pow118; // pow(trace_generator, 237).
    let pow120 = pow26 * pow119; // pow(trace_generator, 241).
    let pow121 = pow26 * pow120; // pow(trace_generator, 245).
    let pow122 = pow28 * pow121; // pow(trace_generator, 251).
    let pow123 = pow17 * pow122; // pow(trace_generator, 252).
    let pow124 = pow4 * pow35; // pow(trace_generator, 16337).
    let pow125 = pow4 * pow37; // pow(trace_generator, 16339).
    let pow126 = pow4 * pow49; // pow(trace_generator, 16355).
    let pow127 = pow24 * pow126; // pow(trace_generator, 16357).
    let pow128 = pow4 * pow53; // pow(trace_generator, 16363).
    let pow129 = pow4 * pow57; // pow(trace_generator, 16369).
    let pow130 = pow4 * pow59; // pow(trace_generator, 16371).
    let pow131 = pow5 * pow118; // pow(trace_generator, 16385).
    let pow132 = pow59 * pow130; // pow(trace_generator, 16417).
    let pow133 = pow17 * pow123; // pow(trace_generator, 253).
    let pow134 = pow24 * pow133; // pow(trace_generator, 255).
    let pow135 = pow17 * pow134; // pow(trace_generator, 256).
    let pow136 = pow17 * pow135; // pow(trace_generator, 257).
    let pow137 = pow7 * pow135; // pow(trace_generator, 12629).
    let pow138 = pow7 * pow105; // pow(trace_generator, 12565).
    let pow139 = pow60 * pow137; // pow(trace_generator, 12678).
    let pow140 = pow17 * pow139; // pow(trace_generator, 12679).
    let pow141 = pow27 * pow136; // pow(trace_generator, 262).
    let pow142 = pow17 * pow141; // pow(trace_generator, 263).
    let pow143 = pow24 * pow142; // pow(trace_generator, 265).
    let pow144 = pow26 * pow143; // pow(trace_generator, 269).
    let pow145 = pow46 * pow144; // pow(trace_generator, 294).
    let pow146 = pow17 * pow145; // pow(trace_generator, 295).
    let pow147 = pow28 * pow146; // pow(trace_generator, 301).
    let pow148 = pow31 * pow147; // pow(trace_generator, 309).
    let pow149 = pow17 * pow148; // pow(trace_generator, 310).
    let pow150 = pow31 * pow149; // pow(trace_generator, 318).
    let pow151 = pow90 * pow148; // pow(trace_generator, 422).
    let pow152 = pow79 * pow148; // pow(trace_generator, 390).
    let pow153 = pow31 * pow150; // pow(trace_generator, 326).
    let pow154 = pow31 * pow153; // pow(trace_generator, 334).
    let pow155 = pow31 * pow154; // pow(trace_generator, 342).
    let pow156 = pow31 * pow155; // pow(trace_generator, 350).
    let pow157 = pow31 * pow156; // pow(trace_generator, 358).
    let pow158 = pow17 * pow151; // pow(trace_generator, 423).
    let pow159 = pow17 * pow152; // pow(trace_generator, 391).
    let pow160 = pow17 * pow157; // pow(trace_generator, 359).
    let pow161 = pow10 * pow17; // pow(trace_generator, 16775).
    let pow162 = pow48 * pow151; // pow(trace_generator, 451).
    let pow163 = pow25 * pow162; // pow(trace_generator, 454).
    let pow164 = pow30 * pow163; // pow(trace_generator, 461).
    let pow165 = pow39 * pow164; // pow(trace_generator, 477).
    let pow166 = pow37 * pow165; // pow(trace_generator, 491).
    let pow167 = pow24 * pow166; // pow(trace_generator, 493).
    let pow168 = pow28 * pow167; // pow(trace_generator, 499).
    let pow169 = pow24 * pow168; // pow(trace_generator, 501).
    let pow170 = pow28 * pow169; // pow(trace_generator, 507).
    let pow171 = pow24 * pow170; // pow(trace_generator, 509).
    let pow172 = pow24 * pow171; // pow(trace_generator, 511).
    let pow173 = pow2 * pow166; // pow(trace_generator, 33158).
    let pow174 = pow24 * pow172; // pow(trace_generator, 513).
    let pow175 = pow27 * pow174; // pow(trace_generator, 518).
    let pow176 = pow104 * pow175; // pow(trace_generator, 705).
    let pow177 = pow109 * pow176; // pow(trace_generator, 902).
    let pow178 = pow28 * pow176; // pow(trace_generator, 711).
    let pow179 = pow33 * pow178; // pow(trace_generator, 721).
    let pow180 = pow39 * pow179; // pow(trace_generator, 737).
    let pow181 = pow39 * pow180; // pow(trace_generator, 753).
    let pow182 = pow39 * pow181; // pow(trace_generator, 769).
    let pow183 = pow70 * pow177; // pow(trace_generator, 961).
    let pow184 = pow27 * pow183; // pow(trace_generator, 966).
    let pow185 = pow17 * pow184; // pow(trace_generator, 967).
    let pow186 = pow33 * pow185; // pow(trace_generator, 977).
    let pow187 = pow121 * pow186; // pow(trace_generator, 1222).
    let pow188 = pow17 * pow177; // pow(trace_generator, 903).
    let pow189 = pow39 * pow186; // pow(trace_generator, 993).
    let pow190 = pow39 * pow189; // pow(trace_generator, 1009).
    let pow191 = pow25 * pow175; // pow(trace_generator, 521).
    let pow192 = pow31 * pow182; // pow(trace_generator, 777).

    // Fetch columns.
    let [column0, column1, column2, column3, column4, column5, column6, column7, column8, column9] =
        (*column_values
        .multi_pop_front::<10>()
        .unwrap())
        .unbox();

    // Sum the OODS constraints on the trace polynomials.
    let mut total_sum = 0;
    let pows = [
        pow0,
        pow17,
        pow24,
        pow25,
        pow26,
        pow27,
        pow28,
        pow30,
        pow31,
        pow32,
        pow33,
        pow34,
        pow35,
        pow36,
        pow37,
        pow38,
    ].span();
    for pow in pows {
        let value = (column0 - *oods_values.pop_front().unwrap()) / (point - *pow * oods_point);
        total_sum += *constraint_coefficients.pop_front().unwrap() * value;
    };

    let pows = [pow0, pow17, pow134, pow135, pow172,].span();
    for pow in pows {
        let value = (column1 - *oods_values.pop_front().unwrap()) / (point - *pow * oods_point);
        total_sum += *constraint_coefficients.pop_front().unwrap() * value;
    };

    let pows = [pow0, pow17, pow134, pow135,].span();
    for pow in pows {
        let value = (column2 - *oods_values.pop_front().unwrap()) / (point - *pow * oods_point);
        total_sum += *constraint_coefficients.pop_front().unwrap() * value;
    };

    let pows = [pow0, pow17, pow105, pow106, pow108, pow109, pow122, pow123, pow135,].span();
    for pow in pows {
        let value = (column3 - *oods_values.pop_front().unwrap()) / (point - *pow * oods_point);
        total_sum += *constraint_coefficients.pop_front().unwrap() * value;
    };

    let pows = [pow0, pow134,].span();
    for pow in pows {
        let value = (column4 - *oods_values.pop_front().unwrap()) / (point - *pow * oods_point);
        total_sum += *constraint_coefficients.pop_front().unwrap() * value;
    };

    let pows = [
        pow0,
        pow17,
        pow24,
        pow25,
        pow26,
        pow27,
        pow28,
        pow30,
        pow31,
        pow32,
        pow35,
        pow36,
        pow39,
        pow53,
        pow54,
        pow74,
        pow75,
        pow85,
        pow86,
        pow94,
        pow95,
        pow100,
        pow101,
        pow110,
        pow111,
        pow141,
        pow142,
        pow145,
        pow146,
        pow153,
        pow157,
        pow160,
        pow152,
        pow159,
        pow151,
        pow158,
        pow163,
        pow175,
        pow178,
        pow177,
        pow188,
        pow184,
        pow185,
        pow187,
        pow16,
        pow23,
        pow15,
        pow22,
        pow14,
        pow21,
        pow13,
        pow20,
        pow12,
        pow19,
        pow139,
        pow140,
        pow11,
        pow18,
        pow10,
        pow161,
        pow9,
        pow173,
    ].span();
    for pow in pows {
        let value = (column5 - *oods_values.pop_front().unwrap()) / (point - *pow * oods_point);
        total_sum += *constraint_coefficients.pop_front().unwrap() * value;
    };

    let pows = [pow0, pow17, pow24, pow25,].span();
    for pow in pows {
        let value = (column6 - *oods_values.pop_front().unwrap()) / (point - *pow * oods_point);
        total_sum += *constraint_coefficients.pop_front().unwrap() * value;
    };

    let pows = [
        pow0,
        pow17,
        pow24,
        pow25,
        pow26,
        pow27,
        pow28,
        pow30,
        pow31,
        pow32,
        pow34,
        pow35,
        pow36,
        pow38,
        pow40,
        pow41,
        pow44,
        pow47,
        pow50,
        pow57,
        pow60,
        pow72,
        pow77,
        pow79,
        pow83,
        pow88,
        pow90,
        pow93,
        pow96,
        pow97,
        pow99,
        pow102,
        pow103,
        pow106,
        pow112,
        pow114,
        pow117,
        pow118,
        pow120,
        pow136,
        pow143,
        pow166,
        pow168,
        pow170,
        pow174,
        pow191,
        pow176,
        pow179,
        pow180,
        pow181,
        pow182,
        pow192,
        pow183,
        pow186,
        pow189,
        pow190,
    ].span();
    for pow in pows {
        let value = (column7 - *oods_values.pop_front().unwrap()) / (point - *pow * oods_point);
        total_sum += *constraint_coefficients.pop_front().unwrap() * value;
    };

    let pows = [
        pow0,
        pow17,
        pow24,
        pow25,
        pow26,
        pow27,
        pow28,
        pow30,
        pow31,
        pow32,
        pow33,
        pow34,
        pow35,
        pow36,
        pow37,
        pow39,
        pow40,
        pow41,
        pow42,
        pow43,
        pow45,
        pow46,
        pow47,
        pow48,
        pow49,
        pow50,
        pow51,
        pow52,
        pow53,
        pow55,
        pow56,
        pow58,
        pow59,
        pow60,
        pow61,
        pow62,
        pow63,
        pow69,
        pow70,
        pow71,
        pow72,
        pow73,
        pow75,
        pow76,
        pow78,
        pow79,
        pow80,
        pow81,
        pow82,
        pow83,
        pow84,
        pow87,
        pow89,
        pow90,
        pow91,
        pow92,
        pow98,
        pow104,
        pow107,
        pow113,
        pow115,
        pow116,
        pow119,
        pow121,
        pow133,
        pow144,
        pow147,
        pow148,
        pow149,
        pow150,
        pow153,
        pow154,
        pow155,
        pow156,
        pow162,
        pow164,
        pow165,
        pow167,
        pow169,
        pow171,
        pow8,
        pow7,
        pow138,
        pow137,
        pow6,
        pow5,
        pow4,
        pow29,
        pow124,
        pow125,
        pow126,
        pow127,
        pow128,
        pow129,
        pow130,
        pow131,
        pow132,
        pow3,
        pow2,
        pow1,
        pow64,
        pow65,
        pow66,
        pow67,
        pow68,
    ].span();
    for pow in pows {
        let value = (column8 - *oods_values.pop_front().unwrap()) / (point - *pow * oods_point);
        total_sum += *constraint_coefficients.pop_front().unwrap() * value;
    };

    let pows = [pow0, pow17, pow24, pow25, pow27, pow30, pow34, pow38,].span();
    for pow in pows {
        let value = (column9 - *oods_values.pop_front().unwrap()) / (point - *pow * oods_point);
        total_sum += *constraint_coefficients.pop_front().unwrap() * value;
    };

    // Sum the OODS boundary constraints on the composition polynomials.
    let oods_point_to_deg = pow(oods_point, CONSTRAINT_DEGREE.into());

    let value = (*column_values.pop_front().unwrap() - *oods_values.pop_front().unwrap())
        / (point - oods_point_to_deg);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (*column_values.pop_front().unwrap() - *oods_values.pop_front().unwrap())
        / (point - oods_point_to_deg);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    assert(273 == MASK_SIZE + CONSTRAINT_DEGREE, 'Autogenerated assert failed');
    total_sum
}

