use cairo_verifier::air::global_values::GlobalValues;
use cairo_verifier::common::math::{Felt252Div, pow};
use cairo_verifier::air::constants::{
    CONSTRAINT_DEGREE, NUM_COLUMNS_FIRST, NUM_COLUMNS_SECOND, MASK_SIZE
};

fn eval_composition_polynomial_inner(
    mask_values: Array<felt252>,
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

    let pows = array![
        pow0,
        pow1,
        pow2,
        pow3,
        pow4,
        pow5,
        pow6,
        pow7,
        pow8,
        pow9,
        pow10,
        pow11,
        pow12,
        pow13,
        pow14,
        pow15,
        pow0,
        pow1,
        pow2,
        pow3,
        pow4,
        pow5,
        pow6,
        pow8,
        pow12,
        pow14,
        pow16,
        pow18,
        pow21,
        pow23,
        pow26,
        pow28,
        pow31,
        pow35,
        pow38,
        pow40,
        pow43,
        pow45,
        pow47,
        pow49,
        pow72,
        pow73,
        pow81,
        pow83,
        pow85,
        pow86,
        pow87,
        pow88,
        pow89,
        pow90,
        pow97,
        pow99,
        pow100,
        pow101,
        pow103,
        pow104,
        pow115,
        pow119,
        pow120,
        pow125,
        pow127,
        pow128,
        pow129,
        pow130,
        pow133,
        pow135,
        pow136,
        pow137,
        pow138,
        pow139,
        pow142,
        pow143,
        pow144,
        pow145,
        pow147,
        pow148,
        pow149,
        pow156,
        pow158,
        pow159,
        pow165,
        pow174,
        pow176,
        pow179,
        pow181,
        pow182,
        pow184,
        pow185,
        pow189,
        pow191,
        pow192,
        pow196,
        pow198,
        pow199,
        pow202,
        pow203,
        pow204,
        pow207,
        pow208,
        pow209,
        pow210,
        pow214,
        pow216,
        pow218,
        pow219,
        pow221,
        pow225,
        pow232,
        pow233,
        pow235,
        pow236,
        pow238,
        pow239,
        pow242,
        pow243,
        pow244,
        pow245,
        pow246,
        pow247,
        pow248,
        pow249,
        pow250,
        pow251,
        pow252,
        pow253,
        pow255,
        pow256,
        pow257,
        pow258,
        pow259,
        pow261,
        pow264,
        pow265,
        pow266,
        pow267,
        pow268,
        pow269,
        pow270,
        pow271,
        pow274,
        pow275,
        pow276,
        pow277,
        pow278,
        pow279,
        pow280,
        pow281,
        pow282,
        pow283,
        pow284,
        pow285,
        pow286,
        pow287,
        pow288,
        pow289,
        pow290,
        pow291,
        pow292,
        pow293,
        pow294,
        pow295,
        pow296,
        pow297,
        pow300,
        pow301,
        pow302,
        pow303,
        pow304,
        pow305,
        pow306,
        pow307,
        pow310,
        pow311,
        pow312,
        pow313,
        pow317,
        pow318,
        pow319,
        pow320,
        pow321,
        pow322,
        pow323,
        pow324,
        pow328,
        pow330,
        pow335,
        pow352,
        pow396,
        pow398,
        pow399,
        pow400,
        pow405,
        pow406,
        pow407,
        pow408,
        pow411,
        pow412,
        pow413,
        pow414,
        pow415,
        pow416,
        pow418,
        pow421,
        pow423,
        pow424,
        pow437,
        pow438,
        pow439,
        pow440,
        pow441,
        pow442,
        pow443,
        pow444,
        pow448,
        pow449,
        pow451,
        pow452,
        pow453,
        pow454,
        pow455,
        pow459,
        pow460,
        pow461,
        pow462,
        pow463,
        pow465,
        pow466,
        pow467,
        pow468,
        pow469,
        pow470,
        pow471,
        pow472,
        pow473,
        pow474,
        pow478,
        pow479,
        pow481,
        pow482,
        pow484,
        pow485,
        pow487,
        pow488,
        pow489,
        pow490,
        pow491,
        pow492,
        pow494,
        pow495,
        pow496,
        pow497,
        pow498,
        pow499,
        pow506,
        pow507,
        pow508,
        pow509,
        pow513,
        pow514,
        pow515,
        pow516,
        pow517,
        pow518,
        pow520,
        pow521,
        pow522,
        pow523,
        pow525,
        pow526,
        pow527,
        pow528,
        pow529,
        pow530,
        pow535,
        pow536,
        pow538,
        pow539,
        pow540,
        pow542,
        pow543,
        pow544,
        pow545,
        pow546,
        pow547,
        pow548,
        pow549,
        pow551,
        pow555,
        pow556,
        pow557,
        pow558,
        pow559,
        pow560,
        pow561,
        pow562,
        pow564,
        pow565,
        pow567,
        pow568,
        pow570,
        pow571,
        pow572,
        pow573,
        pow574,
        pow575,
        pow580,
        pow581,
        pow584,
        pow585,
        pow588,
        pow589,
        pow590,
        pow591,
        pow592,
        pow593,
        pow594,
        pow595,
        pow598,
        pow599,
        pow602,
        pow603,
        pow604,
        pow605,
        pow608,
        pow609,
        pow610,
        pow611,
        pow616,
        pow617,
        pow618,
        pow619,
        pow620,
        pow621,
        pow622,
        pow623,
        pow624,
        pow625,
        pow626,
        pow627,
        pow628,
        pow631,
        pow633,
        pow634,
        pow636,
        pow638,
        pow639,
        pow640,
        pow641,
        pow642,
        pow0,
        pow1,
        pow0,
        pow1,
        pow2,
        pow3,
        pow4,
        pow5,
        pow6,
        pow7,
        pow8,
        pow9,
        pow10,
        pow11,
        pow12,
        pow13,
        pow14,
        pow15,
        pow16,
        pow26,
        pow102,
        pow105,
        pow108,
        pow110,
        pow118,
        pow121,
        pow162,
        pow164,
        pow166,
        pow222,
        pow226,
        pow228,
        pow260,
        pow262,
        pow263,
        pow272,
        pow273,
        pow308,
        pow314,
        pow315,
        pow316,
        pow325,
        pow326,
        pow327,
        pow329,
        pow334,
        pow339,
        pow347,
        pow350,
        pow353,
        pow355,
        pow356,
        pow357,
        pow358,
        pow359,
        pow360,
        pow361,
        pow362,
        pow363,
        pow364,
        pow365,
        pow366,
        pow367,
        pow368,
        pow369,
        pow370,
        pow371,
        pow372,
        pow373,
        pow374,
        pow375,
        pow376,
        pow377,
        pow378,
        pow379,
        pow380,
        pow383,
        pow386,
        pow390,
        pow393,
        pow409,
        pow425,
        pow435,
        pow445,
        pow446,
        pow447,
        pow450,
        pow456,
        pow457,
        pow458,
        pow464,
        pow475,
        pow476,
        pow477,
        pow480,
        pow483,
        pow486,
        pow493,
        pow500,
        pow501,
        pow502,
        pow503,
        pow504,
        pow505,
        pow510,
        pow511,
        pow512,
        pow519,
        pow524,
        pow531,
        pow532,
        pow533,
        pow534,
        pow537,
        pow541,
        pow550,
        pow552,
        pow553,
        pow554,
        pow563,
        pow566,
        pow569,
        pow576,
        pow577,
        pow578,
        pow579,
        pow582,
        pow583,
        pow586,
        pow587,
        pow596,
        pow597,
        pow600,
        pow601,
        pow606,
        pow607,
        pow612,
        pow613,
        pow614,
        pow615,
        pow629,
        pow630,
        pow632,
        pow635,
        pow637,
        pow0,
        pow1,
        pow2,
        pow3,
        pow4,
        pow5,
        pow8,
        pow9,
        pow10,
        pow11,
        pow12,
        pow13,
        pow16,
        pow33,
        pow34,
        pow52,
        pow53,
        pow64,
        pow75,
        pow76,
        pow79,
        pow91,
        pow94,
        pow95,
        pow106,
        pow107,
        pow111,
        pow122,
        pow123,
        pow131,
        pow132,
        pow140,
        pow141,
        pow146,
        pow150,
        pow151,
        pow160,
        pow177,
        pow178,
        pow186,
        pow200,
        pow201,
        pow205,
        pow206,
        pow211,
        pow212,
        pow234,
        pow237,
        pow240,
        pow241,
        pow254,
        pow298,
        pow299,
        pow309,
        pow331,
        pow332,
        pow333,
        pow336,
        pow337,
        pow338,
        pow344,
        pow345,
        pow346,
        pow348,
        pow349,
        pow351,
        pow397,
        pow401,
        pow402,
        pow403,
        pow404,
        pow410,
        pow417,
        pow419,
        pow420,
        pow422,
        pow426,
        pow436,
        pow0,
        pow1,
        pow2,
        pow3,
        pow0,
        pow1,
        pow2,
        pow3,
        pow4,
        pow5,
        pow6,
        pow7,
        pow8,
        pow9,
        pow11,
        pow12,
        pow13,
        pow23,
        pow35,
        pow45,
        pow54,
        pow60,
        pow65,
        pow71,
        pow148,
        pow151,
        pow153,
        pow154,
        pow167,
        pow168,
        pow170,
        pow171,
        pow172,
        pow173,
        pow174,
        pow175,
        pow231,
        pow0,
        pow1,
        pow2,
        pow4,
        pow5,
        pow6,
        pow8,
        pow9,
        pow10,
        pow12,
        pow13,
        pow14,
        pow16,
        pow17,
        pow19,
        pow20,
        pow21,
        pow22,
        pow24,
        pow25,
        pow27,
        pow29,
        pow30,
        pow32,
        pow36,
        pow37,
        pow39,
        pow41,
        pow42,
        pow44,
        pow46,
        pow48,
        pow50,
        pow51,
        pow55,
        pow56,
        pow57,
        pow58,
        pow59,
        pow61,
        pow62,
        pow63,
        pow66,
        pow67,
        pow68,
        pow69,
        pow70,
        pow74,
        pow77,
        pow78,
        pow80,
        pow82,
        pow84,
        pow92,
        pow93,
        pow96,
        pow98,
        pow109,
        pow112,
        pow113,
        pow114,
        pow116,
        pow117,
        pow124,
        pow126,
        pow134,
        pow152,
        pow155,
        pow157,
        pow161,
        pow163,
        pow169,
        pow180,
        pow183,
        pow187,
        pow188,
        pow190,
        pow193,
        pow194,
        pow195,
        pow197,
        pow213,
        pow215,
        pow217,
        pow220,
        pow223,
        pow224,
        pow227,
        pow229,
        pow230,
        pow340,
        pow341,
        pow342,
        pow343,
        pow354,
        pow356,
        pow381,
        pow382,
        pow384,
        pow385,
        pow387,
        pow388,
        pow389,
        pow391,
        pow392,
        pow394,
        pow395,
        pow427,
        pow428,
        pow429,
        pow430,
        pow431,
        pow432,
        pow433,
        pow434,
        pow0,
        pow1,
        pow0,
        pow1,
        pow0,
        pow1,
        pow2,
        pow5
    ];

    let columns = array![
        column0,
        column0,
        column0,
        column0,
        column0,
        column0,
        column0,
        column0,
        column0,
        column0,
        column0,
        column0,
        column0,
        column0,
        column0,
        column0,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column1,
        column2,
        column2,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column3,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column4,
        column5,
        column5,
        column5,
        column5,
        column6,
        column6,
        column6,
        column6,
        column6,
        column6,
        column6,
        column6,
        column6,
        column6,
        column6,
        column6,
        column6,
        column6,
        column6,
        column6,
        column6,
        column6,
        column6,
        column6,
        column6,
        column6,
        column6,
        column6,
        column6,
        column6,
        column6,
        column6,
        column6,
        column6,
        column6,
        column6,
        column6,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column7,
        column8,
        column8,
        column9,
        column9,
        column10,
        column10,
        column10,
        column10,
    ];

    // Sum the OODS constraints on the trace polynomials.
    let mut value = 0;
    let mut total_sum = 0;

    let mut i = 0;
    loop {
        if i == 731 {
            break;
        }

        value = (*columns[i] - *oods_values[i]) / (point - *pows[i] * oods_point);
        total_sum = total_sum + *constraint_coefficients[i] * value;

        i += 1;
    };

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
