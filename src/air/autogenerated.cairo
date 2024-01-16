use cairo_verifier::air::global_values::GlobalValues;
use cairo_verifier::common::math::{Felt252Div, pow};
use cairo_verifier::air::constants::{
    CONSTRAINT_DEGREE, NUM_COLUMNS_FIRST, NUM_COLUMNS_SECOND, MASK_SIZE
};

fn eval_composition_polynomial_inner(
    mask_values: Span<felt252>,
    constraint_coefficients: Span<felt252>,
    point: felt252,
    trace_generator: felt252,
    global_values: GlobalValues
) -> felt252 {
    // Compute powers.
    let pow0 = pow(point, global_values.trace_length / 2048);
    let pow1 = pow0 * pow0;
    let pow2 = pow(point, global_values.trace_length / 128);
    let pow3 = pow(point, global_values.trace_length / 32);
    let pow4 = pow3 * pow3;
    let pow5 = pow(point, global_values.trace_length / 4);
    let pow6 = pow5 * pow5;
    let pow7 = pow6 * pow6;
    let pow8 = pow(trace_generator, global_values.trace_length / 64);
    let pow9 = pow8 * pow8;
    let pow10 = pow8 * pow9;
    let pow11 = pow8 * pow10;
    let pow12 = pow8 * pow11;
    let pow13 = pow8 * pow12;
    let pow14 = pow8 * pow13;
    let pow15 = pow8 * pow14;
    let pow16 = pow8 * pow15;
    let pow17 = pow8 * pow16;
    let pow18 = pow8 * pow17;
    let pow19 = pow8 * pow18;
    let pow20 = pow8 * pow19;
    let pow21 = pow8 * pow20;
    let pow22 = pow8 * pow21;
    let pow23 = pow(trace_generator, global_values.trace_length / 2);
    let pow24 = pow(trace_generator, 3 * global_values.trace_length / 4);
    let pow25 = pow19 * pow24;
    let pow26 = pow10 * pow25;
    let pow27 = pow(trace_generator, 255 * global_values.trace_length / 256);
    let pow28 = pow(trace_generator, 16 * (global_values.trace_length / 16 - 1));
    let pow29 = pow(trace_generator, 2 * (global_values.trace_length / 2 - 1));
    let pow30 = pow(trace_generator, 4 * (global_values.trace_length / 4 - 1));
    let pow31 = pow(trace_generator, global_values.trace_length - 1);
    let pow32 = pow(trace_generator, 2048 * (global_values.trace_length / 2048 - 1));
    let pow33 = pow(trace_generator, 128 * (global_values.trace_length / 128 - 1));

    // Compute domains.
    let domain0 = pow7 - 1;
    let domain1 = pow6 - 1;
    let domain2 = pow5 - 1;
    let domain3 = pow4 - pow25;
    let domain4 = pow4 - 1;
    let domain5 = pow3 - 1;
    let domain6 = pow2 - 1;
    let domain7 = pow2 - pow24;
    let domain8 = pow2 - pow8;
    let domain8 = domain8 * (pow2 - pow9);
    let domain8 = domain8 * (pow2 - pow10);
    let domain8 = domain8 * (pow2 - pow11);
    let domain8 = domain8 * (pow2 - pow12);
    let domain8 = domain8 * (pow2 - pow13);
    let domain8 = domain8 * (pow2 - pow14);
    let domain8 = domain8 * (pow2 - pow15);
    let domain8 = domain8 * (pow2 - pow16);
    let domain8 = domain8 * (pow2 - pow17);
    let domain8 = domain8 * (pow2 - pow18);
    let domain8 = domain8 * (pow2 - pow19);
    let domain8 = domain8 * (pow2 - pow20);
    let domain8 = domain8 * (pow2 - pow21);
    let domain8 = domain8 * (pow2 - pow22);
    let domain8 = domain8 * (domain6);
    let domain9 = pow1 - 1;
    let domain10 = pow1 - pow27;
    let domain11 = pow1 - pow26;
    let domain12 = pow0 - pow23;
    let domain13 = pow0 - 1;
    let domain14 = point - pow28;
    let domain15 = point - 1;
    let domain16 = point - pow29;
    let domain17 = point - pow30;
    let domain18 = point - pow31;
    let domain19 = point - pow32;
    let domain20 = point - pow33;

    // Fetch mask variables.
    let column0_row0 = *mask_values[0];
    let column0_row1 = *mask_values[1];
    let column0_row2 = *mask_values[2];
    let column0_row3 = *mask_values[3];
    let column0_row4 = *mask_values[4];
    let column0_row5 = *mask_values[5];
    let column0_row6 = *mask_values[6];
    let column0_row7 = *mask_values[7];
    let column0_row8 = *mask_values[8];
    let column0_row9 = *mask_values[9];
    let column0_row10 = *mask_values[10];
    let column0_row11 = *mask_values[11];
    let column0_row12 = *mask_values[12];
    let column0_row13 = *mask_values[13];
    let column0_row14 = *mask_values[14];
    let column0_row15 = *mask_values[15];
    let column1_row0 = *mask_values[16];
    let column1_row1 = *mask_values[17];
    let column1_row2 = *mask_values[18];
    let column1_row4 = *mask_values[19];
    let column1_row6 = *mask_values[20];
    let column1_row8 = *mask_values[21];
    let column1_row10 = *mask_values[22];
    let column1_row12 = *mask_values[23];
    let column1_row14 = *mask_values[24];
    let column1_row16 = *mask_values[25];
    let column1_row18 = *mask_values[26];
    let column1_row20 = *mask_values[27];
    let column1_row22 = *mask_values[28];
    let column1_row24 = *mask_values[29];
    let column1_row26 = *mask_values[30];
    let column1_row28 = *mask_values[31];
    let column1_row30 = *mask_values[32];
    let column1_row32 = *mask_values[33];
    let column1_row33 = *mask_values[34];
    let column1_row64 = *mask_values[35];
    let column1_row65 = *mask_values[36];
    let column1_row88 = *mask_values[37];
    let column1_row90 = *mask_values[38];
    let column1_row92 = *mask_values[39];
    let column1_row94 = *mask_values[40];
    let column1_row96 = *mask_values[41];
    let column1_row97 = *mask_values[42];
    let column1_row120 = *mask_values[43];
    let column1_row122 = *mask_values[44];
    let column1_row124 = *mask_values[45];
    let column1_row126 = *mask_values[46];
    let column2_row0 = *mask_values[47];
    let column2_row1 = *mask_values[48];
    let column3_row0 = *mask_values[49];
    let column3_row1 = *mask_values[50];
    let column3_row2 = *mask_values[51];
    let column3_row3 = *mask_values[52];
    let column3_row4 = *mask_values[53];
    let column3_row5 = *mask_values[54];
    let column3_row8 = *mask_values[55];
    let column3_row9 = *mask_values[56];
    let column3_row10 = *mask_values[57];
    let column3_row11 = *mask_values[58];
    let column3_row12 = *mask_values[59];
    let column3_row13 = *mask_values[60];
    let column3_row16 = *mask_values[61];
    let column3_row26 = *mask_values[62];
    let column3_row27 = *mask_values[63];
    let column3_row42 = *mask_values[64];
    let column3_row43 = *mask_values[65];
    let column3_row58 = *mask_values[66];
    let column3_row74 = *mask_values[67];
    let column3_row75 = *mask_values[68];
    let column3_row91 = *mask_values[69];
    let column3_row122 = *mask_values[70];
    let column3_row123 = *mask_values[71];
    let column3_row154 = *mask_values[72];
    let column3_row202 = *mask_values[73];
    let column3_row522 = *mask_values[74];
    let column3_row523 = *mask_values[75];
    let column3_row1034 = *mask_values[76];
    let column3_row1035 = *mask_values[77];
    let column3_row2058 = *mask_values[78];
    let column4_row0 = *mask_values[79];
    let column4_row1 = *mask_values[80];
    let column4_row2 = *mask_values[81];
    let column4_row3 = *mask_values[82];
    let column5_row0 = *mask_values[83];
    let column5_row1 = *mask_values[84];
    let column5_row2 = *mask_values[85];
    let column5_row3 = *mask_values[86];
    let column5_row4 = *mask_values[87];
    let column5_row5 = *mask_values[88];
    let column5_row6 = *mask_values[89];
    let column5_row7 = *mask_values[90];
    let column5_row8 = *mask_values[91];
    let column5_row12 = *mask_values[92];
    let column5_row28 = *mask_values[93];
    let column5_row44 = *mask_values[94];
    let column5_row60 = *mask_values[95];
    let column5_row76 = *mask_values[96];
    let column5_row92 = *mask_values[97];
    let column5_row108 = *mask_values[98];
    let column5_row124 = *mask_values[99];
    let column5_row1021 = *mask_values[100];
    let column5_row1023 = *mask_values[101];
    let column5_row1025 = *mask_values[102];
    let column5_row1027 = *mask_values[103];
    let column5_row2045 = *mask_values[104];
    let column6_row0 = *mask_values[105];
    let column6_row1 = *mask_values[106];
    let column6_row2 = *mask_values[107];
    let column6_row3 = *mask_values[108];
    let column6_row4 = *mask_values[109];
    let column6_row5 = *mask_values[110];
    let column6_row7 = *mask_values[111];
    let column6_row9 = *mask_values[112];
    let column6_row11 = *mask_values[113];
    let column6_row13 = *mask_values[114];
    let column6_row17 = *mask_values[115];
    let column6_row25 = *mask_values[116];
    let column6_row768 = *mask_values[117];
    let column6_row772 = *mask_values[118];
    let column6_row784 = *mask_values[119];
    let column6_row788 = *mask_values[120];
    let column6_row1004 = *mask_values[121];
    let column6_row1008 = *mask_values[122];
    let column6_row1022 = *mask_values[123];
    let column6_row1024 = *mask_values[124];
    let column7_inter1_row0 = *mask_values[125];
    let column7_inter1_row1 = *mask_values[126];
    let column8_inter1_row0 = *mask_values[127];
    let column8_inter1_row1 = *mask_values[128];
    let column9_inter1_row0 = *mask_values[129];
    let column9_inter1_row1 = *mask_values[130];
    let column9_inter1_row2 = *mask_values[131];
    let column9_inter1_row5 = *mask_values[132];

    // Compute intermediate values.
    let cpu_decode_opcode_rc_bit_0 = column0_row0 - (column0_row1 + column0_row1);
    let cpu_decode_opcode_rc_bit_2 = column0_row2 - (column0_row3 + column0_row3);
    let cpu_decode_opcode_rc_bit_4 = column0_row4 - (column0_row5 + column0_row5);
    let cpu_decode_opcode_rc_bit_3 = column0_row3 - (column0_row4 + column0_row4);
    let cpu_decode_flag_op1_base_op0_0 = 1
        - (cpu_decode_opcode_rc_bit_2 + cpu_decode_opcode_rc_bit_4 + cpu_decode_opcode_rc_bit_3);
    let cpu_decode_opcode_rc_bit_5 = column0_row5 - (column0_row6 + column0_row6);
    let cpu_decode_opcode_rc_bit_6 = column0_row6 - (column0_row7 + column0_row7);
    let cpu_decode_opcode_rc_bit_9 = column0_row9 - (column0_row10 + column0_row10);
    let cpu_decode_flag_res_op1_0 = 1
        - (cpu_decode_opcode_rc_bit_5 + cpu_decode_opcode_rc_bit_6 + cpu_decode_opcode_rc_bit_9);
    let cpu_decode_opcode_rc_bit_7 = column0_row7 - (column0_row8 + column0_row8);
    let cpu_decode_opcode_rc_bit_8 = column0_row8 - (column0_row9 + column0_row9);
    let cpu_decode_flag_pc_update_regular_0 = 1
        - (cpu_decode_opcode_rc_bit_7 + cpu_decode_opcode_rc_bit_8 + cpu_decode_opcode_rc_bit_9);
    let cpu_decode_opcode_rc_bit_12 = column0_row12 - (column0_row13 + column0_row13);
    let cpu_decode_opcode_rc_bit_13 = column0_row13 - (column0_row14 + column0_row14);
    let cpu_decode_fp_update_regular_0 = 1
        - (cpu_decode_opcode_rc_bit_12 + cpu_decode_opcode_rc_bit_13);
    let cpu_decode_opcode_rc_bit_1 = column0_row1 - (column0_row2 + column0_row2);
    let npc_reg_0 = column3_row0 + cpu_decode_opcode_rc_bit_2 + 1;
    let cpu_decode_opcode_rc_bit_10 = column0_row10 - (column0_row11 + column0_row11);
    let cpu_decode_opcode_rc_bit_11 = column0_row11 - (column0_row12 + column0_row12);
    let cpu_decode_opcode_rc_bit_14 = column0_row14 - (column0_row15 + column0_row15);
    let memory_address_diff_0 = column4_row2 - column4_row0;
    let rc16_diff_0 = column5_row6 - column5_row2;
    let pedersen_hash0_ec_subset_sum_bit_0 = column6_row0 - (column6_row4 + column6_row4);
    let pedersen_hash0_ec_subset_sum_bit_neg_0 = 1 - pedersen_hash0_ec_subset_sum_bit_0;
    let rc_builtin_value0_0 = column5_row12;
    let rc_builtin_value1_0 = rc_builtin_value0_0 * global_values.offset_size + column5_row28;
    let rc_builtin_value2_0 = rc_builtin_value1_0 * global_values.offset_size + column5_row44;
    let rc_builtin_value3_0 = rc_builtin_value2_0 * global_values.offset_size + column5_row60;
    let rc_builtin_value4_0 = rc_builtin_value3_0 * global_values.offset_size + column5_row76;
    let rc_builtin_value5_0 = rc_builtin_value4_0 * global_values.offset_size + column5_row92;
    let rc_builtin_value6_0 = rc_builtin_value5_0 * global_values.offset_size + column5_row108;
    let rc_builtin_value7_0 = rc_builtin_value6_0 * global_values.offset_size + column5_row124;
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
    let total_sum = 0;

    // Constraint: cpu/decode/opcode_rc/bit.
    let value = (cpu_decode_opcode_rc_bit_0 * cpu_decode_opcode_rc_bit_0
        - cpu_decode_opcode_rc_bit_0)
        * domain3
        / domain0;
    let total_sum = total_sum + *constraint_coefficients[0] * value;

    // Constraint: cpu/decode/opcode_rc/zero.
    let value = (column0_row0) / domain3;
    let total_sum = total_sum + *constraint_coefficients[1] * value;

    // Constraint: cpu/decode/opcode_rc_input.
    let value = (column3_row1
        - (((column0_row0 * global_values.offset_size + column5_row4) * global_values.offset_size
            + column5_row8)
            * global_values.offset_size
            + column5_row0))
        / domain4;
    let total_sum = total_sum + *constraint_coefficients[2] * value;

    // Constraint: cpu/decode/flag_op1_base_op0_bit.
    let value = (cpu_decode_flag_op1_base_op0_0 * cpu_decode_flag_op1_base_op0_0
        - cpu_decode_flag_op1_base_op0_0)
        / domain4;
    let total_sum = total_sum + *constraint_coefficients[3] * value;

    // Constraint: cpu/decode/flag_res_op1_bit.
    let value = (cpu_decode_flag_res_op1_0 * cpu_decode_flag_res_op1_0 - cpu_decode_flag_res_op1_0)
        / domain4;
    let total_sum = total_sum + *constraint_coefficients[4] * value;

    // Constraint: cpu/decode/flag_pc_update_regular_bit.
    let value = (cpu_decode_flag_pc_update_regular_0 * cpu_decode_flag_pc_update_regular_0
        - cpu_decode_flag_pc_update_regular_0)
        / domain4;
    let total_sum = total_sum + *constraint_coefficients[5] * value;

    // Constraint: cpu/decode/fp_update_regular_bit.
    let value = (cpu_decode_fp_update_regular_0 * cpu_decode_fp_update_regular_0
        - cpu_decode_fp_update_regular_0)
        / domain4;
    let total_sum = total_sum + *constraint_coefficients[6] * value;

    // Constraint: cpu/operands/mem_dst_addr.
    let value = (column3_row8
        + global_values.half_offset_size
        - (cpu_decode_opcode_rc_bit_0 * column6_row9
            + (1 - cpu_decode_opcode_rc_bit_0) * column6_row1
            + column5_row0))
        / domain4;
    let total_sum = total_sum + *constraint_coefficients[7] * value;

    // Constraint: cpu/operands/mem0_addr.
    let value = (column3_row4
        + global_values.half_offset_size
        - (cpu_decode_opcode_rc_bit_1 * column6_row9
            + (1 - cpu_decode_opcode_rc_bit_1) * column6_row1
            + column5_row8))
        / domain4;
    let total_sum = total_sum + *constraint_coefficients[8] * value;

    // Constraint: cpu/operands/mem1_addr.
    let value = (column3_row12
        + global_values.half_offset_size
        - (cpu_decode_opcode_rc_bit_2 * column3_row0
            + cpu_decode_opcode_rc_bit_4 * column6_row1
            + cpu_decode_opcode_rc_bit_3 * column6_row9
            + cpu_decode_flag_op1_base_op0_0 * column3_row5
            + column5_row4))
        / domain4;
    let total_sum = total_sum + *constraint_coefficients[9] * value;

    // Constraint: cpu/operands/ops_mul.
    let value = (column6_row5 - column3_row5 * column3_row13) / domain4;
    let total_sum = total_sum + *constraint_coefficients[10] * value;

    // Constraint: cpu/operands/res.
    let value = ((1 - cpu_decode_opcode_rc_bit_9) * column6_row13
        - (cpu_decode_opcode_rc_bit_5 * (column3_row5 + column3_row13)
            + cpu_decode_opcode_rc_bit_6 * column6_row5
            + cpu_decode_flag_res_op1_0 * column3_row13))
        / domain4;
    let total_sum = total_sum + *constraint_coefficients[11] * value;

    // Constraint: cpu/update_registers/update_pc/tmp0.
    let value = (column6_row3 - cpu_decode_opcode_rc_bit_9 * column3_row9) * domain14 / domain4;
    let total_sum = total_sum + *constraint_coefficients[12] * value;

    // Constraint: cpu/update_registers/update_pc/tmp1.
    let value = (column6_row11 - column6_row3 * column6_row13) * domain14 / domain4;
    let total_sum = total_sum + *constraint_coefficients[13] * value;

    // Constraint: cpu/update_registers/update_pc/pc_cond_negative.
    let value = ((1 - cpu_decode_opcode_rc_bit_9) * column3_row16
        + column6_row3 * (column3_row16 - (column3_row0 + column3_row13))
        - (cpu_decode_flag_pc_update_regular_0 * npc_reg_0
            + cpu_decode_opcode_rc_bit_7 * column6_row13
            + cpu_decode_opcode_rc_bit_8 * (column3_row0 + column6_row13)))
        * domain14
        / domain4;
    let total_sum = total_sum + *constraint_coefficients[14] * value;

    // Constraint: cpu/update_registers/update_pc/pc_cond_positive.
    let value = ((column6_row11 - cpu_decode_opcode_rc_bit_9) * (column3_row16 - npc_reg_0))
        * domain14
        / domain4;
    let total_sum = total_sum + *constraint_coefficients[15] * value;

    // Constraint: cpu/update_registers/update_ap/ap_update.
    let value = (column6_row17
        - (column6_row1
            + cpu_decode_opcode_rc_bit_10 * column6_row13
            + cpu_decode_opcode_rc_bit_11
            + cpu_decode_opcode_rc_bit_12 * 2))
        * domain14
        / domain4;
    let total_sum = total_sum + *constraint_coefficients[16] * value;

    // Constraint: cpu/update_registers/update_fp/fp_update.
    let value = (column6_row25
        - (cpu_decode_fp_update_regular_0 * column6_row9
            + cpu_decode_opcode_rc_bit_13 * column3_row9
            + cpu_decode_opcode_rc_bit_12 * (column6_row1 + 2)))
        * domain14
        / domain4;
    let total_sum = total_sum + *constraint_coefficients[17] * value;

    // Constraint: cpu/opcodes/call/push_fp.
    let value = (cpu_decode_opcode_rc_bit_12 * (column3_row9 - column6_row9)) / domain4;
    let total_sum = total_sum + *constraint_coefficients[18] * value;

    // Constraint: cpu/opcodes/call/push_pc.
    let value = (cpu_decode_opcode_rc_bit_12
        * (column3_row5 - (column3_row0 + cpu_decode_opcode_rc_bit_2 + 1)))
        / domain4;
    let total_sum = total_sum + *constraint_coefficients[19] * value;

    // Constraint: cpu/opcodes/call/off0.
    let value = (cpu_decode_opcode_rc_bit_12 * (column5_row0 - global_values.half_offset_size))
        / domain4;
    let total_sum = total_sum + *constraint_coefficients[20] * value;

    // Constraint: cpu/opcodes/call/off1.
    let value = (cpu_decode_opcode_rc_bit_12
        * (column5_row8 - (global_values.half_offset_size + 1)))
        / domain4;
    let total_sum = total_sum + *constraint_coefficients[21] * value;

    // Constraint: cpu/opcodes/call/flags.
    let value = (cpu_decode_opcode_rc_bit_12
        * (cpu_decode_opcode_rc_bit_12
            + cpu_decode_opcode_rc_bit_12
            + 1
            + 1
            - (cpu_decode_opcode_rc_bit_0 + cpu_decode_opcode_rc_bit_1 + 4)))
        / domain4;
    let total_sum = total_sum + *constraint_coefficients[22] * value;

    // Constraint: cpu/opcodes/ret/off0.
    let value = (cpu_decode_opcode_rc_bit_13 * (column5_row0 + 2 - global_values.half_offset_size))
        / domain4;
    let total_sum = total_sum + *constraint_coefficients[23] * value;

    // Constraint: cpu/opcodes/ret/off2.
    let value = (cpu_decode_opcode_rc_bit_13 * (column5_row4 + 1 - global_values.half_offset_size))
        / domain4;
    let total_sum = total_sum + *constraint_coefficients[24] * value;

    // Constraint: cpu/opcodes/ret/flags.
    let value = (cpu_decode_opcode_rc_bit_13
        * (cpu_decode_opcode_rc_bit_7
            + cpu_decode_opcode_rc_bit_0
            + cpu_decode_opcode_rc_bit_3
            + cpu_decode_flag_res_op1_0
            - 4))
        / domain4;
    let total_sum = total_sum + *constraint_coefficients[25] * value;

    // Constraint: cpu/opcodes/assert_eq/assert_eq.
    let value = (cpu_decode_opcode_rc_bit_14 * (column3_row9 - column6_row13)) / domain4;
    let total_sum = total_sum + *constraint_coefficients[26] * value;

    // Constraint: initial_ap.
    let value = (column6_row1 - global_values.initial_ap) / domain15;
    let total_sum = total_sum + *constraint_coefficients[27] * value;

    // Constraint: initial_fp.
    let value = (column6_row9 - global_values.initial_ap) / domain15;
    let total_sum = total_sum + *constraint_coefficients[28] * value;

    // Constraint: initial_pc.
    let value = (column3_row0 - global_values.initial_pc) / domain15;
    let total_sum = total_sum + *constraint_coefficients[29] * value;

    // Constraint: final_ap.
    let value = (column6_row1 - global_values.final_ap) / domain14;
    let total_sum = total_sum + *constraint_coefficients[30] * value;

    // Constraint: final_fp.
    let value = (column6_row9 - global_values.initial_ap) / domain14;
    let total_sum = total_sum + *constraint_coefficients[31] * value;

    // Constraint: final_pc.
    let value = (column3_row0 - global_values.final_pc) / domain14;
    let total_sum = total_sum + *constraint_coefficients[32] * value;

    // Constraint: memory/multi_column_perm/perm/init0.
    let value = ((global_values.memory_multi_column_perm_perm_interaction_elm
        - (column4_row0
            + global_values.memory_multi_column_perm_hash_interaction_elm0 * column4_row1))
        * column9_inter1_row0
        + column3_row0
        + global_values.memory_multi_column_perm_hash_interaction_elm0 * column3_row1
        - global_values.memory_multi_column_perm_perm_interaction_elm)
        / domain15;
    let total_sum = total_sum + *constraint_coefficients[33] * value;

    // Constraint: memory/multi_column_perm/perm/step0.
    let value = ((global_values.memory_multi_column_perm_perm_interaction_elm
        - (column4_row2
            + global_values.memory_multi_column_perm_hash_interaction_elm0 * column4_row3))
        * column9_inter1_row2
        - (global_values.memory_multi_column_perm_perm_interaction_elm
            - (column3_row2
                + global_values.memory_multi_column_perm_hash_interaction_elm0 * column3_row3))
            * column9_inter1_row0)
        * domain16
        / domain1;
    let total_sum = total_sum + *constraint_coefficients[34] * value;

    // Constraint: memory/multi_column_perm/perm/last.
    let value = (column9_inter1_row0
        - global_values.memory_multi_column_perm_perm_public_memory_prod)
        / domain16;
    let total_sum = total_sum + *constraint_coefficients[35] * value;

    // Constraint: memory/diff_is_bit.
    let value = (memory_address_diff_0 * memory_address_diff_0 - memory_address_diff_0)
        * domain16
        / domain1;
    let total_sum = total_sum + *constraint_coefficients[36] * value;

    // Constraint: memory/is_func.
    let value = ((memory_address_diff_0 - 1) * (column4_row1 - column4_row3)) * domain16 / domain1;
    let total_sum = total_sum + *constraint_coefficients[37] * value;

    // Constraint: memory/initial_addr.
    let value = (column4_row0 - 1) / domain15;
    let total_sum = total_sum + *constraint_coefficients[38] * value;

    // Constraint: public_memory_addr_zero.
    let value = (column3_row2) / domain4;
    let total_sum = total_sum + *constraint_coefficients[39] * value;

    // Constraint: public_memory_value_zero.
    let value = (column3_row3) / domain4;
    let total_sum = total_sum + *constraint_coefficients[40] * value;

    // Constraint: rc16/perm/init0.
    let value = ((global_values.rc16_perm_interaction_elm - column5_row2) * column9_inter1_row1
        + column5_row0
        - global_values.rc16_perm_interaction_elm)
        / domain15;
    let total_sum = total_sum + *constraint_coefficients[41] * value;

    // Constraint: rc16/perm/step0.
    let value = ((global_values.rc16_perm_interaction_elm - column5_row6) * column9_inter1_row5
        - (global_values.rc16_perm_interaction_elm - column5_row4) * column9_inter1_row1)
        * domain17
        / domain2;
    let total_sum = total_sum + *constraint_coefficients[42] * value;

    // Constraint: rc16/perm/last.
    let value = (column9_inter1_row1 - global_values.rc16_perm_public_memory_prod) / domain17;
    let total_sum = total_sum + *constraint_coefficients[43] * value;

    // Constraint: rc16/diff_is_bit.
    let value = (rc16_diff_0 * rc16_diff_0 - rc16_diff_0) * domain17 / domain2;
    let total_sum = total_sum + *constraint_coefficients[44] * value;

    // Constraint: rc16/minimum.
    let value = (column5_row2 - global_values.rc_min) / domain15;
    let total_sum = total_sum + *constraint_coefficients[45] * value;

    // Constraint: rc16/maximum.
    let value = (column5_row2 - global_values.rc_max) / domain17;
    let total_sum = total_sum + *constraint_coefficients[46] * value;

    // Constraint: diluted_check/permutation/init0.
    let value = ((global_values.diluted_check_permutation_interaction_elm - column2_row0)
        * column8_inter1_row0
        + column1_row0
        - global_values.diluted_check_permutation_interaction_elm)
        / domain15;
    let total_sum = total_sum + *constraint_coefficients[47] * value;

    // Constraint: diluted_check/permutation/step0.
    let value = ((global_values.diluted_check_permutation_interaction_elm - column2_row1)
        * column8_inter1_row1
        - (global_values.diluted_check_permutation_interaction_elm - column1_row1)
            * column8_inter1_row0)
        * domain18
        / domain0;
    let total_sum = total_sum + *constraint_coefficients[48] * value;

    // Constraint: diluted_check/permutation/last.
    let value = (column8_inter1_row0 - global_values.diluted_check_permutation_public_memory_prod)
        / domain18;
    let total_sum = total_sum + *constraint_coefficients[49] * value;

    // Constraint: diluted_check/init.
    let value = (column7_inter1_row0 - 1) / domain15;
    let total_sum = total_sum + *constraint_coefficients[50] * value;

    // Constraint: diluted_check/first_element.
    let value = (column2_row0 - global_values.diluted_check_first_elm) / domain15;
    let total_sum = total_sum + *constraint_coefficients[51] * value;

    // Constraint: diluted_check/step.
    let value = (column7_inter1_row1
        - (column7_inter1_row0
            * (1 + global_values.diluted_check_interaction_z * (column2_row1 - column2_row0))
            + global_values.diluted_check_interaction_alpha
                * (column2_row1 - column2_row0)
                * (column2_row1 - column2_row0)))
        * domain18
        / domain0;
    let total_sum = total_sum + *constraint_coefficients[52] * value;

    // Constraint: diluted_check/last.
    let value = (column7_inter1_row0 - global_values.diluted_check_final_cum_val) / domain18;
    let total_sum = total_sum + *constraint_coefficients[53] * value;

    // Constraint: pedersen/hash0/ec_subset_sum/bit_unpacking/last_one_is_zero.
    let value = (column6_row7 * (column6_row0 - (column6_row4 + column6_row4))) / domain9;
    let total_sum = total_sum + *constraint_coefficients[54] * value;

    // Constraint: pedersen/hash0/ec_subset_sum/bit_unpacking/zeroes_between_ones0.
    let value = (column6_row7
        * (column6_row4
            - 3138550867693340381917894711603833208051177722232017256448 * column6_row768))
        / domain9;
    let total_sum = total_sum + *constraint_coefficients[55] * value;

    // Constraint: pedersen/hash0/ec_subset_sum/bit_unpacking/cumulative_bit192.
    let value = (column6_row7
        - column6_row1022 * (column6_row768 - (column6_row772 + column6_row772)))
        / domain9;
    let total_sum = total_sum + *constraint_coefficients[56] * value;

    // Constraint: pedersen/hash0/ec_subset_sum/bit_unpacking/zeroes_between_ones192.
    let value = (column6_row1022 * (column6_row772 - 8 * column6_row784)) / domain9;
    let total_sum = total_sum + *constraint_coefficients[57] * value;

    // Constraint: pedersen/hash0/ec_subset_sum/bit_unpacking/cumulative_bit196.
    let value = (column6_row1022
        - (column6_row1004 - (column6_row1008 + column6_row1008))
            * (column6_row784 - (column6_row788 + column6_row788)))
        / domain9;
    let total_sum = total_sum + *constraint_coefficients[58] * value;

    // Constraint: pedersen/hash0/ec_subset_sum/bit_unpacking/zeroes_between_ones196.
    let value = ((column6_row1004 - (column6_row1008 + column6_row1008))
        * (column6_row788 - 18014398509481984 * column6_row1004))
        / domain9;
    let total_sum = total_sum + *constraint_coefficients[59] * value;

    // Constraint: pedersen/hash0/ec_subset_sum/booleanity_test.
    let value = (pedersen_hash0_ec_subset_sum_bit_0 * (pedersen_hash0_ec_subset_sum_bit_0 - 1))
        * domain10
        / domain2;
    let total_sum = total_sum + *constraint_coefficients[60] * value;

    // Constraint: pedersen/hash0/ec_subset_sum/bit_extraction_end.
    let value = (column6_row0) / domain11;
    let total_sum = total_sum + *constraint_coefficients[61] * value;

    // Constraint: pedersen/hash0/ec_subset_sum/zeros_tail.
    let value = (column6_row0) / domain10;
    let total_sum = total_sum + *constraint_coefficients[62] * value;

    // Constraint: pedersen/hash0/ec_subset_sum/add_points/slope.
    let value = (pedersen_hash0_ec_subset_sum_bit_0
        * (column5_row3 - global_values.pedersen_points_y)
        - column6_row2 * (column5_row1 - global_values.pedersen_points_x))
        * domain10
        / domain2;
    let total_sum = total_sum + *constraint_coefficients[63] * value;

    // Constraint: pedersen/hash0/ec_subset_sum/add_points/x.
    let value = (column6_row2 * column6_row2
        - pedersen_hash0_ec_subset_sum_bit_0
            * (column5_row1 + global_values.pedersen_points_x + column5_row5))
        * domain10
        / domain2;
    let total_sum = total_sum + *constraint_coefficients[64] * value;

    // Constraint: pedersen/hash0/ec_subset_sum/add_points/y.
    let value = (pedersen_hash0_ec_subset_sum_bit_0 * (column5_row3 + column5_row7)
        - column6_row2 * (column5_row1 - column5_row5))
        * domain10
        / domain2;
    let total_sum = total_sum + *constraint_coefficients[65] * value;

    // Constraint: pedersen/hash0/ec_subset_sum/copy_point/x.
    let value = (pedersen_hash0_ec_subset_sum_bit_neg_0 * (column5_row5 - column5_row1))
        * domain10
        / domain2;
    let total_sum = total_sum + *constraint_coefficients[66] * value;

    // Constraint: pedersen/hash0/ec_subset_sum/copy_point/y.
    let value = (pedersen_hash0_ec_subset_sum_bit_neg_0 * (column5_row7 - column5_row3))
        * domain10
        / domain2;
    let total_sum = total_sum + *constraint_coefficients[67] * value;

    // Constraint: pedersen/hash0/copy_point/x.
    let value = (column5_row1025 - column5_row1021) * domain12 / domain9;
    let total_sum = total_sum + *constraint_coefficients[68] * value;

    // Constraint: pedersen/hash0/copy_point/y.
    let value = (column5_row1027 - column5_row1023) * domain12 / domain9;
    let total_sum = total_sum + *constraint_coefficients[69] * value;

    // Constraint: pedersen/hash0/init/x.
    let value = (column5_row1 - global_values.pedersen_shift_point.x) / domain13;
    let total_sum = total_sum + *constraint_coefficients[70] * value;

    // Constraint: pedersen/hash0/init/y.
    let value = (column5_row3 - global_values.pedersen_shift_point.y) / domain13;
    let total_sum = total_sum + *constraint_coefficients[71] * value;

    // Constraint: pedersen/input0_value0.
    let value = (column3_row11 - column6_row0) / domain13;
    let total_sum = total_sum + *constraint_coefficients[72] * value;

    // Constraint: pedersen/input0_addr.
    let value = (column3_row2058 - (column3_row522 + 1)) * domain19 / domain13;
    let total_sum = total_sum + *constraint_coefficients[73] * value;

    // Constraint: pedersen/init_addr.
    let value = (column3_row10 - global_values.initial_pedersen_addr) / domain15;
    let total_sum = total_sum + *constraint_coefficients[74] * value;

    // Constraint: pedersen/input1_value0.
    let value = (column3_row1035 - column6_row1024) / domain13;
    let total_sum = total_sum + *constraint_coefficients[75] * value;

    // Constraint: pedersen/input1_addr.
    let value = (column3_row1034 - (column3_row10 + 1)) / domain13;
    let total_sum = total_sum + *constraint_coefficients[76] * value;

    // Constraint: pedersen/output_value0.
    let value = (column3_row523 - column5_row2045) / domain13;
    let total_sum = total_sum + *constraint_coefficients[77] * value;

    // Constraint: pedersen/output_addr.
    let value = (column3_row522 - (column3_row1034 + 1)) / domain13;
    let total_sum = total_sum + *constraint_coefficients[78] * value;

    // Constraint: rc_builtin/value.
    let value = (rc_builtin_value7_0 - column3_row75) / domain6;
    let total_sum = total_sum + *constraint_coefficients[79] * value;

    // Constraint: rc_builtin/addr_step.
    let value = (column3_row202 - (column3_row74 + 1)) * domain20 / domain6;
    let total_sum = total_sum + *constraint_coefficients[80] * value;

    // Constraint: rc_builtin/init_addr.
    let value = (column3_row74 - global_values.initial_rc_addr) / domain15;
    let total_sum = total_sum + *constraint_coefficients[81] * value;

    // Constraint: bitwise/init_var_pool_addr.
    let value = (column3_row26 - global_values.initial_bitwise_addr) / domain15;
    let total_sum = total_sum + *constraint_coefficients[82] * value;

    // Constraint: bitwise/step_var_pool_addr.
    let value = (column3_row58 - (column3_row26 + 1)) * domain7 / domain5;
    let total_sum = total_sum + *constraint_coefficients[83] * value;

    // Constraint: bitwise/x_or_y_addr.
    let value = (column3_row42 - (column3_row122 + 1)) / domain6;
    let total_sum = total_sum + *constraint_coefficients[84] * value;

    // Constraint: bitwise/next_var_pool_addr.
    let value = (column3_row154 - (column3_row42 + 1)) * domain20 / domain6;
    let total_sum = total_sum + *constraint_coefficients[85] * value;

    // Constraint: bitwise/partition.
    let value = (bitwise_sum_var_0_0 + bitwise_sum_var_8_0 - column3_row27) / domain5;
    let total_sum = total_sum + *constraint_coefficients[86] * value;

    // Constraint: bitwise/or_is_and_plus_xor.
    let value = (column3_row43 - (column3_row91 + column3_row123)) / domain6;
    let total_sum = total_sum + *constraint_coefficients[87] * value;

    // Constraint: bitwise/addition_is_xor_with_and.
    let value = (column1_row0 + column1_row32 - (column1_row96 + column1_row64 + column1_row64))
        / domain8;
    let total_sum = total_sum + *constraint_coefficients[88] * value;

    // Constraint: bitwise/unique_unpacking192.
    let value = ((column1_row88 + column1_row120) * 16 - column1_row1) / domain6;
    let total_sum = total_sum + *constraint_coefficients[89] * value;

    // Constraint: bitwise/unique_unpacking193.
    let value = ((column1_row90 + column1_row122) * 16 - column1_row65) / domain6;
    let total_sum = total_sum + *constraint_coefficients[90] * value;

    // Constraint: bitwise/unique_unpacking194.
    let value = ((column1_row92 + column1_row124) * 16 - column1_row33) / domain6;
    let total_sum = total_sum + *constraint_coefficients[91] * value;

    // Constraint: bitwise/unique_unpacking195.
    let value = ((column1_row94 + column1_row126) * 256 - column1_row97) / domain6;
    let total_sum = total_sum + *constraint_coefficients[92] * value;

    total_sum
}

