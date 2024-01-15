use cairo_verifier::air::global_values::GlobalValues;
use cairo_verifier::common::math::{Felt252Div, pow};
use cairo_verifier::air::constants::{
    CONSTRAINT_DEGREE, NUM_COLUMNS_FIRST, NUM_COLUMNS_SECOND, MASK_SIZE
};

fn eval_composition_polynomial_inner(
    mask_values: Array<felt252>,
    constraint_coefficients: Array<felt252>,
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
    let pow0 = 1;
    let pow1 = trace_generator;
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
    let pow18 = pow3 * pow17;
    let pow19 = pow1 * pow18;
    let pow20 = pow1 * pow19;
    let pow21 = pow2 * pow20;
    let pow22 = pow1 * pow21;
    let pow23 = pow3 * pow22;
    let pow24 = pow1 * pow23;
    let pow25 = pow1 * pow24;
    let pow26 = pow2 * pow25;
    let pow27 = pow1 * pow26;
    let pow28 = pow3 * pow27;
    let pow29 = pow1 * pow28;
    let pow30 = pow1 * pow29;
    let pow31 = pow2 * pow30;
    let pow32 = pow1 * pow31;
    let pow33 = pow1 * pow32;
    let pow34 = pow1 * pow33;
    let pow35 = pow1 * pow34;
    let pow36 = pow1 * pow35;
    let pow37 = pow1 * pow36;
    let pow38 = pow2 * pow37;
    let pow39 = pow1 * pow38;
    let pow40 = pow3 * pow39;
    let pow41 = pow1 * pow40;
    let pow42 = pow1 * pow41;
    let pow43 = pow2 * pow42;
    let pow44 = pow1 * pow43;
    let pow45 = pow3 * pow44;
    let pow46 = pow2 * pow45;
    let pow47 = pow2 * pow46;
    let pow48 = pow1 * pow47;
    let pow49 = pow1 * pow48;
    let pow50 = pow4 * pow49;
    let pow51 = pow3 * pow50;
    let pow52 = pow1 * pow51;
    let pow53 = pow1 * pow52;
    let pow54 = pow1 * pow53;
    let pow55 = pow1 * pow54;
    let pow56 = pow1 * pow55;
    let pow57 = pow3 * pow56;
    let pow58 = pow4 * pow57;
    let pow59 = pow1 * pow58;
    let pow60 = pow6 * pow59;
    let pow61 = pow2 * pow60;
    let pow62 = pow3 * pow61;
    let pow63 = pow5 * pow62;
    let pow64 = pow4 * pow63;
    let pow65 = pow2 * pow64;
    let pow66 = pow1 * pow65;
    let pow67 = pow1 * pow66;
    let pow68 = pow3 * pow67;
    let pow69 = pow4 * pow68;
    let pow70 = pow1 * pow69;
    let pow71 = pow6 * pow70;
    let pow72 = pow4 * pow71;
    let pow73 = pow2 * pow72;
    let pow74 = pow7 * pow73;
    let pow75 = pow1 * pow74;
    let pow76 = pow1 * pow75;
    let pow77 = pow10 * pow76;
    let pow78 = pow8 * pow77;
    let pow79 = pow14 * pow78;
    let pow80 = pow2 * pow79;
    let pow81 = pow3 * pow80;
    let pow82 = pow1 * pow81;
    let pow83 = pow3 * pow82;
    let pow84 = pow1 * pow83;
    let pow85 = pow3 * pow84;
    let pow86 = pow4 * pow85;
    let pow87 = pow4 * pow86;
    let pow88 = pow2 * pow87;
    let pow89 = pow1 * pow88;
    let pow90 = pow3 * pow89;
    let pow91 = pow4 * pow90;
    let pow92 = pow3 * pow91;
    let pow93 = pow8 * pow92;
    let pow94 = pow19 * pow93;
    let pow95 = pow1 * pow94;
    let pow96 = pow2 * pow95;
    let pow97 = pow3 * pow96;
    let pow98 = pow1 * pow97;
    let pow99 = pow3 * pow98;
    let pow100 = pow4 * pow99;
    let pow101 = pow4 * pow100;
    let pow102 = pow4 * pow101;
    let pow103 = pow3 * pow102;
    let pow104 = pow3 * pow103;
    let pow105 = pow2 * pow104;
    let pow106 = pow2 * pow105;
    let pow107 = pow1 * pow106;
    let pow108 = pow5 * pow107;
    let pow109 = pow13 * pow108;
    let pow110 = pow3 * pow109;
    let pow111 = pow10 * pow110;
    let pow112 = pow3 * pow111;
    let pow113 = pow26 * pow112;
    let pow114 = pow26 * pow113;
    let pow115 = pow59 * pow114;
    let pow116 = pow10 * pow115;
    let pow117 = pow26 * pow116;
    let pow118 = pow97 * pow108;
    let pow119 = pow3 * pow118;
    let pow120 = pow3 * pow119;
    let pow121 = pow2 * pow120;
    let pow122 = pow2 * pow121;
    let pow123 = pow1 * pow122;
    let pow124 = pow64 * pow119;
    let pow125 = pow59 * pow124;
    let pow126 = pow33 * pow125;
    let pow127 = pow18 * pow126;
    let pow128 = pow2 * pow127;
    let pow129 = pow2 * pow128;
    let pow130 = pow1 * pow129;
    let pow131 = pow4 * pow130;
    let pow132 = pow1 * pow131;
    let pow133 = pow3 * pow132;
    let pow134 = pow64 * pow128;
    let pow135 = pow59 * pow134;
    let pow136 = pow46 * pow135;
    let pow137 = pow2 * pow136;
    let pow138 = pow2 * pow137;
    let pow139 = pow1 * pow138;
    let pow140 = pow4 * pow139;
    let pow141 = pow1 * pow140;
    let pow142 = pow3 * pow141;
    let pow143 = pow84 * pow142;
    let pow144 = pow47 * pow143;
    let pow145 = pow3 * pow144;
    let pow146 = pow5 * pow145;
    let pow147 = pow85 * pow146;
    let pow148 = pow47 * pow147;
    let pow149 = pow3 * pow148;
    let pow150 = pow4 * pow149;
    let pow151 = pow1 * pow150;
    let pow152 = pow(trace_generator, 1565);
    let pow153 = pow6 * pow152;
    let pow154 = pow8 * pow153;
    let pow155 = pow49 * pow154;
    let pow156 = pow59 * pow155;
    let pow157 = pow33 * pow156;
    let pow158 = pow20 * pow157;
    let pow159 = pow3 * pow158;
    let pow160 = pow5 * pow159;
    let pow161 = pow38 * pow157;
    let pow162 = pow51 * pow160;
    let pow163 = pow22 * pow162;
    let pow164 = pow47 * pow162;
    let pow165 = pow59 * pow163;
    let pow166 = pow17 * pow165;
    let pow167 = pow7 * pow166;
    let pow168 = pow8 * pow167;
    let pow169 = pow10 * pow168;
    let pow170 = pow12 * pow169;
    let pow171 = pow4 * pow170;
    let pow172 = pow2 * pow171;
    let pow173 = pow2 * pow172;
    let pow174 = pow2 * pow173;
    let pow175 = pow2 * pow174;
    let pow176 = pow1 * pow175;
    let pow177 = pow4 * pow176;
    let pow178 = pow1 * pow177;
    let pow179 = pow45 * pow177;
    let pow180 = pow64 * pow174;
    let pow181 = pow22 * pow180;
    let pow182 = pow59 * pow180;
    let pow183 = pow33 * pow182;
    let pow184 = pow20 * pow183;
    let pow185 = pow3 * pow184;
    let pow186 = pow5 * pow185;
    let pow187 = pow64 * pow184;
    let pow188 = pow47 * pow187;
    let pow189 = pow20 * pow188;
    let pow190 = pow10 * pow189;
    let pow191 = pow42 * pow190;
    let pow192 = pow3 * pow191;
    let pow193 = pow33 * pow191;
    let pow194 = pow26 * pow193;
    let pow195 = pow72 * pow193;
    let pow196 = pow20 * pow195;
    let pow197 = pow10 * pow196;
    let pow198 = pow42 * pow197;
    let pow199 = pow3 * pow198;
    let pow200 = pow4 * pow199;
    let pow201 = pow1 * pow200;
    let pow202 = pow85 * pow201;
    let pow203 = pow47 * pow202;
    let pow204 = pow3 * pow203;
    let pow205 = pow4 * pow204;
    let pow206 = pow1 * pow205;
    let pow207 = pow100 * pow206;
    let pow208 = pow3 * pow207;
    let pow209 = pow102 * pow207;
    let pow210 = pow3 * pow209;
    let pow211 = pow4 * pow210;
    let pow212 = pow1 * pow211;
    let pow213 = pow(trace_generator, 3613);
    let pow214 = pow32 * pow213;
    let pow215 = pow64 * pow209;
    let pow216 = pow22 * pow215;
    let pow217 = pow72 * pow215;
    let pow218 = pow20 * pow217;
    let pow219 = pow3 * pow218;
    let pow220 = pow38 * pow217;
    let pow221 = pow32 * pow220;
    let pow222 = pow14 * pow221;
    let pow223 = pow22 * pow222;
    let pow224 = pow4 * pow223;
    let pow225 = pow19 * pow224;
    let pow226 = pow14 * pow225;
    let pow227 = pow24 * pow226;
    let pow228 = pow47 * pow226;
    let pow229 = pow22 * pow228;
    let pow230 = pow4 * pow229;
    let pow231 = pow8 * pow230;
    let pow232 = pow10 * pow231;
    let pow233 = pow3 * pow232;
    let pow234 = pow4 * pow233;
    let pow235 = pow102 * pow232;
    let pow236 = pow3 * pow235;
    let pow237 = pow4 * pow236;
    let pow238 = pow102 * pow235;
    let pow239 = pow3 * pow238;
    let pow240 = pow4 * pow239;
    let pow241 = pow1 * pow240;
    let pow242 = pow100 * pow241;
    let pow243 = pow3 * pow242;
    let pow244 = pow102 * pow242;
    let pow245 = pow3 * pow244;
    let pow246 = pow102 * pow244;
    let pow247 = pow3 * pow246;
    let pow248 = pow47 * pow246;
    let pow249 = pow3 * pow248;
    let pow250 = pow47 * pow248;
    let pow251 = pow3 * pow250;
    let pow252 = pow72 * pow250;
    let pow253 = pow3 * pow252;
    let pow254 = pow5 * pow253;
    let pow255 = pow43 * pow254;
    let pow256 = pow47 * pow255;
    let pow257 = pow72 * pow256;
    let pow258 = pow3 * pow257;
    let pow259 = pow47 * pow257;
    let pow260 = pow17 * pow259;
    let pow261 = pow47 * pow259;
    let pow262 = pow17 * pow261;
    let pow263 = pow47 * pow262;
    let pow264 = pow72 * pow261;
    let pow265 = pow3 * pow264;
    let pow266 = pow47 * pow264;
    let pow267 = pow47 * pow266;
    let pow268 = pow112 * pow263;
    let pow269 = pow2 * pow268;
    let pow270 = pow2 * pow269;
    let pow271 = pow1 * pow270;
    let pow272 = pow10 * pow271;
    let pow273 = pow16 * pow272;
    let pow274 = pow29 * pow273;
    let pow275 = pow1 * pow274;
    let pow276 = pow47 * pow274;
    let pow277 = pow1 * pow276;
    let pow278 = pow45 * pow276;
    let pow279 = pow2 * pow278;
    let pow280 = pow2 * pow279;
    let pow281 = pow1 * pow280;
    let pow282 = pow45 * pow280;
    let pow283 = pow5 * pow282;
    let pow284 = pow47 * pow282;
    let pow285 = pow5 * pow284;
    let pow286 = pow47 * pow284;
    let pow287 = pow2 * pow286;
    let pow288 = pow2 * pow287;
    let pow289 = pow1 * pow288;
    let pow290 = pow86 * pow288;
    let pow291 = pow2 * pow290;
    let pow292 = pow2 * pow291;
    let pow293 = pow1 * pow292;
    let pow294 = pow86 * pow292;
    let pow295 = pow2 * pow294;
    let pow296 = pow2 * pow295;
    let pow297 = pow1 * pow296;
    let pow298 = pow4 * pow297;
    let pow299 = pow1 * pow298;
    let pow300 = pow86 * pow296;
    let pow301 = pow2 * pow300;
    let pow302 = pow2 * pow301;
    let pow303 = pow1 * pow302;
    let pow304 = pow86 * pow302;
    let pow305 = pow2 * pow304;
    let pow306 = pow2 * pow305;
    let pow307 = pow1 * pow306;
    let pow308 = pow10 * pow307;
    let pow309 = pow75 * pow304;
    let pow310 = pow42 * pow309;
    let pow311 = pow2 * pow310;
    let pow312 = pow2 * pow311;
    let pow313 = pow1 * pow312;
    let pow314 = pow10 * pow313;
    let pow315 = pow47 * pow314;
    let pow316 = pow47 * pow315;
    let pow317 = pow39 * pow316;
    let pow318 = pow2 * pow317;
    let pow319 = pow2 * pow318;
    let pow320 = pow1 * pow319;
    let pow321 = pow101 * pow319;
    let pow322 = pow2 * pow321;
    let pow323 = pow2 * pow322;
    let pow324 = pow9 * pow323;
    let pow325 = pow2 * pow324;
    let pow326 = pow16 * pow325;
    let pow327 = pow97 * pow325;
    let pow328 = pow3 * pow327;
    let pow329 = pow5 * pow328;
    let pow330 = pow102 * pow328;
    let pow331 = pow7 * pow330;
    let pow332 = pow1 * pow331;
    let pow333 = pow136 * pow331;
    let pow334 = pow(trace_generator, 10068);
    let pow335 = pow170 * pow331;
    let pow336 = pow200 * pow327;
    let pow337 = pow1 * pow336;
    let pow338 = pow118 * pow337;
    let pow339 = pow221 * pow324;
    let pow340 = pow120 * pow338;
    let pow341 = pow47 * pow340;
    let pow342 = pow87 * pow341;
    let pow343 = pow47 * pow342;
    let pow344 = pow237 * pow327;
    let pow345 = pow1 * pow344;
    let pow346 = pow136 * pow344;
    let pow347 = pow148 * pow343;
    let pow348 = pow296 * pow323;
    let pow349 = pow1 * pow348;
    let pow350 = pow(trace_generator, 15760);
    let pow351 = pow118 * pow349;
    let pow352 = pow84 * pow350;
    let pow353 = pow11 * pow352;
    let pow354 = pow90 * pow351;
    let pow355 = pow87 * pow353;
    let pow356 = pow1 * pow355;
    let pow357 = pow1 * pow356;
    let pow358 = pow1 * pow357;
    let pow359 = pow1 * pow358;
    let pow360 = pow1 * pow359;
    let pow361 = pow1 * pow360;
    let pow362 = pow1 * pow361;
    let pow363 = pow9 * pow362;
    let pow364 = pow1 * pow363;
    let pow365 = pow1 * pow364;
    let pow366 = pow1 * pow365;
    let pow367 = pow1 * pow366;
    let pow368 = pow1 * pow367;
    let pow369 = pow1 * pow368;
    let pow370 = pow1 * pow369;
    let pow371 = pow9 * pow370;
    let pow372 = pow16 * pow371;
    let pow373 = pow16 * pow372;
    let pow374 = pow16 * pow373;
    let pow375 = pow16 * pow374;
    let pow376 = pow16 * pow375;
    let pow377 = pow16 * pow376;
    let pow378 = pow16 * pow377;
    let pow379 = pow16 * pow378;
    let pow380 = pow16 * pow379;
    let pow381 = pow1 * pow380;
    let pow382 = pow4 * pow381;
    let pow383 = pow11 * pow382;
    let pow384 = pow6 * pow383;
    let pow385 = pow3 * pow384;
    let pow386 = pow7 * pow385;
    let pow387 = pow1 * pow386;
    let pow388 = pow4 * pow387;
    let pow389 = pow4 * pow388;
    let pow390 = pow7 * pow389;
    let pow391 = pow6 * pow390;
    let pow392 = pow3 * pow391;
    let pow393 = pow7 * pow392;
    let pow394 = pow6 * pow393;
    let pow395 = pow26 * pow394;
    let pow396 = pow118 * pow394;
    let pow397 = pow138 * pow396;
    let pow398 = pow189 * pow393;
    let pow399 = pow102 * pow398;
    let pow400 = pow102 * pow399;
    let pow401 = pow205 * pow393;
    let pow402 = pow1 * pow401;
    let pow403 = pow118 * pow402;
    let pow404 = pow254 * pow393;
    let pow405 = pow264 * pow393;
    let pow406 = pow47 * pow405;
    let pow407 = pow47 * pow406;
    let pow408 = pow268 * pow393;
    let pow409 = pow308 * pow393;
    let pow410 = pow296 * pow396;
    let pow411 = pow321 * pow393;
    let pow412 = pow2 * pow411;
    let pow413 = pow2 * pow412;
    let pow414 = pow9 * pow413;
    let pow415 = pow102 * pow412;
    let pow416 = pow102 * pow415;
    let pow417 = pow149 * pow413;
    let pow418 = pow100 * pow417;
    let pow419 = pow336 * pow393;
    let pow420 = pow210 * pow413;
    let pow421 = pow218 * pow418;
    let pow422 = pow5 * pow421;
    let pow423 = pow(trace_generator, 30977);
    let pow424 = pow88 * pow423;
    let pow425 = pow350 * pow393;
    let pow426 = pow175 * pow421;
    let pow427 = pow(trace_generator, 32653);
    let pow428 = pow8 * pow427;
    let pow429 = pow38 * pow428;
    let pow430 = pow16 * pow429;
    let pow431 = pow1 * pow430;
    let pow432 = pow15 * pow431;
    let pow433 = pow16 * pow432;
    let pow434 = pow1 * pow433;
    let pow435 = pow10 * pow434;
    let pow436 = pow205 * pow435;
    let pow437 = pow(trace_generator, 51971);
    let pow438 = pow(trace_generator, 55939);
    let pow439 = pow411 * pow435;
    let pow440 = pow2 * pow439;
    let pow441 = pow2 * pow440;
    let pow442 = pow9 * pow441;
    let pow443 = pow102 * pow440;
    let pow444 = pow102 * pow443;
    let pow445 = pow435 * pow435;
    let pow446 = pow(trace_generator, 66320);
    let pow447 = pow16 * pow446;
    let pow448 = pow207 * pow445;
    let pow449 = pow191 * pow448;
    let pow450 = pow56 * pow449;
    let pow451 = pow270 * pow445;
    let pow452 = pow317 * pow445;
    let pow453 = pow(trace_generator, 75782);
    let pow454 = pow47 * pow453;
    let pow455 = pow47 * pow454;
    let pow456 = pow347 * pow445;
    let pow457 = pow47 * pow456;
    let pow458 = pow47 * pow457;
    let pow459 = pow(trace_generator, 80133);
    let pow460 = pow47 * pow459;
    let pow461 = pow47 * pow460;
    let pow462 = pow(trace_generator, 86275);
    let pow463 = pow(trace_generator, 89283);
    let pow464 = pow435 * pow445;
    let pow465 = pow(trace_generator, 115715);
    let pow466 = pow(trace_generator, 122246);
    let pow467 = pow411 * pow464;
    let pow468 = pow2 * pow467;
    let pow469 = pow2 * pow468;
    let pow470 = pow9 * pow469;
    let pow471 = pow102 * pow468;
    let pow472 = pow102 * pow471;
    let pow473 = pow(trace_generator, 127491);
    let pow474 = pow(trace_generator, 130435);
    let pow475 = pow435 * pow464;
    let pow476 = pow333 * pow469;
    let pow477 = pow16 * pow476;
    let pow478 = pow(trace_generator, 151043);
    let pow479 = pow(trace_generator, 155397);
    let pow480 = pow(trace_generator, 157524);
    let pow481 = pow330 * pow478;
    let pow482 = pow282 * pow479;
    let pow483 = pow435 * pow475;
    let pow484 = pow148 * pow483;
    let pow485 = pow3 * pow484;
    let pow486 = pow162 * pow483;
    let pow487 = pow242 * pow484;
    let pow488 = pow306 * pow483;
    let pow489 = pow(trace_generator, 172803);
    let pow490 = pow184 * pow489;
    let pow491 = pow(trace_generator, 178433);
    let pow492 = pow2 * pow491;
    let pow493 = pow350 * pow483;
    let pow494 = pow448 * pow472;
    let pow495 = pow47 * pow494;
    let pow496 = pow47 * pow495;
    let pow497 = pow(trace_generator, 195009);
    let pow498 = pow47 * pow497;
    let pow499 = pow47 * pow498;
    let pow500 = pow(trace_generator, 196176);
    let pow501 = pow47 * pow500;
    let pow502 = pow47 * pow501;
    let pow503 = pow435 * pow483;
    let pow504 = pow(trace_generator, 198928);
    let pow505 = pow16 * pow504;
    let pow506 = pow(trace_generator, 207875);
    let pow507 = pow119 * pow506;
    let pow508 = pow47 * pow507;
    let pow509 = pow47 * pow508;
    let pow510 = pow339 * pow503;
    let pow511 = pow47 * pow510;
    let pow512 = pow47 * pow511;
    let pow513 = pow382 * pow498;
    let pow514 = pow47 * pow513;
    let pow515 = pow47 * pow514;
    let pow516 = pow242 * pow506;
    let pow517 = pow(trace_generator, 225027);
    let pow518 = pow(trace_generator, 228163);
    let pow519 = pow435 * pow503;
    let pow520 = pow144 * pow519;
    let pow521 = pow3 * pow520;
    let pow522 = pow278 * pow519;
    let pow523 = pow304 * pow519;
    let pow524 = pow314 * pow519;
    let pow525 = pow411 * pow519;
    let pow526 = pow2 * pow525;
    let pow527 = pow2 * pow526;
    let pow528 = pow9 * pow527;
    let pow529 = pow102 * pow526;
    let pow530 = pow102 * pow529;
    let pow531 = pow435 * pow519;
    let pow532 = pow337 * pow527;
    let pow533 = pow16 * pow532;
    let pow534 = pow435 * pow531;
    let pow535 = pow130 * pow534;
    let pow536 = pow232 * pow534;
    let pow537 = pow260 * pow534;
    let pow538 = pow270 * pow534;
    let pow539 = pow295 * pow534;
    let pow540 = pow174 * pow539;
    let pow541 = pow339 * pow534;
    let pow542 = pow464 * pow513;
    let pow543 = pow(trace_generator, 320451);
    let pow544 = pow102 * pow543;
    let pow545 = pow102 * pow544;
    let pow546 = pow448 * pow526;
    let pow547 = pow(trace_generator, 325123);
    let pow548 = pow47 * pow547;
    let pow549 = pow47 * pow548;
    let pow550 = pow(trace_generator, 325460);
    let pow551 = pow(trace_generator, 325893);
    let pow552 = pow435 * pow534;
    let pow553 = pow254 * pow551;
    let pow554 = pow16 * pow553;
    let pow555 = pow(trace_generator, 337603);
    let pow556 = pow102 * pow555;
    let pow557 = pow102 * pow556;
    let pow558 = pow(trace_generator, 341763);
    let pow559 = pow47 * pow558;
    let pow560 = pow47 * pow559;
    let pow561 = pow416 * pow552;
    let pow562 = pow232 * pow561;
    let pow563 = pow435 * pow550;
    let pow564 = pow435 * pow551;
    let pow565 = pow(trace_generator, 359621);
    let pow566 = pow435 * pow552;
    let pow567 = pow103 * pow566;
    let pow568 = pow174 * pow567;
    let pow569 = pow222 * pow566;
    let pow570 = pow281 * pow566;
    let pow571 = pow300 * pow566;
    let pow572 = pow(trace_generator, 370691);
    let pow573 = pow255 * pow572;
    let pow574 = pow473 * pow530;
    let pow575 = pow(trace_generator, 383425);
    let pow576 = pow(trace_generator, 384592);
    let pow577 = pow435 * pow566;
    let pow578 = pow(trace_generator, 397840);
    let pow579 = pow16 * pow578;
    let pow580 = pow(trace_generator, 405766);
    let pow581 = pow491 * pow519;
    let pow582 = pow350 * pow577;
    let pow583 = pow(trace_generator, 413524);
    let pow584 = pow319 * pow581;
    let pow585 = pow(trace_generator, 416198);
    let pow586 = pow435 * pow577;
    let pow587 = pow(trace_generator, 444244);
    let pow588 = pow(trace_generator, 445190);
    let pow589 = pow467 * pow551;
    let pow590 = pow(trace_generator, 450755);
    let pow591 = pow102 * pow590;
    let pow592 = pow102 * pow591;
    let pow593 = pow(trace_generator, 455939);
    let pow594 = pow47 * pow593;
    let pow595 = pow47 * pow594;
    let pow596 = pow435 * pow586;
    let pow597 = pow222 * pow596;
    let pow598 = pow242 * pow596;
    let pow599 = pow3 * pow598;
    let pow600 = pow122 * pow599;
    let pow601 = pow16 * pow600;
    let pow602 = pow156 * pow598;
    let pow603 = pow311 * pow596;
    let pow604 = pow(trace_generator, 476934);
    let pow605 = pow408 * pow596;
    let pow606 = pow409 * pow596;
    let pow607 = pow435 * pow596;
    let pow608 = pow(trace_generator, 502019);
    let pow609 = pow103 * pow608;
    let pow610 = pow(trace_generator, 506305);
    let pow611 = pow(trace_generator, 507457);
    let pow612 = pow15 * pow611;
    let pow613 = pow445 * pow587;
    let pow614 = pow47 * pow613;
    let pow615 = pow47 * pow614;
    let pow616 = pow(trace_generator, 513027);
    let pow617 = pow103 * pow616;
    let pow618 = pow47 * pow617;
    let pow619 = pow47 * pow618;
    let pow620 = pow144 * pow616;
    let pow621 = pow47 * pow620;
    let pow622 = pow47 * pow621;
    let pow623 = pow(trace_generator, 515843);
    let pow624 = pow411 * pow607;
    let pow625 = pow2 * pow624;
    let pow626 = pow2 * pow625;
    let pow627 = pow1 * pow626;
    let pow628 = pow8 * pow627;
    let pow629 = pow2 * pow628;
    let pow630 = pow16 * pow629;
    let pow631 = pow85 * pow628;
    let pow632 = pow97 * pow629;
    let pow633 = pow3 * pow632;
    let pow634 = pow3 * pow633;
    let pow635 = pow2 * pow634;
    let pow636 = pow102 * pow633;
    let pow637 = pow480 * pow566;
    let pow638 = pow372 * pow610;
    let pow639 = pow4 * pow638;
    let pow640 = pow1 * pow639;
    let pow641 = pow86 * pow639;
    let pow642 = pow5 * pow641;

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
    let column10 = *column_values[10];

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

    let value = (column1 - *oods_values[19]) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[19] * value;

    let value = (column1 - *oods_values[20]) / (point - pow4 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[20] * value;

    let value = (column1 - *oods_values[21]) / (point - pow5 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[21] * value;

    let value = (column1 - *oods_values[22]) / (point - pow6 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[22] * value;

    let value = (column1 - *oods_values[23]) / (point - pow8 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[23] * value;

    let value = (column1 - *oods_values[24]) / (point - pow12 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[24] * value;

    let value = (column1 - *oods_values[25]) / (point - pow14 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[25] * value;

    let value = (column1 - *oods_values[26]) / (point - pow16 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[26] * value;

    let value = (column1 - *oods_values[27]) / (point - pow18 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[27] * value;

    let value = (column1 - *oods_values[28]) / (point - pow21 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[28] * value;

    let value = (column1 - *oods_values[29]) / (point - pow23 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[29] * value;

    let value = (column1 - *oods_values[30]) / (point - pow26 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[30] * value;

    let value = (column1 - *oods_values[31]) / (point - pow28 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[31] * value;

    let value = (column1 - *oods_values[32]) / (point - pow31 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[32] * value;

    let value = (column1 - *oods_values[33]) / (point - pow35 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[33] * value;

    let value = (column1 - *oods_values[34]) / (point - pow38 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[34] * value;

    let value = (column1 - *oods_values[35]) / (point - pow40 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[35] * value;

    let value = (column1 - *oods_values[36]) / (point - pow43 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[36] * value;

    let value = (column1 - *oods_values[37]) / (point - pow45 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[37] * value;

    let value = (column1 - *oods_values[38]) / (point - pow47 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[38] * value;

    let value = (column1 - *oods_values[39]) / (point - pow49 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[39] * value;

    let value = (column1 - *oods_values[40]) / (point - pow72 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[40] * value;

    let value = (column1 - *oods_values[41]) / (point - pow73 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[41] * value;

    let value = (column1 - *oods_values[42]) / (point - pow81 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[42] * value;

    let value = (column1 - *oods_values[43]) / (point - pow83 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[43] * value;

    let value = (column1 - *oods_values[44]) / (point - pow85 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[44] * value;

    let value = (column1 - *oods_values[45]) / (point - pow86 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[45] * value;

    let value = (column1 - *oods_values[46]) / (point - pow87 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[46] * value;

    let value = (column1 - *oods_values[47]) / (point - pow88 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[47] * value;

    let value = (column1 - *oods_values[48]) / (point - pow89 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[48] * value;

    let value = (column1 - *oods_values[49]) / (point - pow90 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[49] * value;

    let value = (column1 - *oods_values[50]) / (point - pow97 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[50] * value;

    let value = (column1 - *oods_values[51]) / (point - pow99 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[51] * value;

    let value = (column1 - *oods_values[52]) / (point - pow100 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[52] * value;

    let value = (column1 - *oods_values[53]) / (point - pow101 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[53] * value;

    let value = (column1 - *oods_values[54]) / (point - pow103 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[54] * value;

    let value = (column1 - *oods_values[55]) / (point - pow104 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[55] * value;

    let value = (column1 - *oods_values[56]) / (point - pow115 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[56] * value;

    let value = (column1 - *oods_values[57]) / (point - pow119 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[57] * value;

    let value = (column1 - *oods_values[58]) / (point - pow120 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[58] * value;

    let value = (column1 - *oods_values[59]) / (point - pow125 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[59] * value;

    let value = (column1 - *oods_values[60]) / (point - pow127 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[60] * value;

    let value = (column1 - *oods_values[61]) / (point - pow128 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[61] * value;

    let value = (column1 - *oods_values[62]) / (point - pow129 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[62] * value;

    let value = (column1 - *oods_values[63]) / (point - pow130 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[63] * value;

    let value = (column1 - *oods_values[64]) / (point - pow133 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[64] * value;

    let value = (column1 - *oods_values[65]) / (point - pow135 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[65] * value;

    let value = (column1 - *oods_values[66]) / (point - pow136 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[66] * value;

    let value = (column1 - *oods_values[67]) / (point - pow137 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[67] * value;

    let value = (column1 - *oods_values[68]) / (point - pow138 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[68] * value;

    let value = (column1 - *oods_values[69]) / (point - pow139 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[69] * value;

    let value = (column1 - *oods_values[70]) / (point - pow142 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[70] * value;

    let value = (column1 - *oods_values[71]) / (point - pow143 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[71] * value;

    let value = (column1 - *oods_values[72]) / (point - pow144 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[72] * value;

    let value = (column1 - *oods_values[73]) / (point - pow145 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[73] * value;

    let value = (column1 - *oods_values[74]) / (point - pow147 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[74] * value;

    let value = (column1 - *oods_values[75]) / (point - pow148 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[75] * value;

    let value = (column1 - *oods_values[76]) / (point - pow149 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[76] * value;

    let value = (column1 - *oods_values[77]) / (point - pow156 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[77] * value;

    let value = (column1 - *oods_values[78]) / (point - pow158 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[78] * value;

    let value = (column1 - *oods_values[79]) / (point - pow159 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[79] * value;

    let value = (column1 - *oods_values[80]) / (point - pow165 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[80] * value;

    let value = (column1 - *oods_values[81]) / (point - pow174 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[81] * value;

    let value = (column1 - *oods_values[82]) / (point - pow176 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[82] * value;

    let value = (column1 - *oods_values[83]) / (point - pow179 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[83] * value;

    let value = (column1 - *oods_values[84]) / (point - pow181 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[84] * value;

    let value = (column1 - *oods_values[85]) / (point - pow182 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[85] * value;

    let value = (column1 - *oods_values[86]) / (point - pow184 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[86] * value;

    let value = (column1 - *oods_values[87]) / (point - pow185 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[87] * value;

    let value = (column1 - *oods_values[88]) / (point - pow189 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[88] * value;

    let value = (column1 - *oods_values[89]) / (point - pow191 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[89] * value;

    let value = (column1 - *oods_values[90]) / (point - pow192 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[90] * value;

    let value = (column1 - *oods_values[91]) / (point - pow196 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[91] * value;

    let value = (column1 - *oods_values[92]) / (point - pow198 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[92] * value;

    let value = (column1 - *oods_values[93]) / (point - pow199 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[93] * value;

    let value = (column1 - *oods_values[94]) / (point - pow202 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[94] * value;

    let value = (column1 - *oods_values[95]) / (point - pow203 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[95] * value;

    let value = (column1 - *oods_values[96]) / (point - pow204 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[96] * value;

    let value = (column1 - *oods_values[97]) / (point - pow207 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[97] * value;

    let value = (column1 - *oods_values[98]) / (point - pow208 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[98] * value;

    let value = (column1 - *oods_values[99]) / (point - pow209 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[99] * value;

    let value = (column1 - *oods_values[100]) / (point - pow210 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[100] * value;

    let value = (column1 - *oods_values[101]) / (point - pow214 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[101] * value;

    let value = (column1 - *oods_values[102]) / (point - pow216 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[102] * value;

    let value = (column1 - *oods_values[103]) / (point - pow218 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[103] * value;

    let value = (column1 - *oods_values[104]) / (point - pow219 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[104] * value;

    let value = (column1 - *oods_values[105]) / (point - pow221 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[105] * value;

    let value = (column1 - *oods_values[106]) / (point - pow225 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[106] * value;

    let value = (column1 - *oods_values[107]) / (point - pow232 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[107] * value;

    let value = (column1 - *oods_values[108]) / (point - pow233 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[108] * value;

    let value = (column1 - *oods_values[109]) / (point - pow235 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[109] * value;

    let value = (column1 - *oods_values[110]) / (point - pow236 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[110] * value;

    let value = (column1 - *oods_values[111]) / (point - pow238 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[111] * value;

    let value = (column1 - *oods_values[112]) / (point - pow239 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[112] * value;

    let value = (column1 - *oods_values[113]) / (point - pow242 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[113] * value;

    let value = (column1 - *oods_values[114]) / (point - pow243 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[114] * value;

    let value = (column1 - *oods_values[115]) / (point - pow244 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[115] * value;

    let value = (column1 - *oods_values[116]) / (point - pow245 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[116] * value;

    let value = (column1 - *oods_values[117]) / (point - pow246 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[117] * value;

    let value = (column1 - *oods_values[118]) / (point - pow247 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[118] * value;

    let value = (column1 - *oods_values[119]) / (point - pow248 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[119] * value;

    let value = (column1 - *oods_values[120]) / (point - pow249 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[120] * value;

    let value = (column1 - *oods_values[121]) / (point - pow250 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[121] * value;

    let value = (column1 - *oods_values[122]) / (point - pow251 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[122] * value;

    let value = (column1 - *oods_values[123]) / (point - pow252 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[123] * value;

    let value = (column1 - *oods_values[124]) / (point - pow253 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[124] * value;

    let value = (column1 - *oods_values[125]) / (point - pow255 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[125] * value;

    let value = (column1 - *oods_values[126]) / (point - pow256 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[126] * value;

    let value = (column1 - *oods_values[127]) / (point - pow257 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[127] * value;

    let value = (column1 - *oods_values[128]) / (point - pow258 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[128] * value;

    let value = (column1 - *oods_values[129]) / (point - pow259 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[129] * value;

    let value = (column1 - *oods_values[130]) / (point - pow261 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[130] * value;

    let value = (column1 - *oods_values[131]) / (point - pow264 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[131] * value;

    let value = (column1 - *oods_values[132]) / (point - pow265 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[132] * value;

    let value = (column1 - *oods_values[133]) / (point - pow266 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[133] * value;

    let value = (column1 - *oods_values[134]) / (point - pow267 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[134] * value;

    let value = (column1 - *oods_values[135]) / (point - pow268 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[135] * value;

    let value = (column1 - *oods_values[136]) / (point - pow269 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[136] * value;

    let value = (column1 - *oods_values[137]) / (point - pow270 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[137] * value;

    let value = (column1 - *oods_values[138]) / (point - pow271 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[138] * value;

    let value = (column1 - *oods_values[139]) / (point - pow274 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[139] * value;

    let value = (column1 - *oods_values[140]) / (point - pow275 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[140] * value;

    let value = (column1 - *oods_values[141]) / (point - pow276 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[141] * value;

    let value = (column1 - *oods_values[142]) / (point - pow277 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[142] * value;

    let value = (column1 - *oods_values[143]) / (point - pow278 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[143] * value;

    let value = (column1 - *oods_values[144]) / (point - pow279 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[144] * value;

    let value = (column1 - *oods_values[145]) / (point - pow280 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[145] * value;

    let value = (column1 - *oods_values[146]) / (point - pow281 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[146] * value;

    let value = (column1 - *oods_values[147]) / (point - pow282 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[147] * value;

    let value = (column1 - *oods_values[148]) / (point - pow283 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[148] * value;

    let value = (column1 - *oods_values[149]) / (point - pow284 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[149] * value;

    let value = (column1 - *oods_values[150]) / (point - pow285 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[150] * value;

    let value = (column1 - *oods_values[151]) / (point - pow286 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[151] * value;

    let value = (column1 - *oods_values[152]) / (point - pow287 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[152] * value;

    let value = (column1 - *oods_values[153]) / (point - pow288 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[153] * value;

    let value = (column1 - *oods_values[154]) / (point - pow289 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[154] * value;

    let value = (column1 - *oods_values[155]) / (point - pow290 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[155] * value;

    let value = (column1 - *oods_values[156]) / (point - pow291 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[156] * value;

    let value = (column1 - *oods_values[157]) / (point - pow292 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[157] * value;

    let value = (column1 - *oods_values[158]) / (point - pow293 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[158] * value;

    let value = (column1 - *oods_values[159]) / (point - pow294 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[159] * value;

    let value = (column1 - *oods_values[160]) / (point - pow295 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[160] * value;

    let value = (column1 - *oods_values[161]) / (point - pow296 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[161] * value;

    let value = (column1 - *oods_values[162]) / (point - pow297 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[162] * value;

    let value = (column1 - *oods_values[163]) / (point - pow300 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[163] * value;

    let value = (column1 - *oods_values[164]) / (point - pow301 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[164] * value;

    let value = (column1 - *oods_values[165]) / (point - pow302 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[165] * value;

    let value = (column1 - *oods_values[166]) / (point - pow303 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[166] * value;

    let value = (column1 - *oods_values[167]) / (point - pow304 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[167] * value;

    let value = (column1 - *oods_values[168]) / (point - pow305 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[168] * value;

    let value = (column1 - *oods_values[169]) / (point - pow306 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[169] * value;

    let value = (column1 - *oods_values[170]) / (point - pow307 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[170] * value;

    let value = (column1 - *oods_values[171]) / (point - pow310 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[171] * value;

    let value = (column1 - *oods_values[172]) / (point - pow311 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[172] * value;

    let value = (column1 - *oods_values[173]) / (point - pow312 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[173] * value;

    let value = (column1 - *oods_values[174]) / (point - pow313 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[174] * value;

    let value = (column1 - *oods_values[175]) / (point - pow317 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[175] * value;

    let value = (column1 - *oods_values[176]) / (point - pow318 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[176] * value;

    let value = (column1 - *oods_values[177]) / (point - pow319 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[177] * value;

    let value = (column1 - *oods_values[178]) / (point - pow320 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[178] * value;

    let value = (column1 - *oods_values[179]) / (point - pow321 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[179] * value;

    let value = (column1 - *oods_values[180]) / (point - pow322 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[180] * value;

    let value = (column1 - *oods_values[181]) / (point - pow323 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[181] * value;

    let value = (column1 - *oods_values[182]) / (point - pow324 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[182] * value;

    let value = (column1 - *oods_values[183]) / (point - pow328 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[183] * value;

    let value = (column1 - *oods_values[184]) / (point - pow330 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[184] * value;

    let value = (column1 - *oods_values[185]) / (point - pow335 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[185] * value;

    let value = (column1 - *oods_values[186]) / (point - pow352 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[186] * value;

    let value = (column1 - *oods_values[187]) / (point - pow396 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[187] * value;

    let value = (column1 - *oods_values[188]) / (point - pow398 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[188] * value;

    let value = (column1 - *oods_values[189]) / (point - pow399 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[189] * value;

    let value = (column1 - *oods_values[190]) / (point - pow400 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[190] * value;

    let value = (column1 - *oods_values[191]) / (point - pow405 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[191] * value;

    let value = (column1 - *oods_values[192]) / (point - pow406 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[192] * value;

    let value = (column1 - *oods_values[193]) / (point - pow407 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[193] * value;

    let value = (column1 - *oods_values[194]) / (point - pow408 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[194] * value;

    let value = (column1 - *oods_values[195]) / (point - pow411 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[195] * value;

    let value = (column1 - *oods_values[196]) / (point - pow412 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[196] * value;

    let value = (column1 - *oods_values[197]) / (point - pow413 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[197] * value;

    let value = (column1 - *oods_values[198]) / (point - pow414 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[198] * value;

    let value = (column1 - *oods_values[199]) / (point - pow415 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[199] * value;

    let value = (column1 - *oods_values[200]) / (point - pow416 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[200] * value;

    let value = (column1 - *oods_values[201]) / (point - pow418 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[201] * value;

    let value = (column1 - *oods_values[202]) / (point - pow421 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[202] * value;

    let value = (column1 - *oods_values[203]) / (point - pow423 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[203] * value;

    let value = (column1 - *oods_values[204]) / (point - pow424 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[204] * value;

    let value = (column1 - *oods_values[205]) / (point - pow437 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[205] * value;

    let value = (column1 - *oods_values[206]) / (point - pow438 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[206] * value;

    let value = (column1 - *oods_values[207]) / (point - pow439 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[207] * value;

    let value = (column1 - *oods_values[208]) / (point - pow440 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[208] * value;

    let value = (column1 - *oods_values[209]) / (point - pow441 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[209] * value;

    let value = (column1 - *oods_values[210]) / (point - pow442 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[210] * value;

    let value = (column1 - *oods_values[211]) / (point - pow443 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[211] * value;

    let value = (column1 - *oods_values[212]) / (point - pow444 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[212] * value;

    let value = (column1 - *oods_values[213]) / (point - pow448 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[213] * value;

    let value = (column1 - *oods_values[214]) / (point - pow449 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[214] * value;

    let value = (column1 - *oods_values[215]) / (point - pow451 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[215] * value;

    let value = (column1 - *oods_values[216]) / (point - pow452 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[216] * value;

    let value = (column1 - *oods_values[217]) / (point - pow453 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[217] * value;

    let value = (column1 - *oods_values[218]) / (point - pow454 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[218] * value;

    let value = (column1 - *oods_values[219]) / (point - pow455 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[219] * value;

    let value = (column1 - *oods_values[220]) / (point - pow459 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[220] * value;

    let value = (column1 - *oods_values[221]) / (point - pow460 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[221] * value;

    let value = (column1 - *oods_values[222]) / (point - pow461 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[222] * value;

    let value = (column1 - *oods_values[223]) / (point - pow462 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[223] * value;

    let value = (column1 - *oods_values[224]) / (point - pow463 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[224] * value;

    let value = (column1 - *oods_values[225]) / (point - pow465 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[225] * value;

    let value = (column1 - *oods_values[226]) / (point - pow466 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[226] * value;

    let value = (column1 - *oods_values[227]) / (point - pow467 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[227] * value;

    let value = (column1 - *oods_values[228]) / (point - pow468 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[228] * value;

    let value = (column1 - *oods_values[229]) / (point - pow469 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[229] * value;

    let value = (column1 - *oods_values[230]) / (point - pow470 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[230] * value;

    let value = (column1 - *oods_values[231]) / (point - pow471 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[231] * value;

    let value = (column1 - *oods_values[232]) / (point - pow472 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[232] * value;

    let value = (column1 - *oods_values[233]) / (point - pow473 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[233] * value;

    let value = (column1 - *oods_values[234]) / (point - pow474 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[234] * value;

    let value = (column1 - *oods_values[235]) / (point - pow478 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[235] * value;

    let value = (column1 - *oods_values[236]) / (point - pow479 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[236] * value;

    let value = (column1 - *oods_values[237]) / (point - pow481 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[237] * value;

    let value = (column1 - *oods_values[238]) / (point - pow482 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[238] * value;

    let value = (column1 - *oods_values[239]) / (point - pow484 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[239] * value;

    let value = (column1 - *oods_values[240]) / (point - pow485 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[240] * value;

    let value = (column1 - *oods_values[241]) / (point - pow487 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[241] * value;

    let value = (column1 - *oods_values[242]) / (point - pow488 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[242] * value;

    let value = (column1 - *oods_values[243]) / (point - pow489 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[243] * value;

    let value = (column1 - *oods_values[244]) / (point - pow490 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[244] * value;

    let value = (column1 - *oods_values[245]) / (point - pow491 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[245] * value;

    let value = (column1 - *oods_values[246]) / (point - pow492 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[246] * value;

    let value = (column1 - *oods_values[247]) / (point - pow494 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[247] * value;

    let value = (column1 - *oods_values[248]) / (point - pow495 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[248] * value;

    let value = (column1 - *oods_values[249]) / (point - pow496 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[249] * value;

    let value = (column1 - *oods_values[250]) / (point - pow497 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[250] * value;

    let value = (column1 - *oods_values[251]) / (point - pow498 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[251] * value;

    let value = (column1 - *oods_values[252]) / (point - pow499 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[252] * value;

    let value = (column1 - *oods_values[253]) / (point - pow506 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[253] * value;

    let value = (column1 - *oods_values[254]) / (point - pow507 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[254] * value;

    let value = (column1 - *oods_values[255]) / (point - pow508 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[255] * value;

    let value = (column1 - *oods_values[256]) / (point - pow509 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[256] * value;

    let value = (column1 - *oods_values[257]) / (point - pow513 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[257] * value;

    let value = (column1 - *oods_values[258]) / (point - pow514 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[258] * value;

    let value = (column1 - *oods_values[259]) / (point - pow515 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[259] * value;

    let value = (column1 - *oods_values[260]) / (point - pow516 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[260] * value;

    let value = (column1 - *oods_values[261]) / (point - pow517 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[261] * value;

    let value = (column1 - *oods_values[262]) / (point - pow518 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[262] * value;

    let value = (column1 - *oods_values[263]) / (point - pow520 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[263] * value;

    let value = (column1 - *oods_values[264]) / (point - pow521 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[264] * value;

    let value = (column1 - *oods_values[265]) / (point - pow522 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[265] * value;

    let value = (column1 - *oods_values[266]) / (point - pow523 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[266] * value;

    let value = (column1 - *oods_values[267]) / (point - pow525 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[267] * value;

    let value = (column1 - *oods_values[268]) / (point - pow526 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[268] * value;

    let value = (column1 - *oods_values[269]) / (point - pow527 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[269] * value;

    let value = (column1 - *oods_values[270]) / (point - pow528 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[270] * value;

    let value = (column1 - *oods_values[271]) / (point - pow529 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[271] * value;

    let value = (column1 - *oods_values[272]) / (point - pow530 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[272] * value;

    let value = (column1 - *oods_values[273]) / (point - pow535 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[273] * value;

    let value = (column1 - *oods_values[274]) / (point - pow536 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[274] * value;

    let value = (column1 - *oods_values[275]) / (point - pow538 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[275] * value;

    let value = (column1 - *oods_values[276]) / (point - pow539 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[276] * value;

    let value = (column1 - *oods_values[277]) / (point - pow540 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[277] * value;

    let value = (column1 - *oods_values[278]) / (point - pow542 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[278] * value;

    let value = (column1 - *oods_values[279]) / (point - pow543 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[279] * value;

    let value = (column1 - *oods_values[280]) / (point - pow544 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[280] * value;

    let value = (column1 - *oods_values[281]) / (point - pow545 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[281] * value;

    let value = (column1 - *oods_values[282]) / (point - pow546 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[282] * value;

    let value = (column1 - *oods_values[283]) / (point - pow547 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[283] * value;

    let value = (column1 - *oods_values[284]) / (point - pow548 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[284] * value;

    let value = (column1 - *oods_values[285]) / (point - pow549 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[285] * value;

    let value = (column1 - *oods_values[286]) / (point - pow551 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[286] * value;

    let value = (column1 - *oods_values[287]) / (point - pow555 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[287] * value;

    let value = (column1 - *oods_values[288]) / (point - pow556 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[288] * value;

    let value = (column1 - *oods_values[289]) / (point - pow557 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[289] * value;

    let value = (column1 - *oods_values[290]) / (point - pow558 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[290] * value;

    let value = (column1 - *oods_values[291]) / (point - pow559 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[291] * value;

    let value = (column1 - *oods_values[292]) / (point - pow560 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[292] * value;

    let value = (column1 - *oods_values[293]) / (point - pow561 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[293] * value;

    let value = (column1 - *oods_values[294]) / (point - pow562 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[294] * value;

    let value = (column1 - *oods_values[295]) / (point - pow564 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[295] * value;

    let value = (column1 - *oods_values[296]) / (point - pow565 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[296] * value;

    let value = (column1 - *oods_values[297]) / (point - pow567 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[297] * value;

    let value = (column1 - *oods_values[298]) / (point - pow568 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[298] * value;

    let value = (column1 - *oods_values[299]) / (point - pow570 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[299] * value;

    let value = (column1 - *oods_values[300]) / (point - pow571 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[300] * value;

    let value = (column1 - *oods_values[301]) / (point - pow572 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[301] * value;

    let value = (column1 - *oods_values[302]) / (point - pow573 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[302] * value;

    let value = (column1 - *oods_values[303]) / (point - pow574 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[303] * value;

    let value = (column1 - *oods_values[304]) / (point - pow575 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[304] * value;

    let value = (column1 - *oods_values[305]) / (point - pow580 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[305] * value;

    let value = (column1 - *oods_values[306]) / (point - pow581 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[306] * value;

    let value = (column1 - *oods_values[307]) / (point - pow584 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[307] * value;

    let value = (column1 - *oods_values[308]) / (point - pow585 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[308] * value;

    let value = (column1 - *oods_values[309]) / (point - pow588 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[309] * value;

    let value = (column1 - *oods_values[310]) / (point - pow589 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[310] * value;

    let value = (column1 - *oods_values[311]) / (point - pow590 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[311] * value;

    let value = (column1 - *oods_values[312]) / (point - pow591 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[312] * value;

    let value = (column1 - *oods_values[313]) / (point - pow592 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[313] * value;

    let value = (column1 - *oods_values[314]) / (point - pow593 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[314] * value;

    let value = (column1 - *oods_values[315]) / (point - pow594 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[315] * value;

    let value = (column1 - *oods_values[316]) / (point - pow595 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[316] * value;

    let value = (column1 - *oods_values[317]) / (point - pow598 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[317] * value;

    let value = (column1 - *oods_values[318]) / (point - pow599 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[318] * value;

    let value = (column1 - *oods_values[319]) / (point - pow602 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[319] * value;

    let value = (column1 - *oods_values[320]) / (point - pow603 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[320] * value;

    let value = (column1 - *oods_values[321]) / (point - pow604 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[321] * value;

    let value = (column1 - *oods_values[322]) / (point - pow605 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[322] * value;

    let value = (column1 - *oods_values[323]) / (point - pow608 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[323] * value;

    let value = (column1 - *oods_values[324]) / (point - pow609 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[324] * value;

    let value = (column1 - *oods_values[325]) / (point - pow610 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[325] * value;

    let value = (column1 - *oods_values[326]) / (point - pow611 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[326] * value;

    let value = (column1 - *oods_values[327]) / (point - pow616 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[327] * value;

    let value = (column1 - *oods_values[328]) / (point - pow617 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[328] * value;

    let value = (column1 - *oods_values[329]) / (point - pow618 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[329] * value;

    let value = (column1 - *oods_values[330]) / (point - pow619 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[330] * value;

    let value = (column1 - *oods_values[331]) / (point - pow620 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[331] * value;

    let value = (column1 - *oods_values[332]) / (point - pow621 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[332] * value;

    let value = (column1 - *oods_values[333]) / (point - pow622 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[333] * value;

    let value = (column1 - *oods_values[334]) / (point - pow623 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[334] * value;

    let value = (column1 - *oods_values[335]) / (point - pow624 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[335] * value;

    let value = (column1 - *oods_values[336]) / (point - pow625 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[336] * value;

    let value = (column1 - *oods_values[337]) / (point - pow626 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[337] * value;

    let value = (column1 - *oods_values[338]) / (point - pow627 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[338] * value;

    let value = (column1 - *oods_values[339]) / (point - pow628 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[339] * value;

    let value = (column1 - *oods_values[340]) / (point - pow631 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[340] * value;

    let value = (column1 - *oods_values[341]) / (point - pow633 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[341] * value;

    let value = (column1 - *oods_values[342]) / (point - pow634 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[342] * value;

    let value = (column1 - *oods_values[343]) / (point - pow636 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[343] * value;

    let value = (column1 - *oods_values[344]) / (point - pow638 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[344] * value;

    let value = (column1 - *oods_values[345]) / (point - pow639 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[345] * value;

    let value = (column1 - *oods_values[346]) / (point - pow640 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[346] * value;

    let value = (column1 - *oods_values[347]) / (point - pow641 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[347] * value;

    let value = (column1 - *oods_values[348]) / (point - pow642 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[348] * value;

    let value = (column2 - *oods_values[349]) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[349] * value;

    let value = (column2 - *oods_values[350]) / (point - pow1 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[350] * value;

    let value = (column3 - *oods_values[351]) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[351] * value;

    let value = (column3 - *oods_values[352]) / (point - pow1 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[352] * value;

    let value = (column3 - *oods_values[353]) / (point - pow2 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[353] * value;

    let value = (column3 - *oods_values[354]) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[354] * value;

    let value = (column3 - *oods_values[355]) / (point - pow4 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[355] * value;

    let value = (column3 - *oods_values[356]) / (point - pow5 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[356] * value;

    let value = (column3 - *oods_values[357]) / (point - pow6 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[357] * value;

    let value = (column3 - *oods_values[358]) / (point - pow7 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[358] * value;

    let value = (column3 - *oods_values[359]) / (point - pow8 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[359] * value;

    let value = (column3 - *oods_values[360]) / (point - pow9 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[360] * value;

    let value = (column3 - *oods_values[361]) / (point - pow10 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[361] * value;

    let value = (column3 - *oods_values[362]) / (point - pow11 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[362] * value;

    let value = (column3 - *oods_values[363]) / (point - pow12 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[363] * value;

    let value = (column3 - *oods_values[364]) / (point - pow13 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[364] * value;

    let value = (column3 - *oods_values[365]) / (point - pow14 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[365] * value;

    let value = (column3 - *oods_values[366]) / (point - pow15 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[366] * value;

    let value = (column3 - *oods_values[367]) / (point - pow16 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[367] * value;

    let value = (column3 - *oods_values[368]) / (point - pow26 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[368] * value;

    let value = (column3 - *oods_values[369]) / (point - pow102 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[369] * value;

    let value = (column3 - *oods_values[370]) / (point - pow105 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[370] * value;

    let value = (column3 - *oods_values[371]) / (point - pow108 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[371] * value;

    let value = (column3 - *oods_values[372]) / (point - pow110 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[372] * value;

    let value = (column3 - *oods_values[373]) / (point - pow118 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[373] * value;

    let value = (column3 - *oods_values[374]) / (point - pow121 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[374] * value;

    let value = (column3 - *oods_values[375]) / (point - pow162 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[375] * value;

    let value = (column3 - *oods_values[376]) / (point - pow164 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[376] * value;

    let value = (column3 - *oods_values[377]) / (point - pow166 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[377] * value;

    let value = (column3 - *oods_values[378]) / (point - pow222 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[378] * value;

    let value = (column3 - *oods_values[379]) / (point - pow226 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[379] * value;

    let value = (column3 - *oods_values[380]) / (point - pow228 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[380] * value;

    let value = (column3 - *oods_values[381]) / (point - pow260 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[381] * value;

    let value = (column3 - *oods_values[382]) / (point - pow262 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[382] * value;

    let value = (column3 - *oods_values[383]) / (point - pow263 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[383] * value;

    let value = (column3 - *oods_values[384]) / (point - pow272 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[384] * value;

    let value = (column3 - *oods_values[385]) / (point - pow273 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[385] * value;

    let value = (column3 - *oods_values[386]) / (point - pow308 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[386] * value;

    let value = (column3 - *oods_values[387]) / (point - pow314 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[387] * value;

    let value = (column3 - *oods_values[388]) / (point - pow315 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[388] * value;

    let value = (column3 - *oods_values[389]) / (point - pow316 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[389] * value;

    let value = (column3 - *oods_values[390]) / (point - pow325 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[390] * value;

    let value = (column3 - *oods_values[391]) / (point - pow326 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[391] * value;

    let value = (column3 - *oods_values[392]) / (point - pow327 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[392] * value;

    let value = (column3 - *oods_values[393]) / (point - pow329 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[393] * value;

    let value = (column3 - *oods_values[394]) / (point - pow334 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[394] * value;

    let value = (column3 - *oods_values[395]) / (point - pow339 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[395] * value;

    let value = (column3 - *oods_values[396]) / (point - pow347 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[396] * value;

    let value = (column3 - *oods_values[397]) / (point - pow350 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[397] * value;

    let value = (column3 - *oods_values[398]) / (point - pow353 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[398] * value;

    let value = (column3 - *oods_values[399]) / (point - pow355 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[399] * value;

    let value = (column3 - *oods_values[400]) / (point - pow356 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[400] * value;

    let value = (column3 - *oods_values[401]) / (point - pow357 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[401] * value;

    let value = (column3 - *oods_values[402]) / (point - pow358 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[402] * value;

    let value = (column3 - *oods_values[403]) / (point - pow359 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[403] * value;

    let value = (column3 - *oods_values[404]) / (point - pow360 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[404] * value;

    let value = (column3 - *oods_values[405]) / (point - pow361 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[405] * value;

    let value = (column3 - *oods_values[406]) / (point - pow362 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[406] * value;

    let value = (column3 - *oods_values[407]) / (point - pow363 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[407] * value;

    let value = (column3 - *oods_values[408]) / (point - pow364 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[408] * value;

    let value = (column3 - *oods_values[409]) / (point - pow365 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[409] * value;

    let value = (column3 - *oods_values[410]) / (point - pow366 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[410] * value;

    let value = (column3 - *oods_values[411]) / (point - pow367 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[411] * value;

    let value = (column3 - *oods_values[412]) / (point - pow368 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[412] * value;

    let value = (column3 - *oods_values[413]) / (point - pow369 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[413] * value;

    let value = (column3 - *oods_values[414]) / (point - pow370 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[414] * value;

    let value = (column3 - *oods_values[415]) / (point - pow371 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[415] * value;

    let value = (column3 - *oods_values[416]) / (point - pow372 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[416] * value;

    let value = (column3 - *oods_values[417]) / (point - pow373 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[417] * value;

    let value = (column3 - *oods_values[418]) / (point - pow374 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[418] * value;

    let value = (column3 - *oods_values[419]) / (point - pow375 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[419] * value;

    let value = (column3 - *oods_values[420]) / (point - pow376 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[420] * value;

    let value = (column3 - *oods_values[421]) / (point - pow377 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[421] * value;

    let value = (column3 - *oods_values[422]) / (point - pow378 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[422] * value;

    let value = (column3 - *oods_values[423]) / (point - pow379 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[423] * value;

    let value = (column3 - *oods_values[424]) / (point - pow380 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[424] * value;

    let value = (column3 - *oods_values[425]) / (point - pow383 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[425] * value;

    let value = (column3 - *oods_values[426]) / (point - pow386 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[426] * value;

    let value = (column3 - *oods_values[427]) / (point - pow390 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[427] * value;

    let value = (column3 - *oods_values[428]) / (point - pow393 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[428] * value;

    let value = (column3 - *oods_values[429]) / (point - pow409 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[429] * value;

    let value = (column3 - *oods_values[430]) / (point - pow425 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[430] * value;

    let value = (column3 - *oods_values[431]) / (point - pow435 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[431] * value;

    let value = (column3 - *oods_values[432]) / (point - pow445 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[432] * value;

    let value = (column3 - *oods_values[433]) / (point - pow446 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[433] * value;

    let value = (column3 - *oods_values[434]) / (point - pow447 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[434] * value;

    let value = (column3 - *oods_values[435]) / (point - pow450 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[435] * value;

    let value = (column3 - *oods_values[436]) / (point - pow456 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[436] * value;

    let value = (column3 - *oods_values[437]) / (point - pow457 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[437] * value;

    let value = (column3 - *oods_values[438]) / (point - pow458 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[438] * value;

    let value = (column3 - *oods_values[439]) / (point - pow464 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[439] * value;

    let value = (column3 - *oods_values[440]) / (point - pow475 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[440] * value;

    let value = (column3 - *oods_values[441]) / (point - pow476 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[441] * value;

    let value = (column3 - *oods_values[442]) / (point - pow477 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[442] * value;

    let value = (column3 - *oods_values[443]) / (point - pow480 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[443] * value;

    let value = (column3 - *oods_values[444]) / (point - pow483 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[444] * value;

    let value = (column3 - *oods_values[445]) / (point - pow486 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[445] * value;

    let value = (column3 - *oods_values[446]) / (point - pow493 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[446] * value;

    let value = (column3 - *oods_values[447]) / (point - pow500 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[447] * value;

    let value = (column3 - *oods_values[448]) / (point - pow501 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[448] * value;

    let value = (column3 - *oods_values[449]) / (point - pow502 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[449] * value;

    let value = (column3 - *oods_values[450]) / (point - pow503 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[450] * value;

    let value = (column3 - *oods_values[451]) / (point - pow504 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[451] * value;

    let value = (column3 - *oods_values[452]) / (point - pow505 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[452] * value;

    let value = (column3 - *oods_values[453]) / (point - pow510 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[453] * value;

    let value = (column3 - *oods_values[454]) / (point - pow511 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[454] * value;

    let value = (column3 - *oods_values[455]) / (point - pow512 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[455] * value;

    let value = (column3 - *oods_values[456]) / (point - pow519 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[456] * value;

    let value = (column3 - *oods_values[457]) / (point - pow524 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[457] * value;

    let value = (column3 - *oods_values[458]) / (point - pow531 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[458] * value;

    let value = (column3 - *oods_values[459]) / (point - pow532 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[459] * value;

    let value = (column3 - *oods_values[460]) / (point - pow533 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[460] * value;

    let value = (column3 - *oods_values[461]) / (point - pow534 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[461] * value;

    let value = (column3 - *oods_values[462]) / (point - pow537 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[462] * value;

    let value = (column3 - *oods_values[463]) / (point - pow541 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[463] * value;

    let value = (column3 - *oods_values[464]) / (point - pow550 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[464] * value;

    let value = (column3 - *oods_values[465]) / (point - pow552 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[465] * value;

    let value = (column3 - *oods_values[466]) / (point - pow553 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[466] * value;

    let value = (column3 - *oods_values[467]) / (point - pow554 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[467] * value;

    let value = (column3 - *oods_values[468]) / (point - pow563 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[468] * value;

    let value = (column3 - *oods_values[469]) / (point - pow566 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[469] * value;

    let value = (column3 - *oods_values[470]) / (point - pow569 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[470] * value;

    let value = (column3 - *oods_values[471]) / (point - pow576 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[471] * value;

    let value = (column3 - *oods_values[472]) / (point - pow577 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[472] * value;

    let value = (column3 - *oods_values[473]) / (point - pow578 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[473] * value;

    let value = (column3 - *oods_values[474]) / (point - pow579 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[474] * value;

    let value = (column3 - *oods_values[475]) / (point - pow582 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[475] * value;

    let value = (column3 - *oods_values[476]) / (point - pow583 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[476] * value;

    let value = (column3 - *oods_values[477]) / (point - pow586 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[477] * value;

    let value = (column3 - *oods_values[478]) / (point - pow587 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[478] * value;

    let value = (column3 - *oods_values[479]) / (point - pow596 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[479] * value;

    let value = (column3 - *oods_values[480]) / (point - pow597 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[480] * value;

    let value = (column3 - *oods_values[481]) / (point - pow600 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[481] * value;

    let value = (column3 - *oods_values[482]) / (point - pow601 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[482] * value;

    let value = (column3 - *oods_values[483]) / (point - pow606 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[483] * value;

    let value = (column3 - *oods_values[484]) / (point - pow607 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[484] * value;

    let value = (column3 - *oods_values[485]) / (point - pow612 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[485] * value;

    let value = (column3 - *oods_values[486]) / (point - pow613 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[486] * value;

    let value = (column3 - *oods_values[487]) / (point - pow614 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[487] * value;

    let value = (column3 - *oods_values[488]) / (point - pow615 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[488] * value;

    let value = (column3 - *oods_values[489]) / (point - pow629 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[489] * value;

    let value = (column3 - *oods_values[490]) / (point - pow630 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[490] * value;

    let value = (column3 - *oods_values[491]) / (point - pow632 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[491] * value;

    let value = (column3 - *oods_values[492]) / (point - pow635 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[492] * value;

    let value = (column3 - *oods_values[493]) / (point - pow637 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[493] * value;

    let value = (column4 - *oods_values[494]) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[494] * value;

    let value = (column4 - *oods_values[495]) / (point - pow1 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[495] * value;

    let value = (column4 - *oods_values[496]) / (point - pow2 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[496] * value;

    let value = (column4 - *oods_values[497]) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[497] * value;

    let value = (column4 - *oods_values[498]) / (point - pow4 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[498] * value;

    let value = (column4 - *oods_values[499]) / (point - pow5 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[499] * value;

    let value = (column4 - *oods_values[500]) / (point - pow8 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[500] * value;

    let value = (column4 - *oods_values[501]) / (point - pow9 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[501] * value;

    let value = (column4 - *oods_values[502]) / (point - pow10 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[502] * value;

    let value = (column4 - *oods_values[503]) / (point - pow11 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[503] * value;

    let value = (column4 - *oods_values[504]) / (point - pow12 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[504] * value;

    let value = (column4 - *oods_values[505]) / (point - pow13 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[505] * value;

    let value = (column4 - *oods_values[506]) / (point - pow16 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[506] * value;

    let value = (column4 - *oods_values[507]) / (point - pow33 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[507] * value;

    let value = (column4 - *oods_values[508]) / (point - pow34 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[508] * value;

    let value = (column4 - *oods_values[509]) / (point - pow52 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[509] * value;

    let value = (column4 - *oods_values[510]) / (point - pow53 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[510] * value;

    let value = (column4 - *oods_values[511]) / (point - pow64 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[511] * value;

    let value = (column4 - *oods_values[512]) / (point - pow75 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[512] * value;

    let value = (column4 - *oods_values[513]) / (point - pow76 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[513] * value;

    let value = (column4 - *oods_values[514]) / (point - pow79 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[514] * value;

    let value = (column4 - *oods_values[515]) / (point - pow91 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[515] * value;

    let value = (column4 - *oods_values[516]) / (point - pow94 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[516] * value;

    let value = (column4 - *oods_values[517]) / (point - pow95 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[517] * value;

    let value = (column4 - *oods_values[518]) / (point - pow106 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[518] * value;

    let value = (column4 - *oods_values[519]) / (point - pow107 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[519] * value;

    let value = (column4 - *oods_values[520]) / (point - pow111 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[520] * value;

    let value = (column4 - *oods_values[521]) / (point - pow122 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[521] * value;

    let value = (column4 - *oods_values[522]) / (point - pow123 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[522] * value;

    let value = (column4 - *oods_values[523]) / (point - pow131 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[523] * value;

    let value = (column4 - *oods_values[524]) / (point - pow132 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[524] * value;

    let value = (column4 - *oods_values[525]) / (point - pow140 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[525] * value;

    let value = (column4 - *oods_values[526]) / (point - pow141 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[526] * value;

    let value = (column4 - *oods_values[527]) / (point - pow146 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[527] * value;

    let value = (column4 - *oods_values[528]) / (point - pow150 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[528] * value;

    let value = (column4 - *oods_values[529]) / (point - pow151 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[529] * value;

    let value = (column4 - *oods_values[530]) / (point - pow160 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[530] * value;

    let value = (column4 - *oods_values[531]) / (point - pow177 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[531] * value;

    let value = (column4 - *oods_values[532]) / (point - pow178 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[532] * value;

    let value = (column4 - *oods_values[533]) / (point - pow186 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[533] * value;

    let value = (column4 - *oods_values[534]) / (point - pow200 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[534] * value;

    let value = (column4 - *oods_values[535]) / (point - pow201 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[535] * value;

    let value = (column4 - *oods_values[536]) / (point - pow205 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[536] * value;

    let value = (column4 - *oods_values[537]) / (point - pow206 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[537] * value;

    let value = (column4 - *oods_values[538]) / (point - pow211 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[538] * value;

    let value = (column4 - *oods_values[539]) / (point - pow212 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[539] * value;

    let value = (column4 - *oods_values[540]) / (point - pow234 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[540] * value;

    let value = (column4 - *oods_values[541]) / (point - pow237 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[541] * value;

    let value = (column4 - *oods_values[542]) / (point - pow240 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[542] * value;

    let value = (column4 - *oods_values[543]) / (point - pow241 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[543] * value;

    let value = (column4 - *oods_values[544]) / (point - pow254 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[544] * value;

    let value = (column4 - *oods_values[545]) / (point - pow298 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[545] * value;

    let value = (column4 - *oods_values[546]) / (point - pow299 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[546] * value;

    let value = (column4 - *oods_values[547]) / (point - pow309 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[547] * value;

    let value = (column4 - *oods_values[548]) / (point - pow331 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[548] * value;

    let value = (column4 - *oods_values[549]) / (point - pow332 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[549] * value;

    let value = (column4 - *oods_values[550]) / (point - pow333 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[550] * value;

    let value = (column4 - *oods_values[551]) / (point - pow336 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[551] * value;

    let value = (column4 - *oods_values[552]) / (point - pow337 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[552] * value;

    let value = (column4 - *oods_values[553]) / (point - pow338 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[553] * value;

    let value = (column4 - *oods_values[554]) / (point - pow344 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[554] * value;

    let value = (column4 - *oods_values[555]) / (point - pow345 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[555] * value;

    let value = (column4 - *oods_values[556]) / (point - pow346 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[556] * value;

    let value = (column4 - *oods_values[557]) / (point - pow348 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[557] * value;

    let value = (column4 - *oods_values[558]) / (point - pow349 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[558] * value;

    let value = (column4 - *oods_values[559]) / (point - pow351 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[559] * value;

    let value = (column4 - *oods_values[560]) / (point - pow397 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[560] * value;

    let value = (column4 - *oods_values[561]) / (point - pow401 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[561] * value;

    let value = (column4 - *oods_values[562]) / (point - pow402 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[562] * value;

    let value = (column4 - *oods_values[563]) / (point - pow403 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[563] * value;

    let value = (column4 - *oods_values[564]) / (point - pow404 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[564] * value;

    let value = (column4 - *oods_values[565]) / (point - pow410 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[565] * value;

    let value = (column4 - *oods_values[566]) / (point - pow417 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[566] * value;

    let value = (column4 - *oods_values[567]) / (point - pow419 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[567] * value;

    let value = (column4 - *oods_values[568]) / (point - pow420 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[568] * value;

    let value = (column4 - *oods_values[569]) / (point - pow422 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[569] * value;

    let value = (column4 - *oods_values[570]) / (point - pow426 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[570] * value;

    let value = (column4 - *oods_values[571]) / (point - pow436 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[571] * value;

    let value = (column5 - *oods_values[572]) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[572] * value;

    let value = (column5 - *oods_values[573]) / (point - pow1 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[573] * value;

    let value = (column5 - *oods_values[574]) / (point - pow2 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[574] * value;

    let value = (column5 - *oods_values[575]) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[575] * value;

    let value = (column6 - *oods_values[576]) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[576] * value;

    let value = (column6 - *oods_values[577]) / (point - pow1 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[577] * value;

    let value = (column6 - *oods_values[578]) / (point - pow2 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[578] * value;

    let value = (column6 - *oods_values[579]) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[579] * value;

    let value = (column6 - *oods_values[580]) / (point - pow4 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[580] * value;

    let value = (column6 - *oods_values[581]) / (point - pow5 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[581] * value;

    let value = (column6 - *oods_values[582]) / (point - pow6 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[582] * value;

    let value = (column6 - *oods_values[583]) / (point - pow7 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[583] * value;

    let value = (column6 - *oods_values[584]) / (point - pow8 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[584] * value;

    let value = (column6 - *oods_values[585]) / (point - pow9 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[585] * value;

    let value = (column6 - *oods_values[586]) / (point - pow11 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[586] * value;

    let value = (column6 - *oods_values[587]) / (point - pow12 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[587] * value;

    let value = (column6 - *oods_values[588]) / (point - pow13 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[588] * value;

    let value = (column6 - *oods_values[589]) / (point - pow23 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[589] * value;

    let value = (column6 - *oods_values[590]) / (point - pow35 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[590] * value;

    let value = (column6 - *oods_values[591]) / (point - pow45 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[591] * value;

    let value = (column6 - *oods_values[592]) / (point - pow54 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[592] * value;

    let value = (column6 - *oods_values[593]) / (point - pow60 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[593] * value;

    let value = (column6 - *oods_values[594]) / (point - pow65 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[594] * value;

    let value = (column6 - *oods_values[595]) / (point - pow71 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[595] * value;

    let value = (column6 - *oods_values[596]) / (point - pow148 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[596] * value;

    let value = (column6 - *oods_values[597]) / (point - pow151 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[597] * value;

    let value = (column6 - *oods_values[598]) / (point - pow153 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[598] * value;

    let value = (column6 - *oods_values[599]) / (point - pow154 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[599] * value;

    let value = (column6 - *oods_values[600]) / (point - pow167 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[600] * value;

    let value = (column6 - *oods_values[601]) / (point - pow168 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[601] * value;

    let value = (column6 - *oods_values[602]) / (point - pow170 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[602] * value;

    let value = (column6 - *oods_values[603]) / (point - pow171 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[603] * value;

    let value = (column6 - *oods_values[604]) / (point - pow172 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[604] * value;

    let value = (column6 - *oods_values[605]) / (point - pow173 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[605] * value;

    let value = (column6 - *oods_values[606]) / (point - pow174 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[606] * value;

    let value = (column6 - *oods_values[607]) / (point - pow175 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[607] * value;

    let value = (column6 - *oods_values[608]) / (point - pow231 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[608] * value;

    let value = (column7 - *oods_values[609]) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[609] * value;

    let value = (column7 - *oods_values[610]) / (point - pow1 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[610] * value;

    let value = (column7 - *oods_values[611]) / (point - pow2 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[611] * value;

    let value = (column7 - *oods_values[612]) / (point - pow4 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[612] * value;

    let value = (column7 - *oods_values[613]) / (point - pow5 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[613] * value;

    let value = (column7 - *oods_values[614]) / (point - pow6 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[614] * value;

    let value = (column7 - *oods_values[615]) / (point - pow8 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[615] * value;

    let value = (column7 - *oods_values[616]) / (point - pow9 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[616] * value;

    let value = (column7 - *oods_values[617]) / (point - pow10 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[617] * value;

    let value = (column7 - *oods_values[618]) / (point - pow12 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[618] * value;

    let value = (column7 - *oods_values[619]) / (point - pow13 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[619] * value;

    let value = (column7 - *oods_values[620]) / (point - pow14 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[620] * value;

    let value = (column7 - *oods_values[621]) / (point - pow16 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[621] * value;

    let value = (column7 - *oods_values[622]) / (point - pow17 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[622] * value;

    let value = (column7 - *oods_values[623]) / (point - pow19 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[623] * value;

    let value = (column7 - *oods_values[624]) / (point - pow20 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[624] * value;

    let value = (column7 - *oods_values[625]) / (point - pow21 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[625] * value;

    let value = (column7 - *oods_values[626]) / (point - pow22 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[626] * value;

    let value = (column7 - *oods_values[627]) / (point - pow24 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[627] * value;

    let value = (column7 - *oods_values[628]) / (point - pow25 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[628] * value;

    let value = (column7 - *oods_values[629]) / (point - pow27 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[629] * value;

    let value = (column7 - *oods_values[630]) / (point - pow29 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[630] * value;

    let value = (column7 - *oods_values[631]) / (point - pow30 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[631] * value;

    let value = (column7 - *oods_values[632]) / (point - pow32 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[632] * value;

    let value = (column7 - *oods_values[633]) / (point - pow36 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[633] * value;

    let value = (column7 - *oods_values[634]) / (point - pow37 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[634] * value;

    let value = (column7 - *oods_values[635]) / (point - pow39 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[635] * value;

    let value = (column7 - *oods_values[636]) / (point - pow41 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[636] * value;

    let value = (column7 - *oods_values[637]) / (point - pow42 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[637] * value;

    let value = (column7 - *oods_values[638]) / (point - pow44 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[638] * value;

    let value = (column7 - *oods_values[639]) / (point - pow46 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[639] * value;

    let value = (column7 - *oods_values[640]) / (point - pow48 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[640] * value;

    let value = (column7 - *oods_values[641]) / (point - pow50 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[641] * value;

    let value = (column7 - *oods_values[642]) / (point - pow51 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[642] * value;

    let value = (column7 - *oods_values[643]) / (point - pow55 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[643] * value;

    let value = (column7 - *oods_values[644]) / (point - pow56 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[644] * value;

    let value = (column7 - *oods_values[645]) / (point - pow57 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[645] * value;

    let value = (column7 - *oods_values[646]) / (point - pow58 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[646] * value;

    let value = (column7 - *oods_values[647]) / (point - pow59 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[647] * value;

    let value = (column7 - *oods_values[648]) / (point - pow61 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[648] * value;

    let value = (column7 - *oods_values[649]) / (point - pow62 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[649] * value;

    let value = (column7 - *oods_values[650]) / (point - pow63 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[650] * value;

    let value = (column7 - *oods_values[651]) / (point - pow66 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[651] * value;

    let value = (column7 - *oods_values[652]) / (point - pow67 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[652] * value;

    let value = (column7 - *oods_values[653]) / (point - pow68 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[653] * value;

    let value = (column7 - *oods_values[654]) / (point - pow69 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[654] * value;

    let value = (column7 - *oods_values[655]) / (point - pow70 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[655] * value;

    let value = (column7 - *oods_values[656]) / (point - pow74 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[656] * value;

    let value = (column7 - *oods_values[657]) / (point - pow77 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[657] * value;

    let value = (column7 - *oods_values[658]) / (point - pow78 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[658] * value;

    let value = (column7 - *oods_values[659]) / (point - pow80 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[659] * value;

    let value = (column7 - *oods_values[660]) / (point - pow82 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[660] * value;

    let value = (column7 - *oods_values[661]) / (point - pow84 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[661] * value;

    let value = (column7 - *oods_values[662]) / (point - pow92 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[662] * value;

    let value = (column7 - *oods_values[663]) / (point - pow93 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[663] * value;

    let value = (column7 - *oods_values[664]) / (point - pow96 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[664] * value;

    let value = (column7 - *oods_values[665]) / (point - pow98 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[665] * value;

    let value = (column7 - *oods_values[666]) / (point - pow109 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[666] * value;

    let value = (column7 - *oods_values[667]) / (point - pow112 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[667] * value;

    let value = (column7 - *oods_values[668]) / (point - pow113 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[668] * value;

    let value = (column7 - *oods_values[669]) / (point - pow114 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[669] * value;

    let value = (column7 - *oods_values[670]) / (point - pow116 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[670] * value;

    let value = (column7 - *oods_values[671]) / (point - pow117 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[671] * value;

    let value = (column7 - *oods_values[672]) / (point - pow124 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[672] * value;

    let value = (column7 - *oods_values[673]) / (point - pow126 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[673] * value;

    let value = (column7 - *oods_values[674]) / (point - pow134 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[674] * value;

    let value = (column7 - *oods_values[675]) / (point - pow152 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[675] * value;

    let value = (column7 - *oods_values[676]) / (point - pow155 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[676] * value;

    let value = (column7 - *oods_values[677]) / (point - pow157 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[677] * value;

    let value = (column7 - *oods_values[678]) / (point - pow161 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[678] * value;

    let value = (column7 - *oods_values[679]) / (point - pow163 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[679] * value;

    let value = (column7 - *oods_values[680]) / (point - pow169 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[680] * value;

    let value = (column7 - *oods_values[681]) / (point - pow180 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[681] * value;

    let value = (column7 - *oods_values[682]) / (point - pow183 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[682] * value;

    let value = (column7 - *oods_values[683]) / (point - pow187 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[683] * value;

    let value = (column7 - *oods_values[684]) / (point - pow188 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[684] * value;

    let value = (column7 - *oods_values[685]) / (point - pow190 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[685] * value;

    let value = (column7 - *oods_values[686]) / (point - pow193 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[686] * value;

    let value = (column7 - *oods_values[687]) / (point - pow194 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[687] * value;

    let value = (column7 - *oods_values[688]) / (point - pow195 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[688] * value;

    let value = (column7 - *oods_values[689]) / (point - pow197 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[689] * value;

    let value = (column7 - *oods_values[690]) / (point - pow213 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[690] * value;

    let value = (column7 - *oods_values[691]) / (point - pow215 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[691] * value;

    let value = (column7 - *oods_values[692]) / (point - pow217 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[692] * value;

    let value = (column7 - *oods_values[693]) / (point - pow220 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[693] * value;

    let value = (column7 - *oods_values[694]) / (point - pow223 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[694] * value;

    let value = (column7 - *oods_values[695]) / (point - pow224 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[695] * value;

    let value = (column7 - *oods_values[696]) / (point - pow227 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[696] * value;

    let value = (column7 - *oods_values[697]) / (point - pow229 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[697] * value;

    let value = (column7 - *oods_values[698]) / (point - pow230 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[698] * value;

    let value = (column7 - *oods_values[699]) / (point - pow340 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[699] * value;

    let value = (column7 - *oods_values[700]) / (point - pow341 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[700] * value;

    let value = (column7 - *oods_values[701]) / (point - pow342 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[701] * value;

    let value = (column7 - *oods_values[702]) / (point - pow343 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[702] * value;

    let value = (column7 - *oods_values[703]) / (point - pow354 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[703] * value;

    let value = (column7 - *oods_values[704]) / (point - pow356 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[704] * value;

    let value = (column7 - *oods_values[705]) / (point - pow381 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[705] * value;

    let value = (column7 - *oods_values[706]) / (point - pow382 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[706] * value;

    let value = (column7 - *oods_values[707]) / (point - pow384 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[707] * value;

    let value = (column7 - *oods_values[708]) / (point - pow385 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[708] * value;

    let value = (column7 - *oods_values[709]) / (point - pow387 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[709] * value;

    let value = (column7 - *oods_values[710]) / (point - pow388 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[710] * value;

    let value = (column7 - *oods_values[711]) / (point - pow389 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[711] * value;

    let value = (column7 - *oods_values[712]) / (point - pow391 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[712] * value;

    let value = (column7 - *oods_values[713]) / (point - pow392 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[713] * value;

    let value = (column7 - *oods_values[714]) / (point - pow394 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[714] * value;

    let value = (column7 - *oods_values[715]) / (point - pow395 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[715] * value;

    let value = (column7 - *oods_values[716]) / (point - pow427 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[716] * value;

    let value = (column7 - *oods_values[717]) / (point - pow428 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[717] * value;

    let value = (column7 - *oods_values[718]) / (point - pow429 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[718] * value;

    let value = (column7 - *oods_values[719]) / (point - pow430 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[719] * value;

    let value = (column7 - *oods_values[720]) / (point - pow431 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[720] * value;

    let value = (column7 - *oods_values[721]) / (point - pow432 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[721] * value;

    let value = (column7 - *oods_values[722]) / (point - pow433 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[722] * value;

    let value = (column7 - *oods_values[723]) / (point - pow434 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[723] * value;

    let value = (column8 - *oods_values[724]) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[724] * value;

    let value = (column8 - *oods_values[725]) / (point - pow1 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[725] * value;

    let value = (column9 - *oods_values[726]) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[726] * value;

    let value = (column9 - *oods_values[727]) / (point - pow1 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[727] * value;

    let value = (column10 - *oods_values[728]) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[728] * value;

    let value = (column10 - *oods_values[729]) / (point - pow1 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[729] * value;

    let value = (column10 - *oods_values[730]) / (point - pow2 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[730] * value;

    let value = (column10 - *oods_values[731]) / (point - pow5 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[731] * value;

    // Sum the OODS boundary constraints on the composition polynomials.
    let oods_point_to_deg = pow(oods_point, CONSTRAINT_DEGREE.into());

    let value = (*column_values[NUM_COLUMNS_FIRST + NUM_COLUMNS_SECOND] - *oods_values[732])
        / (point - oods_point_to_deg);
    let total_sum = total_sum + *constraint_coefficients[732] * value;

    let value = (*column_values[NUM_COLUMNS_FIRST + NUM_COLUMNS_SECOND + 1] - *oods_values[733])
        / (point - oods_point_to_deg);
    let total_sum = total_sum + *constraint_coefficients[733] * value;

    assert(734 == MASK_SIZE + CONSTRAINT_DEGREE.into(), 'Invalid value');
    total_sum
}
