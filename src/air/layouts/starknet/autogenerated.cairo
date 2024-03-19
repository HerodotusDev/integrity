use cairo_verifier::{
    air::layouts::starknet::{
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
    let pow21 = pow(trace_generator, 251 * global_values.trace_length / 256);
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
    let column4_row255 = *mask_values[35];
    let column5_row0 = *mask_values[36];
    let column5_row1 = *mask_values[37];
    let column5_row2 = *mask_values[38];
    let column5_row3 = *mask_values[39];
    let column5_row4 = *mask_values[40];
    let column5_row5 = *mask_values[41];
    let column5_row6 = *mask_values[42];
    let column5_row7 = *mask_values[43];
    let column5_row8 = *mask_values[44];
    let column5_row9 = *mask_values[45];
    let column5_row12 = *mask_values[46];
    let column5_row13 = *mask_values[47];
    let column5_row16 = *mask_values[48];
    let column5_row38 = *mask_values[49];
    let column5_row39 = *mask_values[50];
    let column5_row70 = *mask_values[51];
    let column5_row71 = *mask_values[52];
    let column5_row102 = *mask_values[53];
    let column5_row103 = *mask_values[54];
    let column5_row134 = *mask_values[55];
    let column5_row135 = *mask_values[56];
    let column5_row166 = *mask_values[57];
    let column5_row167 = *mask_values[58];
    let column5_row198 = *mask_values[59];
    let column5_row199 = *mask_values[60];
    let column5_row262 = *mask_values[61];
    let column5_row263 = *mask_values[62];
    let column5_row294 = *mask_values[63];
    let column5_row295 = *mask_values[64];
    let column5_row326 = *mask_values[65];
    let column5_row358 = *mask_values[66];
    let column5_row359 = *mask_values[67];
    let column5_row390 = *mask_values[68];
    let column5_row391 = *mask_values[69];
    let column5_row422 = *mask_values[70];
    let column5_row423 = *mask_values[71];
    let column5_row454 = *mask_values[72];
    let column5_row518 = *mask_values[73];
    let column5_row711 = *mask_values[74];
    let column5_row902 = *mask_values[75];
    let column5_row903 = *mask_values[76];
    let column5_row966 = *mask_values[77];
    let column5_row967 = *mask_values[78];
    let column5_row1222 = *mask_values[79];
    let column5_row2438 = *mask_values[80];
    let column5_row2439 = *mask_values[81];
    let column5_row4486 = *mask_values[82];
    let column5_row4487 = *mask_values[83];
    let column5_row6534 = *mask_values[84];
    let column5_row6535 = *mask_values[85];
    let column5_row8582 = *mask_values[86];
    let column5_row8583 = *mask_values[87];
    let column5_row10630 = *mask_values[88];
    let column5_row10631 = *mask_values[89];
    let column5_row12678 = *mask_values[90];
    let column5_row12679 = *mask_values[91];
    let column5_row14726 = *mask_values[92];
    let column5_row14727 = *mask_values[93];
    let column5_row16774 = *mask_values[94];
    let column5_row16775 = *mask_values[95];
    let column5_row24966 = *mask_values[96];
    let column5_row33158 = *mask_values[97];
    let column6_row0 = *mask_values[98];
    let column6_row1 = *mask_values[99];
    let column6_row2 = *mask_values[100];
    let column6_row3 = *mask_values[101];
    let column7_row0 = *mask_values[102];
    let column7_row1 = *mask_values[103];
    let column7_row2 = *mask_values[104];
    let column7_row3 = *mask_values[105];
    let column7_row4 = *mask_values[106];
    let column7_row5 = *mask_values[107];
    let column7_row6 = *mask_values[108];
    let column7_row7 = *mask_values[109];
    let column7_row8 = *mask_values[110];
    let column7_row9 = *mask_values[111];
    let column7_row11 = *mask_values[112];
    let column7_row12 = *mask_values[113];
    let column7_row13 = *mask_values[114];
    let column7_row15 = *mask_values[115];
    let column7_row17 = *mask_values[116];
    let column7_row19 = *mask_values[117];
    let column7_row23 = *mask_values[118];
    let column7_row27 = *mask_values[119];
    let column7_row33 = *mask_values[120];
    let column7_row44 = *mask_values[121];
    let column7_row49 = *mask_values[122];
    let column7_row65 = *mask_values[123];
    let column7_row76 = *mask_values[124];
    let column7_row81 = *mask_values[125];
    let column7_row97 = *mask_values[126];
    let column7_row108 = *mask_values[127];
    let column7_row113 = *mask_values[128];
    let column7_row129 = *mask_values[129];
    let column7_row140 = *mask_values[130];
    let column7_row145 = *mask_values[131];
    let column7_row161 = *mask_values[132];
    let column7_row172 = *mask_values[133];
    let column7_row177 = *mask_values[134];
    let column7_row193 = *mask_values[135];
    let column7_row204 = *mask_values[136];
    let column7_row209 = *mask_values[137];
    let column7_row225 = *mask_values[138];
    let column7_row236 = *mask_values[139];
    let column7_row241 = *mask_values[140];
    let column7_row257 = *mask_values[141];
    let column7_row265 = *mask_values[142];
    let column7_row491 = *mask_values[143];
    let column7_row499 = *mask_values[144];
    let column7_row507 = *mask_values[145];
    let column7_row513 = *mask_values[146];
    let column7_row521 = *mask_values[147];
    let column7_row705 = *mask_values[148];
    let column7_row721 = *mask_values[149];
    let column7_row737 = *mask_values[150];
    let column7_row753 = *mask_values[151];
    let column7_row769 = *mask_values[152];
    let column7_row777 = *mask_values[153];
    let column7_row961 = *mask_values[154];
    let column7_row977 = *mask_values[155];
    let column7_row993 = *mask_values[156];
    let column7_row1009 = *mask_values[157];
    let column8_row0 = *mask_values[158];
    let column8_row1 = *mask_values[159];
    let column8_row2 = *mask_values[160];
    let column8_row3 = *mask_values[161];
    let column8_row4 = *mask_values[162];
    let column8_row5 = *mask_values[163];
    let column8_row6 = *mask_values[164];
    let column8_row7 = *mask_values[165];
    let column8_row8 = *mask_values[166];
    let column8_row9 = *mask_values[167];
    let column8_row10 = *mask_values[168];
    let column8_row11 = *mask_values[169];
    let column8_row12 = *mask_values[170];
    let column8_row13 = *mask_values[171];
    let column8_row14 = *mask_values[172];
    let column8_row16 = *mask_values[173];
    let column8_row17 = *mask_values[174];
    let column8_row19 = *mask_values[175];
    let column8_row21 = *mask_values[176];
    let column8_row22 = *mask_values[177];
    let column8_row24 = *mask_values[178];
    let column8_row25 = *mask_values[179];
    let column8_row27 = *mask_values[180];
    let column8_row29 = *mask_values[181];
    let column8_row30 = *mask_values[182];
    let column8_row33 = *mask_values[183];
    let column8_row35 = *mask_values[184];
    let column8_row37 = *mask_values[185];
    let column8_row38 = *mask_values[186];
    let column8_row41 = *mask_values[187];
    let column8_row43 = *mask_values[188];
    let column8_row45 = *mask_values[189];
    let column8_row46 = *mask_values[190];
    let column8_row49 = *mask_values[191];
    let column8_row51 = *mask_values[192];
    let column8_row53 = *mask_values[193];
    let column8_row54 = *mask_values[194];
    let column8_row57 = *mask_values[195];
    let column8_row59 = *mask_values[196];
    let column8_row61 = *mask_values[197];
    let column8_row65 = *mask_values[198];
    let column8_row69 = *mask_values[199];
    let column8_row71 = *mask_values[200];
    let column8_row73 = *mask_values[201];
    let column8_row77 = *mask_values[202];
    let column8_row81 = *mask_values[203];
    let column8_row85 = *mask_values[204];
    let column8_row89 = *mask_values[205];
    let column8_row91 = *mask_values[206];
    let column8_row97 = *mask_values[207];
    let column8_row101 = *mask_values[208];
    let column8_row105 = *mask_values[209];
    let column8_row109 = *mask_values[210];
    let column8_row113 = *mask_values[211];
    let column8_row117 = *mask_values[212];
    let column8_row123 = *mask_values[213];
    let column8_row155 = *mask_values[214];
    let column8_row187 = *mask_values[215];
    let column8_row195 = *mask_values[216];
    let column8_row205 = *mask_values[217];
    let column8_row219 = *mask_values[218];
    let column8_row221 = *mask_values[219];
    let column8_row237 = *mask_values[220];
    let column8_row245 = *mask_values[221];
    let column8_row253 = *mask_values[222];
    let column8_row269 = *mask_values[223];
    let column8_row301 = *mask_values[224];
    let column8_row309 = *mask_values[225];
    let column8_row310 = *mask_values[226];
    let column8_row318 = *mask_values[227];
    let column8_row326 = *mask_values[228];
    let column8_row334 = *mask_values[229];
    let column8_row342 = *mask_values[230];
    let column8_row350 = *mask_values[231];
    let column8_row451 = *mask_values[232];
    let column8_row461 = *mask_values[233];
    let column8_row477 = *mask_values[234];
    let column8_row493 = *mask_values[235];
    let column8_row501 = *mask_values[236];
    let column8_row509 = *mask_values[237];
    let column8_row12309 = *mask_values[238];
    let column8_row12373 = *mask_values[239];
    let column8_row12565 = *mask_values[240];
    let column8_row12629 = *mask_values[241];
    let column8_row16085 = *mask_values[242];
    let column8_row16149 = *mask_values[243];
    let column8_row16325 = *mask_values[244];
    let column8_row16331 = *mask_values[245];
    let column8_row16337 = *mask_values[246];
    let column8_row16339 = *mask_values[247];
    let column8_row16355 = *mask_values[248];
    let column8_row16357 = *mask_values[249];
    let column8_row16363 = *mask_values[250];
    let column8_row16369 = *mask_values[251];
    let column8_row16371 = *mask_values[252];
    let column8_row16385 = *mask_values[253];
    let column8_row16417 = *mask_values[254];
    let column8_row32647 = *mask_values[255];
    let column8_row32667 = *mask_values[256];
    let column8_row32715 = *mask_values[257];
    let column8_row32721 = *mask_values[258];
    let column8_row32731 = *mask_values[259];
    let column8_row32747 = *mask_values[260];
    let column8_row32753 = *mask_values[261];
    let column8_row32763 = *mask_values[262];
    let column9_inter1_row0 = *mask_values[263];
    let column9_inter1_row1 = *mask_values[264];
    let column9_inter1_row2 = *mask_values[265];
    let column9_inter1_row3 = *mask_values[266];
    let column9_inter1_row5 = *mask_values[267];
    let column9_inter1_row7 = *mask_values[268];
    let column9_inter1_row11 = *mask_values[269];
    let column9_inter1_row15 = *mask_values[270];

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
    let value = (column5_row1
        - (((column0_row0 * global_values.offset_size + column7_row4) * global_values.offset_size
            + column7_row8)
            * global_values.offset_size
            + column7_row0))
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
    let value = (column5_row8
        + global_values.half_offset_size
        - (cpu_decode_opcode_range_check_bit_0 * column8_row8
            + (1 - cpu_decode_opcode_range_check_bit_0) * column8_row0
            + column7_row0))
        / domain5;
    let total_sum = total_sum + *constraint_coefficients[7] * value;

    // Constraint: cpu/operands/mem0_addr.
    let value = (column5_row4
        + global_values.half_offset_size
        - (cpu_decode_opcode_range_check_bit_1 * column8_row8
            + (1 - cpu_decode_opcode_range_check_bit_1) * column8_row0
            + column7_row8))
        / domain5;
    let total_sum = total_sum + *constraint_coefficients[8] * value;

    // Constraint: cpu/operands/mem1_addr.
    let value = (column5_row12
        + global_values.half_offset_size
        - (cpu_decode_opcode_range_check_bit_2 * column5_row0
            + cpu_decode_opcode_range_check_bit_4 * column8_row0
            + cpu_decode_opcode_range_check_bit_3 * column8_row8
            + cpu_decode_flag_op1_base_op0_0 * column5_row5
            + column7_row4))
        / domain5;
    let total_sum = total_sum + *constraint_coefficients[9] * value;

    // Constraint: cpu/operands/ops_mul.
    let value = (column8_row4 - column5_row5 * column5_row13) / domain5;
    let total_sum = total_sum + *constraint_coefficients[10] * value;

    // Constraint: cpu/operands/res.
    let value = ((1 - cpu_decode_opcode_range_check_bit_9) * column8_row12
        - (cpu_decode_opcode_range_check_bit_5 * (column5_row5 + column5_row13)
            + cpu_decode_opcode_range_check_bit_6 * column8_row4
            + cpu_decode_flag_res_op1_0 * column5_row13))
        / domain5;
    let total_sum = total_sum + *constraint_coefficients[11] * value;

    // Constraint: cpu/update_registers/update_pc/tmp0.
    let value = (column8_row2 - cpu_decode_opcode_range_check_bit_9 * column5_row9)
        * domain28
        / domain5;
    let total_sum = total_sum + *constraint_coefficients[12] * value;

    // Constraint: cpu/update_registers/update_pc/tmp1.
    let value = (column8_row10 - column8_row2 * column8_row12) * domain28 / domain5;
    let total_sum = total_sum + *constraint_coefficients[13] * value;

    // Constraint: cpu/update_registers/update_pc/pc_cond_negative.
    let value = ((1 - cpu_decode_opcode_range_check_bit_9) * column5_row16
        + column8_row2 * (column5_row16 - (column5_row0 + column5_row13))
        - (cpu_decode_flag_pc_update_regular_0 * npc_reg_0
            + cpu_decode_opcode_range_check_bit_7 * column8_row12
            + cpu_decode_opcode_range_check_bit_8 * (column5_row0 + column8_row12)))
        * domain28
        / domain5;
    let total_sum = total_sum + *constraint_coefficients[14] * value;

    // Constraint: cpu/update_registers/update_pc/pc_cond_positive.
    let value = ((column8_row10 - cpu_decode_opcode_range_check_bit_9)
        * (column5_row16 - npc_reg_0))
        * domain28
        / domain5;
    let total_sum = total_sum + *constraint_coefficients[15] * value;

    // Constraint: cpu/update_registers/update_ap/ap_update.
    let value = (column8_row16
        - (column8_row0
            + cpu_decode_opcode_range_check_bit_10 * column8_row12
            + cpu_decode_opcode_range_check_bit_11
            + cpu_decode_opcode_range_check_bit_12 * 2))
        * domain28
        / domain5;
    let total_sum = total_sum + *constraint_coefficients[16] * value;

    // Constraint: cpu/update_registers/update_fp/fp_update.
    let value = (column8_row24
        - (cpu_decode_fp_update_regular_0 * column8_row8
            + cpu_decode_opcode_range_check_bit_13 * column5_row9
            + cpu_decode_opcode_range_check_bit_12 * (column8_row0 + 2)))
        * domain28
        / domain5;
    let total_sum = total_sum + *constraint_coefficients[17] * value;

    // Constraint: cpu/opcodes/call/push_fp.
    let value = (cpu_decode_opcode_range_check_bit_12 * (column5_row9 - column8_row8)) / domain5;
    let total_sum = total_sum + *constraint_coefficients[18] * value;

    // Constraint: cpu/opcodes/call/push_pc.
    let value = (cpu_decode_opcode_range_check_bit_12
        * (column5_row5 - (column5_row0 + cpu_decode_opcode_range_check_bit_2 + 1)))
        / domain5;
    let total_sum = total_sum + *constraint_coefficients[19] * value;

    // Constraint: cpu/opcodes/call/off0.
    let value = (cpu_decode_opcode_range_check_bit_12
        * (column7_row0 - global_values.half_offset_size))
        / domain5;
    let total_sum = total_sum + *constraint_coefficients[20] * value;

    // Constraint: cpu/opcodes/call/off1.
    let value = (cpu_decode_opcode_range_check_bit_12
        * (column7_row8 - (global_values.half_offset_size + 1)))
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
        * (column7_row0 + 2 - global_values.half_offset_size))
        / domain5;
    let total_sum = total_sum + *constraint_coefficients[23] * value;

    // Constraint: cpu/opcodes/ret/off2.
    let value = (cpu_decode_opcode_range_check_bit_13
        * (column7_row4 + 1 - global_values.half_offset_size))
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
    let value = (cpu_decode_opcode_range_check_bit_14 * (column5_row9 - column8_row12)) / domain5;
    let total_sum = total_sum + *constraint_coefficients[26] * value;

    // Constraint: initial_ap.
    let value = (column8_row0 - global_values.initial_ap) / domain29;
    let total_sum = total_sum + *constraint_coefficients[27] * value;

    // Constraint: initial_fp.
    let value = (column8_row8 - global_values.initial_ap) / domain29;
    let total_sum = total_sum + *constraint_coefficients[28] * value;

    // Constraint: initial_pc.
    let value = (column5_row0 - global_values.initial_pc) / domain29;
    let total_sum = total_sum + *constraint_coefficients[29] * value;

    // Constraint: final_ap.
    let value = (column8_row0 - global_values.final_ap) / domain28;
    let total_sum = total_sum + *constraint_coefficients[30] * value;

    // Constraint: final_fp.
    let value = (column8_row8 - global_values.initial_ap) / domain28;
    let total_sum = total_sum + *constraint_coefficients[31] * value;

    // Constraint: final_pc.
    let value = (column5_row0 - global_values.final_pc) / domain28;
    let total_sum = total_sum + *constraint_coefficients[32] * value;

    // Constraint: memory/multi_column_perm/perm/init0.
    let value = ((global_values.memory_multi_column_perm_perm_interaction_elm
        - (column6_row0
            + global_values.memory_multi_column_perm_hash_interaction_elm0 * column6_row1))
        * column9_inter1_row0
        + column5_row0
        + global_values.memory_multi_column_perm_hash_interaction_elm0 * column5_row1
        - global_values.memory_multi_column_perm_perm_interaction_elm)
        / domain29;
    let total_sum = total_sum + *constraint_coefficients[33] * value;

    // Constraint: memory/multi_column_perm/perm/step0.
    let value = ((global_values.memory_multi_column_perm_perm_interaction_elm
        - (column6_row2
            + global_values.memory_multi_column_perm_hash_interaction_elm0 * column6_row3))
        * column9_inter1_row2
        - (global_values.memory_multi_column_perm_perm_interaction_elm
            - (column5_row2
                + global_values.memory_multi_column_perm_hash_interaction_elm0 * column5_row3))
            * column9_inter1_row0)
        * domain30
        / domain1;
    let total_sum = total_sum + *constraint_coefficients[34] * value;

    // Constraint: memory/multi_column_perm/perm/last.
    let value = (column9_inter1_row0
        - global_values.memory_multi_column_perm_perm_public_memory_prod)
        / domain30;
    let total_sum = total_sum + *constraint_coefficients[35] * value;

    // Constraint: memory/diff_is_bit.
    let value = (memory_address_diff_0 * memory_address_diff_0 - memory_address_diff_0)
        * domain30
        / domain1;
    let total_sum = total_sum + *constraint_coefficients[36] * value;

    // Constraint: memory/is_func.
    let value = ((memory_address_diff_0 - 1) * (column6_row1 - column6_row3)) * domain30 / domain1;
    let total_sum = total_sum + *constraint_coefficients[37] * value;

    // Constraint: memory/initial_addr.
    let value = (column6_row0 - 1) / domain29;
    let total_sum = total_sum + *constraint_coefficients[38] * value;

    // Constraint: public_memory_addr_zero.
    let value = (column5_row2) / domain3;
    let total_sum = total_sum + *constraint_coefficients[39] * value;

    // Constraint: public_memory_value_zero.
    let value = (column5_row3) / domain3;
    let total_sum = total_sum + *constraint_coefficients[40] * value;

    // Constraint: range_check16/perm/init0.
    let value = ((global_values.range_check16_perm_interaction_elm - column7_row2)
        * column9_inter1_row1
        + column7_row0
        - global_values.range_check16_perm_interaction_elm)
        / domain29;
    let total_sum = total_sum + *constraint_coefficients[41] * value;

    // Constraint: range_check16/perm/step0.
    let value = ((global_values.range_check16_perm_interaction_elm - column7_row6)
        * column9_inter1_row5
        - (global_values.range_check16_perm_interaction_elm - column7_row4) * column9_inter1_row1)
        * domain31
        / domain2;
    let total_sum = total_sum + *constraint_coefficients[42] * value;

    // Constraint: range_check16/perm/last.
    let value = (column9_inter1_row1 - global_values.range_check16_perm_public_memory_prod)
        / domain31;
    let total_sum = total_sum + *constraint_coefficients[43] * value;

    // Constraint: range_check16/diff_is_bit.
    let value = (range_check16_diff_0 * range_check16_diff_0 - range_check16_diff_0)
        * domain31
        / domain2;
    let total_sum = total_sum + *constraint_coefficients[44] * value;

    // Constraint: range_check16/minimum.
    let value = (column7_row2 - global_values.range_check_min) / domain29;
    let total_sum = total_sum + *constraint_coefficients[45] * value;

    // Constraint: range_check16/maximum.
    let value = (column7_row2 - global_values.range_check_max) / domain31;
    let total_sum = total_sum + *constraint_coefficients[46] * value;

    // Constraint: diluted_check/permutation/init0.
    let value = ((global_values.diluted_check_permutation_interaction_elm - column7_row5)
        * column9_inter1_row7
        + column7_row1
        - global_values.diluted_check_permutation_interaction_elm)
        / domain29;
    let total_sum = total_sum + *constraint_coefficients[47] * value;

    // Constraint: diluted_check/permutation/step0.
    let value = ((global_values.diluted_check_permutation_interaction_elm - column7_row13)
        * column9_inter1_row15
        - (global_values.diluted_check_permutation_interaction_elm - column7_row9)
            * column9_inter1_row7)
        * domain32
        / domain3;
    let total_sum = total_sum + *constraint_coefficients[48] * value;

    // Constraint: diluted_check/permutation/last.
    let value = (column9_inter1_row7 - global_values.diluted_check_permutation_public_memory_prod)
        / domain32;
    let total_sum = total_sum + *constraint_coefficients[49] * value;

    // Constraint: diluted_check/init.
    let value = (column9_inter1_row3 - 1) / domain29;
    let total_sum = total_sum + *constraint_coefficients[50] * value;

    // Constraint: diluted_check/first_element.
    let value = (column7_row5 - global_values.diluted_check_first_elm) / domain29;
    let total_sum = total_sum + *constraint_coefficients[51] * value;

    // Constraint: diluted_check/step.
    let value = (column9_inter1_row11
        - (column9_inter1_row3
            * (1 + global_values.diluted_check_interaction_z * (column7_row13 - column7_row5))
            + global_values.diluted_check_interaction_alpha
                * (column7_row13 - column7_row5)
                * (column7_row13 - column7_row5)))
        * domain32
        / domain3;
    let total_sum = total_sum + *constraint_coefficients[52] * value;

    // Constraint: diluted_check/last.
    let value = (column9_inter1_row3 - global_values.diluted_check_final_cum_val) / domain32;
    let total_sum = total_sum + *constraint_coefficients[53] * value;

    // Constraint: pedersen/hash0/ec_subset_sum/bit_unpacking/last_one_is_zero.
    let value = (column8_row71 * (column3_row0 - (column3_row1 + column3_row1))) / domain8;
    let total_sum = total_sum + *constraint_coefficients[54] * value;

    // Constraint: pedersen/hash0/ec_subset_sum/bit_unpacking/zeroes_between_ones0.
    let value = (column8_row71
        * (column3_row1
            - 3138550867693340381917894711603833208051177722232017256448 * column3_row192))
        / domain8;
    let total_sum = total_sum + *constraint_coefficients[55] * value;

    // Constraint: pedersen/hash0/ec_subset_sum/bit_unpacking/cumulative_bit192.
    let value = (column8_row71
        - column4_row255 * (column3_row192 - (column3_row193 + column3_row193)))
        / domain8;
    let total_sum = total_sum + *constraint_coefficients[56] * value;

    // Constraint: pedersen/hash0/ec_subset_sum/bit_unpacking/zeroes_between_ones192.
    let value = (column4_row255 * (column3_row193 - 8 * column3_row196)) / domain8;
    let total_sum = total_sum + *constraint_coefficients[57] * value;

    // Constraint: pedersen/hash0/ec_subset_sum/bit_unpacking/cumulative_bit196.
    let value = (column4_row255
        - (column3_row251 - (column3_row252 + column3_row252))
            * (column3_row196 - (column3_row197 + column3_row197)))
        / domain8;
    let total_sum = total_sum + *constraint_coefficients[58] * value;

    // Constraint: pedersen/hash0/ec_subset_sum/bit_unpacking/zeroes_between_ones196.
    let value = ((column3_row251 - (column3_row252 + column3_row252))
        * (column3_row197 - 18014398509481984 * column3_row251))
        / domain8;
    let total_sum = total_sum + *constraint_coefficients[59] * value;

    // Constraint: pedersen/hash0/ec_subset_sum/booleanity_test.
    let value = (pedersen_hash0_ec_subset_sum_bit_0 * (pedersen_hash0_ec_subset_sum_bit_0 - 1))
        * domain9
        / domain0;
    let total_sum = total_sum + *constraint_coefficients[60] * value;

    // Constraint: pedersen/hash0/ec_subset_sum/bit_extraction_end.
    let value = (column3_row0) / domain10;
    let total_sum = total_sum + *constraint_coefficients[61] * value;

    // Constraint: pedersen/hash0/ec_subset_sum/zeros_tail.
    let value = (column3_row0) / domain9;
    let total_sum = total_sum + *constraint_coefficients[62] * value;

    // Constraint: pedersen/hash0/ec_subset_sum/add_points/slope.
    let value = (pedersen_hash0_ec_subset_sum_bit_0
        * (column2_row0 - global_values.pedersen_points_y)
        - column4_row0 * (column1_row0 - global_values.pedersen_points_x))
        * domain9
        / domain0;
    let total_sum = total_sum + *constraint_coefficients[63] * value;

    // Constraint: pedersen/hash0/ec_subset_sum/add_points/x.
    let value = (column4_row0 * column4_row0
        - pedersen_hash0_ec_subset_sum_bit_0
            * (column1_row0 + global_values.pedersen_points_x + column1_row1))
        * domain9
        / domain0;
    let total_sum = total_sum + *constraint_coefficients[64] * value;

    // Constraint: pedersen/hash0/ec_subset_sum/add_points/y.
    let value = (pedersen_hash0_ec_subset_sum_bit_0 * (column2_row0 + column2_row1)
        - column4_row0 * (column1_row0 - column1_row1))
        * domain9
        / domain0;
    let total_sum = total_sum + *constraint_coefficients[65] * value;

    // Constraint: pedersen/hash0/ec_subset_sum/copy_point/x.
    let value = (pedersen_hash0_ec_subset_sum_bit_neg_0 * (column1_row1 - column1_row0))
        * domain9
        / domain0;
    let total_sum = total_sum + *constraint_coefficients[66] * value;

    // Constraint: pedersen/hash0/ec_subset_sum/copy_point/y.
    let value = (pedersen_hash0_ec_subset_sum_bit_neg_0 * (column2_row1 - column2_row0))
        * domain9
        / domain0;
    let total_sum = total_sum + *constraint_coefficients[67] * value;

    // Constraint: pedersen/hash0/copy_point/x.
    let value = (column1_row256 - column1_row255) * domain12 / domain8;
    let total_sum = total_sum + *constraint_coefficients[68] * value;

    // Constraint: pedersen/hash0/copy_point/y.
    let value = (column2_row256 - column2_row255) * domain12 / domain8;
    let total_sum = total_sum + *constraint_coefficients[69] * value;

    // Constraint: pedersen/hash0/init/x.
    let value = (column1_row0 - global_values.pedersen_shift_point.x) / domain13;
    let total_sum = total_sum + *constraint_coefficients[70] * value;

    // Constraint: pedersen/hash0/init/y.
    let value = (column2_row0 - global_values.pedersen_shift_point.y) / domain13;
    let total_sum = total_sum + *constraint_coefficients[71] * value;

    // Constraint: pedersen/input0_value0.
    let value = (column5_row7 - column3_row0) / domain13;
    let total_sum = total_sum + *constraint_coefficients[72] * value;

    // Constraint: pedersen/input0_addr.
    let value = (column5_row518 - (column5_row134 + 1)) * domain33 / domain13;
    let total_sum = total_sum + *constraint_coefficients[73] * value;

    // Constraint: pedersen/init_addr.
    let value = (column5_row6 - global_values.initial_pedersen_addr) / domain29;
    let total_sum = total_sum + *constraint_coefficients[74] * value;

    // Constraint: pedersen/input1_value0.
    let value = (column5_row263 - column3_row256) / domain13;
    let total_sum = total_sum + *constraint_coefficients[75] * value;

    // Constraint: pedersen/input1_addr.
    let value = (column5_row262 - (column5_row6 + 1)) / domain13;
    let total_sum = total_sum + *constraint_coefficients[76] * value;

    // Constraint: pedersen/output_value0.
    let value = (column5_row135 - column1_row511) / domain13;
    let total_sum = total_sum + *constraint_coefficients[77] * value;

    // Constraint: pedersen/output_addr.
    let value = (column5_row134 - (column5_row262 + 1)) / domain13;
    let total_sum = total_sum + *constraint_coefficients[78] * value;

    // Constraint: range_check_builtin/value.
    let value = (range_check_builtin_value7_0 - column5_row71) / domain8;
    let total_sum = total_sum + *constraint_coefficients[79] * value;

    // Constraint: range_check_builtin/addr_step.
    let value = (column5_row326 - (column5_row70 + 1)) * domain34 / domain8;
    let total_sum = total_sum + *constraint_coefficients[80] * value;

    // Constraint: range_check_builtin/init_addr.
    let value = (column5_row70 - global_values.initial_range_check_addr) / domain29;
    let total_sum = total_sum + *constraint_coefficients[81] * value;

    // Constraint: ecdsa/signature0/doubling_key/slope.
    let value = (ecdsa_signature0_doubling_key_x_squared
        + ecdsa_signature0_doubling_key_x_squared
        + ecdsa_signature0_doubling_key_x_squared
        + global_values.ecdsa_sig_config.alpha
        - (column8_row33 + column8_row33) * column8_row35)
        * domain21
        / domain6;
    let total_sum = total_sum + *constraint_coefficients[82] * value;

    // Constraint: ecdsa/signature0/doubling_key/x.
    let value = (column8_row35 * column8_row35 - (column8_row1 + column8_row1 + column8_row65))
        * domain21
        / domain6;
    let total_sum = total_sum + *constraint_coefficients[83] * value;

    // Constraint: ecdsa/signature0/doubling_key/y.
    let value = (column8_row33 + column8_row97 - column8_row35 * (column8_row1 - column8_row65))
        * domain21
        / domain6;
    let total_sum = total_sum + *constraint_coefficients[84] * value;

    // Constraint: ecdsa/signature0/exponentiate_generator/booleanity_test.
    let value = (ecdsa_signature0_exponentiate_generator_bit_0
        * (ecdsa_signature0_exponentiate_generator_bit_0 - 1))
        * domain25
        / domain7;
    let total_sum = total_sum + *constraint_coefficients[85] * value;

    // Constraint: ecdsa/signature0/exponentiate_generator/bit_extraction_end.
    let value = (column8_row59) / domain26;
    let total_sum = total_sum + *constraint_coefficients[86] * value;

    // Constraint: ecdsa/signature0/exponentiate_generator/zeros_tail.
    let value = (column8_row59) / domain25;
    let total_sum = total_sum + *constraint_coefficients[87] * value;

    // Constraint: ecdsa/signature0/exponentiate_generator/add_points/slope.
    let value = (ecdsa_signature0_exponentiate_generator_bit_0
        * (column8_row91 - global_values.ecdsa_generator_points_y)
        - column8_row123 * (column8_row27 - global_values.ecdsa_generator_points_x))
        * domain25
        / domain7;
    let total_sum = total_sum + *constraint_coefficients[88] * value;

    // Constraint: ecdsa/signature0/exponentiate_generator/add_points/x.
    let value = (column8_row123 * column8_row123
        - ecdsa_signature0_exponentiate_generator_bit_0
            * (column8_row27 + global_values.ecdsa_generator_points_x + column8_row155))
        * domain25
        / domain7;
    let total_sum = total_sum + *constraint_coefficients[89] * value;

    // Constraint: ecdsa/signature0/exponentiate_generator/add_points/y.
    let value = (ecdsa_signature0_exponentiate_generator_bit_0 * (column8_row91 + column8_row219)
        - column8_row123 * (column8_row27 - column8_row155))
        * domain25
        / domain7;
    let total_sum = total_sum + *constraint_coefficients[90] * value;

    // Constraint: ecdsa/signature0/exponentiate_generator/add_points/x_diff_inv.
    let value = (column8_row7 * (column8_row27 - global_values.ecdsa_generator_points_x) - 1)
        * domain25
        / domain7;
    let total_sum = total_sum + *constraint_coefficients[91] * value;

    // Constraint: ecdsa/signature0/exponentiate_generator/copy_point/x.
    let value = (ecdsa_signature0_exponentiate_generator_bit_neg_0
        * (column8_row155 - column8_row27))
        * domain25
        / domain7;
    let total_sum = total_sum + *constraint_coefficients[92] * value;

    // Constraint: ecdsa/signature0/exponentiate_generator/copy_point/y.
    let value = (ecdsa_signature0_exponentiate_generator_bit_neg_0
        * (column8_row219 - column8_row91))
        * domain25
        / domain7;
    let total_sum = total_sum + *constraint_coefficients[93] * value;

    // Constraint: ecdsa/signature0/exponentiate_key/booleanity_test.
    let value = (ecdsa_signature0_exponentiate_key_bit_0
        * (ecdsa_signature0_exponentiate_key_bit_0 - 1))
        * domain21
        / domain6;
    let total_sum = total_sum + *constraint_coefficients[94] * value;

    // Constraint: ecdsa/signature0/exponentiate_key/bit_extraction_end.
    let value = (column8_row9) / domain22;
    let total_sum = total_sum + *constraint_coefficients[95] * value;

    // Constraint: ecdsa/signature0/exponentiate_key/zeros_tail.
    let value = (column8_row9) / domain21;
    let total_sum = total_sum + *constraint_coefficients[96] * value;

    // Constraint: ecdsa/signature0/exponentiate_key/add_points/slope.
    let value = (ecdsa_signature0_exponentiate_key_bit_0 * (column8_row49 - column8_row33)
        - column8_row19 * (column8_row17 - column8_row1))
        * domain21
        / domain6;
    let total_sum = total_sum + *constraint_coefficients[97] * value;

    // Constraint: ecdsa/signature0/exponentiate_key/add_points/x.
    let value = (column8_row19 * column8_row19
        - ecdsa_signature0_exponentiate_key_bit_0 * (column8_row17 + column8_row1 + column8_row81))
        * domain21
        / domain6;
    let total_sum = total_sum + *constraint_coefficients[98] * value;

    // Constraint: ecdsa/signature0/exponentiate_key/add_points/y.
    let value = (ecdsa_signature0_exponentiate_key_bit_0 * (column8_row49 + column8_row113)
        - column8_row19 * (column8_row17 - column8_row81))
        * domain21
        / domain6;
    let total_sum = total_sum + *constraint_coefficients[99] * value;

    // Constraint: ecdsa/signature0/exponentiate_key/add_points/x_diff_inv.
    let value = (column8_row51 * (column8_row17 - column8_row1) - 1) * domain21 / domain6;
    let total_sum = total_sum + *constraint_coefficients[100] * value;

    // Constraint: ecdsa/signature0/exponentiate_key/copy_point/x.
    let value = (ecdsa_signature0_exponentiate_key_bit_neg_0 * (column8_row81 - column8_row17))
        * domain21
        / domain6;
    let total_sum = total_sum + *constraint_coefficients[101] * value;

    // Constraint: ecdsa/signature0/exponentiate_key/copy_point/y.
    let value = (ecdsa_signature0_exponentiate_key_bit_neg_0 * (column8_row113 - column8_row49))
        * domain21
        / domain6;
    let total_sum = total_sum + *constraint_coefficients[102] * value;

    // Constraint: ecdsa/signature0/init_gen/x.
    let value = (column8_row27 - global_values.ecdsa_sig_config.shift_point.x) / domain27;
    let total_sum = total_sum + *constraint_coefficients[103] * value;

    // Constraint: ecdsa/signature0/init_gen/y.
    let value = (column8_row91 + global_values.ecdsa_sig_config.shift_point.y) / domain27;
    let total_sum = total_sum + *constraint_coefficients[104] * value;

    // Constraint: ecdsa/signature0/init_key/x.
    let value = (column8_row17 - global_values.ecdsa_sig_config.shift_point.x) / domain23;
    let total_sum = total_sum + *constraint_coefficients[105] * value;

    // Constraint: ecdsa/signature0/init_key/y.
    let value = (column8_row49 - global_values.ecdsa_sig_config.shift_point.y) / domain23;
    let total_sum = total_sum + *constraint_coefficients[106] * value;

    // Constraint: ecdsa/signature0/add_results/slope.
    let value = (column8_row32731
        - (column8_row16369 + column8_row32763 * (column8_row32667 - column8_row16337)))
        / domain27;
    let total_sum = total_sum + *constraint_coefficients[107] * value;

    // Constraint: ecdsa/signature0/add_results/x.
    let value = (column8_row32763 * column8_row32763
        - (column8_row32667 + column8_row16337 + column8_row16385))
        / domain27;
    let total_sum = total_sum + *constraint_coefficients[108] * value;

    // Constraint: ecdsa/signature0/add_results/y.
    let value = (column8_row32731
        + column8_row16417
        - column8_row32763 * (column8_row32667 - column8_row16385))
        / domain27;
    let total_sum = total_sum + *constraint_coefficients[109] * value;

    // Constraint: ecdsa/signature0/add_results/x_diff_inv.
    let value = (column8_row32647 * (column8_row32667 - column8_row16337) - 1) / domain27;
    let total_sum = total_sum + *constraint_coefficients[110] * value;

    // Constraint: ecdsa/signature0/extract_r/slope.
    let value = (column8_row32753
        + global_values.ecdsa_sig_config.shift_point.y
        - column8_row16331 * (column8_row32721 - global_values.ecdsa_sig_config.shift_point.x))
        / domain27;
    let total_sum = total_sum + *constraint_coefficients[111] * value;

    // Constraint: ecdsa/signature0/extract_r/x.
    let value = (column8_row16331 * column8_row16331
        - (column8_row32721 + global_values.ecdsa_sig_config.shift_point.x + column8_row9))
        / domain27;
    let total_sum = total_sum + *constraint_coefficients[112] * value;

    // Constraint: ecdsa/signature0/extract_r/x_diff_inv.
    let value = (column8_row32715
        * (column8_row32721 - global_values.ecdsa_sig_config.shift_point.x)
        - 1)
        / domain27;
    let total_sum = total_sum + *constraint_coefficients[113] * value;

    // Constraint: ecdsa/signature0/z_nonzero.
    let value = (column8_row59 * column8_row16363 - 1) / domain27;
    let total_sum = total_sum + *constraint_coefficients[114] * value;

    // Constraint: ecdsa/signature0/r_and_w_nonzero.
    let value = (column8_row9 * column8_row16355 - 1) / domain23;
    let total_sum = total_sum + *constraint_coefficients[115] * value;

    // Constraint: ecdsa/signature0/q_on_curve/x_squared.
    let value = (column8_row32747 - column8_row1 * column8_row1) / domain27;
    let total_sum = total_sum + *constraint_coefficients[116] * value;

    // Constraint: ecdsa/signature0/q_on_curve/on_curve.
    let value = (column8_row33 * column8_row33
        - (column8_row1 * column8_row32747
            + global_values.ecdsa_sig_config.alpha * column8_row1
            + global_values.ecdsa_sig_config.beta))
        / domain27;
    let total_sum = total_sum + *constraint_coefficients[117] * value;

    // Constraint: ecdsa/init_addr.
    let value = (column5_row390 - global_values.initial_ecdsa_addr) / domain29;
    let total_sum = total_sum + *constraint_coefficients[118] * value;

    // Constraint: ecdsa/message_addr.
    let value = (column5_row16774 - (column5_row390 + 1)) / domain27;
    let total_sum = total_sum + *constraint_coefficients[119] * value;

    // Constraint: ecdsa/pubkey_addr.
    let value = (column5_row33158 - (column5_row16774 + 1)) * domain35 / domain27;
    let total_sum = total_sum + *constraint_coefficients[120] * value;

    // Constraint: ecdsa/message_value0.
    let value = (column5_row16775 - column8_row59) / domain27;
    let total_sum = total_sum + *constraint_coefficients[121] * value;

    // Constraint: ecdsa/pubkey_value0.
    let value = (column5_row391 - column8_row1) / domain27;
    let total_sum = total_sum + *constraint_coefficients[122] * value;

    // Constraint: bitwise/init_var_pool_addr.
    let value = (column5_row198 - global_values.initial_bitwise_addr) / domain29;
    let total_sum = total_sum + *constraint_coefficients[123] * value;

    // Constraint: bitwise/step_var_pool_addr.
    let value = (column5_row454 - (column5_row198 + 1)) * domain18 / domain8;
    let total_sum = total_sum + *constraint_coefficients[124] * value;

    // Constraint: bitwise/x_or_y_addr.
    let value = (column5_row902 - (column5_row966 + 1)) / domain19;
    let total_sum = total_sum + *constraint_coefficients[125] * value;

    // Constraint: bitwise/next_var_pool_addr.
    let value = (column5_row1222 - (column5_row902 + 1)) * domain36 / domain19;
    let total_sum = total_sum + *constraint_coefficients[126] * value;

    // Constraint: bitwise/partition.
    let value = (bitwise_sum_var_0_0 + bitwise_sum_var_8_0 - column5_row199) / domain8;
    let total_sum = total_sum + *constraint_coefficients[127] * value;

    // Constraint: bitwise/or_is_and_plus_xor.
    let value = (column5_row903 - (column5_row711 + column5_row967)) / domain19;
    let total_sum = total_sum + *constraint_coefficients[128] * value;

    // Constraint: bitwise/addition_is_xor_with_and.
    let value = (column7_row1 + column7_row257 - (column7_row769 + column7_row513 + column7_row513))
        / domain20;
    let total_sum = total_sum + *constraint_coefficients[129] * value;

    // Constraint: bitwise/unique_unpacking192.
    let value = ((column7_row705 + column7_row961) * 16 - column7_row9) / domain19;
    let total_sum = total_sum + *constraint_coefficients[130] * value;

    // Constraint: bitwise/unique_unpacking193.
    let value = ((column7_row721 + column7_row977) * 16 - column7_row521) / domain19;
    let total_sum = total_sum + *constraint_coefficients[131] * value;

    // Constraint: bitwise/unique_unpacking194.
    let value = ((column7_row737 + column7_row993) * 16 - column7_row265) / domain19;
    let total_sum = total_sum + *constraint_coefficients[132] * value;

    // Constraint: bitwise/unique_unpacking195.
    let value = ((column7_row753 + column7_row1009) * 256 - column7_row777) / domain19;
    let total_sum = total_sum + *constraint_coefficients[133] * value;

    // Constraint: ec_op/init_addr.
    let value = (column5_row8582 - global_values.initial_ec_op_addr) / domain29;
    let total_sum = total_sum + *constraint_coefficients[134] * value;

    // Constraint: ec_op/p_x_addr.
    let value = (column5_row24966 - (column5_row8582 + 7)) * domain37 / domain23;
    let total_sum = total_sum + *constraint_coefficients[135] * value;

    // Constraint: ec_op/p_y_addr.
    let value = (column5_row4486 - (column5_row8582 + 1)) / domain23;
    let total_sum = total_sum + *constraint_coefficients[136] * value;

    // Constraint: ec_op/q_x_addr.
    let value = (column5_row12678 - (column5_row4486 + 1)) / domain23;
    let total_sum = total_sum + *constraint_coefficients[137] * value;

    // Constraint: ec_op/q_y_addr.
    let value = (column5_row2438 - (column5_row12678 + 1)) / domain23;
    let total_sum = total_sum + *constraint_coefficients[138] * value;

    // Constraint: ec_op/m_addr.
    let value = (column5_row10630 - (column5_row2438 + 1)) / domain23;
    let total_sum = total_sum + *constraint_coefficients[139] * value;

    // Constraint: ec_op/r_x_addr.
    let value = (column5_row6534 - (column5_row10630 + 1)) / domain23;
    let total_sum = total_sum + *constraint_coefficients[140] * value;

    // Constraint: ec_op/r_y_addr.
    let value = (column5_row14726 - (column5_row6534 + 1)) / domain23;
    let total_sum = total_sum + *constraint_coefficients[141] * value;

    // Constraint: ec_op/doubling_q/slope.
    let value = (ec_op_doubling_q_x_squared_0
        + ec_op_doubling_q_x_squared_0
        + ec_op_doubling_q_x_squared_0
        + global_values.ec_op_curve_config.alpha
        - (column8_row25 + column8_row25) * column8_row57)
        * domain21
        / domain6;
    let total_sum = total_sum + *constraint_coefficients[142] * value;

    // Constraint: ec_op/doubling_q/x.
    let value = (column8_row57 * column8_row57 - (column8_row41 + column8_row41 + column8_row105))
        * domain21
        / domain6;
    let total_sum = total_sum + *constraint_coefficients[143] * value;

    // Constraint: ec_op/doubling_q/y.
    let value = (column8_row25 + column8_row89 - column8_row57 * (column8_row41 - column8_row105))
        * domain21
        / domain6;
    let total_sum = total_sum + *constraint_coefficients[144] * value;

    // Constraint: ec_op/get_q_x.
    let value = (column5_row12679 - column8_row41) / domain23;
    let total_sum = total_sum + *constraint_coefficients[145] * value;

    // Constraint: ec_op/get_q_y.
    let value = (column5_row2439 - column8_row25) / domain23;
    let total_sum = total_sum + *constraint_coefficients[146] * value;

    // Constraint: ec_op/ec_subset_sum/bit_unpacking/last_one_is_zero.
    let value = (column8_row16371 * (column8_row21 - (column8_row85 + column8_row85))) / domain23;
    let total_sum = total_sum + *constraint_coefficients[147] * value;

    // Constraint: ec_op/ec_subset_sum/bit_unpacking/zeroes_between_ones0.
    let value = (column8_row16371
        * (column8_row85
            - 3138550867693340381917894711603833208051177722232017256448 * column8_row12309))
        / domain23;
    let total_sum = total_sum + *constraint_coefficients[148] * value;

    // Constraint: ec_op/ec_subset_sum/bit_unpacking/cumulative_bit192.
    let value = (column8_row16371
        - column8_row16339 * (column8_row12309 - (column8_row12373 + column8_row12373)))
        / domain23;
    let total_sum = total_sum + *constraint_coefficients[149] * value;

    // Constraint: ec_op/ec_subset_sum/bit_unpacking/zeroes_between_ones192.
    let value = (column8_row16339 * (column8_row12373 - 8 * column8_row12565)) / domain23;
    let total_sum = total_sum + *constraint_coefficients[150] * value;

    // Constraint: ec_op/ec_subset_sum/bit_unpacking/cumulative_bit196.
    let value = (column8_row16339
        - (column8_row16085 - (column8_row16149 + column8_row16149))
            * (column8_row12565 - (column8_row12629 + column8_row12629)))
        / domain23;
    let total_sum = total_sum + *constraint_coefficients[151] * value;

    // Constraint: ec_op/ec_subset_sum/bit_unpacking/zeroes_between_ones196.
    let value = ((column8_row16085 - (column8_row16149 + column8_row16149))
        * (column8_row12629 - 18014398509481984 * column8_row16085))
        / domain23;
    let total_sum = total_sum + *constraint_coefficients[152] * value;

    // Constraint: ec_op/ec_subset_sum/booleanity_test.
    let value = (ec_op_ec_subset_sum_bit_0 * (ec_op_ec_subset_sum_bit_0 - 1)) * domain21 / domain6;
    let total_sum = total_sum + *constraint_coefficients[153] * value;

    // Constraint: ec_op/ec_subset_sum/bit_extraction_end.
    let value = (column8_row21) / domain24;
    let total_sum = total_sum + *constraint_coefficients[154] * value;

    // Constraint: ec_op/ec_subset_sum/zeros_tail.
    let value = (column8_row21) / domain21;
    let total_sum = total_sum + *constraint_coefficients[155] * value;

    // Constraint: ec_op/ec_subset_sum/add_points/slope.
    let value = (ec_op_ec_subset_sum_bit_0 * (column8_row37 - column8_row25)
        - column8_row11 * (column8_row5 - column8_row41))
        * domain21
        / domain6;
    let total_sum = total_sum + *constraint_coefficients[156] * value;

    // Constraint: ec_op/ec_subset_sum/add_points/x.
    let value = (column8_row11 * column8_row11
        - ec_op_ec_subset_sum_bit_0 * (column8_row5 + column8_row41 + column8_row69))
        * domain21
        / domain6;
    let total_sum = total_sum + *constraint_coefficients[157] * value;

    // Constraint: ec_op/ec_subset_sum/add_points/y.
    let value = (ec_op_ec_subset_sum_bit_0 * (column8_row37 + column8_row101)
        - column8_row11 * (column8_row5 - column8_row69))
        * domain21
        / domain6;
    let total_sum = total_sum + *constraint_coefficients[158] * value;

    // Constraint: ec_op/ec_subset_sum/add_points/x_diff_inv.
    let value = (column8_row43 * (column8_row5 - column8_row41) - 1) * domain21 / domain6;
    let total_sum = total_sum + *constraint_coefficients[159] * value;

    // Constraint: ec_op/ec_subset_sum/copy_point/x.
    let value = (ec_op_ec_subset_sum_bit_neg_0 * (column8_row69 - column8_row5))
        * domain21
        / domain6;
    let total_sum = total_sum + *constraint_coefficients[160] * value;

    // Constraint: ec_op/ec_subset_sum/copy_point/y.
    let value = (ec_op_ec_subset_sum_bit_neg_0 * (column8_row101 - column8_row37))
        * domain21
        / domain6;
    let total_sum = total_sum + *constraint_coefficients[161] * value;

    // Constraint: ec_op/get_m.
    let value = (column8_row21 - column5_row10631) / domain23;
    let total_sum = total_sum + *constraint_coefficients[162] * value;

    // Constraint: ec_op/get_p_x.
    let value = (column5_row8583 - column8_row5) / domain23;
    let total_sum = total_sum + *constraint_coefficients[163] * value;

    // Constraint: ec_op/get_p_y.
    let value = (column5_row4487 - column8_row37) / domain23;
    let total_sum = total_sum + *constraint_coefficients[164] * value;

    // Constraint: ec_op/set_r_x.
    let value = (column5_row6535 - column8_row16325) / domain23;
    let total_sum = total_sum + *constraint_coefficients[165] * value;

    // Constraint: ec_op/set_r_y.
    let value = (column5_row14727 - column8_row16357) / domain23;
    let total_sum = total_sum + *constraint_coefficients[166] * value;

    // Constraint: poseidon/param_0/init_input_output_addr.
    let value = (column5_row38 - global_values.initial_poseidon_addr) / domain29;
    let total_sum = total_sum + *constraint_coefficients[167] * value;

    // Constraint: poseidon/param_0/addr_input_output_step.
    let value = (column5_row294 - (column5_row38 + 3)) * domain34 / domain8;
    let total_sum = total_sum + *constraint_coefficients[168] * value;

    // Constraint: poseidon/param_1/init_input_output_addr.
    let value = (column5_row166 - (global_values.initial_poseidon_addr + 1)) / domain29;
    let total_sum = total_sum + *constraint_coefficients[169] * value;

    // Constraint: poseidon/param_1/addr_input_output_step.
    let value = (column5_row422 - (column5_row166 + 3)) * domain34 / domain8;
    let total_sum = total_sum + *constraint_coefficients[170] * value;

    // Constraint: poseidon/param_2/init_input_output_addr.
    let value = (column5_row102 - (global_values.initial_poseidon_addr + 2)) / domain29;
    let total_sum = total_sum + *constraint_coefficients[171] * value;

    // Constraint: poseidon/param_2/addr_input_output_step.
    let value = (column5_row358 - (column5_row102 + 3)) * domain34 / domain8;
    let total_sum = total_sum + *constraint_coefficients[172] * value;

    // Constraint: poseidon/poseidon/full_rounds_state0_squaring.
    let value = (column8_row53 * column8_row53 - column8_row29) / domain6;
    let total_sum = total_sum + *constraint_coefficients[173] * value;

    // Constraint: poseidon/poseidon/full_rounds_state1_squaring.
    let value = (column8_row13 * column8_row13 - column8_row61) / domain6;
    let total_sum = total_sum + *constraint_coefficients[174] * value;

    // Constraint: poseidon/poseidon/full_rounds_state2_squaring.
    let value = (column8_row45 * column8_row45 - column8_row3) / domain6;
    let total_sum = total_sum + *constraint_coefficients[175] * value;

    // Constraint: poseidon/poseidon/partial_rounds_state0_squaring.
    let value = (column7_row3 * column7_row3 - column7_row7) / domain3;
    let total_sum = total_sum + *constraint_coefficients[176] * value;

    // Constraint: poseidon/poseidon/partial_rounds_state1_squaring.
    let value = (column8_row6 * column8_row6 - column8_row14) * domain15 / domain5;
    let total_sum = total_sum + *constraint_coefficients[177] * value;

    // Constraint: poseidon/poseidon/add_first_round_key0.
    let value = (column5_row39
        + 2950795762459345168613727575620414179244544320470208355568817838579231751791
        - column8_row53)
        / domain13;
    let total_sum = total_sum + *constraint_coefficients[178] * value;

    // Constraint: poseidon/poseidon/add_first_round_key1.
    let value = (column5_row167
        + 1587446564224215276866294500450702039420286416111469274423465069420553242820
        - column8_row13)
        / domain13;
    let total_sum = total_sum + *constraint_coefficients[179] * value;

    // Constraint: poseidon/poseidon/add_first_round_key2.
    let value = (column5_row103
        + 1645965921169490687904413452218868659025437693527479459426157555728339600137
        - column8_row45)
        / domain13;
    let total_sum = total_sum + *constraint_coefficients[180] * value;

    // Constraint: poseidon/poseidon/full_round0.
    let value = (column8_row117
        - (poseidon_poseidon_full_rounds_state0_cubed_0
            + poseidon_poseidon_full_rounds_state0_cubed_0
            + poseidon_poseidon_full_rounds_state0_cubed_0
            + poseidon_poseidon_full_rounds_state1_cubed_0
            + poseidon_poseidon_full_rounds_state2_cubed_0
            + global_values.poseidon_poseidon_full_round_key0))
        * domain11
        / domain6;
    let total_sum = total_sum + *constraint_coefficients[181] * value;

    // Constraint: poseidon/poseidon/full_round1.
    let value = (column8_row77
        + poseidon_poseidon_full_rounds_state1_cubed_0
        - (poseidon_poseidon_full_rounds_state0_cubed_0
            + poseidon_poseidon_full_rounds_state2_cubed_0
            + global_values.poseidon_poseidon_full_round_key1))
        * domain11
        / domain6;
    let total_sum = total_sum + *constraint_coefficients[182] * value;

    // Constraint: poseidon/poseidon/full_round2.
    let value = (column8_row109
        + poseidon_poseidon_full_rounds_state2_cubed_0
        + poseidon_poseidon_full_rounds_state2_cubed_0
        - (poseidon_poseidon_full_rounds_state0_cubed_0
            + poseidon_poseidon_full_rounds_state1_cubed_0
            + global_values.poseidon_poseidon_full_round_key2))
        * domain11
        / domain6;
    let total_sum = total_sum + *constraint_coefficients[183] * value;

    // Constraint: poseidon/poseidon/last_full_round0.
    let value = (column5_row295
        - (poseidon_poseidon_full_rounds_state0_cubed_7
            + poseidon_poseidon_full_rounds_state0_cubed_7
            + poseidon_poseidon_full_rounds_state0_cubed_7
            + poseidon_poseidon_full_rounds_state1_cubed_7
            + poseidon_poseidon_full_rounds_state2_cubed_7))
        / domain13;
    let total_sum = total_sum + *constraint_coefficients[184] * value;

    // Constraint: poseidon/poseidon/last_full_round1.
    let value = (column5_row423
        + poseidon_poseidon_full_rounds_state1_cubed_7
        - (poseidon_poseidon_full_rounds_state0_cubed_7
            + poseidon_poseidon_full_rounds_state2_cubed_7))
        / domain13;
    let total_sum = total_sum + *constraint_coefficients[185] * value;

    // Constraint: poseidon/poseidon/last_full_round2.
    let value = (column5_row359
        + poseidon_poseidon_full_rounds_state2_cubed_7
        + poseidon_poseidon_full_rounds_state2_cubed_7
        - (poseidon_poseidon_full_rounds_state0_cubed_7
            + poseidon_poseidon_full_rounds_state1_cubed_7))
        / domain13;
    let total_sum = total_sum + *constraint_coefficients[186] * value;

    // Constraint: poseidon/poseidon/copy_partial_rounds0_i0.
    let value = (column7_row491 - column8_row6) / domain13;
    let total_sum = total_sum + *constraint_coefficients[187] * value;

    // Constraint: poseidon/poseidon/copy_partial_rounds0_i1.
    let value = (column7_row499 - column8_row22) / domain13;
    let total_sum = total_sum + *constraint_coefficients[188] * value;

    // Constraint: poseidon/poseidon/copy_partial_rounds0_i2.
    let value = (column7_row507 - column8_row38) / domain13;
    let total_sum = total_sum + *constraint_coefficients[189] * value;

    // Constraint: poseidon/poseidon/margin_full_to_partial0.
    let value = (column7_row3
        + poseidon_poseidon_full_rounds_state2_cubed_3
        + poseidon_poseidon_full_rounds_state2_cubed_3
        - (poseidon_poseidon_full_rounds_state0_cubed_3
            + poseidon_poseidon_full_rounds_state1_cubed_3
            + 2121140748740143694053732746913428481442990369183417228688865837805149503386))
        / domain13;
    let total_sum = total_sum + *constraint_coefficients[190] * value;

    // Constraint: poseidon/poseidon/margin_full_to_partial1.
    let value = (column7_row11
        - (3618502788666131213697322783095070105623107215331596699973092056135872020477
            * poseidon_poseidon_full_rounds_state1_cubed_3
            + 10 * poseidon_poseidon_full_rounds_state2_cubed_3
            + 4 * column7_row3
            + 3618502788666131213697322783095070105623107215331596699973092056135872020479
                * poseidon_poseidon_partial_rounds_state0_cubed_0
            + 2006642341318481906727563724340978325665491359415674592697055778067937914672))
        / domain13;
    let total_sum = total_sum + *constraint_coefficients[191] * value;

    // Constraint: poseidon/poseidon/margin_full_to_partial2.
    let value = (column7_row19
        - (8 * poseidon_poseidon_full_rounds_state2_cubed_3
            + 4 * column7_row3
            + 6 * poseidon_poseidon_partial_rounds_state0_cubed_0
            + column7_row11
            + column7_row11
            + 3618502788666131213697322783095070105623107215331596699973092056135872020479
                * poseidon_poseidon_partial_rounds_state0_cubed_1
            + 427751140904099001132521606468025610873158555767197326325930641757709538586))
        / domain13;
    let total_sum = total_sum + *constraint_coefficients[192] * value;

    // Constraint: poseidon/poseidon/partial_round0.
    let value = (column7_row27
        - (8 * poseidon_poseidon_partial_rounds_state0_cubed_0
            + 4 * column7_row11
            + 6 * poseidon_poseidon_partial_rounds_state0_cubed_1
            + column7_row19
            + column7_row19
            + 3618502788666131213697322783095070105623107215331596699973092056135872020479
                * poseidon_poseidon_partial_rounds_state0_cubed_2
            + global_values.poseidon_poseidon_partial_round_key0))
        * domain16
        / domain3;
    let total_sum = total_sum + *constraint_coefficients[193] * value;

    // Constraint: poseidon/poseidon/partial_round1.
    let value = (column8_row54
        - (8 * poseidon_poseidon_partial_rounds_state1_cubed_0
            + 4 * column8_row22
            + 6 * poseidon_poseidon_partial_rounds_state1_cubed_1
            + column8_row38
            + column8_row38
            + 3618502788666131213697322783095070105623107215331596699973092056135872020479
                * poseidon_poseidon_partial_rounds_state1_cubed_2
            + global_values.poseidon_poseidon_partial_round_key1))
        * domain17
        / domain5;
    let total_sum = total_sum + *constraint_coefficients[194] * value;

    // Constraint: poseidon/poseidon/margin_partial_to_full0.
    let value = (column8_row309
        - (16 * poseidon_poseidon_partial_rounds_state1_cubed_19
            + 8 * column8_row326
            + 16 * poseidon_poseidon_partial_rounds_state1_cubed_20
            + 6 * column8_row342
            + poseidon_poseidon_partial_rounds_state1_cubed_21
            + 560279373700919169769089400651532183647886248799764942664266404650165812023))
        / domain13;
    let total_sum = total_sum + *constraint_coefficients[195] * value;

    // Constraint: poseidon/poseidon/margin_partial_to_full1.
    let value = (column8_row269
        - (4 * poseidon_poseidon_partial_rounds_state1_cubed_20
            + column8_row342
            + column8_row342
            + poseidon_poseidon_partial_rounds_state1_cubed_21
            + 1401754474293352309994371631695783042590401941592571735921592823982231996415))
        / domain13;
    let total_sum = total_sum + *constraint_coefficients[196] * value;

    // Constraint: poseidon/poseidon/margin_partial_to_full2.
    let value = (column8_row301
        - (8 * poseidon_poseidon_partial_rounds_state1_cubed_19
            + 4 * column8_row326
            + 6 * poseidon_poseidon_partial_rounds_state1_cubed_20
            + column8_row342
            + column8_row342
            + 3618502788666131213697322783095070105623107215331596699973092056135872020479
                * poseidon_poseidon_partial_rounds_state1_cubed_21
            + 1246177936547655338400308396717835700699368047388302793172818304164989556526))
        / domain13;
    let total_sum = total_sum + *constraint_coefficients[197] * value;

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

    let value = (column0 - *oods_values[1]) / (point - pow17 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[1] * value;

    let value = (column0 - *oods_values[2]) / (point - pow24 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[2] * value;

    let value = (column0 - *oods_values[3]) / (point - pow25 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[3] * value;

    let value = (column0 - *oods_values[4]) / (point - pow26 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[4] * value;

    let value = (column0 - *oods_values[5]) / (point - pow27 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[5] * value;

    let value = (column0 - *oods_values[6]) / (point - pow28 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[6] * value;

    let value = (column0 - *oods_values[7]) / (point - pow30 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[7] * value;

    let value = (column0 - *oods_values[8]) / (point - pow31 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[8] * value;

    let value = (column0 - *oods_values[9]) / (point - pow32 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[9] * value;

    let value = (column0 - *oods_values[10]) / (point - pow33 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[10] * value;

    let value = (column0 - *oods_values[11]) / (point - pow34 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[11] * value;

    let value = (column0 - *oods_values[12]) / (point - pow35 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[12] * value;

    let value = (column0 - *oods_values[13]) / (point - pow36 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[13] * value;

    let value = (column0 - *oods_values[14]) / (point - pow37 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[14] * value;

    let value = (column0 - *oods_values[15]) / (point - pow38 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[15] * value;

    let value = (column1 - *oods_values[16]) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[16] * value;

    let value = (column1 - *oods_values[17]) / (point - pow17 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[17] * value;

    let value = (column1 - *oods_values[18]) / (point - pow134 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[18] * value;

    let value = (column1 - *oods_values[19]) / (point - pow135 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[19] * value;

    let value = (column1 - *oods_values[20]) / (point - pow172 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[20] * value;

    let value = (column2 - *oods_values[21]) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[21] * value;

    let value = (column2 - *oods_values[22]) / (point - pow17 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[22] * value;

    let value = (column2 - *oods_values[23]) / (point - pow134 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[23] * value;

    let value = (column2 - *oods_values[24]) / (point - pow135 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[24] * value;

    let value = (column3 - *oods_values[25]) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[25] * value;

    let value = (column3 - *oods_values[26]) / (point - pow17 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[26] * value;

    let value = (column3 - *oods_values[27]) / (point - pow105 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[27] * value;

    let value = (column3 - *oods_values[28]) / (point - pow106 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[28] * value;

    let value = (column3 - *oods_values[29]) / (point - pow108 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[29] * value;

    let value = (column3 - *oods_values[30]) / (point - pow109 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[30] * value;

    let value = (column3 - *oods_values[31]) / (point - pow122 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[31] * value;

    let value = (column3 - *oods_values[32]) / (point - pow123 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[32] * value;

    let value = (column3 - *oods_values[33]) / (point - pow135 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[33] * value;

    let value = (column4 - *oods_values[34]) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[34] * value;

    let value = (column4 - *oods_values[35]) / (point - pow134 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[35] * value;

    let value = (column5 - *oods_values[36]) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[36] * value;

    let value = (column5 - *oods_values[37]) / (point - pow17 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[37] * value;

    let value = (column5 - *oods_values[38]) / (point - pow24 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[38] * value;

    let value = (column5 - *oods_values[39]) / (point - pow25 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[39] * value;

    let value = (column5 - *oods_values[40]) / (point - pow26 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[40] * value;

    let value = (column5 - *oods_values[41]) / (point - pow27 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[41] * value;

    let value = (column5 - *oods_values[42]) / (point - pow28 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[42] * value;

    let value = (column5 - *oods_values[43]) / (point - pow30 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[43] * value;

    let value = (column5 - *oods_values[44]) / (point - pow31 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[44] * value;

    let value = (column5 - *oods_values[45]) / (point - pow32 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[45] * value;

    let value = (column5 - *oods_values[46]) / (point - pow35 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[46] * value;

    let value = (column5 - *oods_values[47]) / (point - pow36 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[47] * value;

    let value = (column5 - *oods_values[48]) / (point - pow39 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[48] * value;

    let value = (column5 - *oods_values[49]) / (point - pow53 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[49] * value;

    let value = (column5 - *oods_values[50]) / (point - pow54 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[50] * value;

    let value = (column5 - *oods_values[51]) / (point - pow74 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[51] * value;

    let value = (column5 - *oods_values[52]) / (point - pow75 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[52] * value;

    let value = (column5 - *oods_values[53]) / (point - pow85 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[53] * value;

    let value = (column5 - *oods_values[54]) / (point - pow86 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[54] * value;

    let value = (column5 - *oods_values[55]) / (point - pow94 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[55] * value;

    let value = (column5 - *oods_values[56]) / (point - pow95 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[56] * value;

    let value = (column5 - *oods_values[57]) / (point - pow100 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[57] * value;

    let value = (column5 - *oods_values[58]) / (point - pow101 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[58] * value;

    let value = (column5 - *oods_values[59]) / (point - pow110 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[59] * value;

    let value = (column5 - *oods_values[60]) / (point - pow111 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[60] * value;

    let value = (column5 - *oods_values[61]) / (point - pow141 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[61] * value;

    let value = (column5 - *oods_values[62]) / (point - pow142 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[62] * value;

    let value = (column5 - *oods_values[63]) / (point - pow145 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[63] * value;

    let value = (column5 - *oods_values[64]) / (point - pow146 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[64] * value;

    let value = (column5 - *oods_values[65]) / (point - pow153 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[65] * value;

    let value = (column5 - *oods_values[66]) / (point - pow157 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[66] * value;

    let value = (column5 - *oods_values[67]) / (point - pow160 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[67] * value;

    let value = (column5 - *oods_values[68]) / (point - pow152 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[68] * value;

    let value = (column5 - *oods_values[69]) / (point - pow159 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[69] * value;

    let value = (column5 - *oods_values[70]) / (point - pow151 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[70] * value;

    let value = (column5 - *oods_values[71]) / (point - pow158 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[71] * value;

    let value = (column5 - *oods_values[72]) / (point - pow163 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[72] * value;

    let value = (column5 - *oods_values[73]) / (point - pow175 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[73] * value;

    let value = (column5 - *oods_values[74]) / (point - pow178 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[74] * value;

    let value = (column5 - *oods_values[75]) / (point - pow177 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[75] * value;

    let value = (column5 - *oods_values[76]) / (point - pow188 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[76] * value;

    let value = (column5 - *oods_values[77]) / (point - pow184 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[77] * value;

    let value = (column5 - *oods_values[78]) / (point - pow185 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[78] * value;

    let value = (column5 - *oods_values[79]) / (point - pow187 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[79] * value;

    let value = (column5 - *oods_values[80]) / (point - pow16 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[80] * value;

    let value = (column5 - *oods_values[81]) / (point - pow23 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[81] * value;

    let value = (column5 - *oods_values[82]) / (point - pow15 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[82] * value;

    let value = (column5 - *oods_values[83]) / (point - pow22 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[83] * value;

    let value = (column5 - *oods_values[84]) / (point - pow14 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[84] * value;

    let value = (column5 - *oods_values[85]) / (point - pow21 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[85] * value;

    let value = (column5 - *oods_values[86]) / (point - pow13 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[86] * value;

    let value = (column5 - *oods_values[87]) / (point - pow20 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[87] * value;

    let value = (column5 - *oods_values[88]) / (point - pow12 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[88] * value;

    let value = (column5 - *oods_values[89]) / (point - pow19 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[89] * value;

    let value = (column5 - *oods_values[90]) / (point - pow139 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[90] * value;

    let value = (column5 - *oods_values[91]) / (point - pow140 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[91] * value;

    let value = (column5 - *oods_values[92]) / (point - pow11 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[92] * value;

    let value = (column5 - *oods_values[93]) / (point - pow18 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[93] * value;

    let value = (column5 - *oods_values[94]) / (point - pow10 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[94] * value;

    let value = (column5 - *oods_values[95]) / (point - pow161 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[95] * value;

    let value = (column5 - *oods_values[96]) / (point - pow9 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[96] * value;

    let value = (column5 - *oods_values[97]) / (point - pow173 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[97] * value;

    let value = (column6 - *oods_values[98]) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[98] * value;

    let value = (column6 - *oods_values[99]) / (point - pow17 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[99] * value;

    let value = (column6 - *oods_values[100]) / (point - pow24 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[100] * value;

    let value = (column6 - *oods_values[101]) / (point - pow25 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[101] * value;

    let value = (column7 - *oods_values[102]) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[102] * value;

    let value = (column7 - *oods_values[103]) / (point - pow17 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[103] * value;

    let value = (column7 - *oods_values[104]) / (point - pow24 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[104] * value;

    let value = (column7 - *oods_values[105]) / (point - pow25 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[105] * value;

    let value = (column7 - *oods_values[106]) / (point - pow26 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[106] * value;

    let value = (column7 - *oods_values[107]) / (point - pow27 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[107] * value;

    let value = (column7 - *oods_values[108]) / (point - pow28 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[108] * value;

    let value = (column7 - *oods_values[109]) / (point - pow30 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[109] * value;

    let value = (column7 - *oods_values[110]) / (point - pow31 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[110] * value;

    let value = (column7 - *oods_values[111]) / (point - pow32 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[111] * value;

    let value = (column7 - *oods_values[112]) / (point - pow34 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[112] * value;

    let value = (column7 - *oods_values[113]) / (point - pow35 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[113] * value;

    let value = (column7 - *oods_values[114]) / (point - pow36 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[114] * value;

    let value = (column7 - *oods_values[115]) / (point - pow38 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[115] * value;

    let value = (column7 - *oods_values[116]) / (point - pow40 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[116] * value;

    let value = (column7 - *oods_values[117]) / (point - pow41 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[117] * value;

    let value = (column7 - *oods_values[118]) / (point - pow44 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[118] * value;

    let value = (column7 - *oods_values[119]) / (point - pow47 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[119] * value;

    let value = (column7 - *oods_values[120]) / (point - pow50 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[120] * value;

    let value = (column7 - *oods_values[121]) / (point - pow57 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[121] * value;

    let value = (column7 - *oods_values[122]) / (point - pow60 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[122] * value;

    let value = (column7 - *oods_values[123]) / (point - pow72 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[123] * value;

    let value = (column7 - *oods_values[124]) / (point - pow77 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[124] * value;

    let value = (column7 - *oods_values[125]) / (point - pow79 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[125] * value;

    let value = (column7 - *oods_values[126]) / (point - pow83 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[126] * value;

    let value = (column7 - *oods_values[127]) / (point - pow88 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[127] * value;

    let value = (column7 - *oods_values[128]) / (point - pow90 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[128] * value;

    let value = (column7 - *oods_values[129]) / (point - pow93 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[129] * value;

    let value = (column7 - *oods_values[130]) / (point - pow96 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[130] * value;

    let value = (column7 - *oods_values[131]) / (point - pow97 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[131] * value;

    let value = (column7 - *oods_values[132]) / (point - pow99 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[132] * value;

    let value = (column7 - *oods_values[133]) / (point - pow102 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[133] * value;

    let value = (column7 - *oods_values[134]) / (point - pow103 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[134] * value;

    let value = (column7 - *oods_values[135]) / (point - pow106 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[135] * value;

    let value = (column7 - *oods_values[136]) / (point - pow112 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[136] * value;

    let value = (column7 - *oods_values[137]) / (point - pow114 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[137] * value;

    let value = (column7 - *oods_values[138]) / (point - pow117 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[138] * value;

    let value = (column7 - *oods_values[139]) / (point - pow118 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[139] * value;

    let value = (column7 - *oods_values[140]) / (point - pow120 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[140] * value;

    let value = (column7 - *oods_values[141]) / (point - pow136 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[141] * value;

    let value = (column7 - *oods_values[142]) / (point - pow143 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[142] * value;

    let value = (column7 - *oods_values[143]) / (point - pow166 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[143] * value;

    let value = (column7 - *oods_values[144]) / (point - pow168 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[144] * value;

    let value = (column7 - *oods_values[145]) / (point - pow170 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[145] * value;

    let value = (column7 - *oods_values[146]) / (point - pow174 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[146] * value;

    let value = (column7 - *oods_values[147]) / (point - pow191 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[147] * value;

    let value = (column7 - *oods_values[148]) / (point - pow176 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[148] * value;

    let value = (column7 - *oods_values[149]) / (point - pow179 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[149] * value;

    let value = (column7 - *oods_values[150]) / (point - pow180 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[150] * value;

    let value = (column7 - *oods_values[151]) / (point - pow181 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[151] * value;

    let value = (column7 - *oods_values[152]) / (point - pow182 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[152] * value;

    let value = (column7 - *oods_values[153]) / (point - pow192 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[153] * value;

    let value = (column7 - *oods_values[154]) / (point - pow183 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[154] * value;

    let value = (column7 - *oods_values[155]) / (point - pow186 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[155] * value;

    let value = (column7 - *oods_values[156]) / (point - pow189 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[156] * value;

    let value = (column7 - *oods_values[157]) / (point - pow190 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[157] * value;

    let value = (column8 - *oods_values[158]) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[158] * value;

    let value = (column8 - *oods_values[159]) / (point - pow17 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[159] * value;

    let value = (column8 - *oods_values[160]) / (point - pow24 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[160] * value;

    let value = (column8 - *oods_values[161]) / (point - pow25 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[161] * value;

    let value = (column8 - *oods_values[162]) / (point - pow26 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[162] * value;

    let value = (column8 - *oods_values[163]) / (point - pow27 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[163] * value;

    let value = (column8 - *oods_values[164]) / (point - pow28 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[164] * value;

    let value = (column8 - *oods_values[165]) / (point - pow30 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[165] * value;

    let value = (column8 - *oods_values[166]) / (point - pow31 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[166] * value;

    let value = (column8 - *oods_values[167]) / (point - pow32 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[167] * value;

    let value = (column8 - *oods_values[168]) / (point - pow33 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[168] * value;

    let value = (column8 - *oods_values[169]) / (point - pow34 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[169] * value;

    let value = (column8 - *oods_values[170]) / (point - pow35 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[170] * value;

    let value = (column8 - *oods_values[171]) / (point - pow36 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[171] * value;

    let value = (column8 - *oods_values[172]) / (point - pow37 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[172] * value;

    let value = (column8 - *oods_values[173]) / (point - pow39 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[173] * value;

    let value = (column8 - *oods_values[174]) / (point - pow40 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[174] * value;

    let value = (column8 - *oods_values[175]) / (point - pow41 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[175] * value;

    let value = (column8 - *oods_values[176]) / (point - pow42 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[176] * value;

    let value = (column8 - *oods_values[177]) / (point - pow43 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[177] * value;

    let value = (column8 - *oods_values[178]) / (point - pow45 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[178] * value;

    let value = (column8 - *oods_values[179]) / (point - pow46 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[179] * value;

    let value = (column8 - *oods_values[180]) / (point - pow47 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[180] * value;

    let value = (column8 - *oods_values[181]) / (point - pow48 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[181] * value;

    let value = (column8 - *oods_values[182]) / (point - pow49 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[182] * value;

    let value = (column8 - *oods_values[183]) / (point - pow50 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[183] * value;

    let value = (column8 - *oods_values[184]) / (point - pow51 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[184] * value;

    let value = (column8 - *oods_values[185]) / (point - pow52 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[185] * value;

    let value = (column8 - *oods_values[186]) / (point - pow53 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[186] * value;

    let value = (column8 - *oods_values[187]) / (point - pow55 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[187] * value;

    let value = (column8 - *oods_values[188]) / (point - pow56 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[188] * value;

    let value = (column8 - *oods_values[189]) / (point - pow58 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[189] * value;

    let value = (column8 - *oods_values[190]) / (point - pow59 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[190] * value;

    let value = (column8 - *oods_values[191]) / (point - pow60 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[191] * value;

    let value = (column8 - *oods_values[192]) / (point - pow61 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[192] * value;

    let value = (column8 - *oods_values[193]) / (point - pow62 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[193] * value;

    let value = (column8 - *oods_values[194]) / (point - pow63 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[194] * value;

    let value = (column8 - *oods_values[195]) / (point - pow69 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[195] * value;

    let value = (column8 - *oods_values[196]) / (point - pow70 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[196] * value;

    let value = (column8 - *oods_values[197]) / (point - pow71 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[197] * value;

    let value = (column8 - *oods_values[198]) / (point - pow72 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[198] * value;

    let value = (column8 - *oods_values[199]) / (point - pow73 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[199] * value;

    let value = (column8 - *oods_values[200]) / (point - pow75 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[200] * value;

    let value = (column8 - *oods_values[201]) / (point - pow76 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[201] * value;

    let value = (column8 - *oods_values[202]) / (point - pow78 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[202] * value;

    let value = (column8 - *oods_values[203]) / (point - pow79 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[203] * value;

    let value = (column8 - *oods_values[204]) / (point - pow80 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[204] * value;

    let value = (column8 - *oods_values[205]) / (point - pow81 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[205] * value;

    let value = (column8 - *oods_values[206]) / (point - pow82 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[206] * value;

    let value = (column8 - *oods_values[207]) / (point - pow83 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[207] * value;

    let value = (column8 - *oods_values[208]) / (point - pow84 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[208] * value;

    let value = (column8 - *oods_values[209]) / (point - pow87 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[209] * value;

    let value = (column8 - *oods_values[210]) / (point - pow89 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[210] * value;

    let value = (column8 - *oods_values[211]) / (point - pow90 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[211] * value;

    let value = (column8 - *oods_values[212]) / (point - pow91 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[212] * value;

    let value = (column8 - *oods_values[213]) / (point - pow92 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[213] * value;

    let value = (column8 - *oods_values[214]) / (point - pow98 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[214] * value;

    let value = (column8 - *oods_values[215]) / (point - pow104 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[215] * value;

    let value = (column8 - *oods_values[216]) / (point - pow107 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[216] * value;

    let value = (column8 - *oods_values[217]) / (point - pow113 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[217] * value;

    let value = (column8 - *oods_values[218]) / (point - pow115 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[218] * value;

    let value = (column8 - *oods_values[219]) / (point - pow116 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[219] * value;

    let value = (column8 - *oods_values[220]) / (point - pow119 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[220] * value;

    let value = (column8 - *oods_values[221]) / (point - pow121 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[221] * value;

    let value = (column8 - *oods_values[222]) / (point - pow133 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[222] * value;

    let value = (column8 - *oods_values[223]) / (point - pow144 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[223] * value;

    let value = (column8 - *oods_values[224]) / (point - pow147 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[224] * value;

    let value = (column8 - *oods_values[225]) / (point - pow148 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[225] * value;

    let value = (column8 - *oods_values[226]) / (point - pow149 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[226] * value;

    let value = (column8 - *oods_values[227]) / (point - pow150 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[227] * value;

    let value = (column8 - *oods_values[228]) / (point - pow153 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[228] * value;

    let value = (column8 - *oods_values[229]) / (point - pow154 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[229] * value;

    let value = (column8 - *oods_values[230]) / (point - pow155 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[230] * value;

    let value = (column8 - *oods_values[231]) / (point - pow156 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[231] * value;

    let value = (column8 - *oods_values[232]) / (point - pow162 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[232] * value;

    let value = (column8 - *oods_values[233]) / (point - pow164 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[233] * value;

    let value = (column8 - *oods_values[234]) / (point - pow165 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[234] * value;

    let value = (column8 - *oods_values[235]) / (point - pow167 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[235] * value;

    let value = (column8 - *oods_values[236]) / (point - pow169 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[236] * value;

    let value = (column8 - *oods_values[237]) / (point - pow171 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[237] * value;

    let value = (column8 - *oods_values[238]) / (point - pow8 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[238] * value;

    let value = (column8 - *oods_values[239]) / (point - pow7 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[239] * value;

    let value = (column8 - *oods_values[240]) / (point - pow138 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[240] * value;

    let value = (column8 - *oods_values[241]) / (point - pow137 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[241] * value;

    let value = (column8 - *oods_values[242]) / (point - pow6 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[242] * value;

    let value = (column8 - *oods_values[243]) / (point - pow5 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[243] * value;

    let value = (column8 - *oods_values[244]) / (point - pow4 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[244] * value;

    let value = (column8 - *oods_values[245]) / (point - pow29 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[245] * value;

    let value = (column8 - *oods_values[246]) / (point - pow124 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[246] * value;

    let value = (column8 - *oods_values[247]) / (point - pow125 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[247] * value;

    let value = (column8 - *oods_values[248]) / (point - pow126 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[248] * value;

    let value = (column8 - *oods_values[249]) / (point - pow127 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[249] * value;

    let value = (column8 - *oods_values[250]) / (point - pow128 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[250] * value;

    let value = (column8 - *oods_values[251]) / (point - pow129 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[251] * value;

    let value = (column8 - *oods_values[252]) / (point - pow130 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[252] * value;

    let value = (column8 - *oods_values[253]) / (point - pow131 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[253] * value;

    let value = (column8 - *oods_values[254]) / (point - pow132 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[254] * value;

    let value = (column8 - *oods_values[255]) / (point - pow3 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[255] * value;

    let value = (column8 - *oods_values[256]) / (point - pow2 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[256] * value;

    let value = (column8 - *oods_values[257]) / (point - pow1 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[257] * value;

    let value = (column8 - *oods_values[258]) / (point - pow64 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[258] * value;

    let value = (column8 - *oods_values[259]) / (point - pow65 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[259] * value;

    let value = (column8 - *oods_values[260]) / (point - pow66 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[260] * value;

    let value = (column8 - *oods_values[261]) / (point - pow67 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[261] * value;

    let value = (column8 - *oods_values[262]) / (point - pow68 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[262] * value;

    let value = (column9 - *oods_values[263]) / (point - pow0 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[263] * value;

    let value = (column9 - *oods_values[264]) / (point - pow17 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[264] * value;

    let value = (column9 - *oods_values[265]) / (point - pow24 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[265] * value;

    let value = (column9 - *oods_values[266]) / (point - pow25 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[266] * value;

    let value = (column9 - *oods_values[267]) / (point - pow27 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[267] * value;

    let value = (column9 - *oods_values[268]) / (point - pow30 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[268] * value;

    let value = (column9 - *oods_values[269]) / (point - pow34 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[269] * value;

    let value = (column9 - *oods_values[270]) / (point - pow38 * oods_point);
    let total_sum = total_sum + *constraint_coefficients[270] * value;

    // Sum the OODS boundary constraints on the composition polynomials.
    let oods_point_to_deg = pow(oods_point, CONSTRAINT_DEGREE.into());

    let value = (*column_values[NUM_COLUMNS_FIRST + NUM_COLUMNS_SECOND] - *oods_values[271])
        / (point - oods_point_to_deg);
    let total_sum = total_sum + *constraint_coefficients[271] * value;

    let value = (*column_values[NUM_COLUMNS_FIRST + NUM_COLUMNS_SECOND + 1] - *oods_values[272])
        / (point - oods_point_to_deg);
    let total_sum = total_sum + *constraint_coefficients[272] * value;

    assert(273 == MASK_SIZE + CONSTRAINT_DEGREE, 'Invalid value');
    total_sum
}
