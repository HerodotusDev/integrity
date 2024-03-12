use cairo_verifier::{
    air::layouts::dex::{
        global_values::GlobalValues,
        constants::{CONSTRAINT_DEGREE, NUM_COLUMNS_FIRST, NUM_COLUMNS_SECOND, MASK_SIZE}
    },
    common::math::{Felt252Div, pow},
};

fn eval_composition_polynomial_inner(
    mask_values: Span<felt252>,
    constraint_coefficients: Span<felt252>,
    point: felt252,
    trace_generator: felt252,
    global_values: GlobalValues
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
    let pow16 = pow(trace_generator, 251 * global_values.trace_length / 256);
    let pow17 = pow(trace_generator, global_values.trace_length / 2);
    let pow18 = pow(trace_generator, 63 * global_values.trace_length / 64);
    let pow19 = pow(trace_generator, 255 * global_values.trace_length / 256);
    let pow20 = pow(trace_generator, 15 * global_values.trace_length / 16);

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
    let column1_row255 = *mask_values[18];
    let column1_row256 = *mask_values[19];
    let column1_row511 = *mask_values[20];
    let column2_row0 = *mask_values[21];
    let column2_row1 = *mask_values[22];
    let column2_row255 = *mask_values[23];
    let column2_row256 = *mask_values[24];
    let column3_row0 = *mask_values[25];
    let column3_row1 = *mask_values[26];
    let column3_row192 = *mask_values[27];
    let column3_row193 = *mask_values[28];
    let column3_row196 = *mask_values[29];
    let column3_row197 = *mask_values[30];
    let column3_row251 = *mask_values[31];
    let column3_row252 = *mask_values[32];
    let column3_row256 = *mask_values[33];
    let column4_row0 = *mask_values[34];
    let column4_row1 = *mask_values[35];
    let column4_row255 = *mask_values[36];
    let column4_row256 = *mask_values[37];
    let column4_row511 = *mask_values[38];
    let column5_row0 = *mask_values[39];
    let column5_row1 = *mask_values[40];
    let column5_row255 = *mask_values[41];
    let column5_row256 = *mask_values[42];
    let column6_row0 = *mask_values[43];
    let column6_row1 = *mask_values[44];
    let column6_row192 = *mask_values[45];
    let column6_row193 = *mask_values[46];
    let column6_row196 = *mask_values[47];
    let column6_row197 = *mask_values[48];
    let column6_row251 = *mask_values[49];
    let column6_row252 = *mask_values[50];
    let column6_row256 = *mask_values[51];
    let column7_row0 = *mask_values[52];
    let column7_row1 = *mask_values[53];
    let column7_row255 = *mask_values[54];
    let column7_row256 = *mask_values[55];
    let column7_row511 = *mask_values[56];
    let column8_row0 = *mask_values[57];
    let column8_row1 = *mask_values[58];
    let column8_row255 = *mask_values[59];
    let column8_row256 = *mask_values[60];
    let column9_row0 = *mask_values[61];
    let column9_row1 = *mask_values[62];
    let column9_row192 = *mask_values[63];
    let column9_row193 = *mask_values[64];
    let column9_row196 = *mask_values[65];
    let column9_row197 = *mask_values[66];
    let column9_row251 = *mask_values[67];
    let column9_row252 = *mask_values[68];
    let column9_row256 = *mask_values[69];
    let column10_row0 = *mask_values[70];
    let column10_row1 = *mask_values[71];
    let column10_row255 = *mask_values[72];
    let column10_row256 = *mask_values[73];
    let column10_row511 = *mask_values[74];
    let column11_row0 = *mask_values[75];
    let column11_row1 = *mask_values[76];
    let column11_row255 = *mask_values[77];
    let column11_row256 = *mask_values[78];
    let column12_row0 = *mask_values[79];
    let column12_row1 = *mask_values[80];
    let column12_row192 = *mask_values[81];
    let column12_row193 = *mask_values[82];
    let column12_row196 = *mask_values[83];
    let column12_row197 = *mask_values[84];
    let column12_row251 = *mask_values[85];
    let column12_row252 = *mask_values[86];
    let column12_row256 = *mask_values[87];
    let column13_row0 = *mask_values[88];
    let column13_row255 = *mask_values[89];
    let column14_row0 = *mask_values[90];
    let column14_row255 = *mask_values[91];
    let column15_row0 = *mask_values[92];
    let column15_row255 = *mask_values[93];
    let column16_row0 = *mask_values[94];
    let column16_row255 = *mask_values[95];
    let column17_row0 = *mask_values[96];
    let column17_row1 = *mask_values[97];
    let column17_row2 = *mask_values[98];
    let column17_row3 = *mask_values[99];
    let column17_row4 = *mask_values[100];
    let column17_row5 = *mask_values[101];
    let column17_row6 = *mask_values[102];
    let column17_row7 = *mask_values[103];
    let column17_row8 = *mask_values[104];
    let column17_row9 = *mask_values[105];
    let column17_row12 = *mask_values[106];
    let column17_row13 = *mask_values[107];
    let column17_row16 = *mask_values[108];
    let column17_row22 = *mask_values[109];
    let column17_row23 = *mask_values[110];
    let column17_row38 = *mask_values[111];
    let column17_row39 = *mask_values[112];
    let column17_row70 = *mask_values[113];
    let column17_row71 = *mask_values[114];
    let column17_row102 = *mask_values[115];
    let column17_row103 = *mask_values[116];
    let column17_row134 = *mask_values[117];
    let column17_row135 = *mask_values[118];
    let column17_row167 = *mask_values[119];
    let column17_row199 = *mask_values[120];
    let column17_row230 = *mask_values[121];
    let column17_row263 = *mask_values[122];
    let column17_row295 = *mask_values[123];
    let column17_row327 = *mask_values[124];
    let column17_row391 = *mask_values[125];
    let column17_row423 = *mask_values[126];
    let column17_row455 = *mask_values[127];
    let column17_row4118 = *mask_values[128];
    let column17_row4119 = *mask_values[129];
    let column17_row8214 = *mask_values[130];
    let column18_row0 = *mask_values[131];
    let column18_row1 = *mask_values[132];
    let column18_row2 = *mask_values[133];
    let column18_row3 = *mask_values[134];
    let column19_row0 = *mask_values[135];
    let column19_row1 = *mask_values[136];
    let column19_row2 = *mask_values[137];
    let column19_row3 = *mask_values[138];
    let column19_row4 = *mask_values[139];
    let column19_row5 = *mask_values[140];
    let column19_row6 = *mask_values[141];
    let column19_row7 = *mask_values[142];
    let column19_row8 = *mask_values[143];
    let column19_row9 = *mask_values[144];
    let column19_row11 = *mask_values[145];
    let column19_row12 = *mask_values[146];
    let column19_row13 = *mask_values[147];
    let column19_row15 = *mask_values[148];
    let column19_row17 = *mask_values[149];
    let column19_row23 = *mask_values[150];
    let column19_row25 = *mask_values[151];
    let column19_row28 = *mask_values[152];
    let column19_row31 = *mask_values[153];
    let column19_row44 = *mask_values[154];
    let column19_row60 = *mask_values[155];
    let column19_row76 = *mask_values[156];
    let column19_row92 = *mask_values[157];
    let column19_row108 = *mask_values[158];
    let column19_row124 = *mask_values[159];
    let column19_row4103 = *mask_values[160];
    let column19_row4111 = *mask_values[161];
    let column20_row0 = *mask_values[162];
    let column20_row1 = *mask_values[163];
    let column20_row2 = *mask_values[164];
    let column20_row4 = *mask_values[165];
    let column20_row6 = *mask_values[166];
    let column20_row8 = *mask_values[167];
    let column20_row10 = *mask_values[168];
    let column20_row12 = *mask_values[169];
    let column20_row14 = *mask_values[170];
    let column20_row16 = *mask_values[171];
    let column20_row17 = *mask_values[172];
    let column20_row20 = *mask_values[173];
    let column20_row22 = *mask_values[174];
    let column20_row24 = *mask_values[175];
    let column20_row30 = *mask_values[176];
    let column20_row38 = *mask_values[177];
    let column20_row46 = *mask_values[178];
    let column20_row54 = *mask_values[179];
    let column20_row81 = *mask_values[180];
    let column20_row145 = *mask_values[181];
    let column20_row209 = *mask_values[182];
    let column20_row4080 = *mask_values[183];
    let column20_row4082 = *mask_values[184];
    let column20_row4088 = *mask_values[185];
    let column20_row4090 = *mask_values[186];
    let column20_row4092 = *mask_values[187];
    let column20_row8161 = *mask_values[188];
    let column20_row8166 = *mask_values[189];
    let column20_row8176 = *mask_values[190];
    let column20_row8178 = *mask_values[191];
    let column20_row8182 = *mask_values[192];
    let column20_row8184 = *mask_values[193];
    let column20_row8186 = *mask_values[194];
    let column20_row8190 = *mask_values[195];
    let column21_inter1_row0 = *mask_values[196];
    let column21_inter1_row1 = *mask_values[197];
    let column21_inter1_row2 = *mask_values[198];
    let column21_inter1_row5 = *mask_values[199];

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
    let total_sum = total_sum + *constraint_coefficients[0] * value;

    // Constraint: cpu/decode/opcode_range_check/zero.
    let value = (column0_row0) / domain4;
    let total_sum = total_sum + *constraint_coefficients[1] * value;

    // Constraint: cpu/decode/opcode_range_check_input.
    let value = (column17_row1
        - (((column0_row0 * global_values.offset_size + column19_row4) * global_values.offset_size
            + column19_row8)
            * global_values.offset_size
            + column19_row0))
        / domain5;
    let total_sum = total_sum + *constraint_coefficients[2] * value;

    // Constraint: cpu/decode/flag_op1_base_op0_bit.
    let value = (cpu_decode_flag_op1_base_op0_0 * cpu_decode_flag_op1_base_op0_0
        - cpu_decode_flag_op1_base_op0_0)
        / domain5;
    let total_sum = total_sum + *constraint_coefficients[3] * value;

    // Constraint: cpu/decode/flag_res_op1_bit.
    let value = (cpu_decode_flag_res_op1_0 * cpu_decode_flag_res_op1_0 - cpu_decode_flag_res_op1_0)
        / domain5;
    let total_sum = total_sum + *constraint_coefficients[4] * value;

    // Constraint: cpu/decode/flag_pc_update_regular_bit.
    let value = (cpu_decode_flag_pc_update_regular_0 * cpu_decode_flag_pc_update_regular_0
        - cpu_decode_flag_pc_update_regular_0)
        / domain5;
    let total_sum = total_sum + *constraint_coefficients[5] * value;

    // Constraint: cpu/decode/fp_update_regular_bit.
    let value = (cpu_decode_fp_update_regular_0 * cpu_decode_fp_update_regular_0
        - cpu_decode_fp_update_regular_0)
        / domain5;
    let total_sum = total_sum + *constraint_coefficients[6] * value;

    // Constraint: cpu/operands/mem_dst_addr.
    let value = (column17_row8
        + global_values.half_offset_size
        - (cpu_decode_opcode_range_check_bit_0 * column19_row9
            + (1 - cpu_decode_opcode_range_check_bit_0) * column19_row1
            + column19_row0))
        / domain5;
    let total_sum = total_sum + *constraint_coefficients[7] * value;

    // Constraint: cpu/operands/mem0_addr.
    let value = (column17_row4
        + global_values.half_offset_size
        - (cpu_decode_opcode_range_check_bit_1 * column19_row9
            + (1 - cpu_decode_opcode_range_check_bit_1) * column19_row1
            + column19_row8))
        / domain5;
    let total_sum = total_sum + *constraint_coefficients[8] * value;

    // Constraint: cpu/operands/mem1_addr.
    let value = (column17_row12
        + global_values.half_offset_size
        - (cpu_decode_opcode_range_check_bit_2 * column17_row0
            + cpu_decode_opcode_range_check_bit_4 * column19_row1
            + cpu_decode_opcode_range_check_bit_3 * column19_row9
            + cpu_decode_flag_op1_base_op0_0 * column17_row5
            + column19_row4))
        / domain5;
    let total_sum = total_sum + *constraint_coefficients[9] * value;

    // Constraint: cpu/operands/ops_mul.
    let value = (column19_row5 - column17_row5 * column17_row13) / domain5;
    let total_sum = total_sum + *constraint_coefficients[10] * value;

    // Constraint: cpu/operands/res.
    let value = ((1 - cpu_decode_opcode_range_check_bit_9) * column19_row13
        - (cpu_decode_opcode_range_check_bit_5 * (column17_row5 + column17_row13)
            + cpu_decode_opcode_range_check_bit_6 * column19_row5
            + cpu_decode_flag_res_op1_0 * column17_row13))
        / domain5;
    let total_sum = total_sum + *constraint_coefficients[11] * value;

    // Constraint: cpu/update_registers/update_pc/tmp0.
    let value = (column19_row3 - cpu_decode_opcode_range_check_bit_9 * column17_row9)
        * domain19
        / domain5;
    let total_sum = total_sum + *constraint_coefficients[12] * value;

    // Constraint: cpu/update_registers/update_pc/tmp1.
    let value = (column19_row11 - column19_row3 * column19_row13) * domain19 / domain5;
    let total_sum = total_sum + *constraint_coefficients[13] * value;

    // Constraint: cpu/update_registers/update_pc/pc_cond_negative.
    let value = ((1 - cpu_decode_opcode_range_check_bit_9) * column17_row16
        + column19_row3 * (column17_row16 - (column17_row0 + column17_row13))
        - (cpu_decode_flag_pc_update_regular_0 * npc_reg_0
            + cpu_decode_opcode_range_check_bit_7 * column19_row13
            + cpu_decode_opcode_range_check_bit_8 * (column17_row0 + column19_row13)))
        * domain19
        / domain5;
    let total_sum = total_sum + *constraint_coefficients[14] * value;

    // Constraint: cpu/update_registers/update_pc/pc_cond_positive.
    let value = ((column19_row11 - cpu_decode_opcode_range_check_bit_9)
        * (column17_row16 - npc_reg_0))
        * domain19
        / domain5;
    let total_sum = total_sum + *constraint_coefficients[15] * value;

    // Constraint: cpu/update_registers/update_ap/ap_update.
    let value = (column19_row17
        - (column19_row1
            + cpu_decode_opcode_range_check_bit_10 * column19_row13
            + cpu_decode_opcode_range_check_bit_11
            + cpu_decode_opcode_range_check_bit_12 * 2))
        * domain19
        / domain5;
    let total_sum = total_sum + *constraint_coefficients[16] * value;

    // Constraint: cpu/update_registers/update_fp/fp_update.
    let value = (column19_row25
        - (cpu_decode_fp_update_regular_0 * column19_row9
            + cpu_decode_opcode_range_check_bit_13 * column17_row9
            + cpu_decode_opcode_range_check_bit_12 * (column19_row1 + 2)))
        * domain19
        / domain5;
    let total_sum = total_sum + *constraint_coefficients[17] * value;

    // Constraint: cpu/opcodes/call/push_fp.
    let value = (cpu_decode_opcode_range_check_bit_12 * (column17_row9 - column19_row9)) / domain5;
    let total_sum = total_sum + *constraint_coefficients[18] * value;

    // Constraint: cpu/opcodes/call/push_pc.
    let value = (cpu_decode_opcode_range_check_bit_12
        * (column17_row5 - (column17_row0 + cpu_decode_opcode_range_check_bit_2 + 1)))
        / domain5;
    let total_sum = total_sum + *constraint_coefficients[19] * value;

    // Constraint: cpu/opcodes/call/off0.
    let value = (cpu_decode_opcode_range_check_bit_12
        * (column19_row0 - global_values.half_offset_size))
        / domain5;
    let total_sum = total_sum + *constraint_coefficients[20] * value;

    // Constraint: cpu/opcodes/call/off1.
    let value = (cpu_decode_opcode_range_check_bit_12
        * (column19_row8 - (global_values.half_offset_size + 1)))
        / domain5;
    let total_sum = total_sum + *constraint_coefficients[21] * value;

    // Constraint: cpu/opcodes/call/flags.
    let value = (cpu_decode_opcode_range_check_bit_12
        * (cpu_decode_opcode_range_check_bit_12
            + cpu_decode_opcode_range_check_bit_12
            + 1
            + 1
            - (cpu_decode_opcode_range_check_bit_0 + cpu_decode_opcode_range_check_bit_1 + 4)))
        / domain5;
    let total_sum = total_sum + *constraint_coefficients[22] * value;

    // Constraint: cpu/opcodes/ret/off0.
    let value = (cpu_decode_opcode_range_check_bit_13
        * (column19_row0 + 2 - global_values.half_offset_size))
        / domain5;
    let total_sum = total_sum + *constraint_coefficients[23] * value;

    // Constraint: cpu/opcodes/ret/off2.
    let value = (cpu_decode_opcode_range_check_bit_13
        * (column19_row4 + 1 - global_values.half_offset_size))
        / domain5;
    let total_sum = total_sum + *constraint_coefficients[24] * value;

    // Constraint: cpu/opcodes/ret/flags.
    let value = (cpu_decode_opcode_range_check_bit_13
        * (cpu_decode_opcode_range_check_bit_7
            + cpu_decode_opcode_range_check_bit_0
            + cpu_decode_opcode_range_check_bit_3
            + cpu_decode_flag_res_op1_0
            - 4))
        / domain5;
    let total_sum = total_sum + *constraint_coefficients[25] * value;

    // Constraint: cpu/opcodes/assert_eq/assert_eq.
    let value = (cpu_decode_opcode_range_check_bit_14 * (column17_row9 - column19_row13)) / domain5;
    let total_sum = total_sum + *constraint_coefficients[26] * value;

    // Constraint: initial_ap.
    let value = (column19_row1 - global_values.initial_ap) / domain20;
    let total_sum = total_sum + *constraint_coefficients[27] * value;

    // Constraint: initial_fp.
    let value = (column19_row9 - global_values.initial_ap) / domain20;
    let total_sum = total_sum + *constraint_coefficients[28] * value;

    // Constraint: initial_pc.
    let value = (column17_row0 - global_values.initial_pc) / domain20;
    let total_sum = total_sum + *constraint_coefficients[29] * value;

    // Constraint: final_ap.
    let value = (column19_row1 - global_values.final_ap) / domain19;
    let total_sum = total_sum + *constraint_coefficients[30] * value;

    // Constraint: final_fp.
    let value = (column19_row9 - global_values.initial_ap) / domain19;
    let total_sum = total_sum + *constraint_coefficients[31] * value;

    // Constraint: final_pc.
    let value = (column17_row0 - global_values.final_pc) / domain19;
    let total_sum = total_sum + *constraint_coefficients[32] * value;

    // Constraint: memory/multi_column_perm/perm/init0.
    let value = ((global_values.memory_multi_column_perm_perm_interaction_elm
        - (column18_row0
            + global_values.memory_multi_column_perm_hash_interaction_elm0 * column18_row1))
        * column21_inter1_row0
        + column17_row0
        + global_values.memory_multi_column_perm_hash_interaction_elm0 * column17_row1
        - global_values.memory_multi_column_perm_perm_interaction_elm)
        / domain20;
    let total_sum = total_sum + *constraint_coefficients[33] * value;

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
    let total_sum = total_sum + *constraint_coefficients[34] * value;

    // Constraint: memory/multi_column_perm/perm/last.
    let value = (column21_inter1_row0
        - global_values.memory_multi_column_perm_perm_public_memory_prod)
        / domain21;
    let total_sum = total_sum + *constraint_coefficients[35] * value;

    // Constraint: memory/diff_is_bit.
    let value = (memory_address_diff_0 * memory_address_diff_0 - memory_address_diff_0)
        * domain21
        / domain1;
    let total_sum = total_sum + *constraint_coefficients[36] * value;

    // Constraint: memory/is_func.
    let value = ((memory_address_diff_0 - 1) * (column18_row1 - column18_row3))
        * domain21
        / domain1;
    let total_sum = total_sum + *constraint_coefficients[37] * value;

    // Constraint: memory/initial_addr.
    let value = (column18_row0 - 1) / domain20;
    let total_sum = total_sum + *constraint_coefficients[38] * value;

    // Constraint: public_memory_addr_zero.
    let value = (column17_row2) / domain3;
    let total_sum = total_sum + *constraint_coefficients[39] * value;

    // Constraint: public_memory_value_zero.
    let value = (column17_row3) / domain3;
    let total_sum = total_sum + *constraint_coefficients[40] * value;

    // Constraint: range_check16/perm/init0.
    let value = ((global_values.range_check16_perm_interaction_elm - column19_row2)
        * column21_inter1_row1
        + column19_row0
        - global_values.range_check16_perm_interaction_elm)
        / domain20;
    let total_sum = total_sum + *constraint_coefficients[41] * value;

    // Constraint: range_check16/perm/step0.
    let value = ((global_values.range_check16_perm_interaction_elm - column19_row6)
        * column21_inter1_row5
        - (global_values.range_check16_perm_interaction_elm - column19_row4) * column21_inter1_row1)
        * domain22
        / domain2;
    let total_sum = total_sum + *constraint_coefficients[42] * value;

    // Constraint: range_check16/perm/last.
    let value = (column21_inter1_row1 - global_values.range_check16_perm_public_memory_prod)
        / domain22;
    let total_sum = total_sum + *constraint_coefficients[43] * value;

    // Constraint: range_check16/diff_is_bit.
    let value = (range_check16_diff_0 * range_check16_diff_0 - range_check16_diff_0)
        * domain22
        / domain2;
    let total_sum = total_sum + *constraint_coefficients[44] * value;

    // Constraint: range_check16/minimum.
    let value = (column19_row2 - global_values.range_check_min) / domain20;
    let total_sum = total_sum + *constraint_coefficients[45] * value;

    // Constraint: range_check16/maximum.
    let value = (column19_row2 - global_values.range_check_max) / domain22;
    let total_sum = total_sum + *constraint_coefficients[46] * value;

    // Constraint: pedersen/hash0/ec_subset_sum/bit_unpacking/last_one_is_zero.
    let value = (column14_row255 * (column3_row0 - (column3_row1 + column3_row1))) / domain8;
    let total_sum = total_sum + *constraint_coefficients[47] * value;

    // Constraint: pedersen/hash0/ec_subset_sum/bit_unpacking/zeroes_between_ones0.
    let value = (column14_row255
        * (column3_row1
            - 3138550867693340381917894711603833208051177722232017256448 * column3_row192))
        / domain8;
    let total_sum = total_sum + *constraint_coefficients[48] * value;

    // Constraint: pedersen/hash0/ec_subset_sum/bit_unpacking/cumulative_bit192.
    let value = (column14_row255
        - column13_row255 * (column3_row192 - (column3_row193 + column3_row193)))
        / domain8;
    let total_sum = total_sum + *constraint_coefficients[49] * value;

    // Constraint: pedersen/hash0/ec_subset_sum/bit_unpacking/zeroes_between_ones192.
    let value = (column13_row255 * (column3_row193 - 8 * column3_row196)) / domain8;
    let total_sum = total_sum + *constraint_coefficients[50] * value;

    // Constraint: pedersen/hash0/ec_subset_sum/bit_unpacking/cumulative_bit196.
    let value = (column13_row255
        - (column3_row251 - (column3_row252 + column3_row252))
            * (column3_row196 - (column3_row197 + column3_row197)))
        / domain8;
    let total_sum = total_sum + *constraint_coefficients[51] * value;

    // Constraint: pedersen/hash0/ec_subset_sum/bit_unpacking/zeroes_between_ones196.
    let value = ((column3_row251 - (column3_row252 + column3_row252))
        * (column3_row197 - 18014398509481984 * column3_row251))
        / domain8;
    let total_sum = total_sum + *constraint_coefficients[52] * value;

    // Constraint: pedersen/hash0/ec_subset_sum/booleanity_test.
    let value = (pedersen_hash0_ec_subset_sum_bit_0 * (pedersen_hash0_ec_subset_sum_bit_0 - 1))
        * domain9
        / domain0;
    let total_sum = total_sum + *constraint_coefficients[53] * value;

    // Constraint: pedersen/hash0/ec_subset_sum/bit_extraction_end.
    let value = (column3_row0) / domain10;
    let total_sum = total_sum + *constraint_coefficients[54] * value;

    // Constraint: pedersen/hash0/ec_subset_sum/zeros_tail.
    let value = (column3_row0) / domain9;
    let total_sum = total_sum + *constraint_coefficients[55] * value;

    // Constraint: pedersen/hash0/ec_subset_sum/add_points/slope.
    let value = (pedersen_hash0_ec_subset_sum_bit_0
        * (column2_row0 - global_values.pedersen_points_y)
        - column13_row0 * (column1_row0 - global_values.pedersen_points_x))
        * domain9
        / domain0;
    let total_sum = total_sum + *constraint_coefficients[56] * value;

    // Constraint: pedersen/hash0/ec_subset_sum/add_points/x.
    let value = (column13_row0 * column13_row0
        - pedersen_hash0_ec_subset_sum_bit_0
            * (column1_row0 + global_values.pedersen_points_x + column1_row1))
        * domain9
        / domain0;
    let total_sum = total_sum + *constraint_coefficients[57] * value;

    // Constraint: pedersen/hash0/ec_subset_sum/add_points/y.
    let value = (pedersen_hash0_ec_subset_sum_bit_0 * (column2_row0 + column2_row1)
        - column13_row0 * (column1_row0 - column1_row1))
        * domain9
        / domain0;
    let total_sum = total_sum + *constraint_coefficients[58] * value;

    // Constraint: pedersen/hash0/ec_subset_sum/copy_point/x.
    let value = (pedersen_hash0_ec_subset_sum_bit_neg_0 * (column1_row1 - column1_row0))
        * domain9
        / domain0;
    let total_sum = total_sum + *constraint_coefficients[59] * value;

    // Constraint: pedersen/hash0/ec_subset_sum/copy_point/y.
    let value = (pedersen_hash0_ec_subset_sum_bit_neg_0 * (column2_row1 - column2_row0))
        * domain9
        / domain0;
    let total_sum = total_sum + *constraint_coefficients[60] * value;

    // Constraint: pedersen/hash0/copy_point/x.
    let value = (column1_row256 - column1_row255) * domain11 / domain8;
    let total_sum = total_sum + *constraint_coefficients[61] * value;

    // Constraint: pedersen/hash0/copy_point/y.
    let value = (column2_row256 - column2_row255) * domain11 / domain8;
    let total_sum = total_sum + *constraint_coefficients[62] * value;

    // Constraint: pedersen/hash0/init/x.
    let value = (column1_row0 - global_values.pedersen_shift_point.x) / domain12;
    let total_sum = total_sum + *constraint_coefficients[63] * value;

    // Constraint: pedersen/hash0/init/y.
    let value = (column2_row0 - global_values.pedersen_shift_point.y) / domain12;
    let total_sum = total_sum + *constraint_coefficients[64] * value;

    // Constraint: pedersen/hash1/ec_subset_sum/bit_unpacking/last_one_is_zero.
    let value = (column16_row255 * (column6_row0 - (column6_row1 + column6_row1))) / domain8;
    let total_sum = total_sum + *constraint_coefficients[65] * value;

    // Constraint: pedersen/hash1/ec_subset_sum/bit_unpacking/zeroes_between_ones0.
    let value = (column16_row255
        * (column6_row1
            - 3138550867693340381917894711603833208051177722232017256448 * column6_row192))
        / domain8;
    let total_sum = total_sum + *constraint_coefficients[66] * value;

    // Constraint: pedersen/hash1/ec_subset_sum/bit_unpacking/cumulative_bit192.
    let value = (column16_row255
        - column15_row255 * (column6_row192 - (column6_row193 + column6_row193)))
        / domain8;
    let total_sum = total_sum + *constraint_coefficients[67] * value;

    // Constraint: pedersen/hash1/ec_subset_sum/bit_unpacking/zeroes_between_ones192.
    let value = (column15_row255 * (column6_row193 - 8 * column6_row196)) / domain8;
    let total_sum = total_sum + *constraint_coefficients[68] * value;

    // Constraint: pedersen/hash1/ec_subset_sum/bit_unpacking/cumulative_bit196.
    let value = (column15_row255
        - (column6_row251 - (column6_row252 + column6_row252))
            * (column6_row196 - (column6_row197 + column6_row197)))
        / domain8;
    let total_sum = total_sum + *constraint_coefficients[69] * value;

    // Constraint: pedersen/hash1/ec_subset_sum/bit_unpacking/zeroes_between_ones196.
    let value = ((column6_row251 - (column6_row252 + column6_row252))
        * (column6_row197 - 18014398509481984 * column6_row251))
        / domain8;
    let total_sum = total_sum + *constraint_coefficients[70] * value;

    // Constraint: pedersen/hash1/ec_subset_sum/booleanity_test.
    let value = (pedersen_hash1_ec_subset_sum_bit_0 * (pedersen_hash1_ec_subset_sum_bit_0 - 1))
        * domain9
        / domain0;
    let total_sum = total_sum + *constraint_coefficients[71] * value;

    // Constraint: pedersen/hash1/ec_subset_sum/bit_extraction_end.
    let value = (column6_row0) / domain10;
    let total_sum = total_sum + *constraint_coefficients[72] * value;

    // Constraint: pedersen/hash1/ec_subset_sum/zeros_tail.
    let value = (column6_row0) / domain9;
    let total_sum = total_sum + *constraint_coefficients[73] * value;

    // Constraint: pedersen/hash1/ec_subset_sum/add_points/slope.
    let value = (pedersen_hash1_ec_subset_sum_bit_0
        * (column5_row0 - global_values.pedersen_points_y)
        - column14_row0 * (column4_row0 - global_values.pedersen_points_x))
        * domain9
        / domain0;
    let total_sum = total_sum + *constraint_coefficients[74] * value;

    // Constraint: pedersen/hash1/ec_subset_sum/add_points/x.
    let value = (column14_row0 * column14_row0
        - pedersen_hash1_ec_subset_sum_bit_0
            * (column4_row0 + global_values.pedersen_points_x + column4_row1))
        * domain9
        / domain0;
    let total_sum = total_sum + *constraint_coefficients[75] * value;

    // Constraint: pedersen/hash1/ec_subset_sum/add_points/y.
    let value = (pedersen_hash1_ec_subset_sum_bit_0 * (column5_row0 + column5_row1)
        - column14_row0 * (column4_row0 - column4_row1))
        * domain9
        / domain0;
    let total_sum = total_sum + *constraint_coefficients[76] * value;

    // Constraint: pedersen/hash1/ec_subset_sum/copy_point/x.
    let value = (pedersen_hash1_ec_subset_sum_bit_neg_0 * (column4_row1 - column4_row0))
        * domain9
        / domain0;
    let total_sum = total_sum + *constraint_coefficients[77] * value;

    // Constraint: pedersen/hash1/ec_subset_sum/copy_point/y.
    let value = (pedersen_hash1_ec_subset_sum_bit_neg_0 * (column5_row1 - column5_row0))
        * domain9
        / domain0;
    let total_sum = total_sum + *constraint_coefficients[78] * value;

    // Constraint: pedersen/hash1/copy_point/x.
    let value = (column4_row256 - column4_row255) * domain11 / domain8;
    let total_sum = total_sum + *constraint_coefficients[79] * value;

    // Constraint: pedersen/hash1/copy_point/y.
    let value = (column5_row256 - column5_row255) * domain11 / domain8;
    let total_sum = total_sum + *constraint_coefficients[80] * value;

    // Constraint: pedersen/hash1/init/x.
    let value = (column4_row0 - global_values.pedersen_shift_point.x) / domain12;
    let total_sum = total_sum + *constraint_coefficients[81] * value;

    // Constraint: pedersen/hash1/init/y.
    let value = (column5_row0 - global_values.pedersen_shift_point.y) / domain12;
    let total_sum = total_sum + *constraint_coefficients[82] * value;

    // Constraint: pedersen/hash2/ec_subset_sum/bit_unpacking/last_one_is_zero.
    let value = (column20_row145 * (column9_row0 - (column9_row1 + column9_row1))) / domain8;
    let total_sum = total_sum + *constraint_coefficients[83] * value;

    // Constraint: pedersen/hash2/ec_subset_sum/bit_unpacking/zeroes_between_ones0.
    let value = (column20_row145
        * (column9_row1
            - 3138550867693340381917894711603833208051177722232017256448 * column9_row192))
        / domain8;
    let total_sum = total_sum + *constraint_coefficients[84] * value;

    // Constraint: pedersen/hash2/ec_subset_sum/bit_unpacking/cumulative_bit192.
    let value = (column20_row145
        - column20_row17 * (column9_row192 - (column9_row193 + column9_row193)))
        / domain8;
    let total_sum = total_sum + *constraint_coefficients[85] * value;

    // Constraint: pedersen/hash2/ec_subset_sum/bit_unpacking/zeroes_between_ones192.
    let value = (column20_row17 * (column9_row193 - 8 * column9_row196)) / domain8;
    let total_sum = total_sum + *constraint_coefficients[86] * value;

    // Constraint: pedersen/hash2/ec_subset_sum/bit_unpacking/cumulative_bit196.
    let value = (column20_row17
        - (column9_row251 - (column9_row252 + column9_row252))
            * (column9_row196 - (column9_row197 + column9_row197)))
        / domain8;
    let total_sum = total_sum + *constraint_coefficients[87] * value;

    // Constraint: pedersen/hash2/ec_subset_sum/bit_unpacking/zeroes_between_ones196.
    let value = ((column9_row251 - (column9_row252 + column9_row252))
        * (column9_row197 - 18014398509481984 * column9_row251))
        / domain8;
    let total_sum = total_sum + *constraint_coefficients[88] * value;

    // Constraint: pedersen/hash2/ec_subset_sum/booleanity_test.
    let value = (pedersen_hash2_ec_subset_sum_bit_0 * (pedersen_hash2_ec_subset_sum_bit_0 - 1))
        * domain9
        / domain0;
    let total_sum = total_sum + *constraint_coefficients[89] * value;

    // Constraint: pedersen/hash2/ec_subset_sum/bit_extraction_end.
    let value = (column9_row0) / domain10;
    let total_sum = total_sum + *constraint_coefficients[90] * value;

    // Constraint: pedersen/hash2/ec_subset_sum/zeros_tail.
    let value = (column9_row0) / domain9;
    let total_sum = total_sum + *constraint_coefficients[91] * value;

    // Constraint: pedersen/hash2/ec_subset_sum/add_points/slope.
    let value = (pedersen_hash2_ec_subset_sum_bit_0
        * (column8_row0 - global_values.pedersen_points_y)
        - column15_row0 * (column7_row0 - global_values.pedersen_points_x))
        * domain9
        / domain0;
    let total_sum = total_sum + *constraint_coefficients[92] * value;

    // Constraint: pedersen/hash2/ec_subset_sum/add_points/x.
    let value = (column15_row0 * column15_row0
        - pedersen_hash2_ec_subset_sum_bit_0
            * (column7_row0 + global_values.pedersen_points_x + column7_row1))
        * domain9
        / domain0;
    let total_sum = total_sum + *constraint_coefficients[93] * value;

    // Constraint: pedersen/hash2/ec_subset_sum/add_points/y.
    let value = (pedersen_hash2_ec_subset_sum_bit_0 * (column8_row0 + column8_row1)
        - column15_row0 * (column7_row0 - column7_row1))
        * domain9
        / domain0;
    let total_sum = total_sum + *constraint_coefficients[94] * value;

    // Constraint: pedersen/hash2/ec_subset_sum/copy_point/x.
    let value = (pedersen_hash2_ec_subset_sum_bit_neg_0 * (column7_row1 - column7_row0))
        * domain9
        / domain0;
    let total_sum = total_sum + *constraint_coefficients[95] * value;

    // Constraint: pedersen/hash2/ec_subset_sum/copy_point/y.
    let value = (pedersen_hash2_ec_subset_sum_bit_neg_0 * (column8_row1 - column8_row0))
        * domain9
        / domain0;
    let total_sum = total_sum + *constraint_coefficients[96] * value;

    // Constraint: pedersen/hash2/copy_point/x.
    let value = (column7_row256 - column7_row255) * domain11 / domain8;
    let total_sum = total_sum + *constraint_coefficients[97] * value;

    // Constraint: pedersen/hash2/copy_point/y.
    let value = (column8_row256 - column8_row255) * domain11 / domain8;
    let total_sum = total_sum + *constraint_coefficients[98] * value;

    // Constraint: pedersen/hash2/init/x.
    let value = (column7_row0 - global_values.pedersen_shift_point.x) / domain12;
    let total_sum = total_sum + *constraint_coefficients[99] * value;

    // Constraint: pedersen/hash2/init/y.
    let value = (column8_row0 - global_values.pedersen_shift_point.y) / domain12;
    let total_sum = total_sum + *constraint_coefficients[100] * value;

    // Constraint: pedersen/hash3/ec_subset_sum/bit_unpacking/last_one_is_zero.
    let value = (column20_row209 * (column12_row0 - (column12_row1 + column12_row1))) / domain8;
    let total_sum = total_sum + *constraint_coefficients[101] * value;

    // Constraint: pedersen/hash3/ec_subset_sum/bit_unpacking/zeroes_between_ones0.
    let value = (column20_row209
        * (column12_row1
            - 3138550867693340381917894711603833208051177722232017256448 * column12_row192))
        / domain8;
    let total_sum = total_sum + *constraint_coefficients[102] * value;

    // Constraint: pedersen/hash3/ec_subset_sum/bit_unpacking/cumulative_bit192.
    let value = (column20_row209
        - column20_row81 * (column12_row192 - (column12_row193 + column12_row193)))
        / domain8;
    let total_sum = total_sum + *constraint_coefficients[103] * value;

    // Constraint: pedersen/hash3/ec_subset_sum/bit_unpacking/zeroes_between_ones192.
    let value = (column20_row81 * (column12_row193 - 8 * column12_row196)) / domain8;
    let total_sum = total_sum + *constraint_coefficients[104] * value;

    // Constraint: pedersen/hash3/ec_subset_sum/bit_unpacking/cumulative_bit196.
    let value = (column20_row81
        - (column12_row251 - (column12_row252 + column12_row252))
            * (column12_row196 - (column12_row197 + column12_row197)))
        / domain8;
    let total_sum = total_sum + *constraint_coefficients[105] * value;

    // Constraint: pedersen/hash3/ec_subset_sum/bit_unpacking/zeroes_between_ones196.
    let value = ((column12_row251 - (column12_row252 + column12_row252))
        * (column12_row197 - 18014398509481984 * column12_row251))
        / domain8;
    let total_sum = total_sum + *constraint_coefficients[106] * value;

    // Constraint: pedersen/hash3/ec_subset_sum/booleanity_test.
    let value = (pedersen_hash3_ec_subset_sum_bit_0 * (pedersen_hash3_ec_subset_sum_bit_0 - 1))
        * domain9
        / domain0;
    let total_sum = total_sum + *constraint_coefficients[107] * value;

    // Constraint: pedersen/hash3/ec_subset_sum/bit_extraction_end.
    let value = (column12_row0) / domain10;
    let total_sum = total_sum + *constraint_coefficients[108] * value;

    // Constraint: pedersen/hash3/ec_subset_sum/zeros_tail.
    let value = (column12_row0) / domain9;
    let total_sum = total_sum + *constraint_coefficients[109] * value;

    // Constraint: pedersen/hash3/ec_subset_sum/add_points/slope.
    let value = (pedersen_hash3_ec_subset_sum_bit_0
        * (column11_row0 - global_values.pedersen_points_y)
        - column16_row0 * (column10_row0 - global_values.pedersen_points_x))
        * domain9
        / domain0;
    let total_sum = total_sum + *constraint_coefficients[110] * value;

    // Constraint: pedersen/hash3/ec_subset_sum/add_points/x.
    let value = (column16_row0 * column16_row0
        - pedersen_hash3_ec_subset_sum_bit_0
            * (column10_row0 + global_values.pedersen_points_x + column10_row1))
        * domain9
        / domain0;
    let total_sum = total_sum + *constraint_coefficients[111] * value;

    // Constraint: pedersen/hash3/ec_subset_sum/add_points/y.
    let value = (pedersen_hash3_ec_subset_sum_bit_0 * (column11_row0 + column11_row1)
        - column16_row0 * (column10_row0 - column10_row1))
        * domain9
        / domain0;
    let total_sum = total_sum + *constraint_coefficients[112] * value;

    // Constraint: pedersen/hash3/ec_subset_sum/copy_point/x.
    let value = (pedersen_hash3_ec_subset_sum_bit_neg_0 * (column10_row1 - column10_row0))
        * domain9
        / domain0;
    let total_sum = total_sum + *constraint_coefficients[113] * value;

    // Constraint: pedersen/hash3/ec_subset_sum/copy_point/y.
    let value = (pedersen_hash3_ec_subset_sum_bit_neg_0 * (column11_row1 - column11_row0))
        * domain9
        / domain0;
    let total_sum = total_sum + *constraint_coefficients[114] * value;

    // Constraint: pedersen/hash3/copy_point/x.
    let value = (column10_row256 - column10_row255) * domain11 / domain8;
    let total_sum = total_sum + *constraint_coefficients[115] * value;

    // Constraint: pedersen/hash3/copy_point/y.
    let value = (column11_row256 - column11_row255) * domain11 / domain8;
    let total_sum = total_sum + *constraint_coefficients[116] * value;

    // Constraint: pedersen/hash3/init/x.
    let value = (column10_row0 - global_values.pedersen_shift_point.x) / domain12;
    let total_sum = total_sum + *constraint_coefficients[117] * value;

    // Constraint: pedersen/hash3/init/y.
    let value = (column11_row0 - global_values.pedersen_shift_point.y) / domain12;
    let total_sum = total_sum + *constraint_coefficients[118] * value;

    // Constraint: pedersen/input0_value0.
    let value = (column17_row7 - column3_row0) / domain12;
    let total_sum = total_sum + *constraint_coefficients[119] * value;

    // Constraint: pedersen/input0_value1.
    let value = (column17_row135 - column6_row0) / domain12;
    let total_sum = total_sum + *constraint_coefficients[120] * value;

    // Constraint: pedersen/input0_value2.
    let value = (column17_row263 - column9_row0) / domain12;
    let total_sum = total_sum + *constraint_coefficients[121] * value;

    // Constraint: pedersen/input0_value3.
    let value = (column17_row391 - column12_row0) / domain12;
    let total_sum = total_sum + *constraint_coefficients[122] * value;

    // Constraint: pedersen/input0_addr.
    let value = (column17_row134 - (column17_row38 + 1)) * domain23 / domain7;
    let total_sum = total_sum + *constraint_coefficients[123] * value;

    // Constraint: pedersen/init_addr.
    let value = (column17_row6 - global_values.initial_pedersen_addr) / domain20;
    let total_sum = total_sum + *constraint_coefficients[124] * value;

    // Constraint: pedersen/input1_value0.
    let value = (column17_row71 - column3_row256) / domain12;
    let total_sum = total_sum + *constraint_coefficients[125] * value;

    // Constraint: pedersen/input1_value1.
    let value = (column17_row199 - column6_row256) / domain12;
    let total_sum = total_sum + *constraint_coefficients[126] * value;

    // Constraint: pedersen/input1_value2.
    let value = (column17_row327 - column9_row256) / domain12;
    let total_sum = total_sum + *constraint_coefficients[127] * value;

    // Constraint: pedersen/input1_value3.
    let value = (column17_row455 - column12_row256) / domain12;
    let total_sum = total_sum + *constraint_coefficients[128] * value;

    // Constraint: pedersen/input1_addr.
    let value = (column17_row70 - (column17_row6 + 1)) / domain7;
    let total_sum = total_sum + *constraint_coefficients[129] * value;

    // Constraint: pedersen/output_value0.
    let value = (column17_row39 - column1_row511) / domain12;
    let total_sum = total_sum + *constraint_coefficients[130] * value;

    // Constraint: pedersen/output_value1.
    let value = (column17_row167 - column4_row511) / domain12;
    let total_sum = total_sum + *constraint_coefficients[131] * value;

    // Constraint: pedersen/output_value2.
    let value = (column17_row295 - column7_row511) / domain12;
    let total_sum = total_sum + *constraint_coefficients[132] * value;

    // Constraint: pedersen/output_value3.
    let value = (column17_row423 - column10_row511) / domain12;
    let total_sum = total_sum + *constraint_coefficients[133] * value;

    // Constraint: pedersen/output_addr.
    let value = (column17_row38 - (column17_row70 + 1)) / domain7;
    let total_sum = total_sum + *constraint_coefficients[134] * value;

    // Constraint: range_check_builtin/value.
    let value = (range_check_builtin_value7_0 - column17_row103) / domain7;
    let total_sum = total_sum + *constraint_coefficients[135] * value;

    // Constraint: range_check_builtin/addr_step.
    let value = (column17_row230 - (column17_row102 + 1)) * domain23 / domain7;
    let total_sum = total_sum + *constraint_coefficients[136] * value;

    // Constraint: range_check_builtin/init_addr.
    let value = (column17_row102 - global_values.initial_range_check_addr) / domain20;
    let total_sum = total_sum + *constraint_coefficients[137] * value;

    // Constraint: ecdsa/signature0/doubling_key/slope.
    let value = (ecdsa_signature0_doubling_key_x_squared
        + ecdsa_signature0_doubling_key_x_squared
        + ecdsa_signature0_doubling_key_x_squared
        + global_values.ecdsa_sig_config.alpha
        - (column19_row15 + column19_row15) * column20_row12)
        * domain13
        / domain5;
    let total_sum = total_sum + *constraint_coefficients[138] * value;

    // Constraint: ecdsa/signature0/doubling_key/x.
    let value = (column20_row12 * column20_row12 - (column19_row7 + column19_row7 + column19_row23))
        * domain13
        / domain5;
    let total_sum = total_sum + *constraint_coefficients[139] * value;

    // Constraint: ecdsa/signature0/doubling_key/y.
    let value = (column19_row15
        + column19_row31
        - column20_row12 * (column19_row7 - column19_row23))
        * domain13
        / domain5;
    let total_sum = total_sum + *constraint_coefficients[140] * value;

    // Constraint: ecdsa/signature0/exponentiate_generator/booleanity_test.
    let value = (ecdsa_signature0_exponentiate_generator_bit_0
        * (ecdsa_signature0_exponentiate_generator_bit_0 - 1))
        * domain16
        / domain6;
    let total_sum = total_sum + *constraint_coefficients[141] * value;

    // Constraint: ecdsa/signature0/exponentiate_generator/bit_extraction_end.
    let value = (column20_row14) / domain17;
    let total_sum = total_sum + *constraint_coefficients[142] * value;

    // Constraint: ecdsa/signature0/exponentiate_generator/zeros_tail.
    let value = (column20_row14) / domain16;
    let total_sum = total_sum + *constraint_coefficients[143] * value;

    // Constraint: ecdsa/signature0/exponentiate_generator/add_points/slope.
    let value = (ecdsa_signature0_exponentiate_generator_bit_0
        * (column20_row22 - global_values.ecdsa_generator_points_y)
        - column20_row30 * (column20_row6 - global_values.ecdsa_generator_points_x))
        * domain16
        / domain6;
    let total_sum = total_sum + *constraint_coefficients[144] * value;

    // Constraint: ecdsa/signature0/exponentiate_generator/add_points/x.
    let value = (column20_row30 * column20_row30
        - ecdsa_signature0_exponentiate_generator_bit_0
            * (column20_row6 + global_values.ecdsa_generator_points_x + column20_row38))
        * domain16
        / domain6;
    let total_sum = total_sum + *constraint_coefficients[145] * value;

    // Constraint: ecdsa/signature0/exponentiate_generator/add_points/y.
    let value = (ecdsa_signature0_exponentiate_generator_bit_0 * (column20_row22 + column20_row54)
        - column20_row30 * (column20_row6 - column20_row38))
        * domain16
        / domain6;
    let total_sum = total_sum + *constraint_coefficients[146] * value;

    // Constraint: ecdsa/signature0/exponentiate_generator/add_points/x_diff_inv.
    let value = (column20_row1 * (column20_row6 - global_values.ecdsa_generator_points_x) - 1)
        * domain16
        / domain6;
    let total_sum = total_sum + *constraint_coefficients[147] * value;

    // Constraint: ecdsa/signature0/exponentiate_generator/copy_point/x.
    let value = (ecdsa_signature0_exponentiate_generator_bit_neg_0
        * (column20_row38 - column20_row6))
        * domain16
        / domain6;
    let total_sum = total_sum + *constraint_coefficients[148] * value;

    // Constraint: ecdsa/signature0/exponentiate_generator/copy_point/y.
    let value = (ecdsa_signature0_exponentiate_generator_bit_neg_0
        * (column20_row54 - column20_row22))
        * domain16
        / domain6;
    let total_sum = total_sum + *constraint_coefficients[149] * value;

    // Constraint: ecdsa/signature0/exponentiate_key/booleanity_test.
    let value = (ecdsa_signature0_exponentiate_key_bit_0
        * (ecdsa_signature0_exponentiate_key_bit_0 - 1))
        * domain13
        / domain5;
    let total_sum = total_sum + *constraint_coefficients[150] * value;

    // Constraint: ecdsa/signature0/exponentiate_key/bit_extraction_end.
    let value = (column20_row4) / domain14;
    let total_sum = total_sum + *constraint_coefficients[151] * value;

    // Constraint: ecdsa/signature0/exponentiate_key/zeros_tail.
    let value = (column20_row4) / domain13;
    let total_sum = total_sum + *constraint_coefficients[152] * value;

    // Constraint: ecdsa/signature0/exponentiate_key/add_points/slope.
    let value = (ecdsa_signature0_exponentiate_key_bit_0 * (column20_row8 - column19_row15)
        - column20_row2 * (column20_row0 - column19_row7))
        * domain13
        / domain5;
    let total_sum = total_sum + *constraint_coefficients[153] * value;

    // Constraint: ecdsa/signature0/exponentiate_key/add_points/x.
    let value = (column20_row2 * column20_row2
        - ecdsa_signature0_exponentiate_key_bit_0
            * (column20_row0 + column19_row7 + column20_row16))
        * domain13
        / domain5;
    let total_sum = total_sum + *constraint_coefficients[154] * value;

    // Constraint: ecdsa/signature0/exponentiate_key/add_points/y.
    let value = (ecdsa_signature0_exponentiate_key_bit_0 * (column20_row8 + column20_row24)
        - column20_row2 * (column20_row0 - column20_row16))
        * domain13
        / domain5;
    let total_sum = total_sum + *constraint_coefficients[155] * value;

    // Constraint: ecdsa/signature0/exponentiate_key/add_points/x_diff_inv.
    let value = (column20_row10 * (column20_row0 - column19_row7) - 1) * domain13 / domain5;
    let total_sum = total_sum + *constraint_coefficients[156] * value;

    // Constraint: ecdsa/signature0/exponentiate_key/copy_point/x.
    let value = (ecdsa_signature0_exponentiate_key_bit_neg_0 * (column20_row16 - column20_row0))
        * domain13
        / domain5;
    let total_sum = total_sum + *constraint_coefficients[157] * value;

    // Constraint: ecdsa/signature0/exponentiate_key/copy_point/y.
    let value = (ecdsa_signature0_exponentiate_key_bit_neg_0 * (column20_row24 - column20_row8))
        * domain13
        / domain5;
    let total_sum = total_sum + *constraint_coefficients[158] * value;

    // Constraint: ecdsa/signature0/init_gen/x.
    let value = (column20_row6 - global_values.ecdsa_sig_config.shift_point.x) / domain18;
    let total_sum = total_sum + *constraint_coefficients[159] * value;

    // Constraint: ecdsa/signature0/init_gen/y.
    let value = (column20_row22 + global_values.ecdsa_sig_config.shift_point.y) / domain18;
    let total_sum = total_sum + *constraint_coefficients[160] * value;

    // Constraint: ecdsa/signature0/init_key/x.
    let value = (column20_row0 - global_values.ecdsa_sig_config.shift_point.x) / domain15;
    let total_sum = total_sum + *constraint_coefficients[161] * value;

    // Constraint: ecdsa/signature0/init_key/y.
    let value = (column20_row8 - global_values.ecdsa_sig_config.shift_point.y) / domain15;
    let total_sum = total_sum + *constraint_coefficients[162] * value;

    // Constraint: ecdsa/signature0/add_results/slope.
    let value = (column20_row8182
        - (column20_row4088 + column20_row8190 * (column20_row8166 - column20_row4080)))
        / domain18;
    let total_sum = total_sum + *constraint_coefficients[163] * value;

    // Constraint: ecdsa/signature0/add_results/x.
    let value = (column20_row8190 * column20_row8190
        - (column20_row8166 + column20_row4080 + column19_row4103))
        / domain18;
    let total_sum = total_sum + *constraint_coefficients[164] * value;

    // Constraint: ecdsa/signature0/add_results/y.
    let value = (column20_row8182
        + column19_row4111
        - column20_row8190 * (column20_row8166 - column19_row4103))
        / domain18;
    let total_sum = total_sum + *constraint_coefficients[165] * value;

    // Constraint: ecdsa/signature0/add_results/x_diff_inv.
    let value = (column20_row8161 * (column20_row8166 - column20_row4080) - 1) / domain18;
    let total_sum = total_sum + *constraint_coefficients[166] * value;

    // Constraint: ecdsa/signature0/extract_r/slope.
    let value = (column20_row8184
        + global_values.ecdsa_sig_config.shift_point.y
        - column20_row4082 * (column20_row8176 - global_values.ecdsa_sig_config.shift_point.x))
        / domain18;
    let total_sum = total_sum + *constraint_coefficients[167] * value;

    // Constraint: ecdsa/signature0/extract_r/x.
    let value = (column20_row4082 * column20_row4082
        - (column20_row8176 + global_values.ecdsa_sig_config.shift_point.x + column20_row4))
        / domain18;
    let total_sum = total_sum + *constraint_coefficients[168] * value;

    // Constraint: ecdsa/signature0/extract_r/x_diff_inv.
    let value = (column20_row8178
        * (column20_row8176 - global_values.ecdsa_sig_config.shift_point.x)
        - 1)
        / domain18;
    let total_sum = total_sum + *constraint_coefficients[169] * value;

    // Constraint: ecdsa/signature0/z_nonzero.
    let value = (column20_row14 * column20_row4090 - 1) / domain18;
    let total_sum = total_sum + *constraint_coefficients[170] * value;

    // Constraint: ecdsa/signature0/r_and_w_nonzero.
    let value = (column20_row4 * column20_row4092 - 1) / domain15;
    let total_sum = total_sum + *constraint_coefficients[171] * value;

    // Constraint: ecdsa/signature0/q_on_curve/x_squared.
    let value = (column20_row8186 - column19_row7 * column19_row7) / domain18;
    let total_sum = total_sum + *constraint_coefficients[172] * value;

    // Constraint: ecdsa/signature0/q_on_curve/on_curve.
    let value = (column19_row15 * column19_row15
        - (column19_row7 * column20_row8186
            + global_values.ecdsa_sig_config.alpha * column19_row7
            + global_values.ecdsa_sig_config.beta))
        / domain18;
    let total_sum = total_sum + *constraint_coefficients[173] * value;

    // Constraint: ecdsa/init_addr.
    let value = (column17_row22 - global_values.initial_ecdsa_addr) / domain20;
    let total_sum = total_sum + *constraint_coefficients[174] * value;

    // Constraint: ecdsa/message_addr.
    let value = (column17_row4118 - (column17_row22 + 1)) / domain18;
    let total_sum = total_sum + *constraint_coefficients[175] * value;

    // Constraint: ecdsa/pubkey_addr.
    let value = (column17_row8214 - (column17_row4118 + 1)) * domain24 / domain18;
    let total_sum = total_sum + *constraint_coefficients[176] * value;

    // Constraint: ecdsa/message_value0.
    let value = (column17_row4119 - column20_row14) / domain18;
    let total_sum = total_sum + *constraint_coefficients[177] * value;

    // Constraint: ecdsa/pubkey_value0.
    let value = (column17_row23 - column19_row7) / domain18;
    let total_sum = total_sum + *constraint_coefficients[178] * value;

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
    let column11 = *column_values[11];
    let column12 = *column_values[12];
    let column13 = *column_values[13];
    let column14 = *column_values[14];
    let column15 = *column_values[15];
    let column16 = *column_values[16];
    let column17 = *column_values[17];
    let column18 = *column_values[18];
    let column19 = *column_values[19];
    let column20 = *column_values[20];
    let column21 = *column_values[21];

    // Sum the OODS constraints on the trace polynomials.
    let total_sum = 0;

    let value = (column0 - *oods_values[0]) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[0] * value;

    let value = (column0 - *oods_values[1]) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[1] * value;

    let value = (column0 - *oods_values[2]) / (point - pow4 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[2] * value;

    let value = (column0 - *oods_values[3]) / (point - pow6 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[3] * value;

    let value = (column0 - *oods_values[4]) / (point - pow7 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[4] * value;

    let value = (column0 - *oods_values[5]) / (point - pow8 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[5] * value;

    let value = (column0 - *oods_values[6]) / (point - pow10 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[6] * value;

    let value = (column0 - *oods_values[7]) / (point - pow11 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[7] * value;

    let value = (column0 - *oods_values[8]) / (point - pow12 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[8] * value;

    let value = (column0 - *oods_values[9]) / (point - pow14 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[9] * value;

    let value = (column0 - *oods_values[10]) / (point - pow15 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[10] * value;

    let value = (column0 - *oods_values[11]) / (point - pow17 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[11] * value;

    let value = (column0 - *oods_values[12]) / (point - pow18 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[12] * value;

    let value = (column0 - *oods_values[13]) / (point - pow19 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[13] * value;

    let value = (column0 - *oods_values[14]) / (point - pow20 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[14] * value;

    let value = (column0 - *oods_values[15]) / (point - pow21 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[15] * value;

    let value = (column1 - *oods_values[16]) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[16] * value;

    let value = (column1 - *oods_values[17]) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[17] * value;

    let value = (column1 - *oods_values[18]) / (point - pow72 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[18] * value;

    let value = (column1 - *oods_values[19]) / (point - pow73 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[19] * value;

    let value = (column1 - *oods_values[20]) / (point - pow74 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[20] * value;

    let value = (column2 - *oods_values[21]) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[21] * value;

    let value = (column2 - *oods_values[22]) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[22] * value;

    let value = (column2 - *oods_values[23]) / (point - pow72 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[23] * value;

    let value = (column2 - *oods_values[24]) / (point - pow73 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[24] * value;

    let value = (column3 - *oods_values[25]) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[25] * value;

    let value = (column3 - *oods_values[26]) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[26] * value;

    let value = (column3 - *oods_values[27]) / (point - pow53 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[27] * value;

    let value = (column3 - *oods_values[28]) / (point - pow54 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[28] * value;

    let value = (column3 - *oods_values[29]) / (point - pow55 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[29] * value;

    let value = (column3 - *oods_values[30]) / (point - pow56 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[30] * value;

    let value = (column3 - *oods_values[31]) / (point - pow57 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[31] * value;

    let value = (column3 - *oods_values[32]) / (point - pow60 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[32] * value;

    let value = (column3 - *oods_values[33]) / (point - pow73 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[33] * value;

    let value = (column4 - *oods_values[34]) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[34] * value;

    let value = (column4 - *oods_values[35]) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[35] * value;

    let value = (column4 - *oods_values[36]) / (point - pow72 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[36] * value;

    let value = (column4 - *oods_values[37]) / (point - pow73 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[37] * value;

    let value = (column4 - *oods_values[38]) / (point - pow74 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[38] * value;

    let value = (column5 - *oods_values[39]) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[39] * value;

    let value = (column5 - *oods_values[40]) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[40] * value;

    let value = (column5 - *oods_values[41]) / (point - pow72 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[41] * value;

    let value = (column5 - *oods_values[42]) / (point - pow73 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[42] * value;

    let value = (column6 - *oods_values[43]) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[43] * value;

    let value = (column6 - *oods_values[44]) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[44] * value;

    let value = (column6 - *oods_values[45]) / (point - pow53 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[45] * value;

    let value = (column6 - *oods_values[46]) / (point - pow54 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[46] * value;

    let value = (column6 - *oods_values[47]) / (point - pow55 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[47] * value;

    let value = (column6 - *oods_values[48]) / (point - pow56 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[48] * value;

    let value = (column6 - *oods_values[49]) / (point - pow57 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[49] * value;

    let value = (column6 - *oods_values[50]) / (point - pow60 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[50] * value;

    let value = (column6 - *oods_values[51]) / (point - pow73 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[51] * value;

    let value = (column7 - *oods_values[52]) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[52] * value;

    let value = (column7 - *oods_values[53]) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[53] * value;

    let value = (column7 - *oods_values[54]) / (point - pow72 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[54] * value;

    let value = (column7 - *oods_values[55]) / (point - pow73 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[55] * value;

    let value = (column7 - *oods_values[56]) / (point - pow74 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[56] * value;

    let value = (column8 - *oods_values[57]) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[57] * value;

    let value = (column8 - *oods_values[58]) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[58] * value;

    let value = (column8 - *oods_values[59]) / (point - pow72 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[59] * value;

    let value = (column8 - *oods_values[60]) / (point - pow73 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[60] * value;

    let value = (column9 - *oods_values[61]) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[61] * value;

    let value = (column9 - *oods_values[62]) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[62] * value;

    let value = (column9 - *oods_values[63]) / (point - pow53 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[63] * value;

    let value = (column9 - *oods_values[64]) / (point - pow54 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[64] * value;

    let value = (column9 - *oods_values[65]) / (point - pow55 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[65] * value;

    let value = (column9 - *oods_values[66]) / (point - pow56 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[66] * value;

    let value = (column9 - *oods_values[67]) / (point - pow57 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[67] * value;

    let value = (column9 - *oods_values[68]) / (point - pow60 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[68] * value;

    let value = (column9 - *oods_values[69]) / (point - pow73 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[69] * value;

    let value = (column10 - *oods_values[70]) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[70] * value;

    let value = (column10 - *oods_values[71]) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[71] * value;

    let value = (column10 - *oods_values[72]) / (point - pow72 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[72] * value;

    let value = (column10 - *oods_values[73]) / (point - pow73 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[73] * value;

    let value = (column10 - *oods_values[74]) / (point - pow74 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[74] * value;

    let value = (column11 - *oods_values[75]) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[75] * value;

    let value = (column11 - *oods_values[76]) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[76] * value;

    let value = (column11 - *oods_values[77]) / (point - pow72 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[77] * value;

    let value = (column11 - *oods_values[78]) / (point - pow73 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[78] * value;

    let value = (column12 - *oods_values[79]) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[79] * value;

    let value = (column12 - *oods_values[80]) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[80] * value;

    let value = (column12 - *oods_values[81]) / (point - pow53 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[81] * value;

    let value = (column12 - *oods_values[82]) / (point - pow54 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[82] * value;

    let value = (column12 - *oods_values[83]) / (point - pow55 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[83] * value;

    let value = (column12 - *oods_values[84]) / (point - pow56 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[84] * value;

    let value = (column12 - *oods_values[85]) / (point - pow57 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[85] * value;

    let value = (column12 - *oods_values[86]) / (point - pow60 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[86] * value;

    let value = (column12 - *oods_values[87]) / (point - pow73 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[87] * value;

    let value = (column13 - *oods_values[88]) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[88] * value;

    let value = (column13 - *oods_values[89]) / (point - pow72 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[89] * value;

    let value = (column14 - *oods_values[90]) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[90] * value;

    let value = (column14 - *oods_values[91]) / (point - pow72 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[91] * value;

    let value = (column15 - *oods_values[92]) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[92] * value;

    let value = (column15 - *oods_values[93]) / (point - pow72 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[93] * value;

    let value = (column16 - *oods_values[94]) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[94] * value;

    let value = (column16 - *oods_values[95]) / (point - pow72 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[95] * value;

    let value = (column17 - *oods_values[96]) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[96] * value;

    let value = (column17 - *oods_values[97]) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[97] * value;

    let value = (column17 - *oods_values[98]) / (point - pow4 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[98] * value;

    let value = (column17 - *oods_values[99]) / (point - pow6 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[99] * value;

    let value = (column17 - *oods_values[100]) / (point - pow7 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[100] * value;

    let value = (column17 - *oods_values[101]) / (point - pow8 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[101] * value;

    let value = (column17 - *oods_values[102]) / (point - pow10 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[102] * value;

    let value = (column17 - *oods_values[103]) / (point - pow11 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[103] * value;

    let value = (column17 - *oods_values[104]) / (point - pow12 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[104] * value;

    let value = (column17 - *oods_values[105]) / (point - pow14 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[105] * value;

    let value = (column17 - *oods_values[106]) / (point - pow18 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[106] * value;

    let value = (column17 - *oods_values[107]) / (point - pow19 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[107] * value;

    let value = (column17 - *oods_values[108]) / (point - pow22 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[108] * value;

    let value = (column17 - *oods_values[109]) / (point - pow25 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[109] * value;

    let value = (column17 - *oods_values[110]) / (point - pow26 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[110] * value;

    let value = (column17 - *oods_values[111]) / (point - pow34 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[111] * value;

    let value = (column17 - *oods_values[112]) / (point - pow35 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[112] * value;

    let value = (column17 - *oods_values[113]) / (point - pow40 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[113] * value;

    let value = (column17 - *oods_values[114]) / (point - pow41 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[114] * value;

    let value = (column17 - *oods_values[115]) / (point - pow45 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[115] * value;

    let value = (column17 - *oods_values[116]) / (point - pow46 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[116] * value;

    let value = (column17 - *oods_values[117]) / (point - pow49 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[117] * value;

    let value = (column17 - *oods_values[118]) / (point - pow50 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[118] * value;

    let value = (column17 - *oods_values[119]) / (point - pow52 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[119] * value;

    let value = (column17 - *oods_values[120]) / (point - pow58 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[120] * value;

    let value = (column17 - *oods_values[121]) / (point - pow59 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[121] * value;

    let value = (column17 - *oods_values[122]) / (point - pow79 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[122] * value;

    let value = (column17 - *oods_values[123]) / (point - pow78 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[123] * value;

    let value = (column17 - *oods_values[124]) / (point - pow77 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[124] * value;

    let value = (column17 - *oods_values[125]) / (point - pow76 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[125] * value;

    let value = (column17 - *oods_values[126]) / (point - pow75 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[126] * value;

    let value = (column17 - *oods_values[127]) / (point - pow80 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[127] * value;

    let value = (column17 - *oods_values[128]) / (point - pow69 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[128] * value;

    let value = (column17 - *oods_values[129]) / (point - pow70 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[129] * value;

    let value = (column17 - *oods_values[130]) / (point - pow68 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[130] * value;

    let value = (column18 - *oods_values[131]) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[131] * value;

    let value = (column18 - *oods_values[132]) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[132] * value;

    let value = (column18 - *oods_values[133]) / (point - pow4 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[133] * value;

    let value = (column18 - *oods_values[134]) / (point - pow6 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[134] * value;

    let value = (column19 - *oods_values[135]) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[135] * value;

    let value = (column19 - *oods_values[136]) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[136] * value;

    let value = (column19 - *oods_values[137]) / (point - pow4 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[137] * value;

    let value = (column19 - *oods_values[138]) / (point - pow6 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[138] * value;

    let value = (column19 - *oods_values[139]) / (point - pow7 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[139] * value;

    let value = (column19 - *oods_values[140]) / (point - pow8 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[140] * value;

    let value = (column19 - *oods_values[141]) / (point - pow10 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[141] * value;

    let value = (column19 - *oods_values[142]) / (point - pow11 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[142] * value;

    let value = (column19 - *oods_values[143]) / (point - pow12 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[143] * value;

    let value = (column19 - *oods_values[144]) / (point - pow14 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[144] * value;

    let value = (column19 - *oods_values[145]) / (point - pow17 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[145] * value;

    let value = (column19 - *oods_values[146]) / (point - pow18 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[146] * value;

    let value = (column19 - *oods_values[147]) / (point - pow19 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[147] * value;

    let value = (column19 - *oods_values[148]) / (point - pow21 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[148] * value;

    let value = (column19 - *oods_values[149]) / (point - pow23 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[149] * value;

    let value = (column19 - *oods_values[150]) / (point - pow26 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[150] * value;

    let value = (column19 - *oods_values[151]) / (point - pow28 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[151] * value;

    let value = (column19 - *oods_values[152]) / (point - pow29 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[152] * value;

    let value = (column19 - *oods_values[153]) / (point - pow31 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[153] * value;

    let value = (column19 - *oods_values[154]) / (point - pow36 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[154] * value;

    let value = (column19 - *oods_values[155]) / (point - pow39 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[155] * value;

    let value = (column19 - *oods_values[156]) / (point - pow42 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[156] * value;

    let value = (column19 - *oods_values[157]) / (point - pow44 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[157] * value;

    let value = (column19 - *oods_values[158]) / (point - pow47 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[158] * value;

    let value = (column19 - *oods_values[159]) / (point - pow48 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[159] * value;

    let value = (column19 - *oods_values[160]) / (point - pow66 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[160] * value;

    let value = (column19 - *oods_values[161]) / (point - pow67 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[161] * value;

    let value = (column20 - *oods_values[162]) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[162] * value;

    let value = (column20 - *oods_values[163]) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[163] * value;

    let value = (column20 - *oods_values[164]) / (point - pow4 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[164] * value;

    let value = (column20 - *oods_values[165]) / (point - pow7 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[165] * value;

    let value = (column20 - *oods_values[166]) / (point - pow10 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[166] * value;

    let value = (column20 - *oods_values[167]) / (point - pow12 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[167] * value;

    let value = (column20 - *oods_values[168]) / (point - pow15 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[168] * value;

    let value = (column20 - *oods_values[169]) / (point - pow18 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[169] * value;

    let value = (column20 - *oods_values[170]) / (point - pow20 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[170] * value;

    let value = (column20 - *oods_values[171]) / (point - pow22 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[171] * value;

    let value = (column20 - *oods_values[172]) / (point - pow23 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[172] * value;

    let value = (column20 - *oods_values[173]) / (point - pow24 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[173] * value;

    let value = (column20 - *oods_values[174]) / (point - pow25 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[174] * value;

    let value = (column20 - *oods_values[175]) / (point - pow27 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[175] * value;

    let value = (column20 - *oods_values[176]) / (point - pow30 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[176] * value;

    let value = (column20 - *oods_values[177]) / (point - pow34 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[177] * value;

    let value = (column20 - *oods_values[178]) / (point - pow37 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[178] * value;

    let value = (column20 - *oods_values[179]) / (point - pow38 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[179] * value;

    let value = (column20 - *oods_values[180]) / (point - pow43 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[180] * value;

    let value = (column20 - *oods_values[181]) / (point - pow51 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[181] * value;

    let value = (column20 - *oods_values[182]) / (point - pow71 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[182] * value;

    let value = (column20 - *oods_values[183]) / (point - pow2 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[183] * value;

    let value = (column20 - *oods_values[184]) / (point - pow5 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[184] * value;

    let value = (column20 - *oods_values[185]) / (point - pow13 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[185] * value;

    let value = (column20 - *oods_values[186]) / (point - pow16 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[186] * value;

    let value = (column20 - *oods_values[187]) / (point - pow61 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[187] * value;

    let value = (column20 - *oods_values[188]) / (point - pow1 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[188] * value;

    let value = (column20 - *oods_values[189]) / (point - pow9 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[189] * value;

    let value = (column20 - *oods_values[190]) / (point - pow32 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[190] * value;

    let value = (column20 - *oods_values[191]) / (point - pow33 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[191] * value;

    let value = (column20 - *oods_values[192]) / (point - pow62 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[192] * value;

    let value = (column20 - *oods_values[193]) / (point - pow63 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[193] * value;

    let value = (column20 - *oods_values[194]) / (point - pow64 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[194] * value;

    let value = (column20 - *oods_values[195]) / (point - pow65 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[195] * value;

    let value = (column21 - *oods_values[196]) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[196] * value;

    let value = (column21 - *oods_values[197]) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[197] * value;

    let value = (column21 - *oods_values[198]) / (point - pow4 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[198] * value;

    let value = (column21 - *oods_values[199]) / (point - pow8 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[199] * value;

    // Sum the OODS boundary constraints on the composition polynomials.
    let oods_point_to_deg = pow(oods_point, CONSTRAINT_DEGREE.into());

    let value = (*column_values[NUM_COLUMNS_FIRST + NUM_COLUMNS_SECOND] - *oods_values[200])
        / (point - oods_point_to_deg);
    let total_sum = total_sum + *constraint_coefficients[200] * value;

    let value = (*column_values[NUM_COLUMNS_FIRST + NUM_COLUMNS_SECOND + 1] - *oods_values[201])
        / (point - oods_point_to_deg);
    let total_sum = total_sum + *constraint_coefficients[201] * value;

    assert(202 == MASK_SIZE + CONSTRAINT_DEGREE, 'Invalid value');
    total_sum
}
