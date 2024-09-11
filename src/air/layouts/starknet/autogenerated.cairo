use core::array::SpanTrait;
use core::array::ArrayTrait;
use cairo_verifier::{
    air::layouts::starknet::{
        global_values::GlobalValues,
        constants::{CONSTRAINT_DEGREE, NUM_COLUMNS_FIRST, NUM_COLUMNS_SECOND, MASK_SIZE}
    },
    common::math::{Felt252Div, pow},
};

fn eval_composition_polynomial_inner(
    mut mask_values: Span<felt252>,
    mut constraint_coefficients: Span<felt252>,
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
    let column0_row0 = *mask_values.pop_front().unwrap();
    let column0_row1 = *mask_values.pop_front().unwrap();
    let column0_row2 = *mask_values.pop_front().unwrap();
    let column0_row3 = *mask_values.pop_front().unwrap();
    let column0_row4 = *mask_values.pop_front().unwrap();
    let column0_row5 = *mask_values.pop_front().unwrap();
    let column0_row6 = *mask_values.pop_front().unwrap();
    let column0_row7 = *mask_values.pop_front().unwrap();
    let column0_row8 = *mask_values.pop_front().unwrap();
    let column0_row9 = *mask_values.pop_front().unwrap();
    let column0_row10 = *mask_values.pop_front().unwrap();
    let column0_row11 = *mask_values.pop_front().unwrap();
    let column0_row12 = *mask_values.pop_front().unwrap();
    let column0_row13 = *mask_values.pop_front().unwrap();
    let column0_row14 = *mask_values.pop_front().unwrap();
    let column0_row15 = *mask_values.pop_front().unwrap();
    let column1_row0 = *mask_values.pop_front().unwrap();
    let column1_row1 = *mask_values.pop_front().unwrap();
    let column1_row255 = *mask_values.pop_front().unwrap();
    let column1_row256 = *mask_values.pop_front().unwrap();
    let column1_row511 = *mask_values.pop_front().unwrap();
    let column2_row0 = *mask_values.pop_front().unwrap();
    let column2_row1 = *mask_values.pop_front().unwrap();
    let column2_row255 = *mask_values.pop_front().unwrap();
    let column2_row256 = *mask_values.pop_front().unwrap();
    let column3_row0 = *mask_values.pop_front().unwrap();
    let column3_row1 = *mask_values.pop_front().unwrap();
    let column3_row192 = *mask_values.pop_front().unwrap();
    let column3_row193 = *mask_values.pop_front().unwrap();
    let column3_row196 = *mask_values.pop_front().unwrap();
    let column3_row197 = *mask_values.pop_front().unwrap();
    let column3_row251 = *mask_values.pop_front().unwrap();
    let column3_row252 = *mask_values.pop_front().unwrap();
    let column3_row256 = *mask_values.pop_front().unwrap();
    let column4_row0 = *mask_values.pop_front().unwrap();
    let column4_row255 = *mask_values.pop_front().unwrap();
    let column5_row0 = *mask_values.pop_front().unwrap();
    let column5_row1 = *mask_values.pop_front().unwrap();
    let column5_row2 = *mask_values.pop_front().unwrap();
    let column5_row3 = *mask_values.pop_front().unwrap();
    let column5_row4 = *mask_values.pop_front().unwrap();
    let column5_row5 = *mask_values.pop_front().unwrap();
    let column5_row6 = *mask_values.pop_front().unwrap();
    let column5_row7 = *mask_values.pop_front().unwrap();
    let column5_row8 = *mask_values.pop_front().unwrap();
    let column5_row9 = *mask_values.pop_front().unwrap();
    let column5_row12 = *mask_values.pop_front().unwrap();
    let column5_row13 = *mask_values.pop_front().unwrap();
    let column5_row16 = *mask_values.pop_front().unwrap();
    let column5_row38 = *mask_values.pop_front().unwrap();
    let column5_row39 = *mask_values.pop_front().unwrap();
    let column5_row70 = *mask_values.pop_front().unwrap();
    let column5_row71 = *mask_values.pop_front().unwrap();
    let column5_row102 = *mask_values.pop_front().unwrap();
    let column5_row103 = *mask_values.pop_front().unwrap();
    let column5_row134 = *mask_values.pop_front().unwrap();
    let column5_row135 = *mask_values.pop_front().unwrap();
    let column5_row166 = *mask_values.pop_front().unwrap();
    let column5_row167 = *mask_values.pop_front().unwrap();
    let column5_row198 = *mask_values.pop_front().unwrap();
    let column5_row199 = *mask_values.pop_front().unwrap();
    let column5_row262 = *mask_values.pop_front().unwrap();
    let column5_row263 = *mask_values.pop_front().unwrap();
    let column5_row294 = *mask_values.pop_front().unwrap();
    let column5_row295 = *mask_values.pop_front().unwrap();
    let column5_row326 = *mask_values.pop_front().unwrap();
    let column5_row358 = *mask_values.pop_front().unwrap();
    let column5_row359 = *mask_values.pop_front().unwrap();
    let column5_row390 = *mask_values.pop_front().unwrap();
    let column5_row391 = *mask_values.pop_front().unwrap();
    let column5_row422 = *mask_values.pop_front().unwrap();
    let column5_row423 = *mask_values.pop_front().unwrap();
    let column5_row454 = *mask_values.pop_front().unwrap();
    let column5_row518 = *mask_values.pop_front().unwrap();
    let column5_row711 = *mask_values.pop_front().unwrap();
    let column5_row902 = *mask_values.pop_front().unwrap();
    let column5_row903 = *mask_values.pop_front().unwrap();
    let column5_row966 = *mask_values.pop_front().unwrap();
    let column5_row967 = *mask_values.pop_front().unwrap();
    let column5_row1222 = *mask_values.pop_front().unwrap();
    let column5_row2438 = *mask_values.pop_front().unwrap();
    let column5_row2439 = *mask_values.pop_front().unwrap();
    let column5_row4486 = *mask_values.pop_front().unwrap();
    let column5_row4487 = *mask_values.pop_front().unwrap();
    let column5_row6534 = *mask_values.pop_front().unwrap();
    let column5_row6535 = *mask_values.pop_front().unwrap();
    let column5_row8582 = *mask_values.pop_front().unwrap();
    let column5_row8583 = *mask_values.pop_front().unwrap();
    let column5_row10630 = *mask_values.pop_front().unwrap();
    let column5_row10631 = *mask_values.pop_front().unwrap();
    let column5_row12678 = *mask_values.pop_front().unwrap();
    let column5_row12679 = *mask_values.pop_front().unwrap();
    let column5_row14726 = *mask_values.pop_front().unwrap();
    let column5_row14727 = *mask_values.pop_front().unwrap();
    let column5_row16774 = *mask_values.pop_front().unwrap();
    let column5_row16775 = *mask_values.pop_front().unwrap();
    let column5_row24966 = *mask_values.pop_front().unwrap();
    let column5_row33158 = *mask_values.pop_front().unwrap();
    let column6_row0 = *mask_values.pop_front().unwrap();
    let column6_row1 = *mask_values.pop_front().unwrap();
    let column6_row2 = *mask_values.pop_front().unwrap();
    let column6_row3 = *mask_values.pop_front().unwrap();
    let column7_row0 = *mask_values.pop_front().unwrap();
    let column7_row1 = *mask_values.pop_front().unwrap();
    let column7_row2 = *mask_values.pop_front().unwrap();
    let column7_row3 = *mask_values.pop_front().unwrap();
    let column7_row4 = *mask_values.pop_front().unwrap();
    let column7_row5 = *mask_values.pop_front().unwrap();
    let column7_row6 = *mask_values.pop_front().unwrap();
    let column7_row7 = *mask_values.pop_front().unwrap();
    let column7_row8 = *mask_values.pop_front().unwrap();
    let column7_row9 = *mask_values.pop_front().unwrap();
    let column7_row11 = *mask_values.pop_front().unwrap();
    let column7_row12 = *mask_values.pop_front().unwrap();
    let column7_row13 = *mask_values.pop_front().unwrap();
    let column7_row15 = *mask_values.pop_front().unwrap();
    let column7_row17 = *mask_values.pop_front().unwrap();
    let column7_row19 = *mask_values.pop_front().unwrap();
    let column7_row23 = *mask_values.pop_front().unwrap();
    let column7_row27 = *mask_values.pop_front().unwrap();
    let column7_row33 = *mask_values.pop_front().unwrap();
    let column7_row44 = *mask_values.pop_front().unwrap();
    let column7_row49 = *mask_values.pop_front().unwrap();
    let column7_row65 = *mask_values.pop_front().unwrap();
    let column7_row76 = *mask_values.pop_front().unwrap();
    let column7_row81 = *mask_values.pop_front().unwrap();
    let column7_row97 = *mask_values.pop_front().unwrap();
    let column7_row108 = *mask_values.pop_front().unwrap();
    let column7_row113 = *mask_values.pop_front().unwrap();
    let column7_row129 = *mask_values.pop_front().unwrap();
    let column7_row140 = *mask_values.pop_front().unwrap();
    let column7_row145 = *mask_values.pop_front().unwrap();
    let column7_row161 = *mask_values.pop_front().unwrap();
    let column7_row172 = *mask_values.pop_front().unwrap();
    let column7_row177 = *mask_values.pop_front().unwrap();
    let column7_row193 = *mask_values.pop_front().unwrap();
    let column7_row204 = *mask_values.pop_front().unwrap();
    let column7_row209 = *mask_values.pop_front().unwrap();
    let column7_row225 = *mask_values.pop_front().unwrap();
    let column7_row236 = *mask_values.pop_front().unwrap();
    let column7_row241 = *mask_values.pop_front().unwrap();
    let column7_row257 = *mask_values.pop_front().unwrap();
    let column7_row265 = *mask_values.pop_front().unwrap();
    let column7_row491 = *mask_values.pop_front().unwrap();
    let column7_row499 = *mask_values.pop_front().unwrap();
    let column7_row507 = *mask_values.pop_front().unwrap();
    let column7_row513 = *mask_values.pop_front().unwrap();
    let column7_row521 = *mask_values.pop_front().unwrap();
    let column7_row705 = *mask_values.pop_front().unwrap();
    let column7_row721 = *mask_values.pop_front().unwrap();
    let column7_row737 = *mask_values.pop_front().unwrap();
    let column7_row753 = *mask_values.pop_front().unwrap();
    let column7_row769 = *mask_values.pop_front().unwrap();
    let column7_row777 = *mask_values.pop_front().unwrap();
    let column7_row961 = *mask_values.pop_front().unwrap();
    let column7_row977 = *mask_values.pop_front().unwrap();
    let column7_row993 = *mask_values.pop_front().unwrap();
    let column7_row1009 = *mask_values.pop_front().unwrap();
    let column8_row0 = *mask_values.pop_front().unwrap();
    let column8_row1 = *mask_values.pop_front().unwrap();
    let column8_row2 = *mask_values.pop_front().unwrap();
    let column8_row3 = *mask_values.pop_front().unwrap();
    let column8_row4 = *mask_values.pop_front().unwrap();
    let column8_row5 = *mask_values.pop_front().unwrap();
    let column8_row6 = *mask_values.pop_front().unwrap();
    let column8_row7 = *mask_values.pop_front().unwrap();
    let column8_row8 = *mask_values.pop_front().unwrap();
    let column8_row9 = *mask_values.pop_front().unwrap();
    let column8_row10 = *mask_values.pop_front().unwrap();
    let column8_row11 = *mask_values.pop_front().unwrap();
    let column8_row12 = *mask_values.pop_front().unwrap();
    let column8_row13 = *mask_values.pop_front().unwrap();
    let column8_row14 = *mask_values.pop_front().unwrap();
    let column8_row16 = *mask_values.pop_front().unwrap();
    let column8_row17 = *mask_values.pop_front().unwrap();
    let column8_row19 = *mask_values.pop_front().unwrap();
    let column8_row21 = *mask_values.pop_front().unwrap();
    let column8_row22 = *mask_values.pop_front().unwrap();
    let column8_row24 = *mask_values.pop_front().unwrap();
    let column8_row25 = *mask_values.pop_front().unwrap();
    let column8_row27 = *mask_values.pop_front().unwrap();
    let column8_row29 = *mask_values.pop_front().unwrap();
    let column8_row30 = *mask_values.pop_front().unwrap();
    let column8_row33 = *mask_values.pop_front().unwrap();
    let column8_row35 = *mask_values.pop_front().unwrap();
    let column8_row37 = *mask_values.pop_front().unwrap();
    let column8_row38 = *mask_values.pop_front().unwrap();
    let column8_row41 = *mask_values.pop_front().unwrap();
    let column8_row43 = *mask_values.pop_front().unwrap();
    let column8_row45 = *mask_values.pop_front().unwrap();
    let column8_row46 = *mask_values.pop_front().unwrap();
    let column8_row49 = *mask_values.pop_front().unwrap();
    let column8_row51 = *mask_values.pop_front().unwrap();
    let column8_row53 = *mask_values.pop_front().unwrap();
    let column8_row54 = *mask_values.pop_front().unwrap();
    let column8_row57 = *mask_values.pop_front().unwrap();
    let column8_row59 = *mask_values.pop_front().unwrap();
    let column8_row61 = *mask_values.pop_front().unwrap();
    let column8_row65 = *mask_values.pop_front().unwrap();
    let column8_row69 = *mask_values.pop_front().unwrap();
    let column8_row71 = *mask_values.pop_front().unwrap();
    let column8_row73 = *mask_values.pop_front().unwrap();
    let column8_row77 = *mask_values.pop_front().unwrap();
    let column8_row81 = *mask_values.pop_front().unwrap();
    let column8_row85 = *mask_values.pop_front().unwrap();
    let column8_row89 = *mask_values.pop_front().unwrap();
    let column8_row91 = *mask_values.pop_front().unwrap();
    let column8_row97 = *mask_values.pop_front().unwrap();
    let column8_row101 = *mask_values.pop_front().unwrap();
    let column8_row105 = *mask_values.pop_front().unwrap();
    let column8_row109 = *mask_values.pop_front().unwrap();
    let column8_row113 = *mask_values.pop_front().unwrap();
    let column8_row117 = *mask_values.pop_front().unwrap();
    let column8_row123 = *mask_values.pop_front().unwrap();
    let column8_row155 = *mask_values.pop_front().unwrap();
    let column8_row187 = *mask_values.pop_front().unwrap();
    let column8_row195 = *mask_values.pop_front().unwrap();
    let column8_row205 = *mask_values.pop_front().unwrap();
    let column8_row219 = *mask_values.pop_front().unwrap();
    let column8_row221 = *mask_values.pop_front().unwrap();
    let column8_row237 = *mask_values.pop_front().unwrap();
    let column8_row245 = *mask_values.pop_front().unwrap();
    let column8_row253 = *mask_values.pop_front().unwrap();
    let column8_row269 = *mask_values.pop_front().unwrap();
    let column8_row301 = *mask_values.pop_front().unwrap();
    let column8_row309 = *mask_values.pop_front().unwrap();
    let column8_row310 = *mask_values.pop_front().unwrap();
    let column8_row318 = *mask_values.pop_front().unwrap();
    let column8_row326 = *mask_values.pop_front().unwrap();
    let column8_row334 = *mask_values.pop_front().unwrap();
    let column8_row342 = *mask_values.pop_front().unwrap();
    let column8_row350 = *mask_values.pop_front().unwrap();
    let column8_row451 = *mask_values.pop_front().unwrap();
    let column8_row461 = *mask_values.pop_front().unwrap();
    let column8_row477 = *mask_values.pop_front().unwrap();
    let column8_row493 = *mask_values.pop_front().unwrap();
    let column8_row501 = *mask_values.pop_front().unwrap();
    let column8_row509 = *mask_values.pop_front().unwrap();
    let column8_row12309 = *mask_values.pop_front().unwrap();
    let column8_row12373 = *mask_values.pop_front().unwrap();
    let column8_row12565 = *mask_values.pop_front().unwrap();
    let column8_row12629 = *mask_values.pop_front().unwrap();
    let column8_row16085 = *mask_values.pop_front().unwrap();
    let column8_row16149 = *mask_values.pop_front().unwrap();
    let column8_row16325 = *mask_values.pop_front().unwrap();
    let column8_row16331 = *mask_values.pop_front().unwrap();
    let column8_row16337 = *mask_values.pop_front().unwrap();
    let column8_row16339 = *mask_values.pop_front().unwrap();
    let column8_row16355 = *mask_values.pop_front().unwrap();
    let column8_row16357 = *mask_values.pop_front().unwrap();
    let column8_row16363 = *mask_values.pop_front().unwrap();
    let column8_row16369 = *mask_values.pop_front().unwrap();
    let column8_row16371 = *mask_values.pop_front().unwrap();
    let column8_row16385 = *mask_values.pop_front().unwrap();
    let column8_row16417 = *mask_values.pop_front().unwrap();
    let column8_row32647 = *mask_values.pop_front().unwrap();
    let column8_row32667 = *mask_values.pop_front().unwrap();
    let column8_row32715 = *mask_values.pop_front().unwrap();
    let column8_row32721 = *mask_values.pop_front().unwrap();
    let column8_row32731 = *mask_values.pop_front().unwrap();
    let column8_row32747 = *mask_values.pop_front().unwrap();
    let column8_row32753 = *mask_values.pop_front().unwrap();
    let column8_row32763 = *mask_values.pop_front().unwrap();
    let column9_inter1_row0 = *mask_values.pop_front().unwrap();
    let column9_inter1_row1 = *mask_values.pop_front().unwrap();
    let column9_inter1_row2 = *mask_values.pop_front().unwrap();
    let column9_inter1_row3 = *mask_values.pop_front().unwrap();
    let column9_inter1_row5 = *mask_values.pop_front().unwrap();
    let column9_inter1_row7 = *mask_values.pop_front().unwrap();
    let column9_inter1_row11 = *mask_values.pop_front().unwrap();
    let column9_inter1_row15 = *mask_values.pop_front().unwrap();

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
    let mut total_sum = 0;

    let constraints = array![
        (cpu_decode_opcode_range_check_bit_0 * cpu_decode_opcode_range_check_bit_0
            - cpu_decode_opcode_range_check_bit_0)
            * domain4,
        domain0,
        (column0_row0),
        domain4,
        (column5_row1
            - (((column0_row0 * global_values.offset_size + column7_row4)
                * global_values.offset_size
                + column7_row8)
                * global_values.offset_size
                + column7_row0)),
        domain5,
        (cpu_decode_flag_op1_base_op0_0 * cpu_decode_flag_op1_base_op0_0
            - cpu_decode_flag_op1_base_op0_0),
        domain5,
        (cpu_decode_flag_res_op1_0 * cpu_decode_flag_res_op1_0 - cpu_decode_flag_res_op1_0),
        domain5,
        (cpu_decode_flag_pc_update_regular_0 * cpu_decode_flag_pc_update_regular_0
            - cpu_decode_flag_pc_update_regular_0),
        domain5,
        (cpu_decode_fp_update_regular_0 * cpu_decode_fp_update_regular_0
            - cpu_decode_fp_update_regular_0),
        domain5,
        (column5_row8
            + global_values.half_offset_size
            - (cpu_decode_opcode_range_check_bit_0 * column8_row8
                + (1 - cpu_decode_opcode_range_check_bit_0) * column8_row0
                + column7_row0)),
        domain5,
        (column5_row4
            + global_values.half_offset_size
            - (cpu_decode_opcode_range_check_bit_1 * column8_row8
                + (1 - cpu_decode_opcode_range_check_bit_1) * column8_row0
                + column7_row8)),
        domain5,
        (column5_row12
            + global_values.half_offset_size
            - (cpu_decode_opcode_range_check_bit_2 * column5_row0
                + cpu_decode_opcode_range_check_bit_4 * column8_row0
                + cpu_decode_opcode_range_check_bit_3 * column8_row8
                + cpu_decode_flag_op1_base_op0_0 * column5_row5
                + column7_row4)),
        domain5,
        (column8_row4 - column5_row5 * column5_row13),
        domain5,
        ((1 - cpu_decode_opcode_range_check_bit_9) * column8_row12
            - (cpu_decode_opcode_range_check_bit_5 * (column5_row5 + column5_row13)
                + cpu_decode_opcode_range_check_bit_6 * column8_row4
                + cpu_decode_flag_res_op1_0 * column5_row13)),
        domain5,
        (column8_row2 - cpu_decode_opcode_range_check_bit_9 * column5_row9) * domain28,
        domain5,
        (column8_row10 - column8_row2 * column8_row12) * domain28,
        domain5,
        ((1 - cpu_decode_opcode_range_check_bit_9) * column5_row16
            + column8_row2 * (column5_row16 - (column5_row0 + column5_row13))
            - (cpu_decode_flag_pc_update_regular_0 * npc_reg_0
                + cpu_decode_opcode_range_check_bit_7 * column8_row12
                + cpu_decode_opcode_range_check_bit_8 * (column5_row0 + column8_row12)))
            * domain28,
        domain5,
        ((column8_row10 - cpu_decode_opcode_range_check_bit_9) * (column5_row16 - npc_reg_0))
            * domain28,
        domain5,
        (column8_row16
            - (column8_row0
                + cpu_decode_opcode_range_check_bit_10 * column8_row12
                + cpu_decode_opcode_range_check_bit_11
                + cpu_decode_opcode_range_check_bit_12 * 2))
            * domain28,
        domain5,
        (column8_row24
            - (cpu_decode_fp_update_regular_0 * column8_row8
                + cpu_decode_opcode_range_check_bit_13 * column5_row9
                + cpu_decode_opcode_range_check_bit_12 * (column8_row0 + 2)))
            * domain28,
        domain5,
        (cpu_decode_opcode_range_check_bit_12 * (column5_row9 - column8_row8)),
        domain5,
        (cpu_decode_opcode_range_check_bit_12
            * (column5_row5 - (column5_row0 + cpu_decode_opcode_range_check_bit_2 + 1))),
        domain5,
        (cpu_decode_opcode_range_check_bit_12 * (column7_row0 - global_values.half_offset_size)),
        domain5,
        (cpu_decode_opcode_range_check_bit_12
            * (column7_row8 - (global_values.half_offset_size + 1))),
        domain5,
        (cpu_decode_opcode_range_check_bit_12
            * (cpu_decode_opcode_range_check_bit_12
                + cpu_decode_opcode_range_check_bit_12
                + 1
                + 1
                - (cpu_decode_opcode_range_check_bit_0 + cpu_decode_opcode_range_check_bit_1 + 4))),
        domain5,
        (cpu_decode_opcode_range_check_bit_13
            * (column7_row0 + 2 - global_values.half_offset_size)),
        domain5,
        (cpu_decode_opcode_range_check_bit_13
            * (column7_row4 + 1 - global_values.half_offset_size)),
        domain5,
        (cpu_decode_opcode_range_check_bit_13
            * (cpu_decode_opcode_range_check_bit_7
                + cpu_decode_opcode_range_check_bit_0
                + cpu_decode_opcode_range_check_bit_3
                + cpu_decode_flag_res_op1_0
                - 4)),
        domain5,
        (cpu_decode_opcode_range_check_bit_14 * (column5_row9 - column8_row12)),
        domain5,
        (column8_row0 - global_values.initial_ap),
        domain29,
        (column8_row8 - global_values.initial_ap),
        domain29,
        (column5_row0 - global_values.initial_pc),
        domain29,
        (column8_row0 - global_values.final_ap),
        domain28,
        (column8_row8 - global_values.initial_ap),
        domain28,
        (column5_row0 - global_values.final_pc),
        domain28,
        ((global_values.memory_multi_column_perm_perm_interaction_elm
            - (column6_row0
                + global_values.memory_multi_column_perm_hash_interaction_elm0 * column6_row1))
            * column9_inter1_row0
            + column5_row0
            + global_values.memory_multi_column_perm_hash_interaction_elm0 * column5_row1
            - global_values.memory_multi_column_perm_perm_interaction_elm),
        domain29,
        ((global_values.memory_multi_column_perm_perm_interaction_elm
            - (column6_row2
                + global_values.memory_multi_column_perm_hash_interaction_elm0 * column6_row3))
            * column9_inter1_row2
            - (global_values.memory_multi_column_perm_perm_interaction_elm
                - (column5_row2
                    + global_values.memory_multi_column_perm_hash_interaction_elm0 * column5_row3))
                * column9_inter1_row0)
            * domain30,
        domain1,
        (column9_inter1_row0 - global_values.memory_multi_column_perm_perm_public_memory_prod),
        domain30,
        (memory_address_diff_0 * memory_address_diff_0 - memory_address_diff_0) * domain30,
        domain1,
        ((memory_address_diff_0 - 1) * (column6_row1 - column6_row3)) * domain30,
        domain1,
        (column6_row0 - 1),
        domain29,
        (column5_row2),
        domain3,
        (column5_row3),
        domain3,
        ((global_values.range_check16_perm_interaction_elm - column7_row2) * column9_inter1_row1
            + column7_row0
            - global_values.range_check16_perm_interaction_elm),
        domain29,
        ((global_values.range_check16_perm_interaction_elm - column7_row6) * column9_inter1_row5
            - (global_values.range_check16_perm_interaction_elm - column7_row4)
                * column9_inter1_row1)
            * domain31,
        domain2,
        (column9_inter1_row1 - global_values.range_check16_perm_public_memory_prod),
        domain31,
        (range_check16_diff_0 * range_check16_diff_0 - range_check16_diff_0) * domain31,
        domain2,
        (column7_row2 - global_values.range_check_min),
        domain29,
        (column7_row2 - global_values.range_check_max),
        domain31,
        ((global_values.diluted_check_permutation_interaction_elm - column7_row5)
            * column9_inter1_row7
            + column7_row1
            - global_values.diluted_check_permutation_interaction_elm),
        domain29,
        ((global_values.diluted_check_permutation_interaction_elm - column7_row13)
            * column9_inter1_row15
            - (global_values.diluted_check_permutation_interaction_elm - column7_row9)
                * column9_inter1_row7)
            * domain32,
        domain3,
        (column9_inter1_row7 - global_values.diluted_check_permutation_public_memory_prod),
        domain32,
        (column9_inter1_row3 - 1),
        domain29,
        (column7_row5 - global_values.diluted_check_first_elm),
        domain29,
        (column9_inter1_row11
            - (column9_inter1_row3
                * (1 + global_values.diluted_check_interaction_z * (column7_row13 - column7_row5))
                + global_values.diluted_check_interaction_alpha
                    * (column7_row13 - column7_row5)
                    * (column7_row13 - column7_row5)))
            * domain32,
        domain3,
        (column9_inter1_row3 - global_values.diluted_check_final_cum_val),
        domain32,
        (column8_row71 * (column3_row0 - (column3_row1 + column3_row1))),
        domain8,
        (column8_row71
            * (column3_row1
                - 3138550867693340381917894711603833208051177722232017256448 * column3_row192)),
        domain8,
        (column8_row71 - column4_row255 * (column3_row192 - (column3_row193 + column3_row193))),
        domain8,
        (column4_row255 * (column3_row193 - 8 * column3_row196)),
        domain8,
        (column4_row255
            - (column3_row251 - (column3_row252 + column3_row252))
                * (column3_row196 - (column3_row197 + column3_row197))),
        domain8,
        ((column3_row251 - (column3_row252 + column3_row252))
            * (column3_row197 - 18014398509481984 * column3_row251)),
        domain8,
        (pedersen_hash0_ec_subset_sum_bit_0 * (pedersen_hash0_ec_subset_sum_bit_0 - 1)) * domain9,
        domain0,
        (column3_row0),
        domain10,
        (column3_row0),
        domain9,
        (pedersen_hash0_ec_subset_sum_bit_0 * (column2_row0 - global_values.pedersen_points_y)
            - column4_row0 * (column1_row0 - global_values.pedersen_points_x))
            * domain9,
        domain0,
        (column4_row0 * column4_row0
            - pedersen_hash0_ec_subset_sum_bit_0
                * (column1_row0 + global_values.pedersen_points_x + column1_row1))
            * domain9,
        domain0,
        (pedersen_hash0_ec_subset_sum_bit_0 * (column2_row0 + column2_row1)
            - column4_row0 * (column1_row0 - column1_row1))
            * domain9,
        domain0,
        (pedersen_hash0_ec_subset_sum_bit_neg_0 * (column1_row1 - column1_row0)) * domain9,
        domain0,
        (pedersen_hash0_ec_subset_sum_bit_neg_0 * (column2_row1 - column2_row0)) * domain9,
        domain0,
        (column1_row256 - column1_row255) * domain12,
        domain8,
        (column2_row256 - column2_row255) * domain12,
        domain8,
        (column1_row0 - global_values.pedersen_shift_point.x),
        domain13,
        (column2_row0 - global_values.pedersen_shift_point.y),
        domain13,
        (column5_row7 - column3_row0),
        domain13,
        (column5_row518 - (column5_row134 + 1)) * domain33,
        domain13,
        (column5_row6 - global_values.initial_pedersen_addr),
        domain29,
        (column5_row263 - column3_row256),
        domain13,
        (column5_row262 - (column5_row6 + 1)),
        domain13,
        (column5_row135 - column1_row511),
        domain13,
        (column5_row134 - (column5_row262 + 1)),
        domain13,
        (range_check_builtin_value7_0 - column5_row71),
        domain8,
        (column5_row326 - (column5_row70 + 1)) * domain34,
        domain8,
        (column5_row70 - global_values.initial_range_check_addr),
        domain29,
        (ecdsa_signature0_doubling_key_x_squared
            + ecdsa_signature0_doubling_key_x_squared
            + ecdsa_signature0_doubling_key_x_squared
            + global_values.ecdsa_sig_config.alpha
            - (column8_row33 + column8_row33) * column8_row35)
            * domain21,
        domain6,
        (column8_row35 * column8_row35 - (column8_row1 + column8_row1 + column8_row65)) * domain21,
        domain6,
        (column8_row33 + column8_row97 - column8_row35 * (column8_row1 - column8_row65)) * domain21,
        domain6,
        (ecdsa_signature0_exponentiate_generator_bit_0
            * (ecdsa_signature0_exponentiate_generator_bit_0 - 1))
            * domain25,
        domain7,
        (column8_row59),
        domain26,
        (column8_row59),
        domain25,
        (ecdsa_signature0_exponentiate_generator_bit_0
            * (column8_row91 - global_values.ecdsa_generator_points_y)
            - column8_row123 * (column8_row27 - global_values.ecdsa_generator_points_x))
            * domain25,
        domain7,
        (column8_row123 * column8_row123
            - ecdsa_signature0_exponentiate_generator_bit_0
                * (column8_row27 + global_values.ecdsa_generator_points_x + column8_row155))
            * domain25,
        domain7,
        (ecdsa_signature0_exponentiate_generator_bit_0 * (column8_row91 + column8_row219)
            - column8_row123 * (column8_row27 - column8_row155))
            * domain25,
        domain7,
        (column8_row7 * (column8_row27 - global_values.ecdsa_generator_points_x) - 1) * domain25,
        domain7,
        (ecdsa_signature0_exponentiate_generator_bit_neg_0 * (column8_row155 - column8_row27))
            * domain25,
        domain7,
        (ecdsa_signature0_exponentiate_generator_bit_neg_0 * (column8_row219 - column8_row91))
            * domain25,
        domain7,
        (ecdsa_signature0_exponentiate_key_bit_0 * (ecdsa_signature0_exponentiate_key_bit_0 - 1))
            * domain21,
        domain6,
        (column8_row9),
        domain22,
        (column8_row9),
        domain21,
        (ecdsa_signature0_exponentiate_key_bit_0 * (column8_row49 - column8_row33)
            - column8_row19 * (column8_row17 - column8_row1))
            * domain21,
        domain6,
        (column8_row19 * column8_row19
            - ecdsa_signature0_exponentiate_key_bit_0
                * (column8_row17 + column8_row1 + column8_row81))
            * domain21,
        domain6,
        (ecdsa_signature0_exponentiate_key_bit_0 * (column8_row49 + column8_row113)
            - column8_row19 * (column8_row17 - column8_row81))
            * domain21,
        domain6,
        (column8_row51 * (column8_row17 - column8_row1) - 1) * domain21,
        domain6,
        (ecdsa_signature0_exponentiate_key_bit_neg_0 * (column8_row81 - column8_row17)) * domain21,
        domain6,
        (ecdsa_signature0_exponentiate_key_bit_neg_0 * (column8_row113 - column8_row49)) * domain21,
        domain6,
        (column8_row27 - global_values.ecdsa_sig_config.shift_point.x),
        domain27,
        (column8_row91 + global_values.ecdsa_sig_config.shift_point.y),
        domain27,
        (column8_row17 - global_values.ecdsa_sig_config.shift_point.x),
        domain23,
        (column8_row49 - global_values.ecdsa_sig_config.shift_point.y),
        domain23,
        (column8_row32731
            - (column8_row16369 + column8_row32763 * (column8_row32667 - column8_row16337))),
        domain27,
        (column8_row32763 * column8_row32763
            - (column8_row32667 + column8_row16337 + column8_row16385)),
        domain27,
        (column8_row32731
            + column8_row16417
            - column8_row32763 * (column8_row32667 - column8_row16385)),
        domain27,
        (column8_row32647 * (column8_row32667 - column8_row16337) - 1),
        domain27,
        (column8_row32753
            + global_values.ecdsa_sig_config.shift_point.y
            - column8_row16331 * (column8_row32721 - global_values.ecdsa_sig_config.shift_point.x)),
        domain27,
        (column8_row16331 * column8_row16331
            - (column8_row32721 + global_values.ecdsa_sig_config.shift_point.x + column8_row9)),
        domain27,
        (column8_row32715 * (column8_row32721 - global_values.ecdsa_sig_config.shift_point.x) - 1),
        domain27,
        (column8_row59 * column8_row16363 - 1),
        domain27,
        (column8_row9 * column8_row16355 - 1),
        domain23,
        (column8_row32747 - column8_row1 * column8_row1),
        domain27,
        (column8_row33 * column8_row33
            - (column8_row1 * column8_row32747
                + global_values.ecdsa_sig_config.alpha * column8_row1
                + global_values.ecdsa_sig_config.beta)),
        domain27,
        (column5_row390 - global_values.initial_ecdsa_addr),
        domain29,
        (column5_row16774 - (column5_row390 + 1)),
        domain27,
        (column5_row33158 - (column5_row16774 + 1)) * domain35,
        domain27,
        (column5_row16775 - column8_row59),
        domain27,
        (column5_row391 - column8_row1),
        domain27,
        (column5_row198 - global_values.initial_bitwise_addr),
        domain29,
        (column5_row454 - (column5_row198 + 1)) * domain18,
        domain8,
        (column5_row902 - (column5_row966 + 1)),
        domain19,
        (column5_row1222 - (column5_row902 + 1)) * domain36,
        domain19,
        (bitwise_sum_var_0_0 + bitwise_sum_var_8_0 - column5_row199),
        domain8,
        (column5_row903 - (column5_row711 + column5_row967)),
        domain19,
        (column7_row1 + column7_row257 - (column7_row769 + column7_row513 + column7_row513)),
        domain20,
        ((column7_row705 + column7_row961) * 16 - column7_row9),
        domain19,
        ((column7_row721 + column7_row977) * 16 - column7_row521),
        domain19,
        ((column7_row737 + column7_row993) * 16 - column7_row265),
        domain19,
        ((column7_row753 + column7_row1009) * 256 - column7_row777),
        domain19,
        (column5_row8582 - global_values.initial_ec_op_addr),
        domain29,
        (column5_row24966 - (column5_row8582 + 7)) * domain37,
        domain23,
        (column5_row4486 - (column5_row8582 + 1)),
        domain23,
        (column5_row12678 - (column5_row4486 + 1)),
        domain23,
        (column5_row2438 - (column5_row12678 + 1)),
        domain23,
        (column5_row10630 - (column5_row2438 + 1)),
        domain23,
        (column5_row6534 - (column5_row10630 + 1)),
        domain23,
        (column5_row14726 - (column5_row6534 + 1)),
        domain23,
        (ec_op_doubling_q_x_squared_0
            + ec_op_doubling_q_x_squared_0
            + ec_op_doubling_q_x_squared_0
            + global_values.ec_op_curve_config.alpha
            - (column8_row25 + column8_row25) * column8_row57)
            * domain21,
        domain6,
        (column8_row57 * column8_row57 - (column8_row41 + column8_row41 + column8_row105))
            * domain21,
        domain6,
        (column8_row25 + column8_row89 - column8_row57 * (column8_row41 - column8_row105))
            * domain21,
        domain6,
        (column5_row12679 - column8_row41),
        domain23,
        (column5_row2439 - column8_row25),
        domain23,
        (column8_row16371 * (column8_row21 - (column8_row85 + column8_row85))),
        domain23,
        (column8_row16371
            * (column8_row85
                - 3138550867693340381917894711603833208051177722232017256448 * column8_row12309)),
        domain23,
        (column8_row16371
            - column8_row16339 * (column8_row12309 - (column8_row12373 + column8_row12373))),
        domain23,
        (column8_row16339 * (column8_row12373 - 8 * column8_row12565)),
        domain23,
        (column8_row16339
            - (column8_row16085 - (column8_row16149 + column8_row16149))
                * (column8_row12565 - (column8_row12629 + column8_row12629))),
        domain23,
        ((column8_row16085 - (column8_row16149 + column8_row16149))
            * (column8_row12629 - 18014398509481984 * column8_row16085)),
        domain23,
        (ec_op_ec_subset_sum_bit_0 * (ec_op_ec_subset_sum_bit_0 - 1)) * domain21,
        domain6,
        (column8_row21),
        domain24,
        (column8_row21),
        domain21,
        (ec_op_ec_subset_sum_bit_0 * (column8_row37 - column8_row25)
            - column8_row11 * (column8_row5 - column8_row41))
            * domain21,
        domain6,
        (column8_row11 * column8_row11
            - ec_op_ec_subset_sum_bit_0 * (column8_row5 + column8_row41 + column8_row69))
            * domain21,
        domain6,
        (ec_op_ec_subset_sum_bit_0 * (column8_row37 + column8_row101)
            - column8_row11 * (column8_row5 - column8_row69))
            * domain21,
        domain6,
        (column8_row43 * (column8_row5 - column8_row41) - 1) * domain21,
        domain6,
        (ec_op_ec_subset_sum_bit_neg_0 * (column8_row69 - column8_row5)) * domain21,
        domain6,
        (ec_op_ec_subset_sum_bit_neg_0 * (column8_row101 - column8_row37)) * domain21,
        domain6,
        (column8_row21 - column5_row10631),
        domain23,
        (column5_row8583 - column8_row5),
        domain23,
        (column5_row4487 - column8_row37),
        domain23,
        (column5_row6535 - column8_row16325),
        domain23,
        (column5_row14727 - column8_row16357),
        domain23,
        (column5_row38 - global_values.initial_poseidon_addr),
        domain29,
        (column5_row294 - (column5_row38 + 3)) * domain34,
        domain8,
        (column5_row166 - (global_values.initial_poseidon_addr + 1)),
        domain29,
        (column5_row422 - (column5_row166 + 3)) * domain34,
        domain8,
        (column5_row102 - (global_values.initial_poseidon_addr + 2)),
        domain29,
        (column5_row358 - (column5_row102 + 3)) * domain34,
        domain8,
        (column8_row53 * column8_row53 - column8_row29),
        domain6,
        (column8_row13 * column8_row13 - column8_row61),
        domain6,
        (column8_row45 * column8_row45 - column8_row3),
        domain6,
        (column7_row3 * column7_row3 - column7_row7),
        domain3,
        (column8_row6 * column8_row6 - column8_row14) * domain15,
        domain5,
        (column5_row39
            + 2950795762459345168613727575620414179244544320470208355568817838579231751791
            - column8_row53),
        domain13,
        (column5_row167
            + 1587446564224215276866294500450702039420286416111469274423465069420553242820
            - column8_row13),
        domain13,
        (column5_row103
            + 1645965921169490687904413452218868659025437693527479459426157555728339600137
            - column8_row45),
        domain13,
        (column8_row117
            - (poseidon_poseidon_full_rounds_state0_cubed_0
                + poseidon_poseidon_full_rounds_state0_cubed_0
                + poseidon_poseidon_full_rounds_state0_cubed_0
                + poseidon_poseidon_full_rounds_state1_cubed_0
                + poseidon_poseidon_full_rounds_state2_cubed_0
                + global_values.poseidon_poseidon_full_round_key0))
            * domain11,
        domain6,
        (column8_row77
            + poseidon_poseidon_full_rounds_state1_cubed_0
            - (poseidon_poseidon_full_rounds_state0_cubed_0
                + poseidon_poseidon_full_rounds_state2_cubed_0
                + global_values.poseidon_poseidon_full_round_key1))
            * domain11,
        domain6,
        (column8_row109
            + poseidon_poseidon_full_rounds_state2_cubed_0
            + poseidon_poseidon_full_rounds_state2_cubed_0
            - (poseidon_poseidon_full_rounds_state0_cubed_0
                + poseidon_poseidon_full_rounds_state1_cubed_0
                + global_values.poseidon_poseidon_full_round_key2))
            * domain11,
        domain6,
        (column5_row295
            - (poseidon_poseidon_full_rounds_state0_cubed_7
                + poseidon_poseidon_full_rounds_state0_cubed_7
                + poseidon_poseidon_full_rounds_state0_cubed_7
                + poseidon_poseidon_full_rounds_state1_cubed_7
                + poseidon_poseidon_full_rounds_state2_cubed_7)),
        domain13,
        (column5_row423
            + poseidon_poseidon_full_rounds_state1_cubed_7
            - (poseidon_poseidon_full_rounds_state0_cubed_7
                + poseidon_poseidon_full_rounds_state2_cubed_7)),
        domain13,
        (column5_row359
            + poseidon_poseidon_full_rounds_state2_cubed_7
            + poseidon_poseidon_full_rounds_state2_cubed_7
            - (poseidon_poseidon_full_rounds_state0_cubed_7
                + poseidon_poseidon_full_rounds_state1_cubed_7)),
        domain13,
        (column7_row491 - column8_row6),
        domain13,
        (column7_row499 - column8_row22),
        domain13,
        (column7_row507 - column8_row38),
        domain13,
        (column7_row3
            + poseidon_poseidon_full_rounds_state2_cubed_3
            + poseidon_poseidon_full_rounds_state2_cubed_3
            - (poseidon_poseidon_full_rounds_state0_cubed_3
                + poseidon_poseidon_full_rounds_state1_cubed_3
                + 2121140748740143694053732746913428481442990369183417228688865837805149503386)),
        domain13,
        (column7_row11
            - (3618502788666131213697322783095070105623107215331596699973092056135872020477
                * poseidon_poseidon_full_rounds_state1_cubed_3
                + 10 * poseidon_poseidon_full_rounds_state2_cubed_3
                + 4 * column7_row3
                + 3618502788666131213697322783095070105623107215331596699973092056135872020479
                    * poseidon_poseidon_partial_rounds_state0_cubed_0
                + 2006642341318481906727563724340978325665491359415674592697055778067937914672)),
        domain13,
        (column7_row19
            - (8 * poseidon_poseidon_full_rounds_state2_cubed_3
                + 4 * column7_row3
                + 6 * poseidon_poseidon_partial_rounds_state0_cubed_0
                + column7_row11
                + column7_row11
                + 3618502788666131213697322783095070105623107215331596699973092056135872020479
                    * poseidon_poseidon_partial_rounds_state0_cubed_1
                + 427751140904099001132521606468025610873158555767197326325930641757709538586)),
        domain13,
        (column7_row27
            - (8 * poseidon_poseidon_partial_rounds_state0_cubed_0
                + 4 * column7_row11
                + 6 * poseidon_poseidon_partial_rounds_state0_cubed_1
                + column7_row19
                + column7_row19
                + 3618502788666131213697322783095070105623107215331596699973092056135872020479
                    * poseidon_poseidon_partial_rounds_state0_cubed_2
                + global_values.poseidon_poseidon_partial_round_key0))
            * domain16,
        domain3,
        (column8_row54
            - (8 * poseidon_poseidon_partial_rounds_state1_cubed_0
                + 4 * column8_row22
                + 6 * poseidon_poseidon_partial_rounds_state1_cubed_1
                + column8_row38
                + column8_row38
                + 3618502788666131213697322783095070105623107215331596699973092056135872020479
                    * poseidon_poseidon_partial_rounds_state1_cubed_2
                + global_values.poseidon_poseidon_partial_round_key1))
            * domain17,
        domain5,
        (column8_row309
            - (16 * poseidon_poseidon_partial_rounds_state1_cubed_19
                + 8 * column8_row326
                + 16 * poseidon_poseidon_partial_rounds_state1_cubed_20
                + 6 * column8_row342
                + poseidon_poseidon_partial_rounds_state1_cubed_21
                + 560279373700919169769089400651532183647886248799764942664266404650165812023)),
        domain13,
        (column8_row269
            - (4 * poseidon_poseidon_partial_rounds_state1_cubed_20
                + column8_row342
                + column8_row342
                + poseidon_poseidon_partial_rounds_state1_cubed_21
                + 1401754474293352309994371631695783042590401941592571735921592823982231996415)),
        domain13,
        (column8_row301
            - (8 * poseidon_poseidon_partial_rounds_state1_cubed_19
                + 4 * column8_row326
                + 6 * poseidon_poseidon_partial_rounds_state1_cubed_20
                + column8_row342
                + column8_row342
                + 3618502788666131213697322783095070105623107215331596699973092056135872020479
                    * poseidon_poseidon_partial_rounds_state1_cubed_21
                + 1246177936547655338400308396717835700699368047388302793172818304164989556526)),
        domain13
    ];
    let mut i = 0;
    while i < constraints
        .len() {
            total_sum = total_sum
                + *constraint_coefficients.pop_front().unwrap()
                    * ((*constraints.at(i)) / (*constraints.at(i + 1)));
            i += 2;
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
    let pow_exps = array![
        0,
        32715,
        32667,
        32647,
        16325,
        16149,
        16085,
        12373,
        12309,
        24966,
        16774,
        14726,
        10630,
        8582,
        6534,
        4486,
        2438,
        1,
        14727,
        10631,
        8583,
        6535,
        4487,
        2439,
        2,
        3,
        4,
        5,
        6,
        16331,
        7,
        8,
        9,
        10,
        11,
        12,
        13,
        14,
        15,
        16,
        17,
        19,
        21,
        22,
        23,
        24,
        25,
        27,
        29,
        30,
        33,
        35,
        37,
        38,
        39,
        41,
        43,
        44,
        45,
        46,
        49,
        51,
        53,
        54,
        32721,
        32731,
        32747,
        32753,
        32763,
        57,
        59,
        61,
        65,
        69,
        70,
        71,
        73,
        76,
        77,
        81,
        85,
        89,
        91,
        97,
        101,
        102,
        103,
        105,
        108,
        109,
        113,
        117,
        123,
        129,
        134,
        135,
        140,
        145,
        155,
        161,
        166,
        167,
        172,
        177,
        187,
        192,
        193,
        195,
        196,
        197,
        198,
        199,
        204,
        205,
        209,
        219,
        221,
        225,
        236,
        237,
        241,
        245,
        251,
        252,
        16337,
        16339,
        16355,
        16357,
        16363,
        16369,
        16371,
        16385,
        16417,
        253,
        255,
        256,
        257,
        12629,
        12565,
        12678,
        12679,
        262,
        263,
        265,
        269,
        294,
        295,
        301,
        309,
        310,
        318,
        422,
        390,
        326,
        334,
        342,
        350,
        358,
        423,
        391,
        359,
        16775,
        451,
        454,
        461,
        477,
        491,
        493,
        499,
        501,
        507,
        509,
        511,
        33158,
        513,
        518,
        705,
        902,
        711,
        721,
        737,
        753,
        769,
        961,
        966,
        967,
        977,
        1222,
        903,
        993,
        1009,
        521,
        777
    ]
        .span();

    // Sum the OODS constraints on the trace polynomials.
    let mut total_sum = 0;
    let pow_list0 = array![0, 17, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38];
    let pow_list1 = array![0, 17, 134, 135, 172];
    let pow_list2 = array![0, 17, 134, 135];
    let pow_list3 = array![0, 17, 105, 106, 108, 109, 122, 123, 135];
    let pow_list4 = array![0, 134];
    let pow_list5 = array![
        0,
        17,
        24,
        25,
        26,
        27,
        28,
        30,
        31,
        32,
        35,
        36,
        39,
        53,
        54,
        74,
        75,
        85,
        86,
        94,
        95,
        100,
        101,
        110,
        111,
        141,
        142,
        145,
        146,
        153,
        157,
        160,
        152,
        159,
        151,
        158,
        163,
        175,
        178,
        177,
        188,
        184,
        185,
        187,
        16,
        23,
        15,
        22,
        14,
        21,
        13,
        20,
        12,
        19,
        139,
        140,
        11,
        18,
        10,
        161,
        9,
        173
    ];
    let pow_list6 = array![0, 17, 24, 25];
    let pow_list7 = array![
        0,
        17,
        24,
        25,
        26,
        27,
        28,
        30,
        31,
        32,
        34,
        35,
        36,
        38,
        40,
        41,
        44,
        47,
        50,
        57,
        60,
        72,
        77,
        79,
        83,
        88,
        90,
        93,
        96,
        97,
        99,
        102,
        103,
        106,
        112,
        114,
        117,
        118,
        120,
        136,
        143,
        166,
        168,
        170,
        174,
        191,
        176,
        179,
        180,
        181,
        182,
        192,
        183,
        186,
        189,
        190
    ];
    let pow_list8 = array![
        0,
        17,
        24,
        25,
        26,
        27,
        28,
        30,
        31,
        32,
        33,
        34,
        35,
        36,
        37,
        39,
        40,
        41,
        42,
        43,
        45,
        46,
        47,
        48,
        49,
        50,
        51,
        52,
        53,
        55,
        56,
        58,
        59,
        60,
        61,
        62,
        63,
        69,
        70,
        71,
        72,
        73,
        75,
        76,
        78,
        79,
        80,
        81,
        82,
        83,
        84,
        87,
        89,
        90,
        91,
        92,
        98,
        104,
        107,
        113,
        115,
        116,
        119,
        121,
        133,
        144,
        147,
        148,
        149,
        150,
        153,
        154,
        155,
        156,
        162,
        164,
        165,
        167,
        169,
        171,
        8,
        7,
        138,
        137,
        6,
        5,
        4,
        29,
        124,
        125,
        126,
        127,
        128,
        129,
        130,
        131,
        132,
        3,
        2,
        1,
        64,
        65,
        66,
        67,
        68
    ];
    let pow_list9 = array![0, 17, 24, 25, 27, 30, 34, 38];
    let pow_list = array![
        pow_list0,
        pow_list1,
        pow_list2,
        pow_list3,
        pow_list4,
        pow_list5,
        pow_list6,
        pow_list7,
        pow_list8,
        pow_list9
    ]
        .span();
    let mut i = 0;
    while i < pow_list
        .len() {
            let mut j = 0;
            while j < (pow_list.at(i))
                .len() {
                    let value = (*column_values.at(i) - *oods_values.pop_front().unwrap())
                        / (point
                            - pow(trace_generator, *pow_exps.at(*pow_list.at(i).at(j)))
                                * oods_point);
                    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;
                    j += 1;
                };
            i += 1;
        };

    // Sum the OODS boundary constraints on the composition polynomials.
    let oods_point_to_deg = pow(oods_point, CONSTRAINT_DEGREE.into());

    let value = (*column_values.at(10) - *oods_values.pop_front().unwrap())
        / (point - oods_point_to_deg);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    let value = (*column_values.at(11) - *oods_values.pop_front().unwrap())
        / (point - oods_point_to_deg);
    let total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    assert(273 == MASK_SIZE + CONSTRAINT_DEGREE, 'Invalid value');
    total_sum
}