fn eval_oods_polynomial_inner(
    column_values: Span<felt252>,
    oods_values: Span<felt252>,
    constraint_coefficients: Span<felt252>,
    point: felt252,
    oods_point: felt252,
    trace_generator: felt252,
) -> felt252 {
    // Compute powers.
    let pow0 = pow(trace_generator, 0);
    let pow1 = pow(trace_generator, 1);
    let pow2 = pow1 * pow1;
    let pow3 = pow1 * pow2;
    let pow4 = pow1 * pow3;
    let pow5 = pow1 * pow4;
    let pow6 = pow1 * pow5;
    let pow7 = pow1 * pow6;
    let pow8 = pow1 * pow7;
    let pow9 = pow1 * pow8;
    let pow10 = pow1 * pow9;
    let pow11 = pow1 * pow10;
    let pow12 = pow1 * pow11;
    let pow13 = pow1 * pow12;
    let pow14 = pow1 * pow13;
    let pow15 = pow1 * pow14;
    let pow16 = pow1 * pow15;
    let pow17 = pow1 * pow16;
    let pow18 = pow1 * pow17;
    let pow19 = pow2 * pow18;
    let pow20 = pow2 * pow19;
    let pow21 = pow2 * pow20;
    let pow22 = pow1 * pow21;
    let pow23 = pow1 * pow22;
    let pow24 = pow1 * pow23;
    let pow25 = pow1 * pow24;
    let pow26 = pow2 * pow25;
    let pow27 = pow2 * pow26;
    let pow28 = pow1 * pow27;
    let pow29 = pow9 * pow28;
    let pow30 = pow1 * pow29;
    let pow31 = pow1 * pow30;
    let pow32 = pow14 * pow31;
    let pow33 = pow2 * pow32;
    let pow34 = pow4 * pow33;
    let pow35 = pow1 * pow34;
    let pow36 = pow9 * pow35;
    let pow37 = pow1 * pow36;
    let pow38 = pow1 * pow37;
    let pow39 = pow12 * pow38;
    let pow40 = pow2 * pow39;
    let pow41 = pow1 * pow40;
    let pow42 = pow1 * pow41;
    let pow43 = pow2 * pow42;
    let pow44 = pow2 * pow43;
    let pow45 = pow1 * pow44;
    let pow46 = pow11 * pow45;
    let pow47 = pow12 * pow46;
    let pow48 = pow2 * pow47;
    let pow49 = pow1 * pow48;
    let pow50 = pow1 * pow49;
    let pow51 = pow2 * pow50;
    let pow52 = pow25 * pow51;
    let pow53 = pow38 * pow51;
    let pow54 = pow(trace_generator, 522);
    let pow55 = pow1 * pow54;
    let pow56 = pow(trace_generator, 768);
    let pow57 = pow4 * pow56;
    let pow58 = pow12 * pow57;
    let pow59 = pow4 * pow58;
    let pow60 = pow(trace_generator, 1004);
    let pow61 = pow4 * pow60;
    let pow62 = pow13 * pow61;
    let pow63 = pow1 * pow62;
    let pow64 = pow1 * pow63;
    let pow65 = pow1 * pow64;
    let pow66 = pow1 * pow65;
    let pow67 = pow2 * pow66;
    let pow68 = pow7 * pow67;
    let pow69 = pow1 * pow68;
    let pow70 = pow62 * pow65;
    let pow71 = pow13 * pow70;

    // Fetch columns.
    let column0 = *column_values[0];
    let column1 = *column_values[1];
    let column2 = *column_values[2];
    let column3 = *column_values[3];
    let column4 = *column_values[4];
    let column5 = *column_values[5];
    let column6 = *column_values[6];
    let column7 = *column_values[7];
    let column8 = *column_values[8];
    let column9 = *column_values[9];

    // Sum the OODS constraints on the trace polynomials.
    let total_sum = 0;

    let value = (column0 - *oods_values[0]) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[0] * value;

    let value = (column0 - *oods_values[1]) / (point - pow1 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[1] * value;

    let value = (column0 - *oods_values[2]) / (point - pow2 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[2] * value;

    let value = (column0 - *oods_values[3]) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[3] * value;

    let value = (column0 - *oods_values[4]) / (point - pow4 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[4] * value;

    let value = (column0 - *oods_values[5]) / (point - pow5 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[5] * value;

    let value = (column0 - *oods_values[6]) / (point - pow6 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[6] * value;

    let value = (column0 - *oods_values[7]) / (point - pow7 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[7] * value;

    let value = (column0 - *oods_values[8]) / (point - pow8 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[8] * value;

    let value = (column0 - *oods_values[9]) / (point - pow9 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[9] * value;

    let value = (column0 - *oods_values[10]) / (point - pow10 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[10] * value;

    let value = (column0 - *oods_values[11]) / (point - pow11 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[11] * value;

    let value = (column0 - *oods_values[12]) / (point - pow12 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[12] * value;

    let value = (column0 - *oods_values[13]) / (point - pow13 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[13] * value;

    let value = (column0 - *oods_values[14]) / (point - pow14 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[14] * value;

    let value = (column0 - *oods_values[15]) / (point - pow15 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[15] * value;

    let value = (column1 - *oods_values[16]) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[16] * value;

    let value = (column1 - *oods_values[17]) / (point - pow1 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[17] * value;

    let value = (column1 - *oods_values[18]) / (point - pow2 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[18] * value;

    let value = (column1 - *oods_values[19]) / (point - pow4 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[19] * value;

    let value = (column1 - *oods_values[20]) / (point - pow6 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[20] * value;

    let value = (column1 - *oods_values[21]) / (point - pow8 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[21] * value;

    let value = (column1 - *oods_values[22]) / (point - pow10 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[22] * value;

    let value = (column1 - *oods_values[23]) / (point - pow12 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[23] * value;

    let value = (column1 - *oods_values[24]) / (point - pow14 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[24] * value;

    let value = (column1 - *oods_values[25]) / (point - pow16 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[25] * value;

    let value = (column1 - *oods_values[26]) / (point - pow18 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[26] * value;

    let value = (column1 - *oods_values[27]) / (point - pow19 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[27] * value;

    let value = (column1 - *oods_values[28]) / (point - pow20 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[28] * value;

    let value = (column1 - *oods_values[29]) / (point - pow21 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[29] * value;

    let value = (column1 - *oods_values[30]) / (point - pow23 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[30] * value;

    let value = (column1 - *oods_values[31]) / (point - pow25 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[31] * value;

    let value = (column1 - *oods_values[32]) / (point - pow26 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[32] * value;

    let value = (column1 - *oods_values[33]) / (point - pow27 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[33] * value;

    let value = (column1 - *oods_values[34]) / (point - pow28 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[34] * value;

    let value = (column1 - *oods_values[35]) / (point - pow34 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[35] * value;

    let value = (column1 - *oods_values[36]) / (point - pow35 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[36] * value;

    let value = (column1 - *oods_values[37]) / (point - pow39 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[37] * value;

    let value = (column1 - *oods_values[38]) / (point - pow40 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[38] * value;

    let value = (column1 - *oods_values[39]) / (point - pow42 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[39] * value;

    let value = (column1 - *oods_values[40]) / (point - pow43 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[40] * value;

    let value = (column1 - *oods_values[41]) / (point - pow44 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[41] * value;

    let value = (column1 - *oods_values[42]) / (point - pow45 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[42] * value;

    let value = (column1 - *oods_values[43]) / (point - pow47 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[43] * value;

    let value = (column1 - *oods_values[44]) / (point - pow48 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[44] * value;

    let value = (column1 - *oods_values[45]) / (point - pow50 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[45] * value;

    let value = (column1 - *oods_values[46]) / (point - pow51 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[46] * value;

    let value = (column2 - *oods_values[47]) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[47] * value;

    let value = (column2 - *oods_values[48]) / (point - pow1 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[48] * value;

    let value = (column3 - *oods_values[49]) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[49] * value;

    let value = (column3 - *oods_values[50]) / (point - pow1 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[50] * value;

    let value = (column3 - *oods_values[51]) / (point - pow2 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[51] * value;

    let value = (column3 - *oods_values[52]) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[52] * value;

    let value = (column3 - *oods_values[53]) / (point - pow4 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[53] * value;

    let value = (column3 - *oods_values[54]) / (point - pow5 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[54] * value;

    let value = (column3 - *oods_values[55]) / (point - pow8 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[55] * value;

    let value = (column3 - *oods_values[56]) / (point - pow9 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[56] * value;

    let value = (column3 - *oods_values[57]) / (point - pow10 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[57] * value;

    let value = (column3 - *oods_values[58]) / (point - pow11 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[58] * value;

    let value = (column3 - *oods_values[59]) / (point - pow12 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[59] * value;

    let value = (column3 - *oods_values[60]) / (point - pow13 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[60] * value;

    let value = (column3 - *oods_values[61]) / (point - pow16 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[61] * value;

    let value = (column3 - *oods_values[62]) / (point - pow23 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[62] * value;

    let value = (column3 - *oods_values[63]) / (point - pow24 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[63] * value;

    let value = (column3 - *oods_values[64]) / (point - pow29 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[64] * value;

    let value = (column3 - *oods_values[65]) / (point - pow30 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[65] * value;

    let value = (column3 - *oods_values[66]) / (point - pow32 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[66] * value;

    let value = (column3 - *oods_values[67]) / (point - pow36 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[67] * value;

    let value = (column3 - *oods_values[68]) / (point - pow37 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[68] * value;

    let value = (column3 - *oods_values[69]) / (point - pow41 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[69] * value;

    let value = (column3 - *oods_values[70]) / (point - pow48 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[70] * value;

    let value = (column3 - *oods_values[71]) / (point - pow49 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[71] * value;

    let value = (column3 - *oods_values[72]) / (point - pow52 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[72] * value;

    let value = (column3 - *oods_values[73]) / (point - pow53 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[73] * value;

    let value = (column3 - *oods_values[74]) / (point - pow54 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[74] * value;

    let value = (column3 - *oods_values[75]) / (point - pow55 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[75] * value;

    let value = (column3 - *oods_values[76]) / (point - pow68 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[76] * value;

    let value = (column3 - *oods_values[77]) / (point - pow69 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[77] * value;

    let value = (column3 - *oods_values[78]) / (point - pow71 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[78] * value;

    let value = (column4 - *oods_values[79]) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[79] * value;

    let value = (column4 - *oods_values[80]) / (point - pow1 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[80] * value;

    let value = (column4 - *oods_values[81]) / (point - pow2 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[81] * value;

    let value = (column4 - *oods_values[82]) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[82] * value;

    let value = (column5 - *oods_values[83]) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[83] * value;

    let value = (column5 - *oods_values[84]) / (point - pow1 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[84] * value;

    let value = (column5 - *oods_values[85]) / (point - pow2 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[85] * value;

    let value = (column5 - *oods_values[86]) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[86] * value;

    let value = (column5 - *oods_values[87]) / (point - pow4 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[87] * value;

    let value = (column5 - *oods_values[88]) / (point - pow5 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[88] * value;

    let value = (column5 - *oods_values[89]) / (point - pow6 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[89] * value;

    let value = (column5 - *oods_values[90]) / (point - pow7 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[90] * value;

    let value = (column5 - *oods_values[91]) / (point - pow8 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[91] * value;

    let value = (column5 - *oods_values[92]) / (point - pow12 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[92] * value;

    let value = (column5 - *oods_values[93]) / (point - pow25 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[93] * value;

    let value = (column5 - *oods_values[94]) / (point - pow31 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[94] * value;

    let value = (column5 - *oods_values[95]) / (point - pow33 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[95] * value;

    let value = (column5 - *oods_values[96]) / (point - pow38 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[96] * value;

    let value = (column5 - *oods_values[97]) / (point - pow42 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[97] * value;

    let value = (column5 - *oods_values[98]) / (point - pow46 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[98] * value;

    let value = (column5 - *oods_values[99]) / (point - pow50 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[99] * value;

    let value = (column5 - *oods_values[100]) / (point - pow62 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[100] * value;

    let value = (column5 - *oods_values[101]) / (point - pow64 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[101] * value;

    let value = (column5 - *oods_values[102]) / (point - pow66 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[102] * value;

    let value = (column5 - *oods_values[103]) / (point - pow67 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[103] * value;

    let value = (column5 - *oods_values[104]) / (point - pow70 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[104] * value;

    let value = (column6 - *oods_values[105]) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[105] * value;

    let value = (column6 - *oods_values[106]) / (point - pow1 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[106] * value;

    let value = (column6 - *oods_values[107]) / (point - pow2 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[107] * value;

    let value = (column6 - *oods_values[108]) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[108] * value;

    let value = (column6 - *oods_values[109]) / (point - pow4 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[109] * value;

    let value = (column6 - *oods_values[110]) / (point - pow5 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[110] * value;

    let value = (column6 - *oods_values[111]) / (point - pow7 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[111] * value;

    let value = (column6 - *oods_values[112]) / (point - pow9 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[112] * value;

    let value = (column6 - *oods_values[113]) / (point - pow11 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[113] * value;

    let value = (column6 - *oods_values[114]) / (point - pow13 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[114] * value;

    let value = (column6 - *oods_values[115]) / (point - pow17 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[115] * value;

    let value = (column6 - *oods_values[116]) / (point - pow22 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[116] * value;

    let value = (column6 - *oods_values[117]) / (point - pow56 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[117] * value;

    let value = (column6 - *oods_values[118]) / (point - pow57 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[118] * value;

    let value = (column6 - *oods_values[119]) / (point - pow58 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[119] * value;

    let value = (column6 - *oods_values[120]) / (point - pow59 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[120] * value;

    let value = (column6 - *oods_values[121]) / (point - pow60 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[121] * value;

    let value = (column6 - *oods_values[122]) / (point - pow61 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[122] * value;

    let value = (column6 - *oods_values[123]) / (point - pow63 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[123] * value;

    let value = (column6 - *oods_values[124]) / (point - pow65 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[124] * value;

    let value = (column7 - *oods_values[125]) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[125] * value;

    let value = (column7 - *oods_values[126]) / (point - pow1 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[126] * value;

    let value = (column8 - *oods_values[127]) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[127] * value;

    let value = (column8 - *oods_values[128]) / (point - pow1 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[128] * value;

    let value = (column9 - *oods_values[129]) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[129] * value;

    let value = (column9 - *oods_values[130]) / (point - pow1 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[130] * value;

    let value = (column9 - *oods_values[131]) / (point - pow2 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[131] * value;

    let value = (column9 - *oods_values[132]) / (point - pow5 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[132] * value;

    // Sum the OODS boundary constraints on the composition polynomials.
    let oods_point_to_deg = pow(oods_point, CONSTRAINT_DEGREE.into());

    let value = (*column_values[NUM_COLUMNS_FIRST + NUM_COLUMNS_SECOND] - *oods_values[133])
        / (point - oods_point_to_deg);
    let total_sum = total_sum + *constraint_coefficients[133] * value;

    let value = (*column_values[NUM_COLUMNS_FIRST + NUM_COLUMNS_SECOND + 1] - *oods_values[134])
        / (point - oods_point_to_deg);
    let total_sum = total_sum + *constraint_coefficients[134] * value;

    assert(135 == MASK_SIZE + CONSTRAINT_DEGREE.into(), 'Invalid value');
    total_sum
}
