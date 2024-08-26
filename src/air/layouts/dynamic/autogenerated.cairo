use core::option::OptionTrait;
use cairo_verifier::{
    domains::StarkDomains,
    air::layouts::dynamic::{
        global_values::GlobalValues, constants::{CONSTRAINT_DEGREE, MASK_SIZE, DynamicParams}
    },
    common::{math::{Felt252Div, pow}, asserts::{assert_is_power_of_2, assert_range_u128_from_u256}},
};

fn eval_composition_polynomial_inner(
    mut mask_values: Span<felt252>,
    mut constraint_coefficients: Span<felt252>,
    point: felt252,
    trace_generator: felt252,
    global_values: GlobalValues
) -> felt252 { // TODO REWRITE
    0
}

fn eval_oods_polynomial_inner(
    mut column_values: Span<felt252>,
    mut oods_values: Span<felt252>,
    mut constraint_coefficients: Span<felt252>,
    point: felt252,
    oods_point: felt252,
    trace_generator: felt252,
    dynamic_params: DynamicParams
) -> felt252 {
    // Fetch dynamic params
    let add_mod_a0_suboffset = dynamic_params.add_mod_a0_suboffset;
    let add_mod_a1_suboffset = dynamic_params.add_mod_a1_suboffset;
    let add_mod_a2_suboffset = dynamic_params.add_mod_a2_suboffset;
    let add_mod_a3_suboffset = dynamic_params.add_mod_a3_suboffset;
    let add_mod_a_offset_suboffset = dynamic_params.add_mod_a_offset_suboffset;
    let add_mod_b0_suboffset = dynamic_params.add_mod_b0_suboffset;
    let add_mod_b1_suboffset = dynamic_params.add_mod_b1_suboffset;
    let add_mod_b2_suboffset = dynamic_params.add_mod_b2_suboffset;
    let add_mod_b3_suboffset = dynamic_params.add_mod_b3_suboffset;
    let add_mod_b_offset_suboffset = dynamic_params.add_mod_b_offset_suboffset;
    let add_mod_c0_suboffset = dynamic_params.add_mod_c0_suboffset;
    let add_mod_c1_suboffset = dynamic_params.add_mod_c1_suboffset;
    let add_mod_c2_suboffset = dynamic_params.add_mod_c2_suboffset;
    let add_mod_c3_suboffset = dynamic_params.add_mod_c3_suboffset;
    let add_mod_c_offset_suboffset = dynamic_params.add_mod_c_offset_suboffset;
    let add_mod_carry1_bit_column = dynamic_params.add_mod_carry1_bit_column;
    let add_mod_carry1_bit_offset = dynamic_params.add_mod_carry1_bit_offset;
    let add_mod_carry1_sign_column = dynamic_params.add_mod_carry1_sign_column;
    let add_mod_carry1_sign_offset = dynamic_params.add_mod_carry1_sign_offset;
    let add_mod_carry2_bit_column = dynamic_params.add_mod_carry2_bit_column;
    let add_mod_carry2_bit_offset = dynamic_params.add_mod_carry2_bit_offset;
    let add_mod_carry2_sign_column = dynamic_params.add_mod_carry2_sign_column;
    let add_mod_carry2_sign_offset = dynamic_params.add_mod_carry2_sign_offset;
    let add_mod_carry3_bit_column = dynamic_params.add_mod_carry3_bit_column;
    let add_mod_carry3_bit_offset = dynamic_params.add_mod_carry3_bit_offset;
    let add_mod_carry3_sign_column = dynamic_params.add_mod_carry3_sign_column;
    let add_mod_carry3_sign_offset = dynamic_params.add_mod_carry3_sign_offset;
    let add_mod_n_suboffset = dynamic_params.add_mod_n_suboffset;
    let add_mod_offsets_ptr_suboffset = dynamic_params.add_mod_offsets_ptr_suboffset;
    let add_mod_p0_suboffset = dynamic_params.add_mod_p0_suboffset;
    let add_mod_p1_suboffset = dynamic_params.add_mod_p1_suboffset;
    let add_mod_p2_suboffset = dynamic_params.add_mod_p2_suboffset;
    let add_mod_p3_suboffset = dynamic_params.add_mod_p3_suboffset;
    let add_mod_row_ratio = dynamic_params.add_mod_row_ratio;
    let add_mod_sub_p_bit_column = dynamic_params.add_mod_sub_p_bit_column;
    let add_mod_sub_p_bit_offset = dynamic_params.add_mod_sub_p_bit_offset;
    let add_mod_values_ptr_suboffset = dynamic_params.add_mod_values_ptr_suboffset;
    let bitwise_diluted_var_pool_suboffset = dynamic_params.bitwise_diluted_var_pool_suboffset;
    let bitwise_row_ratio = dynamic_params.bitwise_row_ratio;
    let bitwise_trim_unpacking192_suboffset = dynamic_params.bitwise_trim_unpacking192_suboffset;
    let bitwise_trim_unpacking193_suboffset = dynamic_params.bitwise_trim_unpacking193_suboffset;
    let bitwise_trim_unpacking194_suboffset = dynamic_params.bitwise_trim_unpacking194_suboffset;
    let bitwise_trim_unpacking195_suboffset = dynamic_params.bitwise_trim_unpacking195_suboffset;
    let bitwise_var_pool_suboffset = dynamic_params.bitwise_var_pool_suboffset;
    let bitwise_x_or_y_suboffset = dynamic_params.bitwise_x_or_y_suboffset;
    let cpu_decode_mem_inst_suboffset = dynamic_params.cpu_decode_mem_inst_suboffset;
    let cpu_decode_off0_suboffset = dynamic_params.cpu_decode_off0_suboffset;
    let cpu_decode_off1_suboffset = dynamic_params.cpu_decode_off1_suboffset;
    let cpu_decode_off2_suboffset = dynamic_params.cpu_decode_off2_suboffset;
    let cpu_decode_opcode_range_check_column_column = dynamic_params
        .cpu_decode_opcode_range_check_column_column;
    let cpu_decode_opcode_range_check_column_offset = dynamic_params
        .cpu_decode_opcode_range_check_column_offset;
    let cpu_operands_mem_dst_suboffset = dynamic_params.cpu_operands_mem_dst_suboffset;
    let cpu_operands_mem_op0_suboffset = dynamic_params.cpu_operands_mem_op0_suboffset;
    let cpu_operands_mem_op1_suboffset = dynamic_params.cpu_operands_mem_op1_suboffset;
    let cpu_operands_ops_mul_column = dynamic_params.cpu_operands_ops_mul_column;
    let cpu_operands_ops_mul_offset = dynamic_params.cpu_operands_ops_mul_offset;
    let cpu_operands_res_column = dynamic_params.cpu_operands_res_column;
    let cpu_operands_res_offset = dynamic_params.cpu_operands_res_offset;
    let cpu_registers_ap_column = dynamic_params.cpu_registers_ap_column;
    let cpu_registers_ap_offset = dynamic_params.cpu_registers_ap_offset;
    let cpu_registers_fp_column = dynamic_params.cpu_registers_fp_column;
    let cpu_registers_fp_offset = dynamic_params.cpu_registers_fp_offset;
    let cpu_update_registers_update_pc_tmp0_column = dynamic_params
        .cpu_update_registers_update_pc_tmp0_column;
    let cpu_update_registers_update_pc_tmp0_offset = dynamic_params
        .cpu_update_registers_update_pc_tmp0_offset;
    let cpu_update_registers_update_pc_tmp1_column = dynamic_params
        .cpu_update_registers_update_pc_tmp1_column;
    let cpu_update_registers_update_pc_tmp1_offset = dynamic_params
        .cpu_update_registers_update_pc_tmp1_offset;
    let cpu_component_step = dynamic_params.cpu_component_step;
    let diluted_check_cumulative_value_column = dynamic_params
        .diluted_check_cumulative_value_column;
    let diluted_check_cumulative_value_offset = dynamic_params
        .diluted_check_cumulative_value_offset;
    let diluted_check_permutation_cum_prod0_column = dynamic_params
        .diluted_check_permutation_cum_prod0_column;
    let diluted_check_permutation_cum_prod0_offset = dynamic_params
        .diluted_check_permutation_cum_prod0_offset;
    let diluted_check_permuted_values_column = dynamic_params.diluted_check_permuted_values_column;
    let diluted_check_permuted_values_offset = dynamic_params.diluted_check_permuted_values_offset;
    let diluted_pool_column = dynamic_params.diluted_pool_column;
    let diluted_pool_offset = dynamic_params.diluted_pool_offset;
    let diluted_units_row_ratio = dynamic_params.diluted_units_row_ratio;
    let ec_op_doubled_points_x_column = dynamic_params.ec_op_doubled_points_x_column;
    let ec_op_doubled_points_x_offset = dynamic_params.ec_op_doubled_points_x_offset;
    let ec_op_doubled_points_y_column = dynamic_params.ec_op_doubled_points_y_column;
    let ec_op_doubled_points_y_offset = dynamic_params.ec_op_doubled_points_y_offset;
    let ec_op_doubling_slope_column = dynamic_params.ec_op_doubling_slope_column;
    let ec_op_doubling_slope_offset = dynamic_params.ec_op_doubling_slope_offset;
    let ec_op_ec_subset_sum_bit_unpacking_prod_ones192_column = dynamic_params
        .ec_op_ec_subset_sum_bit_unpacking_prod_ones192_column;
    let ec_op_ec_subset_sum_bit_unpacking_prod_ones192_offset = dynamic_params
        .ec_op_ec_subset_sum_bit_unpacking_prod_ones192_offset;
    let ec_op_ec_subset_sum_bit_unpacking_prod_ones196_column = dynamic_params
        .ec_op_ec_subset_sum_bit_unpacking_prod_ones196_column;
    let ec_op_ec_subset_sum_bit_unpacking_prod_ones196_offset = dynamic_params
        .ec_op_ec_subset_sum_bit_unpacking_prod_ones196_offset;
    let ec_op_ec_subset_sum_partial_sum_x_column = dynamic_params
        .ec_op_ec_subset_sum_partial_sum_x_column;
    let ec_op_ec_subset_sum_partial_sum_x_offset = dynamic_params
        .ec_op_ec_subset_sum_partial_sum_x_offset;
    let ec_op_ec_subset_sum_partial_sum_y_column = dynamic_params
        .ec_op_ec_subset_sum_partial_sum_y_column;
    let ec_op_ec_subset_sum_partial_sum_y_offset = dynamic_params
        .ec_op_ec_subset_sum_partial_sum_y_offset;
    let ec_op_ec_subset_sum_selector_column = dynamic_params.ec_op_ec_subset_sum_selector_column;
    let ec_op_ec_subset_sum_selector_offset = dynamic_params.ec_op_ec_subset_sum_selector_offset;
    let ec_op_ec_subset_sum_slope_column = dynamic_params.ec_op_ec_subset_sum_slope_column;
    let ec_op_ec_subset_sum_slope_offset = dynamic_params.ec_op_ec_subset_sum_slope_offset;
    let ec_op_ec_subset_sum_x_diff_inv_column = dynamic_params
        .ec_op_ec_subset_sum_x_diff_inv_column;
    let ec_op_ec_subset_sum_x_diff_inv_offset = dynamic_params
        .ec_op_ec_subset_sum_x_diff_inv_offset;
    let ec_op_m_suboffset = dynamic_params.ec_op_m_suboffset;
    let ec_op_p_x_suboffset = dynamic_params.ec_op_p_x_suboffset;
    let ec_op_p_y_suboffset = dynamic_params.ec_op_p_y_suboffset;
    let ec_op_q_x_suboffset = dynamic_params.ec_op_q_x_suboffset;
    let ec_op_q_y_suboffset = dynamic_params.ec_op_q_y_suboffset;
    let ec_op_r_x_suboffset = dynamic_params.ec_op_r_x_suboffset;
    let ec_op_r_y_suboffset = dynamic_params.ec_op_r_y_suboffset;
    let ec_op_builtin_row_ratio = dynamic_params.ec_op_builtin_row_ratio;
    let ecdsa_message_suboffset = dynamic_params.ecdsa_message_suboffset;
    let ecdsa_pubkey_suboffset = dynamic_params.ecdsa_pubkey_suboffset;
    let ecdsa_signature0_add_results_inv_column = dynamic_params
        .ecdsa_signature0_add_results_inv_column;
    let ecdsa_signature0_add_results_inv_offset = dynamic_params
        .ecdsa_signature0_add_results_inv_offset;
    let ecdsa_signature0_add_results_slope_column = dynamic_params
        .ecdsa_signature0_add_results_slope_column;
    let ecdsa_signature0_add_results_slope_offset = dynamic_params
        .ecdsa_signature0_add_results_slope_offset;
    let ecdsa_signature0_doubling_slope_column = dynamic_params
        .ecdsa_signature0_doubling_slope_column;
    let ecdsa_signature0_doubling_slope_offset = dynamic_params
        .ecdsa_signature0_doubling_slope_offset;
    let ecdsa_signature0_exponentiate_generator_partial_sum_x_column = dynamic_params
        .ecdsa_signature0_exponentiate_generator_partial_sum_x_column;
    let ecdsa_signature0_exponentiate_generator_partial_sum_x_offset = dynamic_params
        .ecdsa_signature0_exponentiate_generator_partial_sum_x_offset;
    let ecdsa_signature0_exponentiate_generator_partial_sum_y_column = dynamic_params
        .ecdsa_signature0_exponentiate_generator_partial_sum_y_column;
    let ecdsa_signature0_exponentiate_generator_partial_sum_y_offset = dynamic_params
        .ecdsa_signature0_exponentiate_generator_partial_sum_y_offset;
    let ecdsa_signature0_exponentiate_generator_selector_column = dynamic_params
        .ecdsa_signature0_exponentiate_generator_selector_column;
    let ecdsa_signature0_exponentiate_generator_selector_offset = dynamic_params
        .ecdsa_signature0_exponentiate_generator_selector_offset;
    let ecdsa_signature0_exponentiate_generator_slope_column = dynamic_params
        .ecdsa_signature0_exponentiate_generator_slope_column;
    let ecdsa_signature0_exponentiate_generator_slope_offset = dynamic_params
        .ecdsa_signature0_exponentiate_generator_slope_offset;
    let ecdsa_signature0_exponentiate_generator_x_diff_inv_column = dynamic_params
        .ecdsa_signature0_exponentiate_generator_x_diff_inv_column;
    let ecdsa_signature0_exponentiate_generator_x_diff_inv_offset = dynamic_params
        .ecdsa_signature0_exponentiate_generator_x_diff_inv_offset;
    let ecdsa_signature0_exponentiate_key_partial_sum_x_column = dynamic_params
        .ecdsa_signature0_exponentiate_key_partial_sum_x_column;
    let ecdsa_signature0_exponentiate_key_partial_sum_x_offset = dynamic_params
        .ecdsa_signature0_exponentiate_key_partial_sum_x_offset;
    let ecdsa_signature0_exponentiate_key_partial_sum_y_column = dynamic_params
        .ecdsa_signature0_exponentiate_key_partial_sum_y_column;
    let ecdsa_signature0_exponentiate_key_partial_sum_y_offset = dynamic_params
        .ecdsa_signature0_exponentiate_key_partial_sum_y_offset;
    let ecdsa_signature0_exponentiate_key_selector_column = dynamic_params
        .ecdsa_signature0_exponentiate_key_selector_column;
    let ecdsa_signature0_exponentiate_key_selector_offset = dynamic_params
        .ecdsa_signature0_exponentiate_key_selector_offset;
    let ecdsa_signature0_exponentiate_key_slope_column = dynamic_params
        .ecdsa_signature0_exponentiate_key_slope_column;
    let ecdsa_signature0_exponentiate_key_slope_offset = dynamic_params
        .ecdsa_signature0_exponentiate_key_slope_offset;
    let ecdsa_signature0_exponentiate_key_x_diff_inv_column = dynamic_params
        .ecdsa_signature0_exponentiate_key_x_diff_inv_column;
    let ecdsa_signature0_exponentiate_key_x_diff_inv_offset = dynamic_params
        .ecdsa_signature0_exponentiate_key_x_diff_inv_offset;
    let ecdsa_signature0_extract_r_inv_column = dynamic_params
        .ecdsa_signature0_extract_r_inv_column;
    let ecdsa_signature0_extract_r_inv_offset = dynamic_params
        .ecdsa_signature0_extract_r_inv_offset;
    let ecdsa_signature0_extract_r_slope_column = dynamic_params
        .ecdsa_signature0_extract_r_slope_column;
    let ecdsa_signature0_extract_r_slope_offset = dynamic_params
        .ecdsa_signature0_extract_r_slope_offset;
    let ecdsa_signature0_key_points_x_column = dynamic_params.ecdsa_signature0_key_points_x_column;
    let ecdsa_signature0_key_points_x_offset = dynamic_params.ecdsa_signature0_key_points_x_offset;
    let ecdsa_signature0_key_points_y_column = dynamic_params.ecdsa_signature0_key_points_y_column;
    let ecdsa_signature0_key_points_y_offset = dynamic_params.ecdsa_signature0_key_points_y_offset;
    let ecdsa_signature0_q_x_squared_column = dynamic_params.ecdsa_signature0_q_x_squared_column;
    let ecdsa_signature0_q_x_squared_offset = dynamic_params.ecdsa_signature0_q_x_squared_offset;
    let ecdsa_signature0_r_w_inv_column = dynamic_params.ecdsa_signature0_r_w_inv_column;
    let ecdsa_signature0_r_w_inv_offset = dynamic_params.ecdsa_signature0_r_w_inv_offset;
    let ecdsa_signature0_z_inv_column = dynamic_params.ecdsa_signature0_z_inv_column;
    let ecdsa_signature0_z_inv_offset = dynamic_params.ecdsa_signature0_z_inv_offset;
    let ecdsa_builtin_row_ratio = dynamic_params.ecdsa_builtin_row_ratio;
    let keccak_input_output_suboffset = dynamic_params.keccak_input_output_suboffset;
    let keccak_keccak_diluted_column0_suboffset = dynamic_params
        .keccak_keccak_diluted_column0_suboffset;
    let keccak_keccak_diluted_column1_suboffset = dynamic_params
        .keccak_keccak_diluted_column1_suboffset;
    let keccak_keccak_diluted_column2_suboffset = dynamic_params
        .keccak_keccak_diluted_column2_suboffset;
    let keccak_keccak_diluted_column3_suboffset = dynamic_params
        .keccak_keccak_diluted_column3_suboffset;
    let keccak_keccak_parse_to_diluted_cumulative_sum_column = dynamic_params
        .keccak_keccak_parse_to_diluted_cumulative_sum_column;
    let keccak_keccak_parse_to_diluted_cumulative_sum_offset = dynamic_params
        .keccak_keccak_parse_to_diluted_cumulative_sum_offset;
    let keccak_keccak_parse_to_diluted_final_reshaped_input_column = dynamic_params
        .keccak_keccak_parse_to_diluted_final_reshaped_input_column;
    let keccak_keccak_parse_to_diluted_final_reshaped_input_offset = dynamic_params
        .keccak_keccak_parse_to_diluted_final_reshaped_input_offset;
    let keccak_keccak_parse_to_diluted_reshaped_intermediate_column = dynamic_params
        .keccak_keccak_parse_to_diluted_reshaped_intermediate_column;
    let keccak_keccak_parse_to_diluted_reshaped_intermediate_offset = dynamic_params
        .keccak_keccak_parse_to_diluted_reshaped_intermediate_offset;
    let keccak_keccak_rotated_parity0_column = dynamic_params.keccak_keccak_rotated_parity0_column;
    let keccak_keccak_rotated_parity0_offset = dynamic_params.keccak_keccak_rotated_parity0_offset;
    let keccak_keccak_rotated_parity1_column = dynamic_params.keccak_keccak_rotated_parity1_column;
    let keccak_keccak_rotated_parity1_offset = dynamic_params.keccak_keccak_rotated_parity1_offset;
    let keccak_keccak_rotated_parity2_column = dynamic_params.keccak_keccak_rotated_parity2_column;
    let keccak_keccak_rotated_parity2_offset = dynamic_params.keccak_keccak_rotated_parity2_offset;
    let keccak_keccak_rotated_parity3_column = dynamic_params.keccak_keccak_rotated_parity3_column;
    let keccak_keccak_rotated_parity3_offset = dynamic_params.keccak_keccak_rotated_parity3_offset;
    let keccak_keccak_rotated_parity4_column = dynamic_params.keccak_keccak_rotated_parity4_column;
    let keccak_keccak_rotated_parity4_offset = dynamic_params.keccak_keccak_rotated_parity4_offset;
    let keccak_row_ratio = dynamic_params.keccak_row_ratio;
    let mem_pool_addr_column = dynamic_params.mem_pool_addr_column;
    let mem_pool_addr_offset = dynamic_params.mem_pool_addr_offset;
    let mem_pool_value_column = dynamic_params.mem_pool_value_column;
    let mem_pool_value_offset = dynamic_params.mem_pool_value_offset;
    let memory_multi_column_perm_perm_cum_prod0_column = dynamic_params
        .memory_multi_column_perm_perm_cum_prod0_column;
    let memory_multi_column_perm_perm_cum_prod0_offset = dynamic_params
        .memory_multi_column_perm_perm_cum_prod0_offset;
    let memory_sorted_addr_column = dynamic_params.memory_sorted_addr_column;
    let memory_sorted_addr_offset = dynamic_params.memory_sorted_addr_offset;
    let memory_sorted_value_column = dynamic_params.memory_sorted_value_column;
    let memory_sorted_value_offset = dynamic_params.memory_sorted_value_offset;
    let memory_units_row_ratio = dynamic_params.memory_units_row_ratio;
    let mul_mod_a0_suboffset = dynamic_params.mul_mod_a0_suboffset;
    let mul_mod_a1_suboffset = dynamic_params.mul_mod_a1_suboffset;
    let mul_mod_a2_suboffset = dynamic_params.mul_mod_a2_suboffset;
    let mul_mod_a3_suboffset = dynamic_params.mul_mod_a3_suboffset;
    let mul_mod_a_offset_suboffset = dynamic_params.mul_mod_a_offset_suboffset;
    let mul_mod_b0_suboffset = dynamic_params.mul_mod_b0_suboffset;
    let mul_mod_b1_suboffset = dynamic_params.mul_mod_b1_suboffset;
    let mul_mod_b2_suboffset = dynamic_params.mul_mod_b2_suboffset;
    let mul_mod_b3_suboffset = dynamic_params.mul_mod_b3_suboffset;
    let mul_mod_b_offset_suboffset = dynamic_params.mul_mod_b_offset_suboffset;
    let mul_mod_c0_suboffset = dynamic_params.mul_mod_c0_suboffset;
    let mul_mod_c1_suboffset = dynamic_params.mul_mod_c1_suboffset;
    let mul_mod_c2_suboffset = dynamic_params.mul_mod_c2_suboffset;
    let mul_mod_c3_suboffset = dynamic_params.mul_mod_c3_suboffset;
    let mul_mod_c_offset_suboffset = dynamic_params.mul_mod_c_offset_suboffset;
    let mul_mod_carry0_part0_suboffset = dynamic_params.mul_mod_carry0_part0_suboffset;
    let mul_mod_carry0_part1_suboffset = dynamic_params.mul_mod_carry0_part1_suboffset;
    let mul_mod_carry0_part2_suboffset = dynamic_params.mul_mod_carry0_part2_suboffset;
    let mul_mod_carry0_part3_suboffset = dynamic_params.mul_mod_carry0_part3_suboffset;
    let mul_mod_carry0_part4_suboffset = dynamic_params.mul_mod_carry0_part4_suboffset;
    let mul_mod_carry0_part5_suboffset = dynamic_params.mul_mod_carry0_part5_suboffset;
    let mul_mod_carry0_part6_suboffset = dynamic_params.mul_mod_carry0_part6_suboffset;
    let mul_mod_carry1_part0_suboffset = dynamic_params.mul_mod_carry1_part0_suboffset;
    let mul_mod_carry1_part1_suboffset = dynamic_params.mul_mod_carry1_part1_suboffset;
    let mul_mod_carry1_part2_suboffset = dynamic_params.mul_mod_carry1_part2_suboffset;
    let mul_mod_carry1_part3_suboffset = dynamic_params.mul_mod_carry1_part3_suboffset;
    let mul_mod_carry1_part4_suboffset = dynamic_params.mul_mod_carry1_part4_suboffset;
    let mul_mod_carry1_part5_suboffset = dynamic_params.mul_mod_carry1_part5_suboffset;
    let mul_mod_carry1_part6_suboffset = dynamic_params.mul_mod_carry1_part6_suboffset;
    let mul_mod_carry2_part0_suboffset = dynamic_params.mul_mod_carry2_part0_suboffset;
    let mul_mod_carry2_part1_suboffset = dynamic_params.mul_mod_carry2_part1_suboffset;
    let mul_mod_carry2_part2_suboffset = dynamic_params.mul_mod_carry2_part2_suboffset;
    let mul_mod_carry2_part3_suboffset = dynamic_params.mul_mod_carry2_part3_suboffset;
    let mul_mod_carry2_part4_suboffset = dynamic_params.mul_mod_carry2_part4_suboffset;
    let mul_mod_carry2_part5_suboffset = dynamic_params.mul_mod_carry2_part5_suboffset;
    let mul_mod_carry2_part6_suboffset = dynamic_params.mul_mod_carry2_part6_suboffset;
    let mul_mod_carry3_part0_suboffset = dynamic_params.mul_mod_carry3_part0_suboffset;
    let mul_mod_carry3_part1_suboffset = dynamic_params.mul_mod_carry3_part1_suboffset;
    let mul_mod_carry3_part2_suboffset = dynamic_params.mul_mod_carry3_part2_suboffset;
    let mul_mod_carry3_part3_suboffset = dynamic_params.mul_mod_carry3_part3_suboffset;
    let mul_mod_carry3_part4_suboffset = dynamic_params.mul_mod_carry3_part4_suboffset;
    let mul_mod_carry3_part5_suboffset = dynamic_params.mul_mod_carry3_part5_suboffset;
    let mul_mod_carry3_part6_suboffset = dynamic_params.mul_mod_carry3_part6_suboffset;
    let mul_mod_carry4_part0_suboffset = dynamic_params.mul_mod_carry4_part0_suboffset;
    let mul_mod_carry4_part1_suboffset = dynamic_params.mul_mod_carry4_part1_suboffset;
    let mul_mod_carry4_part2_suboffset = dynamic_params.mul_mod_carry4_part2_suboffset;
    let mul_mod_carry4_part3_suboffset = dynamic_params.mul_mod_carry4_part3_suboffset;
    let mul_mod_carry4_part4_suboffset = dynamic_params.mul_mod_carry4_part4_suboffset;
    let mul_mod_carry4_part5_suboffset = dynamic_params.mul_mod_carry4_part5_suboffset;
    let mul_mod_carry4_part6_suboffset = dynamic_params.mul_mod_carry4_part6_suboffset;
    let mul_mod_carry5_part0_suboffset = dynamic_params.mul_mod_carry5_part0_suboffset;
    let mul_mod_carry5_part1_suboffset = dynamic_params.mul_mod_carry5_part1_suboffset;
    let mul_mod_carry5_part2_suboffset = dynamic_params.mul_mod_carry5_part2_suboffset;
    let mul_mod_carry5_part3_suboffset = dynamic_params.mul_mod_carry5_part3_suboffset;
    let mul_mod_carry5_part4_suboffset = dynamic_params.mul_mod_carry5_part4_suboffset;
    let mul_mod_carry5_part5_suboffset = dynamic_params.mul_mod_carry5_part5_suboffset;
    let mul_mod_carry5_part6_suboffset = dynamic_params.mul_mod_carry5_part6_suboffset;
    let mul_mod_n_suboffset = dynamic_params.mul_mod_n_suboffset;
    let mul_mod_offsets_ptr_suboffset = dynamic_params.mul_mod_offsets_ptr_suboffset;
    let mul_mod_p0_suboffset = dynamic_params.mul_mod_p0_suboffset;
    let mul_mod_p1_suboffset = dynamic_params.mul_mod_p1_suboffset;
    let mul_mod_p2_suboffset = dynamic_params.mul_mod_p2_suboffset;
    let mul_mod_p3_suboffset = dynamic_params.mul_mod_p3_suboffset;
    let mul_mod_p_multiplier0_part0_suboffset = dynamic_params
        .mul_mod_p_multiplier0_part0_suboffset;
    let mul_mod_p_multiplier0_part1_suboffset = dynamic_params
        .mul_mod_p_multiplier0_part1_suboffset;
    let mul_mod_p_multiplier0_part2_suboffset = dynamic_params
        .mul_mod_p_multiplier0_part2_suboffset;
    let mul_mod_p_multiplier0_part3_suboffset = dynamic_params
        .mul_mod_p_multiplier0_part3_suboffset;
    let mul_mod_p_multiplier0_part4_suboffset = dynamic_params
        .mul_mod_p_multiplier0_part4_suboffset;
    let mul_mod_p_multiplier0_part5_suboffset = dynamic_params
        .mul_mod_p_multiplier0_part5_suboffset;
    let mul_mod_p_multiplier1_part0_suboffset = dynamic_params
        .mul_mod_p_multiplier1_part0_suboffset;
    let mul_mod_p_multiplier1_part1_suboffset = dynamic_params
        .mul_mod_p_multiplier1_part1_suboffset;
    let mul_mod_p_multiplier1_part2_suboffset = dynamic_params
        .mul_mod_p_multiplier1_part2_suboffset;
    let mul_mod_p_multiplier1_part3_suboffset = dynamic_params
        .mul_mod_p_multiplier1_part3_suboffset;
    let mul_mod_p_multiplier1_part4_suboffset = dynamic_params
        .mul_mod_p_multiplier1_part4_suboffset;
    let mul_mod_p_multiplier1_part5_suboffset = dynamic_params
        .mul_mod_p_multiplier1_part5_suboffset;
    let mul_mod_p_multiplier2_part0_suboffset = dynamic_params
        .mul_mod_p_multiplier2_part0_suboffset;
    let mul_mod_p_multiplier2_part1_suboffset = dynamic_params
        .mul_mod_p_multiplier2_part1_suboffset;
    let mul_mod_p_multiplier2_part2_suboffset = dynamic_params
        .mul_mod_p_multiplier2_part2_suboffset;
    let mul_mod_p_multiplier2_part3_suboffset = dynamic_params
        .mul_mod_p_multiplier2_part3_suboffset;
    let mul_mod_p_multiplier2_part4_suboffset = dynamic_params
        .mul_mod_p_multiplier2_part4_suboffset;
    let mul_mod_p_multiplier2_part5_suboffset = dynamic_params
        .mul_mod_p_multiplier2_part5_suboffset;
    let mul_mod_p_multiplier3_part0_suboffset = dynamic_params
        .mul_mod_p_multiplier3_part0_suboffset;
    let mul_mod_p_multiplier3_part1_suboffset = dynamic_params
        .mul_mod_p_multiplier3_part1_suboffset;
    let mul_mod_p_multiplier3_part2_suboffset = dynamic_params
        .mul_mod_p_multiplier3_part2_suboffset;
    let mul_mod_p_multiplier3_part3_suboffset = dynamic_params
        .mul_mod_p_multiplier3_part3_suboffset;
    let mul_mod_p_multiplier3_part4_suboffset = dynamic_params
        .mul_mod_p_multiplier3_part4_suboffset;
    let mul_mod_p_multiplier3_part5_suboffset = dynamic_params
        .mul_mod_p_multiplier3_part5_suboffset;
    let mul_mod_row_ratio = dynamic_params.mul_mod_row_ratio;
    let mul_mod_values_ptr_suboffset = dynamic_params.mul_mod_values_ptr_suboffset;
    let num_columns_first = dynamic_params.num_columns_first;
    let num_columns_second = dynamic_params.num_columns_second;
    let orig_public_memory_suboffset = dynamic_params.orig_public_memory_suboffset;
    let pedersen_hash0_ec_subset_sum_bit_unpacking_prod_ones192_column = dynamic_params
        .pedersen_hash0_ec_subset_sum_bit_unpacking_prod_ones192_column;
    let pedersen_hash0_ec_subset_sum_bit_unpacking_prod_ones192_offset = dynamic_params
        .pedersen_hash0_ec_subset_sum_bit_unpacking_prod_ones192_offset;
    let pedersen_hash0_ec_subset_sum_bit_unpacking_prod_ones196_column = dynamic_params
        .pedersen_hash0_ec_subset_sum_bit_unpacking_prod_ones196_column;
    let pedersen_hash0_ec_subset_sum_bit_unpacking_prod_ones196_offset = dynamic_params
        .pedersen_hash0_ec_subset_sum_bit_unpacking_prod_ones196_offset;
    let pedersen_hash0_ec_subset_sum_partial_sum_x_column = dynamic_params
        .pedersen_hash0_ec_subset_sum_partial_sum_x_column;
    let pedersen_hash0_ec_subset_sum_partial_sum_x_offset = dynamic_params
        .pedersen_hash0_ec_subset_sum_partial_sum_x_offset;
    let pedersen_hash0_ec_subset_sum_partial_sum_y_column = dynamic_params
        .pedersen_hash0_ec_subset_sum_partial_sum_y_column;
    let pedersen_hash0_ec_subset_sum_partial_sum_y_offset = dynamic_params
        .pedersen_hash0_ec_subset_sum_partial_sum_y_offset;
    let pedersen_hash0_ec_subset_sum_selector_column = dynamic_params
        .pedersen_hash0_ec_subset_sum_selector_column;
    let pedersen_hash0_ec_subset_sum_selector_offset = dynamic_params
        .pedersen_hash0_ec_subset_sum_selector_offset;
    let pedersen_hash0_ec_subset_sum_slope_column = dynamic_params
        .pedersen_hash0_ec_subset_sum_slope_column;
    let pedersen_hash0_ec_subset_sum_slope_offset = dynamic_params
        .pedersen_hash0_ec_subset_sum_slope_offset;
    let pedersen_input0_suboffset = dynamic_params.pedersen_input0_suboffset;
    let pedersen_input1_suboffset = dynamic_params.pedersen_input1_suboffset;
    let pedersen_output_suboffset = dynamic_params.pedersen_output_suboffset;
    let pedersen_builtin_row_ratio = dynamic_params.pedersen_builtin_row_ratio;
    let poseidon_param_0_input_output_suboffset = dynamic_params
        .poseidon_param_0_input_output_suboffset;
    let poseidon_param_1_input_output_suboffset = dynamic_params
        .poseidon_param_1_input_output_suboffset;
    let poseidon_param_2_input_output_suboffset = dynamic_params
        .poseidon_param_2_input_output_suboffset;
    let poseidon_poseidon_full_rounds_state0_column = dynamic_params
        .poseidon_poseidon_full_rounds_state0_column;
    let poseidon_poseidon_full_rounds_state0_offset = dynamic_params
        .poseidon_poseidon_full_rounds_state0_offset;
    let poseidon_poseidon_full_rounds_state0_squared_column = dynamic_params
        .poseidon_poseidon_full_rounds_state0_squared_column;
    let poseidon_poseidon_full_rounds_state0_squared_offset = dynamic_params
        .poseidon_poseidon_full_rounds_state0_squared_offset;
    let poseidon_poseidon_full_rounds_state1_column = dynamic_params
        .poseidon_poseidon_full_rounds_state1_column;
    let poseidon_poseidon_full_rounds_state1_offset = dynamic_params
        .poseidon_poseidon_full_rounds_state1_offset;
    let poseidon_poseidon_full_rounds_state1_squared_column = dynamic_params
        .poseidon_poseidon_full_rounds_state1_squared_column;
    let poseidon_poseidon_full_rounds_state1_squared_offset = dynamic_params
        .poseidon_poseidon_full_rounds_state1_squared_offset;
    let poseidon_poseidon_full_rounds_state2_column = dynamic_params
        .poseidon_poseidon_full_rounds_state2_column;
    let poseidon_poseidon_full_rounds_state2_offset = dynamic_params
        .poseidon_poseidon_full_rounds_state2_offset;
    let poseidon_poseidon_full_rounds_state2_squared_column = dynamic_params
        .poseidon_poseidon_full_rounds_state2_squared_column;
    let poseidon_poseidon_full_rounds_state2_squared_offset = dynamic_params
        .poseidon_poseidon_full_rounds_state2_squared_offset;
    let poseidon_poseidon_partial_rounds_state0_column = dynamic_params
        .poseidon_poseidon_partial_rounds_state0_column;
    let poseidon_poseidon_partial_rounds_state0_offset = dynamic_params
        .poseidon_poseidon_partial_rounds_state0_offset;
    let poseidon_poseidon_partial_rounds_state0_squared_column = dynamic_params
        .poseidon_poseidon_partial_rounds_state0_squared_column;
    let poseidon_poseidon_partial_rounds_state0_squared_offset = dynamic_params
        .poseidon_poseidon_partial_rounds_state0_squared_offset;
    let poseidon_poseidon_partial_rounds_state1_column = dynamic_params
        .poseidon_poseidon_partial_rounds_state1_column;
    let poseidon_poseidon_partial_rounds_state1_offset = dynamic_params
        .poseidon_poseidon_partial_rounds_state1_offset;
    let poseidon_poseidon_partial_rounds_state1_squared_column = dynamic_params
        .poseidon_poseidon_partial_rounds_state1_squared_column;
    let poseidon_poseidon_partial_rounds_state1_squared_offset = dynamic_params
        .poseidon_poseidon_partial_rounds_state1_squared_offset;
    let poseidon_row_ratio = dynamic_params.poseidon_row_ratio;
    let range_check16_perm_cum_prod0_column = dynamic_params.range_check16_perm_cum_prod0_column;
    let range_check16_perm_cum_prod0_offset = dynamic_params.range_check16_perm_cum_prod0_offset;
    let range_check16_sorted_column = dynamic_params.range_check16_sorted_column;
    let range_check16_sorted_offset = dynamic_params.range_check16_sorted_offset;
    let range_check16_pool_column = dynamic_params.range_check16_pool_column;
    let range_check16_pool_offset = dynamic_params.range_check16_pool_offset;
    let range_check96_builtin_inner_range_check0_suboffset = dynamic_params
        .range_check96_builtin_inner_range_check0_suboffset;
    let range_check96_builtin_inner_range_check1_suboffset = dynamic_params
        .range_check96_builtin_inner_range_check1_suboffset;
    let range_check96_builtin_inner_range_check2_suboffset = dynamic_params
        .range_check96_builtin_inner_range_check2_suboffset;
    let range_check96_builtin_inner_range_check3_suboffset = dynamic_params
        .range_check96_builtin_inner_range_check3_suboffset;
    let range_check96_builtin_inner_range_check4_suboffset = dynamic_params
        .range_check96_builtin_inner_range_check4_suboffset;
    let range_check96_builtin_inner_range_check5_suboffset = dynamic_params
        .range_check96_builtin_inner_range_check5_suboffset;
    let range_check96_builtin_mem_suboffset = dynamic_params.range_check96_builtin_mem_suboffset;
    let range_check96_builtin_row_ratio = dynamic_params.range_check96_builtin_row_ratio;
    let range_check_builtin_inner_range_check_suboffset = dynamic_params
        .range_check_builtin_inner_range_check_suboffset;
    let range_check_builtin_mem_suboffset = dynamic_params.range_check_builtin_mem_suboffset;
    let range_check_builtin_row_ratio = dynamic_params.range_check_builtin_row_ratio;
    let range_check_units_row_ratio = dynamic_params.range_check_units_row_ratio;
    let uses_add_mod_builtin = dynamic_params.uses_add_mod_builtin;
    let uses_bitwise_builtin = dynamic_params.uses_bitwise_builtin;
    let uses_ec_op_builtin = dynamic_params.uses_ec_op_builtin;
    let uses_ecdsa_builtin = dynamic_params.uses_ecdsa_builtin;
    let uses_keccak_builtin = dynamic_params.uses_keccak_builtin;
    let uses_mul_mod_builtin = dynamic_params.uses_mul_mod_builtin;
    let uses_pedersen_builtin = dynamic_params.uses_pedersen_builtin;
    let uses_poseidon_builtin = dynamic_params.uses_poseidon_builtin;
    let uses_range_check96_builtin = dynamic_params.uses_range_check96_builtin;
    let uses_range_check_builtin = dynamic_params.uses_range_check_builtin;

    // Compute powers.
    let pow0 = pow(trace_generator, mul_mod_row_ratio.into());
    let pow1 = pow(trace_generator, add_mod_row_ratio.into());
    let pow2 = pow(trace_generator, range_check96_builtin_row_ratio.into());
    let pow3 = pow(trace_generator, (bitwise_row_ratio / 64).into());
    let pow4 = pow3 * pow3; // pow(trace_generator, (safe_div(bitwise_row_ratio, 32))).
    let pow5 = pow3
        * pow4; // pow(trace_generator, (safe_div((safe_mult(3, bitwise_row_ratio)), 64))).
    let pow6 = pow3 * pow5; // pow(trace_generator, (safe_div(bitwise_row_ratio, 16))).
    let pow7 = pow3
        * pow6; // pow(trace_generator, (safe_div((safe_mult(5, bitwise_row_ratio)), 64))).
    let pow8 = pow3
        * pow7; // pow(trace_generator, (safe_div((safe_mult(3, bitwise_row_ratio)), 32))).
    let pow9 = pow3
        * pow8; // pow(trace_generator, (safe_div((safe_mult(7, bitwise_row_ratio)), 64))).
    let pow10 = pow3 * pow9; // pow(trace_generator, (safe_div(bitwise_row_ratio, 8))).
    let pow11 = pow3
        * pow10; // pow(trace_generator, (safe_div((safe_mult(9, bitwise_row_ratio)), 64))).
    let pow12 = pow3
        * pow11; // pow(trace_generator, (safe_div((safe_mult(5, bitwise_row_ratio)), 32))).
    let pow13 = pow3
        * pow12; // pow(trace_generator, (safe_div((safe_mult(11, bitwise_row_ratio)), 64))).
    let pow14 = pow3
        * pow13; // pow(trace_generator, (safe_div((safe_mult(3, bitwise_row_ratio)), 16))).
    let pow15 = pow3
        * pow14; // pow(trace_generator, (safe_div((safe_mult(13, bitwise_row_ratio)), 64))).
    let pow16 = pow3
        * pow15; // pow(trace_generator, (safe_div((safe_mult(7, bitwise_row_ratio)), 32))).
    let pow17 = pow3
        * pow16; // pow(trace_generator, (safe_div((safe_mult(15, bitwise_row_ratio)), 64))).
    let pow18 = pow3 * pow17; // pow(trace_generator, (safe_div(bitwise_row_ratio, 4))).
    let pow19 = pow18 * pow18; // pow(trace_generator, (safe_div(bitwise_row_ratio, 2))).
    let pow20 = pow14
        * pow19; // pow(trace_generator, (safe_div((safe_mult(3, bitwise_row_ratio)), 16)) + (safe_div(bitwise_row_ratio, 2))).
    let pow21 = pow3
        * pow20; // pow(trace_generator, (safe_div((safe_mult(13, bitwise_row_ratio)), 64)) + (safe_div(bitwise_row_ratio, 2))).
    let pow22 = pow3
        * pow21; // pow(trace_generator, (safe_div((safe_mult(7, bitwise_row_ratio)), 32)) + (safe_div(bitwise_row_ratio, 2))).
    let pow23 = pow3
        * pow22; // pow(trace_generator, (safe_div((safe_mult(15, bitwise_row_ratio)), 64)) + (safe_div(bitwise_row_ratio, 2))).
    let pow24 = pow3
        * pow23; // pow(trace_generator, (safe_div((safe_mult(3, bitwise_row_ratio)), 4))).
    let pow25 = pow14
        * pow24; // pow(trace_generator, (safe_div((safe_mult(3, bitwise_row_ratio)), 16)) + (safe_div((safe_mult(3, bitwise_row_ratio)), 4))).
    let pow26 = pow3
        * pow25; // pow(trace_generator, (safe_div((safe_mult(13, bitwise_row_ratio)), 64)) + (safe_div((safe_mult(3, bitwise_row_ratio)), 4))).
    let pow27 = pow3
        * pow26; // pow(trace_generator, (safe_div((safe_mult(7, bitwise_row_ratio)), 32)) + (safe_div((safe_mult(3, bitwise_row_ratio)), 4))).
    let pow28 = pow3
        * pow27; // pow(trace_generator, (safe_div((safe_mult(15, bitwise_row_ratio)), 64)) + (safe_div((safe_mult(3, bitwise_row_ratio)), 4))).
    let pow29 = pow3 * pow28; // pow(trace_generator, bitwise_row_ratio).
    let pow30 = pow(trace_generator, (range_check_builtin_row_ratio / 8).into());
    let pow31 = pow30
        * pow30; // pow(trace_generator, (safe_div(range_check_builtin_row_ratio, 4))).
    let pow32 = pow30
        * pow31; // pow(trace_generator, (safe_div((safe_mult(3, range_check_builtin_row_ratio)), 8))).
    let pow33 = pow30
        * pow32; // pow(trace_generator, (safe_div(range_check_builtin_row_ratio, 2))).
    let pow34 = pow30
        * pow33; // pow(trace_generator, (safe_div((safe_mult(5, range_check_builtin_row_ratio)), 8))).
    let pow35 = pow30
        * pow34; // pow(trace_generator, (safe_div((safe_mult(3, range_check_builtin_row_ratio)), 4))).
    let pow36 = pow30
        * pow35; // pow(trace_generator, (safe_div((safe_mult(7, range_check_builtin_row_ratio)), 8))).
    let pow37 = pow30 * pow36; // pow(trace_generator, range_check_builtin_row_ratio).
    let pow38 = pow(
        trace_generator, (mul_mod_carry0_part6_suboffset * range_check_units_row_ratio).into()
    );
    let pow39 = pow(
        trace_generator, (mul_mod_carry0_part5_suboffset * range_check_units_row_ratio).into()
    );
    let pow40 = pow(
        trace_generator, (mul_mod_carry0_part4_suboffset * range_check_units_row_ratio).into()
    );
    let pow41 = pow(
        trace_generator, (mul_mod_carry0_part3_suboffset * range_check_units_row_ratio).into()
    );
    let pow42 = pow(
        trace_generator, (mul_mod_carry0_part2_suboffset * range_check_units_row_ratio).into()
    );
    let pow43 = pow(
        trace_generator, (mul_mod_carry0_part1_suboffset * range_check_units_row_ratio).into()
    );
    let pow44 = pow(
        trace_generator, (mul_mod_carry0_part0_suboffset * range_check_units_row_ratio).into()
    );
    let pow45 = pow(
        trace_generator, (mul_mod_carry5_part6_suboffset * range_check_units_row_ratio).into()
    );
    let pow46 = pow(
        trace_generator, (mul_mod_carry5_part5_suboffset * range_check_units_row_ratio).into()
    );
    let pow47 = pow(
        trace_generator, (mul_mod_carry5_part4_suboffset * range_check_units_row_ratio).into()
    );
    let pow48 = pow(
        trace_generator, (mul_mod_carry5_part3_suboffset * range_check_units_row_ratio).into()
    );
    let pow49 = pow(
        trace_generator, (mul_mod_carry5_part2_suboffset * range_check_units_row_ratio).into()
    );
    let pow50 = pow(
        trace_generator, (mul_mod_carry5_part1_suboffset * range_check_units_row_ratio).into()
    );
    let pow51 = pow(
        trace_generator, (mul_mod_carry5_part0_suboffset * range_check_units_row_ratio).into()
    );
    let pow52 = pow(
        trace_generator, (mul_mod_carry4_part6_suboffset * range_check_units_row_ratio).into()
    );
    let pow53 = pow(
        trace_generator, (mul_mod_carry4_part5_suboffset * range_check_units_row_ratio).into()
    );
    let pow54 = pow(
        trace_generator, (mul_mod_carry4_part4_suboffset * range_check_units_row_ratio).into()
    );
    let pow55 = pow(
        trace_generator, (mul_mod_carry4_part3_suboffset * range_check_units_row_ratio).into()
    );
    let pow56 = pow(
        trace_generator, (mul_mod_carry4_part2_suboffset * range_check_units_row_ratio).into()
    );
    let pow57 = pow(
        trace_generator, (mul_mod_carry4_part1_suboffset * range_check_units_row_ratio).into()
    );
    let pow58 = pow(
        trace_generator, (mul_mod_carry4_part0_suboffset * range_check_units_row_ratio).into()
    );
    let pow59 = pow(
        trace_generator, (mul_mod_carry3_part6_suboffset * range_check_units_row_ratio).into()
    );
    let pow60 = pow(
        trace_generator, (mul_mod_carry3_part5_suboffset * range_check_units_row_ratio).into()
    );
    let pow61 = pow(
        trace_generator, (mul_mod_carry3_part4_suboffset * range_check_units_row_ratio).into()
    );
    let pow62 = pow(
        trace_generator, (mul_mod_carry3_part3_suboffset * range_check_units_row_ratio).into()
    );
    let pow63 = pow(
        trace_generator, (mul_mod_carry3_part2_suboffset * range_check_units_row_ratio).into()
    );
    let pow64 = pow(
        trace_generator, (mul_mod_carry3_part1_suboffset * range_check_units_row_ratio).into()
    );
    let pow65 = pow(
        trace_generator, (mul_mod_carry3_part0_suboffset * range_check_units_row_ratio).into()
    );
    let pow66 = pow(
        trace_generator, (mul_mod_carry2_part6_suboffset * range_check_units_row_ratio).into()
    );
    let pow67 = pow(
        trace_generator, (mul_mod_carry2_part5_suboffset * range_check_units_row_ratio).into()
    );
    let pow68 = pow(
        trace_generator, (mul_mod_carry2_part4_suboffset * range_check_units_row_ratio).into()
    );
    let pow69 = pow(
        trace_generator, (mul_mod_carry2_part3_suboffset * range_check_units_row_ratio).into()
    );
    let pow70 = pow(
        trace_generator, (mul_mod_carry2_part2_suboffset * range_check_units_row_ratio).into()
    );
    let pow71 = pow(
        trace_generator, (mul_mod_carry2_part1_suboffset * range_check_units_row_ratio).into()
    );
    let pow72 = pow(
        trace_generator, (mul_mod_carry2_part0_suboffset * range_check_units_row_ratio).into()
    );
    let pow73 = pow(
        trace_generator, (mul_mod_carry1_part6_suboffset * range_check_units_row_ratio).into()
    );
    let pow74 = pow(
        trace_generator, (mul_mod_carry1_part5_suboffset * range_check_units_row_ratio).into()
    );
    let pow75 = pow(
        trace_generator, (mul_mod_carry1_part4_suboffset * range_check_units_row_ratio).into()
    );
    let pow76 = pow(
        trace_generator, (mul_mod_carry1_part3_suboffset * range_check_units_row_ratio).into()
    );
    let pow77 = pow(
        trace_generator, (mul_mod_carry1_part2_suboffset * range_check_units_row_ratio).into()
    );
    let pow78 = pow(
        trace_generator, (mul_mod_carry1_part1_suboffset * range_check_units_row_ratio).into()
    );
    let pow79 = pow(
        trace_generator, (mul_mod_carry1_part0_suboffset * range_check_units_row_ratio).into()
    );
    let pow80 = pow(
        trace_generator,
        (mul_mod_p_multiplier0_part5_suboffset * range_check_units_row_ratio).into(),
    );
    let pow81 = pow(
        trace_generator,
        (mul_mod_p_multiplier0_part4_suboffset * range_check_units_row_ratio).into(),
    );
    let pow82 = pow(
        trace_generator,
        (mul_mod_p_multiplier0_part3_suboffset * range_check_units_row_ratio).into(),
    );
    let pow83 = pow(
        trace_generator,
        (mul_mod_p_multiplier0_part2_suboffset * range_check_units_row_ratio).into(),
    );
    let pow84 = pow(
        trace_generator,
        (mul_mod_p_multiplier0_part1_suboffset * range_check_units_row_ratio).into(),
    );
    let pow85 = pow(
        trace_generator,
        (mul_mod_p_multiplier0_part0_suboffset * range_check_units_row_ratio).into(),
    );
    let pow86 = pow(
        trace_generator,
        (mul_mod_p_multiplier3_part5_suboffset * range_check_units_row_ratio).into(),
    );
    let pow87 = pow(
        trace_generator,
        (mul_mod_p_multiplier3_part4_suboffset * range_check_units_row_ratio).into(),
    );
    let pow88 = pow(
        trace_generator,
        (mul_mod_p_multiplier3_part3_suboffset * range_check_units_row_ratio).into(),
    );
    let pow89 = pow(
        trace_generator,
        (mul_mod_p_multiplier3_part2_suboffset * range_check_units_row_ratio).into(),
    );
    let pow90 = pow(
        trace_generator,
        (mul_mod_p_multiplier3_part1_suboffset * range_check_units_row_ratio).into(),
    );
    let pow91 = pow(
        trace_generator,
        (mul_mod_p_multiplier3_part0_suboffset * range_check_units_row_ratio).into(),
    );
    let pow92 = pow(
        trace_generator,
        (mul_mod_p_multiplier2_part5_suboffset * range_check_units_row_ratio).into(),
    );
    let pow93 = pow(
        trace_generator,
        (mul_mod_p_multiplier2_part4_suboffset * range_check_units_row_ratio).into(),
    );
    let pow94 = pow(
        trace_generator,
        (mul_mod_p_multiplier2_part3_suboffset * range_check_units_row_ratio).into(),
    );
    let pow95 = pow(
        trace_generator,
        (mul_mod_p_multiplier2_part2_suboffset * range_check_units_row_ratio).into(),
    );
    let pow96 = pow(
        trace_generator,
        (mul_mod_p_multiplier2_part1_suboffset * range_check_units_row_ratio).into(),
    );
    let pow97 = pow(
        trace_generator,
        (mul_mod_p_multiplier2_part0_suboffset * range_check_units_row_ratio).into(),
    );
    let pow98 = pow(
        trace_generator,
        (mul_mod_p_multiplier1_part5_suboffset * range_check_units_row_ratio).into(),
    );
    let pow99 = pow(
        trace_generator,
        (mul_mod_p_multiplier1_part4_suboffset * range_check_units_row_ratio).into(),
    );
    let pow100 = pow(
        trace_generator,
        (mul_mod_p_multiplier1_part3_suboffset * range_check_units_row_ratio).into(),
    );
    let pow101 = pow(
        trace_generator,
        (mul_mod_p_multiplier1_part2_suboffset * range_check_units_row_ratio).into(),
    );
    let pow102 = pow(
        trace_generator,
        (mul_mod_p_multiplier1_part1_suboffset * range_check_units_row_ratio).into(),
    );
    let pow103 = pow(
        trace_generator,
        (mul_mod_p_multiplier1_part0_suboffset * range_check_units_row_ratio).into(),
    );
    let pow104 = pow(trace_generator, (mul_mod_c3_suboffset * memory_units_row_ratio).into());
    let pow105 = pow(trace_generator, (mul_mod_c2_suboffset * memory_units_row_ratio).into());
    let pow106 = pow(trace_generator, (mul_mod_c1_suboffset * memory_units_row_ratio).into());
    let pow107 = pow(trace_generator, (mul_mod_c0_suboffset * memory_units_row_ratio).into());
    let pow108 = pow(trace_generator, (mul_mod_b3_suboffset * memory_units_row_ratio).into());
    let pow109 = pow(trace_generator, (mul_mod_b2_suboffset * memory_units_row_ratio).into());
    let pow110 = pow(trace_generator, (mul_mod_b1_suboffset * memory_units_row_ratio).into());
    let pow111 = pow(trace_generator, (mul_mod_b0_suboffset * memory_units_row_ratio).into());
    let pow112 = pow(trace_generator, (mul_mod_a3_suboffset * memory_units_row_ratio).into());
    let pow113 = pow(trace_generator, (mul_mod_a2_suboffset * memory_units_row_ratio).into());
    let pow114 = pow(trace_generator, (mul_mod_a1_suboffset * memory_units_row_ratio).into());
    let pow115 = pow(trace_generator, (mul_mod_a0_suboffset * memory_units_row_ratio).into());
    let pow116 = pow(trace_generator, (mul_mod_c_offset_suboffset * memory_units_row_ratio).into());
    let pow117 = pow(trace_generator, (mul_mod_b_offset_suboffset * memory_units_row_ratio).into());
    let pow118 = pow(trace_generator, (mul_mod_a_offset_suboffset * memory_units_row_ratio).into());
    let pow119 = pow(trace_generator, (mul_mod_n_suboffset * memory_units_row_ratio).into());
    let pow120 = pow0
        * pow119; // pow(trace_generator, mul_mod_row_ratio + (safe_mult(mul_mod_n_suboffset, memory_units_row_ratio))).
    let pow121 = pow(
        trace_generator, (mul_mod_offsets_ptr_suboffset * memory_units_row_ratio).into()
    );
    let pow122 = pow0
        * pow121; // pow(trace_generator, mul_mod_row_ratio + (safe_mult(mul_mod_offsets_ptr_suboffset, memory_units_row_ratio))).
    let pow123 = pow(
        trace_generator, (mul_mod_values_ptr_suboffset * memory_units_row_ratio).into()
    );
    let pow124 = pow0
        * pow123; // pow(trace_generator, mul_mod_row_ratio + (safe_mult(mul_mod_values_ptr_suboffset, memory_units_row_ratio))).
    let pow125 = pow(trace_generator, (mul_mod_p3_suboffset * memory_units_row_ratio).into());
    let pow126 = pow0
        * pow125; // pow(trace_generator, mul_mod_row_ratio + (safe_mult(mul_mod_p3_suboffset, memory_units_row_ratio))).
    let pow127 = pow(trace_generator, (mul_mod_p2_suboffset * memory_units_row_ratio).into());
    let pow128 = pow0
        * pow127; // pow(trace_generator, mul_mod_row_ratio + (safe_mult(mul_mod_p2_suboffset, memory_units_row_ratio))).
    let pow129 = pow(trace_generator, (mul_mod_p1_suboffset * memory_units_row_ratio).into());
    let pow130 = pow0
        * pow129; // pow(trace_generator, mul_mod_row_ratio + (safe_mult(mul_mod_p1_suboffset, memory_units_row_ratio))).
    let pow131 = pow(trace_generator, (mul_mod_p0_suboffset * memory_units_row_ratio).into());
    let pow132 = pow0
        * pow131; // pow(trace_generator, mul_mod_row_ratio + (safe_mult(mul_mod_p0_suboffset, memory_units_row_ratio))).
    let pow133 = pow(trace_generator, (add_mod_c3_suboffset * memory_units_row_ratio).into());
    let pow134 = pow(trace_generator, (add_mod_c2_suboffset * memory_units_row_ratio).into());
    let pow135 = pow(trace_generator, (add_mod_c1_suboffset * memory_units_row_ratio).into());
    let pow136 = pow(trace_generator, (add_mod_c0_suboffset * memory_units_row_ratio).into());
    let pow137 = pow(trace_generator, (add_mod_b3_suboffset * memory_units_row_ratio).into());
    let pow138 = pow(trace_generator, (add_mod_b2_suboffset * memory_units_row_ratio).into());
    let pow139 = pow(trace_generator, (add_mod_b1_suboffset * memory_units_row_ratio).into());
    let pow140 = pow(trace_generator, (add_mod_b0_suboffset * memory_units_row_ratio).into());
    let pow141 = pow(trace_generator, (add_mod_a3_suboffset * memory_units_row_ratio).into());
    let pow142 = pow(trace_generator, (add_mod_a2_suboffset * memory_units_row_ratio).into());
    let pow143 = pow(trace_generator, (add_mod_a1_suboffset * memory_units_row_ratio).into());
    let pow144 = pow(trace_generator, (add_mod_a0_suboffset * memory_units_row_ratio).into());
    let pow145 = pow(trace_generator, (add_mod_c_offset_suboffset * memory_units_row_ratio).into());
    let pow146 = pow(trace_generator, (add_mod_b_offset_suboffset * memory_units_row_ratio).into());
    let pow147 = pow(trace_generator, (add_mod_a_offset_suboffset * memory_units_row_ratio).into());
    let pow148 = pow(trace_generator, (add_mod_n_suboffset * memory_units_row_ratio).into());
    let pow149 = pow1
        * pow148; // pow(trace_generator, add_mod_row_ratio + (safe_mult(add_mod_n_suboffset, memory_units_row_ratio))).
    let pow150 = pow(
        trace_generator, (add_mod_offsets_ptr_suboffset * memory_units_row_ratio).into()
    );
    let pow151 = pow1
        * pow150; // pow(trace_generator, add_mod_row_ratio + (safe_mult(add_mod_offsets_ptr_suboffset, memory_units_row_ratio))).
    let pow152 = pow(
        trace_generator, (add_mod_values_ptr_suboffset * memory_units_row_ratio).into()
    );
    let pow153 = pow1
        * pow152; // pow(trace_generator, add_mod_row_ratio + (safe_mult(add_mod_values_ptr_suboffset, memory_units_row_ratio))).
    let pow154 = pow(trace_generator, (add_mod_p3_suboffset * memory_units_row_ratio).into());
    let pow155 = pow1
        * pow154; // pow(trace_generator, add_mod_row_ratio + (safe_mult(add_mod_p3_suboffset, memory_units_row_ratio))).
    let pow156 = pow(trace_generator, (add_mod_p2_suboffset * memory_units_row_ratio).into());
    let pow157 = pow1
        * pow156; // pow(trace_generator, add_mod_row_ratio + (safe_mult(add_mod_p2_suboffset, memory_units_row_ratio))).
    let pow158 = pow(trace_generator, (add_mod_p1_suboffset * memory_units_row_ratio).into());
    let pow159 = pow1
        * pow158; // pow(trace_generator, add_mod_row_ratio + (safe_mult(add_mod_p1_suboffset, memory_units_row_ratio))).
    let pow160 = pow(trace_generator, (add_mod_p0_suboffset * memory_units_row_ratio).into());
    let pow161 = pow1
        * pow160; // pow(trace_generator, add_mod_row_ratio + (safe_mult(add_mod_p0_suboffset, memory_units_row_ratio))).
    let pow162 = pow(
        trace_generator,
        (range_check96_builtin_inner_range_check5_suboffset * range_check_units_row_ratio).into(),
    );
    let pow163 = pow(
        trace_generator,
        (range_check96_builtin_inner_range_check4_suboffset * range_check_units_row_ratio).into(),
    );
    let pow164 = pow(
        trace_generator,
        (range_check96_builtin_inner_range_check3_suboffset * range_check_units_row_ratio).into(),
    );
    let pow165 = pow(
        trace_generator,
        (range_check96_builtin_inner_range_check2_suboffset * range_check_units_row_ratio).into(),
    );
    let pow166 = pow(
        trace_generator,
        (range_check96_builtin_inner_range_check1_suboffset * range_check_units_row_ratio).into(),
    );
    let pow167 = pow(
        trace_generator,
        (range_check96_builtin_inner_range_check0_suboffset * range_check_units_row_ratio).into(),
    );
    let pow168 = pow(
        trace_generator, (range_check96_builtin_mem_suboffset * memory_units_row_ratio).into()
    );
    let pow169 = pow2
        * pow168; // pow(trace_generator, range_check96_builtin_row_ratio + (safe_mult(range_check96_builtin_mem_suboffset, memory_units_row_ratio))).
    let pow170 = pow(trace_generator, (poseidon_row_ratio / 64).into());
    let pow171 = pow(trace_generator, (3 * poseidon_row_ratio / 8).into());
    let pow172 = pow170 * pow170; // pow(trace_generator, (safe_div(poseidon_row_ratio, 32))).
    let pow173 = pow170
        * pow172; // pow(trace_generator, (safe_div((safe_mult(3, poseidon_row_ratio)), 64))).
    let pow174 = pow170 * pow173; // pow(trace_generator, (safe_div(poseidon_row_ratio, 16))).
    let pow175 = pow172
        * pow174; // pow(trace_generator, (safe_div((safe_mult(3, poseidon_row_ratio)), 32))).
    let pow176 = pow(trace_generator, (61 * poseidon_row_ratio / 64).into());
    let pow177 = pow172 * pow175; // pow(trace_generator, (safe_div(poseidon_row_ratio, 8))).
    let pow178 = pow171 * pow177; // pow(trace_generator, (safe_div(poseidon_row_ratio, 2))).
    let pow179 = pow175
        * pow178; // pow(trace_generator, (safe_div((safe_mult(19, poseidon_row_ratio)), 32))).
    let pow180 = pow172
        * pow179; // pow(trace_generator, (safe_div((safe_mult(5, poseidon_row_ratio)), 8))).
    let pow181 = pow172
        * pow180; // pow(trace_generator, (safe_div((safe_mult(21, poseidon_row_ratio)), 32))).
    let pow182 = pow171
        * pow178; // pow(trace_generator, (safe_div((safe_mult(7, poseidon_row_ratio)), 8))).
    let pow183 = pow170
        * pow176; // pow(trace_generator, (safe_div((safe_mult(31, poseidon_row_ratio)), 32))).
    let pow184 = pow170
        * pow183; // pow(trace_generator, (safe_div((safe_mult(63, poseidon_row_ratio)), 64))).
    let pow185 = pow(
        trace_generator, (poseidon_param_2_input_output_suboffset * memory_units_row_ratio).into(),
    );
    let pow186 = pow178
        * pow185; // pow(trace_generator, (safe_div(poseidon_row_ratio, 2)) + (safe_mult(poseidon_param_2_input_output_suboffset, memory_units_row_ratio))).
    let pow187 = pow(
        trace_generator, (poseidon_param_1_input_output_suboffset * memory_units_row_ratio).into(),
    );
    let pow188 = pow178
        * pow187; // pow(trace_generator, (safe_div(poseidon_row_ratio, 2)) + (safe_mult(poseidon_param_1_input_output_suboffset, memory_units_row_ratio))).
    let pow189 = pow(
        trace_generator, (poseidon_param_0_input_output_suboffset * memory_units_row_ratio).into(),
    );
    let pow190 = pow178
        * pow189; // pow(trace_generator, (safe_div(poseidon_row_ratio, 2)) + (safe_mult(poseidon_param_0_input_output_suboffset, memory_units_row_ratio))).
    let pow191 = pow(
        trace_generator, (keccak_keccak_diluted_column2_suboffset * diluted_units_row_ratio).into(),
    );
    let pow192 = pow(
        trace_generator, (keccak_keccak_diluted_column1_suboffset * diluted_units_row_ratio).into(),
    );
    let pow193 = pow(
        trace_generator, (keccak_keccak_diluted_column3_suboffset * diluted_units_row_ratio).into(),
    );
    let pow194 = pow(
        trace_generator, (keccak_keccak_diluted_column0_suboffset * diluted_units_row_ratio).into(),
    );
    let pow195 = pow(trace_generator, (keccak_row_ratio / 32768).into());
    let pow196 = pow195 * pow195; // pow(trace_generator, (safe_div(keccak_row_ratio, 16384))).
    let pow197 = pow195
        * pow196; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 32768))).
    let pow198 = pow195 * pow197; // pow(trace_generator, (safe_div(keccak_row_ratio, 8192))).
    let pow199 = pow195
        * pow198; // pow(trace_generator, (safe_div((safe_mult(5, keccak_row_ratio)), 32768))).
    let pow200 = pow195
        * pow199; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 16384))).
    let pow201 = pow195
        * pow200; // pow(trace_generator, (safe_div((safe_mult(7, keccak_row_ratio)), 32768))).
    let pow202 = pow195 * pow201; // pow(trace_generator, (safe_div(keccak_row_ratio, 4096))).
    let pow203 = pow195
        * pow202; // pow(trace_generator, (safe_div(keccak_row_ratio, 4096)) + (safe_div(keccak_row_ratio, 32768))).
    let pow204 = pow195
        * pow203; // pow(trace_generator, (safe_div(keccak_row_ratio, 4096)) + (safe_div(keccak_row_ratio, 16384))).
    let pow205 = pow195
        * pow204; // pow(trace_generator, (safe_div(keccak_row_ratio, 4096)) + (safe_div((safe_mult(3, keccak_row_ratio)), 32768))).
    let pow206 = pow195
        * pow205; // pow(trace_generator, (safe_div(keccak_row_ratio, 4096)) + (safe_div(keccak_row_ratio, 8192))).
    let pow207 = pow195
        * pow206; // pow(trace_generator, (safe_div(keccak_row_ratio, 4096)) + (safe_div((safe_mult(5, keccak_row_ratio)), 32768))).
    let pow208 = pow195
        * pow207; // pow(trace_generator, (safe_div(keccak_row_ratio, 4096)) + (safe_div((safe_mult(3, keccak_row_ratio)), 16384))).
    let pow209 = pow195
        * pow208; // pow(trace_generator, (safe_div(keccak_row_ratio, 4096)) + (safe_div((safe_mult(7, keccak_row_ratio)), 32768))).
    let pow210 = pow195 * pow209; // pow(trace_generator, (safe_div(keccak_row_ratio, 2048))).
    let pow211 = pow195
        * pow210; // pow(trace_generator, (safe_div(keccak_row_ratio, 2048)) + (safe_div(keccak_row_ratio, 32768))).
    let pow212 = pow195
        * pow211; // pow(trace_generator, (safe_div(keccak_row_ratio, 2048)) + (safe_div(keccak_row_ratio, 16384))).
    let pow213 = pow195
        * pow212; // pow(trace_generator, (safe_div(keccak_row_ratio, 2048)) + (safe_div((safe_mult(3, keccak_row_ratio)), 32768))).
    let pow214 = pow195
        * pow213; // pow(trace_generator, (safe_div(keccak_row_ratio, 2048)) + (safe_div(keccak_row_ratio, 8192))).
    let pow215 = pow195
        * pow214; // pow(trace_generator, (safe_div(keccak_row_ratio, 2048)) + (safe_div((safe_mult(5, keccak_row_ratio)), 32768))).
    let pow216 = pow195
        * pow215; // pow(trace_generator, (safe_div(keccak_row_ratio, 2048)) + (safe_div((safe_mult(3, keccak_row_ratio)), 16384))).
    let pow217 = pow195
        * pow216; // pow(trace_generator, (safe_div(keccak_row_ratio, 2048)) + (safe_div((safe_mult(7, keccak_row_ratio)), 32768))).
    let pow218 = pow203 * pow217; // pow(trace_generator, (safe_div(keccak_row_ratio, 1024))).
    let pow219 = pow210
        * pow218; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 2048))).
    let pow220 = pow210 * pow219; // pow(trace_generator, (safe_div(keccak_row_ratio, 512))).
    let pow221 = pow210
        * pow220; // pow(trace_generator, (safe_div((safe_mult(5, keccak_row_ratio)), 2048))).
    let pow222 = pow210
        * pow221; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 1024))).
    let pow223 = pow210
        * pow222; // pow(trace_generator, (safe_div((safe_mult(7, keccak_row_ratio)), 2048))).
    let pow224 = pow210 * pow223; // pow(trace_generator, (safe_div(keccak_row_ratio, 256))).
    let pow225 = pow210
        * pow224; // pow(trace_generator, (safe_div((safe_mult(9, keccak_row_ratio)), 2048))).
    let pow226 = pow210
        * pow225; // pow(trace_generator, (safe_div((safe_mult(5, keccak_row_ratio)), 1024))).
    let pow227 = pow210
        * pow226; // pow(trace_generator, (safe_div((safe_mult(11, keccak_row_ratio)), 2048))).
    let pow228 = pow210
        * pow227; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow229 = pow193
        * pow228; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow230 = pow194
        * pow228; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow231 = pow210
        * pow228; // pow(trace_generator, (safe_div((safe_mult(13, keccak_row_ratio)), 2048))).
    let pow232 = pow210
        * pow231; // pow(trace_generator, (safe_div((safe_mult(7, keccak_row_ratio)), 1024))).
    let pow233 = pow210
        * pow232; // pow(trace_generator, (safe_div((safe_mult(15, keccak_row_ratio)), 2048))).
    let pow234 = pow202
        * pow233; // pow(trace_generator, (safe_div((safe_mult(31, keccak_row_ratio)), 4096))).
    let pow235 = pow202 * pow234; // pow(trace_generator, (safe_div(keccak_row_ratio, 128))).
    let pow236 = pow193
        * pow235; // pow(trace_generator, (safe_div(keccak_row_ratio, 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow237 = pow210
        * pow235; // pow(trace_generator, (safe_div(keccak_row_ratio, 2048)) + (safe_div(keccak_row_ratio, 128))).
    let pow238 = pow219
        * pow237; // pow(trace_generator, (safe_div(keccak_row_ratio, 256)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow239 = pow220
        * pow238; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow240 = pow220
        * pow239; // pow(trace_generator, (safe_div((safe_mult(7, keccak_row_ratio)), 512))).
    let pow241 = pow193
        * pow240; // pow(trace_generator, (safe_div((safe_mult(7, keccak_row_ratio)), 512)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow242 = pow219
        * pow240; // pow(trace_generator, (safe_div((safe_mult(15, keccak_row_ratio)), 2048)) + (safe_div(keccak_row_ratio, 128))).
    let pow243 = pow202
        * pow242; // pow(trace_generator, (safe_div((safe_mult(31, keccak_row_ratio)), 4096)) + (safe_div(keccak_row_ratio, 128))).
    let pow244 = pow202 * pow243; // pow(trace_generator, (safe_div(keccak_row_ratio, 64))).
    let pow245 = pow220
        * pow244; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow246 = pow193
        * pow244; // pow(trace_generator, (safe_div(keccak_row_ratio, 64)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow247 = pow224
        * pow245; // pow(trace_generator, (safe_div((safe_mult(11, keccak_row_ratio)), 512))).
    let pow248 = pow193
        * pow247; // pow(trace_generator, (safe_div((safe_mult(11, keccak_row_ratio)), 512)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow249 = pow220
        * pow247; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 128))).
    let pow250 = pow191
        * pow249; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column2_suboffset, diluted_units_row_ratio))).
    let pow251 = pow192
        * pow249; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio))).
    let pow252 = pow202
        * pow249; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 128)) + (safe_div(keccak_row_ratio, 4096))).
    let pow253 = pow193
        * pow249; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow254 = pow228
        * pow249; // pow(trace_generator, (safe_div((safe_mult(15, keccak_row_ratio)), 512))).
    let pow255 = pow193
        * pow254; // pow(trace_generator, (safe_div((safe_mult(15, keccak_row_ratio)), 512)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow256 = pow220 * pow254; // pow(trace_generator, (safe_div(keccak_row_ratio, 32))).
    let pow257 = pow191
        * pow256; // pow(trace_generator, (safe_div(keccak_row_ratio, 32)) + (safe_mult(keccak_keccak_diluted_column2_suboffset, diluted_units_row_ratio))).
    let pow258 = pow192
        * pow256; // pow(trace_generator, (safe_div(keccak_row_ratio, 32)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio))).
    let pow259 = pow193
        * pow256; // pow(trace_generator, (safe_div(keccak_row_ratio, 32)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow260 = pow224
        * pow256; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow261 = pow202
        * pow256; // pow(trace_generator, (safe_div(keccak_row_ratio, 32)) + (safe_div(keccak_row_ratio, 4096))).
    let pow262 = pow220
        * pow260; // pow(trace_generator, (safe_div((safe_mult(19, keccak_row_ratio)), 512))).
    let pow263 = pow193
        * pow262; // pow(trace_generator, (safe_div((safe_mult(19, keccak_row_ratio)), 512)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow264 = pow220
        * pow262; // pow(trace_generator, (safe_div((safe_mult(5, keccak_row_ratio)), 128))).
    let pow265 = pow220
        * pow264; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow266 = pow224
        * pow265; // pow(trace_generator, (safe_div((safe_mult(23, keccak_row_ratio)), 512))).
    let pow267 = pow193
        * pow264; // pow(trace_generator, (safe_div((safe_mult(5, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow268 = pow193
        * pow266; // pow(trace_generator, (safe_div((safe_mult(23, keccak_row_ratio)), 512)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow269 = pow220
        * pow266; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 64))).
    let pow270 = pow228
        * pow269; // pow(trace_generator, (safe_div((safe_mult(27, keccak_row_ratio)), 512))).
    let pow271 = pow193
        * pow269; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 64)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow272 = pow193
        * pow270; // pow(trace_generator, (safe_div((safe_mult(27, keccak_row_ratio)), 512)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow273 = pow220
        * pow270; // pow(trace_generator, (safe_div((safe_mult(7, keccak_row_ratio)), 128))).
    let pow274 = pow228
        * pow273; // pow(trace_generator, (safe_div((safe_mult(31, keccak_row_ratio)), 512))).
    let pow275 = pow193
        * pow273; // pow(trace_generator, (safe_div((safe_mult(7, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow276 = pow193
        * pow274; // pow(trace_generator, (safe_div((safe_mult(31, keccak_row_ratio)), 512)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow277 = pow220 * pow274; // pow(trace_generator, (safe_div(keccak_row_ratio, 16))).
    let pow278 = pow193
        * pow277; // pow(trace_generator, (safe_div(keccak_row_ratio, 16)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow279 = pow220
        * pow277; // pow(trace_generator, (safe_div(keccak_row_ratio, 512)) + (safe_div(keccak_row_ratio, 16))).
    let pow280 = pow220
        * pow279; // pow(trace_generator, (safe_div(keccak_row_ratio, 256)) + (safe_div(keccak_row_ratio, 16))).
    let pow281 = pow220
        * pow280; // pow(trace_generator, (safe_div((safe_mult(35, keccak_row_ratio)), 512))).
    let pow282 = pow193
        * pow281; // pow(trace_generator, (safe_div((safe_mult(35, keccak_row_ratio)), 512)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow283 = pow220
        * pow281; // pow(trace_generator, (safe_div((safe_mult(9, keccak_row_ratio)), 128))).
    let pow284 = pow193
        * pow283; // pow(trace_generator, (safe_div((safe_mult(9, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow285 = pow228
        * pow283; // pow(trace_generator, (safe_div((safe_mult(39, keccak_row_ratio)), 512))).
    let pow286 = pow193
        * pow285; // pow(trace_generator, (safe_div((safe_mult(39, keccak_row_ratio)), 512)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow287 = pow220
        * pow285; // pow(trace_generator, (safe_div((safe_mult(5, keccak_row_ratio)), 64))).
    let pow288 = pow228
        * pow287; // pow(trace_generator, (safe_div((safe_mult(43, keccak_row_ratio)), 512))).
    let pow289 = pow193
        * pow287; // pow(trace_generator, (safe_div((safe_mult(5, keccak_row_ratio)), 64)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow290 = pow193
        * pow288; // pow(trace_generator, (safe_div((safe_mult(43, keccak_row_ratio)), 512)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow291 = pow220
        * pow288; // pow(trace_generator, (safe_div((safe_mult(11, keccak_row_ratio)), 128))).
    let pow292 = pow228
        * pow291; // pow(trace_generator, (safe_div((safe_mult(47, keccak_row_ratio)), 512))).
    let pow293 = pow193
        * pow291; // pow(trace_generator, (safe_div((safe_mult(11, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow294 = pow193
        * pow292; // pow(trace_generator, (safe_div((safe_mult(47, keccak_row_ratio)), 512)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow295 = pow220
        * pow292; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 32))).
    let pow296 = pow193
        * pow295; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 32)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow297 = pow235
        * pow295; // pow(trace_generator, (safe_div((safe_mult(13, keccak_row_ratio)), 128))).
    let pow298 = pow193
        * pow297; // pow(trace_generator, (safe_div((safe_mult(13, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow299 = pow235
        * pow297; // pow(trace_generator, (safe_div((safe_mult(7, keccak_row_ratio)), 64))).
    let pow300 = pow193
        * pow299; // pow(trace_generator, (safe_div((safe_mult(7, keccak_row_ratio)), 64)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow301 = pow220
        * pow299; // pow(trace_generator, (safe_div(keccak_row_ratio, 512)) + (safe_div((safe_mult(7, keccak_row_ratio)), 64))).
    let pow302 = pow220
        * pow301; // pow(trace_generator, (safe_div(keccak_row_ratio, 256)) + (safe_div((safe_mult(7, keccak_row_ratio)), 64))).
    let pow303 = pow224
        * pow302; // pow(trace_generator, (safe_div((safe_mult(15, keccak_row_ratio)), 128))).
    let pow304 = pow220
        * pow303; // pow(trace_generator, (safe_div(keccak_row_ratio, 512)) + (safe_div((safe_mult(15, keccak_row_ratio)), 128))).
    let pow305 = pow220
        * pow304; // pow(trace_generator, (safe_div(keccak_row_ratio, 256)) + (safe_div((safe_mult(15, keccak_row_ratio)), 128))).
    let pow306 = pow193
        * pow303; // pow(trace_generator, (safe_div((safe_mult(15, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow307 = pow224 * pow305; // pow(trace_generator, (safe_div(keccak_row_ratio, 8))).
    let pow308 = pow193
        * pow307; // pow(trace_generator, (safe_div(keccak_row_ratio, 8)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow309 = pow235
        * pow307; // pow(trace_generator, (safe_div((safe_mult(17, keccak_row_ratio)), 128))).
    let pow310 = pow193
        * pow309; // pow(trace_generator, (safe_div((safe_mult(17, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow311 = pow235
        * pow309; // pow(trace_generator, (safe_div((safe_mult(9, keccak_row_ratio)), 64))).
    let pow312 = pow193
        * pow311; // pow(trace_generator, (safe_div((safe_mult(9, keccak_row_ratio)), 64)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow313 = pow235
        * pow311; // pow(trace_generator, (safe_div((safe_mult(19, keccak_row_ratio)), 128))).
    let pow314 = pow193
        * pow313; // pow(trace_generator, (safe_div((safe_mult(19, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow315 = pow235
        * pow313; // pow(trace_generator, (safe_div((safe_mult(5, keccak_row_ratio)), 32))).
    let pow316 = pow193
        * pow315; // pow(trace_generator, (safe_div((safe_mult(5, keccak_row_ratio)), 32)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow317 = pow235
        * pow315; // pow(trace_generator, (safe_div((safe_mult(21, keccak_row_ratio)), 128))).
    let pow318 = pow193
        * pow317; // pow(trace_generator, (safe_div((safe_mult(21, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow319 = pow220
        * pow317; // pow(trace_generator, (safe_div(keccak_row_ratio, 512)) + (safe_div((safe_mult(21, keccak_row_ratio)), 128))).
    let pow320 = pow193
        * pow319; // pow(trace_generator, (safe_div(keccak_row_ratio, 512)) + (safe_div((safe_mult(21, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow321 = pow220
        * pow319; // pow(trace_generator, (safe_div(keccak_row_ratio, 256)) + (safe_div((safe_mult(21, keccak_row_ratio)), 128))).
    let pow322 = pow193
        * pow321; // pow(trace_generator, (safe_div(keccak_row_ratio, 256)) + (safe_div((safe_mult(21, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow323 = pow224
        * pow321; // pow(trace_generator, (safe_div((safe_mult(11, keccak_row_ratio)), 64))).
    let pow324 = pow193
        * pow323; // pow(trace_generator, (safe_div((safe_mult(11, keccak_row_ratio)), 64)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow325 = pow220
        * pow323; // pow(trace_generator, (safe_div(keccak_row_ratio, 512)) + (safe_div((safe_mult(11, keccak_row_ratio)), 64))).
    let pow326 = pow193
        * pow325; // pow(trace_generator, (safe_div(keccak_row_ratio, 512)) + (safe_div((safe_mult(11, keccak_row_ratio)), 64)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow327 = pow220
        * pow325; // pow(trace_generator, (safe_div(keccak_row_ratio, 256)) + (safe_div((safe_mult(11, keccak_row_ratio)), 64))).
    let pow328 = pow193
        * pow327; // pow(trace_generator, (safe_div(keccak_row_ratio, 256)) + (safe_div((safe_mult(11, keccak_row_ratio)), 64)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow329 = pow224
        * pow327; // pow(trace_generator, (safe_div((safe_mult(23, keccak_row_ratio)), 128))).
    let pow330 = pow193
        * pow329; // pow(trace_generator, (safe_div((safe_mult(23, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow331 = pow220
        * pow329; // pow(trace_generator, (safe_div(keccak_row_ratio, 512)) + (safe_div((safe_mult(23, keccak_row_ratio)), 128))).
    let pow332 = pow193
        * pow331; // pow(trace_generator, (safe_div(keccak_row_ratio, 512)) + (safe_div((safe_mult(23, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow333 = pow220
        * pow331; // pow(trace_generator, (safe_div(keccak_row_ratio, 256)) + (safe_div((safe_mult(23, keccak_row_ratio)), 128))).
    let pow334 = pow193
        * pow333; // pow(trace_generator, (safe_div(keccak_row_ratio, 256)) + (safe_div((safe_mult(23, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow335 = pow224
        * pow333; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 16))).
    let pow336 = pow193
        * pow335; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 16)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow337 = pow220
        * pow335; // pow(trace_generator, (safe_div(keccak_row_ratio, 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 16))).
    let pow338 = pow193
        * pow337; // pow(trace_generator, (safe_div(keccak_row_ratio, 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 16)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow339 = pow220
        * pow337; // pow(trace_generator, (safe_div(keccak_row_ratio, 256)) + (safe_div((safe_mult(3, keccak_row_ratio)), 16))).
    let pow340 = pow193
        * pow339; // pow(trace_generator, (safe_div(keccak_row_ratio, 256)) + (safe_div((safe_mult(3, keccak_row_ratio)), 16)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow341 = pow224
        * pow339; // pow(trace_generator, (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow342 = pow193
        * pow341; // pow(trace_generator, (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow343 = pow191
        * pow341; // pow(trace_generator, (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column2_suboffset, diluted_units_row_ratio))).
    let pow344 = pow192
        * pow341; // pow(trace_generator, (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio))).
    let pow345 = pow210
        * pow341; // pow(trace_generator, (safe_div(keccak_row_ratio, 2048)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow346 = pow219
        * pow345; // pow(trace_generator, (safe_div(keccak_row_ratio, 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow347 = pow191
        * pow346; // pow(trace_generator, (safe_div(keccak_row_ratio, 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column2_suboffset, diluted_units_row_ratio))).
    let pow348 = pow220
        * pow346; // pow(trace_generator, (safe_div(keccak_row_ratio, 256)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow349 = pow191
        * pow348; // pow(trace_generator, (safe_div(keccak_row_ratio, 256)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column2_suboffset, diluted_units_row_ratio))).
    let pow350 = pow220
        * pow348; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow351 = pow193
        * pow350; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow352 = pow220
        * pow350; // pow(trace_generator, (safe_div(keccak_row_ratio, 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow353 = pow220
        * pow352; // pow(trace_generator, (safe_div(keccak_row_ratio, 256)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow354 = pow220
        * pow353; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow355 = pow193
        * pow354; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow356 = pow228
        * pow354; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow357 = pow193
        * pow356; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow358 = pow228
        * pow356; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow359 = pow193
        * pow358; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow360 = pow228
        * pow358; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow361 = pow228
        * pow360; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow362 = pow228
        * pow361; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow363 = pow228
        * pow362; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow364 = pow235 * pow363; // pow(trace_generator, (safe_div(keccak_row_ratio, 4))).
    let pow365 = pow202
        * pow364; // pow(trace_generator, (safe_div(keccak_row_ratio, 4)) + (safe_div(keccak_row_ratio, 4096))).
    let pow366 = pow202
        * pow365; // pow(trace_generator, (safe_div(keccak_row_ratio, 2048)) + (safe_div(keccak_row_ratio, 4))).
    let pow367 = pow227
        * pow366; // pow(trace_generator, (safe_div(keccak_row_ratio, 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow368 = pow219
        * pow367; // pow(trace_generator, (safe_div((safe_mult(15, keccak_row_ratio)), 2048)) + (safe_div(keccak_row_ratio, 4))).
    let pow369 = pow202
        * pow368; // pow(trace_generator, (safe_div((safe_mult(31, keccak_row_ratio)), 4096)) + (safe_div(keccak_row_ratio, 4))).
    let pow370 = pow202
        * pow369; // pow(trace_generator, (safe_div((safe_mult(33, keccak_row_ratio)), 128))).
    let pow371 = pow224
        * pow370; // pow(trace_generator, (safe_div(keccak_row_ratio, 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow372 = pow224
        * pow371; // pow(trace_generator, (safe_div(keccak_row_ratio, 4)) + (safe_div(keccak_row_ratio, 64))).
    let pow373 = pow220
        * pow372; // pow(trace_generator, (safe_div(keccak_row_ratio, 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow374 = pow228
        * pow373; // pow(trace_generator, (safe_div(keccak_row_ratio, 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow375 = pow228
        * pow374; // pow(trace_generator, (safe_div(keccak_row_ratio, 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow376 = pow193
        * pow360; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow377 = pow193
        * pow361; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow378 = pow228
        * pow375; // pow(trace_generator, (safe_div(keccak_row_ratio, 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow379 = pow228
        * pow378; // pow(trace_generator, (safe_div(keccak_row_ratio, 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow380 = pow192
        * pow350; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio))).
    let pow381 = pow192
        * pow352; // pow(trace_generator, (safe_div(keccak_row_ratio, 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio))).
    let pow382 = pow192
        * pow353; // pow(trace_generator, (safe_div(keccak_row_ratio, 256)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio))).
    let pow383 = pow192
        * pow354; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio))).
    let pow384 = pow192
        * pow356; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio))).
    let pow385 = pow192
        * pow358; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio))).
    let pow386 = pow192
        * pow360; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio))).
    let pow387 = pow192
        * pow361; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio))).
    let pow388 = pow192
        * pow362; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio))).
    let pow389 = pow192
        * pow363; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio))).
    let pow390 = pow192
        * pow364; // pow(trace_generator, (safe_div(keccak_row_ratio, 4)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio))).
    let pow391 = pow247
        * pow379; // pow(trace_generator, (safe_div((safe_mult(5, keccak_row_ratio)), 16))).
    let pow392 = pow244
        * pow391; // pow(trace_generator, (safe_div(keccak_row_ratio, 4)) + (safe_div((safe_mult(5, keccak_row_ratio)), 64))).
    let pow393 = pow269
        * pow392; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 8))).
    let pow394 = pow277
        * pow393; // pow(trace_generator, (safe_div((safe_mult(7, keccak_row_ratio)), 16))).
    let pow395 = pow301
        * pow393; // pow(trace_generator, (safe_div(keccak_row_ratio, 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow396 = pow240 * pow395; // pow(trace_generator, (safe_div(keccak_row_ratio, 2))).
    let pow397 = pow220
        * pow396; // pow(trace_generator, (safe_div(keccak_row_ratio, 2)) + (safe_div(keccak_row_ratio, 512))).
    let pow398 = pow220
        * pow397; // pow(trace_generator, (safe_div(keccak_row_ratio, 2)) + (safe_div(keccak_row_ratio, 256))).
    let pow399 = pow239
        * pow398; // pow(trace_generator, (safe_div(keccak_row_ratio, 2)) + (safe_div(keccak_row_ratio, 64))).
    let pow400 = pow269
        * pow399; // pow(trace_generator, (safe_div(keccak_row_ratio, 2)) + (safe_div(keccak_row_ratio, 16))).
    let pow401 = pow240
        * pow400; // pow(trace_generator, (safe_div(keccak_row_ratio, 2)) + (safe_div((safe_mult(39, keccak_row_ratio)), 512))).
    let pow402 = pow193
        * pow401; // pow(trace_generator, (safe_div(keccak_row_ratio, 2)) + (safe_div((safe_mult(39, keccak_row_ratio)), 512)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow403 = pow235
        * pow401; // pow(trace_generator, (safe_div(keccak_row_ratio, 2)) + (safe_div((safe_mult(43, keccak_row_ratio)), 512))).
    let pow404 = pow235
        * pow403; // pow(trace_generator, (safe_div(keccak_row_ratio, 2)) + (safe_div((safe_mult(47, keccak_row_ratio)), 512))).
    let pow405 = pow265
        * pow403; // pow(trace_generator, (safe_div(keccak_row_ratio, 2)) + (safe_div(keccak_row_ratio, 8))).
    let pow406 = pow277
        * pow405; // pow(trace_generator, (safe_div(keccak_row_ratio, 2)) + (safe_div((safe_mult(3, keccak_row_ratio)), 16))).
    let pow407 = pow220
        * pow406; // pow(trace_generator, (safe_div(keccak_row_ratio, 2)) + (safe_div(keccak_row_ratio, 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 16))).
    let pow408 = pow220
        * pow407; // pow(trace_generator, (safe_div(keccak_row_ratio, 2)) + (safe_div(keccak_row_ratio, 256)) + (safe_div((safe_mult(3, keccak_row_ratio)), 16))).
    let pow409 = pow224
        * pow408; // pow(trace_generator, (safe_div(keccak_row_ratio, 2)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow410 = pow273
        * pow409; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 4))).
    let pow411 = pow202
        * pow410; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 4096))).
    let pow412 = pow228
        * pow410; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow413 = pow192
        * pow409; // pow(trace_generator, (safe_div(keccak_row_ratio, 2)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio))).
    let pow414 = pow192
        * pow410; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 4)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio))).
    let pow415 = pow220
        * pow412; // pow(trace_generator, (safe_div((safe_mult(97, keccak_row_ratio)), 128))).
    let pow416 = pow235
        * pow415; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 64))).
    let pow417 = pow264
        * pow416; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 4)) + (safe_div((safe_mult(7, keccak_row_ratio)), 128))).
    let pow418 = pow235
        * pow417; // pow(trace_generator, (safe_div(keccak_row_ratio, 2)) + (safe_div((safe_mult(5, keccak_row_ratio)), 16))).
    let pow419 = pow277
        * pow418; // pow(trace_generator, (safe_div(keccak_row_ratio, 2)) + (safe_div((safe_mult(3, keccak_row_ratio)), 8))).
    let pow420 = pow269
        * pow419; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 4)) + (safe_div((safe_mult(11, keccak_row_ratio)), 64))).
    let pow421 = pow244
        * pow420; // pow(trace_generator, (safe_div(keccak_row_ratio, 2)) + (safe_div((safe_mult(7, keccak_row_ratio)), 16))).
    let pow422 = pow235
        * pow421; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 4)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow423 = pow192
        * pow422; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 4)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio))).
    let pow424 = pow228
        * pow422; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow425 = pow191
        * pow350; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column2_suboffset, diluted_units_row_ratio))).
    let pow426 = pow191
        * pow354; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column2_suboffset, diluted_units_row_ratio))).
    let pow427 = pow191
        * pow356; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column2_suboffset, diluted_units_row_ratio))).
    let pow428 = pow191
        * pow358; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column2_suboffset, diluted_units_row_ratio))).
    let pow429 = pow191
        * pow360; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column2_suboffset, diluted_units_row_ratio))).
    let pow430 = pow191
        * pow361; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column2_suboffset, diluted_units_row_ratio))).
    let pow431 = pow191
        * pow362; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column2_suboffset, diluted_units_row_ratio))).
    let pow432 = pow191
        * pow363; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column2_suboffset, diluted_units_row_ratio))).
    let pow433 = pow191
        * pow364; // pow(trace_generator, (safe_div(keccak_row_ratio, 4)) + (safe_mult(keccak_keccak_diluted_column2_suboffset, diluted_units_row_ratio))).
    let pow434 = pow191
        * pow410; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 4)) + (safe_mult(keccak_keccak_diluted_column2_suboffset, diluted_units_row_ratio))).
    let pow435 = pow191
        * pow395; // pow(trace_generator, (safe_div(keccak_row_ratio, 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column2_suboffset, diluted_units_row_ratio))).
    let pow436 = pow193
        * pow362; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow437 = pow193
        * pow363; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow438 = pow193
        * pow364; // pow(trace_generator, (safe_div(keccak_row_ratio, 4)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow439 = pow193
        * pow370; // pow(trace_generator, (safe_div((safe_mult(33, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow440 = pow193
        * pow372; // pow(trace_generator, (safe_div(keccak_row_ratio, 4)) + (safe_div(keccak_row_ratio, 64)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow441 = pow193
        * pow406; // pow(trace_generator, (safe_div(keccak_row_ratio, 2)) + (safe_div((safe_mult(3, keccak_row_ratio)), 16)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow442 = pow193
        * pow407; // pow(trace_generator, (safe_div(keccak_row_ratio, 2)) + (safe_div(keccak_row_ratio, 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 16)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow443 = pow193
        * pow408; // pow(trace_generator, (safe_div(keccak_row_ratio, 2)) + (safe_div(keccak_row_ratio, 256)) + (safe_div((safe_mult(3, keccak_row_ratio)), 16)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow444 = pow193
        * pow392; // pow(trace_generator, (safe_div(keccak_row_ratio, 4)) + (safe_div((safe_mult(5, keccak_row_ratio)), 64)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow445 = pow193
        * pow403; // pow(trace_generator, (safe_div(keccak_row_ratio, 2)) + (safe_div((safe_mult(43, keccak_row_ratio)), 512)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow446 = pow193
        * pow410; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 4)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow447 = pow193
        * pow424; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow448 = pow193
        * pow404; // pow(trace_generator, (safe_div(keccak_row_ratio, 2)) + (safe_div((safe_mult(47, keccak_row_ratio)), 512)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow449 = pow193
        * pow415; // pow(trace_generator, (safe_div((safe_mult(97, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow450 = pow193
        * pow416; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 64)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow451 = pow193
        * pow417; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 4)) + (safe_div((safe_mult(7, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow452 = pow273 * pow422; // pow(trace_generator, keccak_row_ratio).
    let pow453 = pow396
        * pow452; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 2))).
    let pow454 = pow228
        * pow453; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 2)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow455 = pow228
        * pow454; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 2)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow456 = pow291
        * pow453; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 2)) + (safe_div((safe_mult(11, keccak_row_ratio)), 128))).
    let pow457 = pow193
        * pow456; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 2)) + (safe_div((safe_mult(11, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow458 = pow305
        * pow456; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 2)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow459 = pow193
        * pow458; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 2)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow460 = pow317
        * pow456; // pow(trace_generator, (safe_div((safe_mult(7, keccak_row_ratio)), 4))).
    let pow461 = pow191
        * pow460; // pow(trace_generator, (safe_div((safe_mult(7, keccak_row_ratio)), 4)) + (safe_mult(keccak_keccak_diluted_column2_suboffset, diluted_units_row_ratio))).
    let pow462 = pow192
        * pow460; // pow(trace_generator, (safe_div((safe_mult(7, keccak_row_ratio)), 4)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio))).
    let pow463 = pow193
        * pow460; // pow(trace_generator, (safe_div((safe_mult(7, keccak_row_ratio)), 4)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow464 = pow202
        * pow460; // pow(trace_generator, (safe_div((safe_mult(7, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 4096))).
    let pow465 = pow234
        * pow464; // pow(trace_generator, (safe_div((safe_mult(225, keccak_row_ratio)), 128))).
    let pow466 = pow235
        * pow465; // pow(trace_generator, (safe_div((safe_mult(7, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 64))).
    let pow467 = pow193
        * pow465; // pow(trace_generator, (safe_div((safe_mult(225, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow468 = pow193
        * pow466; // pow(trace_generator, (safe_div((safe_mult(7, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 64)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow469 = pow363 * pow465; // pow(trace_generator, (safe_mult(2, keccak_row_ratio))).
    let pow470 = pow210
        * pow469; // pow(trace_generator, (safe_div(keccak_row_ratio, 2048)) + (safe_mult(2, keccak_row_ratio))).
    let pow471 = pow227
        * pow470; // pow(trace_generator, (safe_mult(2, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow472 = pow228
        * pow471; // pow(trace_generator, (safe_mult(2, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow473 = pow228
        * pow472; // pow(trace_generator, (safe_mult(2, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow474 = pow228
        * pow473; // pow(trace_generator, (safe_mult(2, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 128))).
    let pow475 = pow210
        * pow474; // pow(trace_generator, (safe_div(keccak_row_ratio, 2048)) + (safe_mult(2, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 128))).
    let pow476 = pow227
        * pow475; // pow(trace_generator, (safe_mult(2, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow477 = pow228
        * pow476; // pow(trace_generator, (safe_mult(2, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow478 = pow228
        * pow477; // pow(trace_generator, (safe_mult(2, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow479 = pow228
        * pow478; // pow(trace_generator, (safe_mult(2, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow480 = pow273
        * pow479; // pow(trace_generator, (safe_mult(2, keccak_row_ratio)) + (safe_div((safe_mult(13, keccak_row_ratio)), 128))).
    let pow481 = pow287
        * pow480; // pow(trace_generator, (safe_mult(2, keccak_row_ratio)) + (safe_div((safe_mult(23, keccak_row_ratio)), 128))).
    let pow482 = pow244
        * pow481; // pow(trace_generator, (safe_mult(2, keccak_row_ratio)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow483 = pow191
        * pow482; // pow(trace_generator, (safe_mult(2, keccak_row_ratio)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column2_suboffset, diluted_units_row_ratio))).
    let pow484 = pow193
        * pow480; // pow(trace_generator, (safe_mult(2, keccak_row_ratio)) + (safe_div((safe_mult(13, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow485 = pow269
        * pow482; // pow(trace_generator, (safe_mult(2, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow486 = pow235
        * pow485; // pow(trace_generator, (safe_div((safe_mult(9, keccak_row_ratio)), 4))).
    let pow487 = pow220
        * pow486; // pow(trace_generator, (safe_div((safe_mult(1153, keccak_row_ratio)), 512))).
    let pow488 = pow220
        * pow487; // pow(trace_generator, (safe_div((safe_mult(577, keccak_row_ratio)), 256))).
    let pow489 = pow192
        * pow485; // pow(trace_generator, (safe_mult(2, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio))).
    let pow490 = pow274
        * pow487; // pow(trace_generator, (safe_div((safe_mult(9, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 16))).
    let pow491 = pow220
        * pow490; // pow(trace_generator, (safe_div((safe_mult(1153, keccak_row_ratio)), 512)) + (safe_div(keccak_row_ratio, 16))).
    let pow492 = pow220
        * pow491; // pow(trace_generator, (safe_div((safe_mult(577, keccak_row_ratio)), 256)) + (safe_div(keccak_row_ratio, 16))).
    let pow493 = pow309
        * pow490; // pow(trace_generator, (safe_div((safe_mult(9, keccak_row_ratio)), 4)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow494 = pow191
        * pow493; // pow(trace_generator, (safe_div((safe_mult(9, keccak_row_ratio)), 4)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column2_suboffset, diluted_units_row_ratio))).
    let pow495 = pow220
        * pow493; // pow(trace_generator, (safe_div((safe_mult(1153, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow496 = pow220
        * pow495; // pow(trace_generator, (safe_div((safe_mult(577, keccak_row_ratio)), 256)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow497 = pow270
        * pow495; // pow(trace_generator, (safe_div((safe_mult(5, keccak_row_ratio)), 2))).
    let pow498 = pow191
        * pow495; // pow(trace_generator, (safe_div((safe_mult(1153, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column2_suboffset, diluted_units_row_ratio))).
    let pow499 = pow191
        * pow496; // pow(trace_generator, (safe_div((safe_mult(577, keccak_row_ratio)), 256)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column2_suboffset, diluted_units_row_ratio))).
    let pow500 = pow228
        * pow497; // pow(trace_generator, (safe_div((safe_mult(5, keccak_row_ratio)), 2)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow501 = pow228
        * pow500; // pow(trace_generator, (safe_div((safe_mult(5, keccak_row_ratio)), 2)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow502 = pow228
        * pow501; // pow(trace_generator, (safe_div((safe_mult(5, keccak_row_ratio)), 2)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow503 = pow228
        * pow502; // pow(trace_generator, (safe_div((safe_mult(5, keccak_row_ratio)), 2)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow504 = pow228
        * pow503; // pow(trace_generator, (safe_div((safe_mult(5, keccak_row_ratio)), 2)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow505 = pow299
        * pow503; // pow(trace_generator, (safe_div((safe_mult(5, keccak_row_ratio)), 2)) + (safe_div((safe_mult(17, keccak_row_ratio)), 128))).
    let pow506 = pow193
        * pow505; // pow(trace_generator, (safe_div((safe_mult(5, keccak_row_ratio)), 2)) + (safe_div((safe_mult(17, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow507 = pow292
        * pow505; // pow(trace_generator, (safe_div((safe_mult(5, keccak_row_ratio)), 2)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow508 = pow193
        * pow507; // pow(trace_generator, (safe_div((safe_mult(5, keccak_row_ratio)), 2)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow509 = pow396 * pow497; // pow(trace_generator, (safe_mult(3, keccak_row_ratio))).
    let pow510 = pow396
        * pow509; // pow(trace_generator, (safe_div((safe_mult(7, keccak_row_ratio)), 2))).
    let pow511 = pow228
        * pow510; // pow(trace_generator, (safe_div((safe_mult(7, keccak_row_ratio)), 2)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow512 = pow228
        * pow511; // pow(trace_generator, (safe_div((safe_mult(7, keccak_row_ratio)), 2)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow513 = pow228
        * pow512; // pow(trace_generator, (safe_div((safe_mult(7, keccak_row_ratio)), 2)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow514 = pow228
        * pow513; // pow(trace_generator, (safe_div((safe_mult(7, keccak_row_ratio)), 2)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow515 = pow228
        * pow514; // pow(trace_generator, (safe_div((safe_mult(7, keccak_row_ratio)), 2)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow516 = pow220
        * pow515; // pow(trace_generator, (safe_div((safe_mult(7, keccak_row_ratio)), 2)) + (safe_div(keccak_row_ratio, 32))).
    let pow517 = pow224
        * pow516; // pow(trace_generator, (safe_div((safe_mult(7, keccak_row_ratio)), 2)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow518 = pow341
        * pow517; // pow(trace_generator, (safe_div((safe_mult(7, keccak_row_ratio)), 2)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow519 = pow193
        * pow516; // pow(trace_generator, (safe_div((safe_mult(7, keccak_row_ratio)), 2)) + (safe_div(keccak_row_ratio, 32)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow520 = pow358
        * pow516; // pow(trace_generator, (safe_div((safe_mult(15, keccak_row_ratio)), 4))).
    let pow521 = pow228
        * pow520; // pow(trace_generator, (safe_div((safe_mult(15, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow522 = pow191
        * pow520; // pow(trace_generator, (safe_div((safe_mult(15, keccak_row_ratio)), 4)) + (safe_mult(keccak_keccak_diluted_column2_suboffset, diluted_units_row_ratio))).
    let pow523 = pow192
        * pow520; // pow(trace_generator, (safe_div((safe_mult(15, keccak_row_ratio)), 4)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio))).
    let pow524 = pow193
        * pow520; // pow(trace_generator, (safe_div((safe_mult(15, keccak_row_ratio)), 4)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow525 = pow202
        * pow520; // pow(trace_generator, (safe_div((safe_mult(15, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 4096))).
    let pow526 = pow220
        * pow521; // pow(trace_generator, (safe_div((safe_mult(481, keccak_row_ratio)), 128))).
    let pow527 = pow224
        * pow526; // pow(trace_generator, (safe_div((safe_mult(15, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow528 = pow224
        * pow527; // pow(trace_generator, (safe_div((safe_mult(15, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 64))).
    let pow529 = pow220
        * pow528; // pow(trace_generator, (safe_div((safe_mult(15, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow530 = pow228
        * pow529; // pow(trace_generator, (safe_div((safe_mult(15, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow531 = pow193
        * pow526; // pow(trace_generator, (safe_div((safe_mult(481, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow532 = pow193
        * pow528; // pow(trace_generator, (safe_div((safe_mult(15, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 64)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow533 = pow228
        * pow530; // pow(trace_generator, (safe_div((safe_mult(15, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow534 = pow228
        * pow533; // pow(trace_generator, (safe_div((safe_mult(15, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow535 = pow341
        * pow534; // pow(trace_generator, (safe_div((safe_mult(15, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow536 = pow193
        * pow535; // pow(trace_generator, (safe_div((safe_mult(15, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow537 = pow301
        * pow533; // pow(trace_generator, (safe_div((safe_mult(15, keccak_row_ratio)), 4)) + (safe_div((safe_mult(9, keccak_row_ratio)), 64))).
    let pow538 = pow193
        * pow537; // pow(trace_generator, (safe_div((safe_mult(15, keccak_row_ratio)), 4)) + (safe_div((safe_mult(9, keccak_row_ratio)), 64)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow539 = pow299 * pow537; // pow(trace_generator, (safe_mult(4, keccak_row_ratio))).
    let pow540 = pow396
        * pow539; // pow(trace_generator, (safe_div((safe_mult(9, keccak_row_ratio)), 2))).
    let pow541 = pow228
        * pow540; // pow(trace_generator, (safe_div((safe_mult(9, keccak_row_ratio)), 2)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow542 = pow228
        * pow541; // pow(trace_generator, (safe_div((safe_mult(9, keccak_row_ratio)), 2)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow543 = pow228
        * pow542; // pow(trace_generator, (safe_div((safe_mult(9, keccak_row_ratio)), 2)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow544 = pow228
        * pow543; // pow(trace_generator, (safe_div((safe_mult(9, keccak_row_ratio)), 2)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow545 = pow228
        * pow544; // pow(trace_generator, (safe_div((safe_mult(9, keccak_row_ratio)), 2)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow546 = pow228
        * pow545; // pow(trace_generator, (safe_div((safe_mult(9, keccak_row_ratio)), 2)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow547 = pow228
        * pow546; // pow(trace_generator, (safe_div((safe_mult(9, keccak_row_ratio)), 2)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow548 = pow210
        * pow539; // pow(trace_generator, (safe_div(keccak_row_ratio, 2048)) + (safe_mult(4, keccak_row_ratio))).
    let pow549 = pow269
        * pow539; // pow(trace_generator, (safe_mult(4, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 64))).
    let pow550 = pow210
        * pow549; // pow(trace_generator, (safe_div(keccak_row_ratio, 2048)) + (safe_mult(4, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 64))).
    let pow551 = pow228
        * pow547; // pow(trace_generator, (safe_div((safe_mult(9, keccak_row_ratio)), 2)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow552 = pow277
        * pow551; // pow(trace_generator, (safe_div((safe_mult(9, keccak_row_ratio)), 2)) + (safe_div((safe_mult(7, keccak_row_ratio)), 64))).
    let pow553 = pow193
        * pow552; // pow(trace_generator, (safe_div((safe_mult(9, keccak_row_ratio)), 2)) + (safe_div((safe_mult(7, keccak_row_ratio)), 64)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow554 = pow309
        * pow552; // pow(trace_generator, (safe_div((safe_mult(9, keccak_row_ratio)), 2)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow555 = pow191
        * pow554; // pow(trace_generator, (safe_div((safe_mult(9, keccak_row_ratio)), 2)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column2_suboffset, diluted_units_row_ratio))).
    let pow556 = pow235
        * pow554; // pow(trace_generator, (safe_div((safe_mult(19, keccak_row_ratio)), 4))).
    let pow557 = pow307
        * pow556; // pow(trace_generator, (safe_div((safe_mult(19, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 8))).
    let pow558 = pow283
        * pow557; // pow(trace_generator, (safe_div((safe_mult(19, keccak_row_ratio)), 4)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow559 = pow273 * pow558; // pow(trace_generator, (safe_mult(5, keccak_row_ratio))).
    let pow560 = pow228
        * pow559; // pow(trace_generator, (safe_mult(5, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow561 = pow228
        * pow560; // pow(trace_generator, (safe_mult(5, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow562 = pow228
        * pow561; // pow(trace_generator, (safe_mult(5, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow563 = pow228
        * pow562; // pow(trace_generator, (safe_mult(5, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow564 = pow228
        * pow563; // pow(trace_generator, (safe_mult(5, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow565 = pow228
        * pow564; // pow(trace_generator, (safe_mult(5, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow566 = pow239
        * pow565; // pow(trace_generator, (safe_mult(5, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 64))).
    let pow567 = pow193
        * pow566; // pow(trace_generator, (safe_mult(5, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 64)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow568 = pow313
        * pow566; // pow(trace_generator, (safe_mult(5, keccak_row_ratio)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow569 = pow260
        * pow568; // pow(trace_generator, (safe_mult(5, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow570 = pow191
        * pow569; // pow(trace_generator, (safe_mult(5, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column2_suboffset, diluted_units_row_ratio))).
    let pow571 = pow273
        * pow568; // pow(trace_generator, (safe_div((safe_mult(21, keccak_row_ratio)), 4))).
    let pow572 = pow396
        * pow571; // pow(trace_generator, (safe_div((safe_mult(23, keccak_row_ratio)), 4))).
    let pow573 = pow220
        * pow572; // pow(trace_generator, (safe_div((safe_mult(2945, keccak_row_ratio)), 512))).
    let pow574 = pow220
        * pow573; // pow(trace_generator, (safe_div((safe_mult(1473, keccak_row_ratio)), 256))).
    let pow575 = pow220
        * pow574; // pow(trace_generator, (safe_div((safe_mult(23, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow576 = pow249
        * pow571; // pow(trace_generator, (safe_div((safe_mult(21, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 128))).
    let pow577 = pow283
        * pow576; // pow(trace_generator, (safe_div((safe_mult(21, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 32))).
    let pow578 = pow297
        * pow577; // pow(trace_generator, (safe_div((safe_mult(21, keccak_row_ratio)), 4)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow579 = pow220
        * pow575; // pow(trace_generator, (safe_div((safe_mult(2945, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow580 = pow220
        * pow579; // pow(trace_generator, (safe_div((safe_mult(1473, keccak_row_ratio)), 256)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow581 = pow299
        * pow579; // pow(trace_generator, (safe_div((safe_mult(23, keccak_row_ratio)), 4)) + (safe_div((safe_mult(15, keccak_row_ratio)), 128))).
    let pow582 = pow220
        * pow581; // pow(trace_generator, (safe_div((safe_mult(2945, keccak_row_ratio)), 512)) + (safe_div((safe_mult(15, keccak_row_ratio)), 128))).
    let pow583 = pow220
        * pow582; // pow(trace_generator, (safe_div((safe_mult(1473, keccak_row_ratio)), 256)) + (safe_div((safe_mult(15, keccak_row_ratio)), 128))).
    let pow584 = pow288
        * pow581; // pow(trace_generator, (safe_div((safe_mult(23, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow585 = pow192
        * pow584; // pow(trace_generator, (safe_div((safe_mult(23, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio))).
    let pow586 = pow220
        * pow584; // pow(trace_generator, (safe_div((safe_mult(2945, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow587 = pow192
        * pow586; // pow(trace_generator, (safe_div((safe_mult(2945, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio))).
    let pow588 = pow220
        * pow586; // pow(trace_generator, (safe_div((safe_mult(1473, keccak_row_ratio)), 256)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow589 = pow192
        * pow588; // pow(trace_generator, (safe_div((safe_mult(1473, keccak_row_ratio)), 256)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio))).
    let pow590 = pow193
        * pow576; // pow(trace_generator, (safe_div((safe_mult(21, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow591 = pow193
        * pow578; // pow(trace_generator, (safe_div((safe_mult(21, keccak_row_ratio)), 4)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow592 = pow192
        * pow578; // pow(trace_generator, (safe_div((safe_mult(21, keccak_row_ratio)), 4)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio))).
    let pow593 = pow266 * pow588; // pow(trace_generator, (safe_mult(6, keccak_row_ratio))).
    let pow594 = pow283
        * pow593; // pow(trace_generator, (safe_mult(6, keccak_row_ratio)) + (safe_div((safe_mult(9, keccak_row_ratio)), 128))).
    let pow595 = pow329
        * pow594; // pow(trace_generator, (safe_div((safe_mult(25, keccak_row_ratio)), 4))).
    let pow596 = pow220
        * pow595; // pow(trace_generator, (safe_div((safe_mult(3201, keccak_row_ratio)), 512))).
    let pow597 = pow220
        * pow596; // pow(trace_generator, (safe_div((safe_mult(1601, keccak_row_ratio)), 256))).
    let pow598 = pow220
        * pow597; // pow(trace_generator, (safe_div((safe_mult(25, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow599 = pow210
        * pow593; // pow(trace_generator, (safe_div(keccak_row_ratio, 2048)) + (safe_mult(6, keccak_row_ratio))).
    let pow600 = pow220
        * pow598; // pow(trace_generator, (safe_div((safe_mult(3201, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow601 = pow220
        * pow600; // pow(trace_generator, (safe_div((safe_mult(1601, keccak_row_ratio)), 256)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow602 = pow220
        * pow601; // pow(trace_generator, (safe_div((safe_mult(25, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow603 = pow228
        * pow602; // pow(trace_generator, (safe_div((safe_mult(25, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow604 = pow228
        * pow603; // pow(trace_generator, (safe_div((safe_mult(25, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow605 = pow228
        * pow604; // pow(trace_generator, (safe_div((safe_mult(25, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow606 = pow228
        * pow605; // pow(trace_generator, (safe_div((safe_mult(25, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow607 = pow228
        * pow606; // pow(trace_generator, (safe_div((safe_mult(25, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow608 = pow228
        * pow607; // pow(trace_generator, (safe_div((safe_mult(25, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow609 = pow269
        * pow608; // pow(trace_generator, (safe_div((safe_mult(25, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 32))).
    let pow610 = pow244
        * pow609; // pow(trace_generator, (safe_div((safe_mult(25, keccak_row_ratio)), 4)) + (safe_div((safe_mult(7, keccak_row_ratio)), 64))).
    let pow611 = pow220
        * pow610; // pow(trace_generator, (safe_div((safe_mult(3201, keccak_row_ratio)), 512)) + (safe_div((safe_mult(7, keccak_row_ratio)), 64))).
    let pow612 = pow220
        * pow611; // pow(trace_generator, (safe_div((safe_mult(1601, keccak_row_ratio)), 256)) + (safe_div((safe_mult(7, keccak_row_ratio)), 64))).
    let pow613 = pow292
        * pow610; // pow(trace_generator, (safe_div((safe_mult(25, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow614 = pow220
        * pow613; // pow(trace_generator, (safe_div((safe_mult(3201, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow615 = pow220
        * pow614; // pow(trace_generator, (safe_div((safe_mult(1601, keccak_row_ratio)), 256)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow616 = pow262
        * pow615; // pow(trace_generator, (safe_div((safe_mult(25, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow617 = pow370
        * pow616; // pow(trace_generator, (safe_div((safe_mult(27, keccak_row_ratio)), 4))).
    let pow618 = pow228
        * pow617; // pow(trace_generator, (safe_div((safe_mult(27, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow619 = pow301
        * pow618; // pow(trace_generator, (safe_div((safe_mult(27, keccak_row_ratio)), 4)) + (safe_div((safe_mult(15, keccak_row_ratio)), 128))).
    let pow620 = pow193
        * pow619; // pow(trace_generator, (safe_div((safe_mult(27, keccak_row_ratio)), 4)) + (safe_div((safe_mult(15, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow621 = pow228
        * pow618; // pow(trace_generator, (safe_div((safe_mult(27, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow622 = pow228
        * pow621; // pow(trace_generator, (safe_div((safe_mult(27, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow623 = pow341
        * pow622; // pow(trace_generator, (safe_div((safe_mult(27, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow624 = pow262 * pow623; // pow(trace_generator, (safe_mult(7, keccak_row_ratio))).
    let pow625 = pow228
        * pow624; // pow(trace_generator, (safe_mult(7, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow626 = pow228
        * pow625; // pow(trace_generator, (safe_mult(7, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow627 = pow410
        * pow624; // pow(trace_generator, (safe_div((safe_mult(31, keccak_row_ratio)), 4))).
    let pow628 = pow191
        * pow627; // pow(trace_generator, (safe_div((safe_mult(31, keccak_row_ratio)), 4)) + (safe_mult(keccak_keccak_diluted_column2_suboffset, diluted_units_row_ratio))).
    let pow629 = pow192
        * pow627; // pow(trace_generator, (safe_div((safe_mult(31, keccak_row_ratio)), 4)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio))).
    let pow630 = pow193
        * pow627; // pow(trace_generator, (safe_div((safe_mult(31, keccak_row_ratio)), 4)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow631 = pow202
        * pow627; // pow(trace_generator, (safe_div((safe_mult(31, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 4096))).
    let pow632 = pow234
        * pow631; // pow(trace_generator, (safe_div((safe_mult(993, keccak_row_ratio)), 128))).
    let pow633 = pow235
        * pow632; // pow(trace_generator, (safe_div((safe_mult(31, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 64))).
    let pow634 = pow193
        * pow632; // pow(trace_generator, (safe_div((safe_mult(993, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow635 = pow193
        * pow633; // pow(trace_generator, (safe_div((safe_mult(31, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 64)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow636 = pow363 * pow632; // pow(trace_generator, (safe_mult(8, keccak_row_ratio))).
    let pow637 = pow295
        * pow636; // pow(trace_generator, (safe_mult(8, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 32))).
    let pow638 = pow452 * pow636; // pow(trace_generator, (safe_mult(9, keccak_row_ratio))).
    let pow639 = pow228
        * pow638; // pow(trace_generator, (safe_mult(9, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow640 = pow228
        * pow639; // pow(trace_generator, (safe_mult(9, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow641 = pow193
        * pow623; // pow(trace_generator, (safe_div((safe_mult(27, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow642 = pow228
        * pow626; // pow(trace_generator, (safe_mult(7, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow643 = pow228
        * pow640; // pow(trace_generator, (safe_mult(9, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow644 = pow228
        * pow642; // pow(trace_generator, (safe_mult(7, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow645 = pow228
        * pow643; // pow(trace_generator, (safe_mult(9, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 128))).
    let pow646 = pow297
        * pow645; // pow(trace_generator, (safe_mult(9, keccak_row_ratio)) + (safe_div(keccak_row_ratio, 8))).
    let pow647 = pow193
        * pow646; // pow(trace_generator, (safe_mult(9, keccak_row_ratio)) + (safe_div(keccak_row_ratio, 8)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow648 = pow283
        * pow646; // pow(trace_generator, (safe_mult(9, keccak_row_ratio)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow649 = pow191
        * pow648; // pow(trace_generator, (safe_mult(9, keccak_row_ratio)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column2_suboffset, diluted_units_row_ratio))).
    let pow650 = pow228
        * pow644; // pow(trace_generator, (safe_mult(7, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow651 = pow228
        * pow650; // pow(trace_generator, (safe_mult(7, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow652 = pow319
        * pow651; // pow(trace_generator, (safe_mult(7, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow653 = pow192
        * pow652; // pow(trace_generator, (safe_mult(7, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio))).
    let pow654 = pow224
        * pow651; // pow(trace_generator, (safe_mult(7, keccak_row_ratio)) + (safe_div((safe_mult(5, keccak_row_ratio)), 128))).
    let pow655 = pow249
        * pow648; // pow(trace_generator, (safe_mult(9, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow656 = pow256
        * pow655; // pow(trace_generator, (safe_div((safe_mult(37, keccak_row_ratio)), 4))).
    let pow657 = pow228
        * pow656; // pow(trace_generator, (safe_div((safe_mult(37, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow658 = pow341
        * pow657; // pow(trace_generator, (safe_div((safe_mult(37, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow659 = pow256
        * pow656; // pow(trace_generator, (safe_div((safe_mult(37, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 32))).
    let pow660 = pow254
        * pow652; // pow(trace_generator, (safe_mult(7, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow661 = pow192
        * pow660; // pow(trace_generator, (safe_mult(7, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio))).
    let pow662 = pow193
        * pow609; // pow(trace_generator, (safe_div((safe_mult(25, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 32)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow663 = pow193
        * pow654; // pow(trace_generator, (safe_mult(7, keccak_row_ratio)) + (safe_div((safe_mult(5, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow664 = pow193
        * pow655; // pow(trace_generator, (safe_mult(9, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow665 = pow210
        * pow594; // pow(trace_generator, (safe_div(keccak_row_ratio, 2048)) + (safe_mult(6, keccak_row_ratio)) + (safe_div((safe_mult(9, keccak_row_ratio)), 128))).
    let pow666 = pow210
        * pow636; // pow(trace_generator, (safe_div(keccak_row_ratio, 2048)) + (safe_mult(8, keccak_row_ratio))).
    let pow667 = pow210
        * pow637; // pow(trace_generator, (safe_div(keccak_row_ratio, 2048)) + (safe_mult(8, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 32))).
    let pow668 = pow396
        * pow656; // pow(trace_generator, (safe_div((safe_mult(39, keccak_row_ratio)), 4))).
    let pow669 = pow220
        * pow668; // pow(trace_generator, (safe_div((safe_mult(39, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 512))).
    let pow670 = pow220
        * pow669; // pow(trace_generator, (safe_div((safe_mult(39, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 256))).
    let pow671 = pow254
        * pow668; // pow(trace_generator, (safe_div((safe_mult(39, keccak_row_ratio)), 4)) + (safe_div((safe_mult(15, keccak_row_ratio)), 512))).
    let pow672 = pow235
        * pow671; // pow(trace_generator, (safe_div((safe_mult(39, keccak_row_ratio)), 4)) + (safe_div((safe_mult(19, keccak_row_ratio)), 512))).
    let pow673 = pow235
        * pow672; // pow(trace_generator, (safe_div((safe_mult(39, keccak_row_ratio)), 4)) + (safe_div((safe_mult(23, keccak_row_ratio)), 512))).
    let pow674 = pow279
        * pow672; // pow(trace_generator, (safe_div((safe_mult(39, keccak_row_ratio)), 4)) + (safe_div((safe_mult(13, keccak_row_ratio)), 128))).
    let pow675 = pow283
        * pow674; // pow(trace_generator, (safe_div((safe_mult(39, keccak_row_ratio)), 4)) + (safe_div((safe_mult(11, keccak_row_ratio)), 64))).
    let pow676 = pow220
        * pow675; // pow(trace_generator, (safe_div((safe_mult(39, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 512)) + (safe_div((safe_mult(11, keccak_row_ratio)), 64))).
    let pow677 = pow220
        * pow676; // pow(trace_generator, (safe_div((safe_mult(39, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 256)) + (safe_div((safe_mult(11, keccak_row_ratio)), 64))).
    let pow678 = pow247
        * pow676; // pow(trace_generator, (safe_div((safe_mult(39, keccak_row_ratio)), 4)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow679 = pow273 * pow678; // pow(trace_generator, (safe_mult(10, keccak_row_ratio))).
    let pow680 = pow303
        * pow679; // pow(trace_generator, (safe_mult(10, keccak_row_ratio)) + (safe_div((safe_mult(15, keccak_row_ratio)), 128))).
    let pow681 = pow309
        * pow680; // pow(trace_generator, (safe_div((safe_mult(41, keccak_row_ratio)), 4))).
    let pow682 = pow220
        * pow681; // pow(trace_generator, (safe_div((safe_mult(41, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 512))).
    let pow683 = pow220
        * pow682; // pow(trace_generator, (safe_div((safe_mult(41, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 256))).
    let pow684 = pow270
        * pow681; // pow(trace_generator, (safe_div((safe_mult(41, keccak_row_ratio)), 4)) + (safe_div((safe_mult(27, keccak_row_ratio)), 512))).
    let pow685 = pow235
        * pow684; // pow(trace_generator, (safe_div((safe_mult(41, keccak_row_ratio)), 4)) + (safe_div((safe_mult(31, keccak_row_ratio)), 512))).
    let pow686 = pow235
        * pow685; // pow(trace_generator, (safe_div((safe_mult(41, keccak_row_ratio)), 4)) + (safe_div((safe_mult(35, keccak_row_ratio)), 512))).
    let pow687 = pow301
        * pow686; // pow(trace_generator, (safe_div((safe_mult(41, keccak_row_ratio)), 4)) + (safe_div((safe_mult(23, keccak_row_ratio)), 128))).
    let pow688 = pow220
        * pow687; // pow(trace_generator, (safe_div((safe_mult(41, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 512)) + (safe_div((safe_mult(23, keccak_row_ratio)), 128))).
    let pow689 = pow220
        * pow688; // pow(trace_generator, (safe_div((safe_mult(41, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 256)) + (safe_div((safe_mult(23, keccak_row_ratio)), 128))).
    let pow690 = pow396
        * pow681; // pow(trace_generator, (safe_div((safe_mult(43, keccak_row_ratio)), 4))).
    let pow691 = pow228
        * pow690; // pow(trace_generator, (safe_div((safe_mult(43, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow692 = pow228
        * pow691; // pow(trace_generator, (safe_div((safe_mult(43, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow693 = pow224
        * pow692; // pow(trace_generator, (safe_div((safe_mult(43, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 64))).
    let pow694 = pow193
        * pow693; // pow(trace_generator, (safe_div((safe_mult(43, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 64)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow695 = pow220
        * pow693; // pow(trace_generator, (safe_div((safe_mult(43, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow696 = pow228
        * pow695; // pow(trace_generator, (safe_div((safe_mult(43, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow697 = pow228
        * pow696; // pow(trace_generator, (safe_div((safe_mult(43, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow698 = pow301
        * pow697; // pow(trace_generator, (safe_div((safe_mult(43, keccak_row_ratio)), 4)) + (safe_div((safe_mult(9, keccak_row_ratio)), 64))).
    let pow699 = pow273
        * pow698; // pow(trace_generator, (safe_div((safe_mult(43, keccak_row_ratio)), 4)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow700 = pow254
        * pow699; // pow(trace_generator, (safe_div((safe_mult(43, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow701 = pow273 * pow699; // pow(trace_generator, (safe_mult(11, keccak_row_ratio))).
    let pow702 = pow228
        * pow701; // pow(trace_generator, (safe_mult(11, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow703 = pow220
        * pow702; // pow(trace_generator, (safe_mult(11, keccak_row_ratio)) + (safe_div(keccak_row_ratio, 128))).
    let pow704 = pow224
        * pow703; // pow(trace_generator, (safe_mult(11, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow705 = pow228
        * pow704; // pow(trace_generator, (safe_mult(11, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow706 = pow228
        * pow705; // pow(trace_generator, (safe_mult(11, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow707 = pow228
        * pow706; // pow(trace_generator, (safe_mult(11, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow708 = pow323
        * pow707; // pow(trace_generator, (safe_mult(11, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow709 = pow265
        * pow707; // pow(trace_generator, (safe_mult(11, keccak_row_ratio)) + (safe_div((safe_mult(9, keccak_row_ratio)), 128))).
    let pow710 = pow249
        * pow708; // pow(trace_generator, (safe_mult(11, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow711 = pow192
        * pow710; // pow(trace_generator, (safe_mult(11, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio))).
    let pow712 = pow193
        * pow671; // pow(trace_generator, (safe_div((safe_mult(39, keccak_row_ratio)), 4)) + (safe_div((safe_mult(15, keccak_row_ratio)), 512)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow713 = pow193
        * pow672; // pow(trace_generator, (safe_div((safe_mult(39, keccak_row_ratio)), 4)) + (safe_div((safe_mult(19, keccak_row_ratio)), 512)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow714 = pow193
        * pow673; // pow(trace_generator, (safe_div((safe_mult(39, keccak_row_ratio)), 4)) + (safe_div((safe_mult(23, keccak_row_ratio)), 512)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow715 = pow193
        * pow684; // pow(trace_generator, (safe_div((safe_mult(41, keccak_row_ratio)), 4)) + (safe_div((safe_mult(27, keccak_row_ratio)), 512)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow716 = pow193
        * pow685; // pow(trace_generator, (safe_div((safe_mult(41, keccak_row_ratio)), 4)) + (safe_div((safe_mult(31, keccak_row_ratio)), 512)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow717 = pow193
        * pow686; // pow(trace_generator, (safe_div((safe_mult(41, keccak_row_ratio)), 4)) + (safe_div((safe_mult(35, keccak_row_ratio)), 512)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow718 = pow210
        * pow679; // pow(trace_generator, (safe_div(keccak_row_ratio, 2048)) + (safe_mult(10, keccak_row_ratio))).
    let pow719 = pow210
        * pow680; // pow(trace_generator, (safe_div(keccak_row_ratio, 2048)) + (safe_mult(10, keccak_row_ratio)) + (safe_div((safe_mult(15, keccak_row_ratio)), 128))).
    let pow720 = pow193
        * pow675; // pow(trace_generator, (safe_div((safe_mult(39, keccak_row_ratio)), 4)) + (safe_div((safe_mult(11, keccak_row_ratio)), 64)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow721 = pow193
        * pow676; // pow(trace_generator, (safe_div((safe_mult(39, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 512)) + (safe_div((safe_mult(11, keccak_row_ratio)), 64)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow722 = pow193
        * pow677; // pow(trace_generator, (safe_div((safe_mult(39, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 256)) + (safe_div((safe_mult(11, keccak_row_ratio)), 64)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow723 = pow193
        * pow687; // pow(trace_generator, (safe_div((safe_mult(41, keccak_row_ratio)), 4)) + (safe_div((safe_mult(23, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow724 = pow193
        * pow688; // pow(trace_generator, (safe_div((safe_mult(41, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 512)) + (safe_div((safe_mult(23, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow725 = pow193
        * pow703; // pow(trace_generator, (safe_mult(11, keccak_row_ratio)) + (safe_div(keccak_row_ratio, 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow726 = pow193
        * pow689; // pow(trace_generator, (safe_div((safe_mult(41, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 256)) + (safe_div((safe_mult(23, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow727 = pow191
        * pow678; // pow(trace_generator, (safe_div((safe_mult(39, keccak_row_ratio)), 4)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column2_suboffset, diluted_units_row_ratio))).
    let pow728 = pow191
        * pow699; // pow(trace_generator, (safe_div((safe_mult(43, keccak_row_ratio)), 4)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column2_suboffset, diluted_units_row_ratio))).
    let pow729 = pow191
        * pow700; // pow(trace_generator, (safe_div((safe_mult(43, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column2_suboffset, diluted_units_row_ratio))).
    let pow730 = pow329
        * pow709; // pow(trace_generator, (safe_div((safe_mult(45, keccak_row_ratio)), 4))).
    let pow731 = pow228
        * pow730; // pow(trace_generator, (safe_div((safe_mult(45, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow732 = pow228
        * pow731; // pow(trace_generator, (safe_div((safe_mult(45, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow733 = pow228
        * pow732; // pow(trace_generator, (safe_div((safe_mult(45, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow734 = pow228
        * pow733; // pow(trace_generator, (safe_div((safe_mult(45, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow735 = pow228
        * pow734; // pow(trace_generator, (safe_div((safe_mult(45, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow736 = pow228
        * pow735; // pow(trace_generator, (safe_div((safe_mult(45, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow737 = pow228
        * pow736; // pow(trace_generator, (safe_div((safe_mult(45, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow738 = pow247
        * pow737; // pow(trace_generator, (safe_div((safe_mult(45, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 16))).
    let pow739 = pow193
        * pow738; // pow(trace_generator, (safe_div((safe_mult(45, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 16)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow740 = pow325
        * pow738; // pow(trace_generator, (safe_div((safe_mult(45, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow741 = pow240
        * pow740; // pow(trace_generator, (safe_div((safe_mult(23, keccak_row_ratio)), 2))).
    let pow742 = pow315
        * pow741; // pow(trace_generator, (safe_div((safe_mult(23, keccak_row_ratio)), 2)) + (safe_div((safe_mult(5, keccak_row_ratio)), 32))).
    let pow743 = pow228
        * pow741; // pow(trace_generator, (safe_div((safe_mult(23, keccak_row_ratio)), 2)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow744 = pow266
        * pow742; // pow(trace_generator, (safe_div((safe_mult(23, keccak_row_ratio)), 2)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow745 = pow192
        * pow744; // pow(trace_generator, (safe_div((safe_mult(23, keccak_row_ratio)), 2)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio))).
    let pow746 = pow396 * pow741; // pow(trace_generator, (safe_mult(12, keccak_row_ratio))).
    let pow747 = pow311
        * pow746; // pow(trace_generator, (safe_mult(12, keccak_row_ratio)) + (safe_div((safe_mult(9, keccak_row_ratio)), 64))).
    let pow748 = pow299
        * pow747; // pow(trace_generator, (safe_div((safe_mult(49, keccak_row_ratio)), 4))).
    let pow749 = pow309
        * pow748; // pow(trace_generator, (safe_div((safe_mult(49, keccak_row_ratio)), 4)) + (safe_div((safe_mult(17, keccak_row_ratio)), 128))).
    let pow750 = pow277
        * pow749; // pow(trace_generator, (safe_div((safe_mult(49, keccak_row_ratio)), 4)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow751 = pow192
        * pow750; // pow(trace_generator, (safe_div((safe_mult(49, keccak_row_ratio)), 4)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio))).
    let pow752 = pow210
        * pow746; // pow(trace_generator, (safe_div(keccak_row_ratio, 2048)) + (safe_mult(12, keccak_row_ratio))).
    let pow753 = pow210
        * pow747; // pow(trace_generator, (safe_div(keccak_row_ratio, 2048)) + (safe_mult(12, keccak_row_ratio)) + (safe_div((safe_mult(9, keccak_row_ratio)), 64))).
    let pow754 = pow273
        * pow750; // pow(trace_generator, (safe_div((safe_mult(25, keccak_row_ratio)), 2))).
    let pow755 = pow228
        * pow754; // pow(trace_generator, (safe_div((safe_mult(25, keccak_row_ratio)), 2)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow756 = pow331
        * pow755; // pow(trace_generator, (safe_div((safe_mult(25, keccak_row_ratio)), 2)) + (safe_div((safe_mult(3, keccak_row_ratio)), 16))).
    let pow757 = pow391 * pow756; // pow(trace_generator, (safe_mult(13, keccak_row_ratio))).
    let pow758 = pow396
        * pow757; // pow(trace_generator, (safe_div((safe_mult(27, keccak_row_ratio)), 2))).
    let pow759 = pow291
        * pow758; // pow(trace_generator, (safe_div((safe_mult(27, keccak_row_ratio)), 2)) + (safe_div((safe_mult(11, keccak_row_ratio)), 128))).
    let pow760 = pow299
        * pow759; // pow(trace_generator, (safe_div((safe_mult(27, keccak_row_ratio)), 2)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow761 = pow273
        * pow760; // pow(trace_generator, (safe_div((safe_mult(55, keccak_row_ratio)), 4))).
    let pow762 = pow220
        * pow761; // pow(trace_generator, (safe_div((safe_mult(55, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 512))).
    let pow763 = pow220
        * pow762; // pow(trace_generator, (safe_div((safe_mult(55, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 256))).
    let pow764 = pow220
        * pow763; // pow(trace_generator, (safe_div((safe_mult(55, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow765 = pow193
        * pow764; // pow(trace_generator, (safe_div((safe_mult(55, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow766 = pow235
        * pow764; // pow(trace_generator, (safe_div((safe_mult(55, keccak_row_ratio)), 4)) + (safe_div((safe_mult(7, keccak_row_ratio)), 512))).
    let pow767 = pow193
        * pow766; // pow(trace_generator, (safe_div((safe_mult(55, keccak_row_ratio)), 4)) + (safe_div((safe_mult(7, keccak_row_ratio)), 512)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow768 = pow235
        * pow766; // pow(trace_generator, (safe_div((safe_mult(55, keccak_row_ratio)), 4)) + (safe_div((safe_mult(11, keccak_row_ratio)), 512))).
    let pow769 = pow193
        * pow768; // pow(trace_generator, (safe_div((safe_mult(55, keccak_row_ratio)), 4)) + (safe_div((safe_mult(11, keccak_row_ratio)), 512)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow770 = pow317
        * pow761; // pow(trace_generator, (safe_div((safe_mult(55, keccak_row_ratio)), 4)) + (safe_div((safe_mult(21, keccak_row_ratio)), 128))).
    let pow771 = pow193
        * pow770; // pow(trace_generator, (safe_div((safe_mult(55, keccak_row_ratio)), 4)) + (safe_div((safe_mult(21, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow772 = pow220
        * pow770; // pow(trace_generator, (safe_div((safe_mult(55, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 512)) + (safe_div((safe_mult(21, keccak_row_ratio)), 128))).
    let pow773 = pow193
        * pow772; // pow(trace_generator, (safe_div((safe_mult(55, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 512)) + (safe_div((safe_mult(21, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow774 = pow220
        * pow772; // pow(trace_generator, (safe_div((safe_mult(55, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 256)) + (safe_div((safe_mult(21, keccak_row_ratio)), 128))).
    let pow775 = pow193
        * pow774; // pow(trace_generator, (safe_div((safe_mult(55, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 256)) + (safe_div((safe_mult(21, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow776 = pow288 * pow772; // pow(trace_generator, (safe_mult(14, keccak_row_ratio))).
    let pow777 = pow396
        * pow776; // pow(trace_generator, (safe_div((safe_mult(29, keccak_row_ratio)), 2))).
    let pow778 = pow273
        * pow777; // pow(trace_generator, (safe_div((safe_mult(29, keccak_row_ratio)), 2)) + (safe_div((safe_mult(7, keccak_row_ratio)), 128))).
    let pow779 = pow396 * pow777; // pow(trace_generator, (safe_mult(15, keccak_row_ratio))).
    let pow780 = pow364
        * pow779; // pow(trace_generator, (safe_div((safe_mult(61, keccak_row_ratio)), 4))).
    let pow781 = pow228
        * pow780; // pow(trace_generator, (safe_div((safe_mult(61, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow782 = pow228
        * pow781; // pow(trace_generator, (safe_div((safe_mult(61, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow783 = pow228
        * pow782; // pow(trace_generator, (safe_div((safe_mult(61, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow784 = pow228
        * pow783; // pow(trace_generator, (safe_div((safe_mult(61, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow785 = pow210
        * pow776; // pow(trace_generator, (safe_div(keccak_row_ratio, 2048)) + (safe_mult(14, keccak_row_ratio))).
    let pow786 = pow240
        * pow756; // pow(trace_generator, (safe_div((safe_mult(25, keccak_row_ratio)), 2)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow787 = pow227
        * pow785; // pow(trace_generator, (safe_mult(14, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow788 = pow228
        * pow787; // pow(trace_generator, (safe_mult(14, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow789 = pow228
        * pow788; // pow(trace_generator, (safe_mult(14, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow790 = pow311
        * pow778; // pow(trace_generator, (safe_div((safe_mult(29, keccak_row_ratio)), 2)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow791 = pow228
        * pow784; // pow(trace_generator, (safe_div((safe_mult(61, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow792 = pow228
        * pow791; // pow(trace_generator, (safe_div((safe_mult(61, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow793 = pow319
        * pow792; // pow(trace_generator, (safe_div((safe_mult(61, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow794 = pow192
        * pow790; // pow(trace_generator, (safe_div((safe_mult(29, keccak_row_ratio)), 2)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio))).
    let pow795 = pow192
        * pow793; // pow(trace_generator, (safe_div((safe_mult(61, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio))).
    let pow796 = pow228
        * pow789; // pow(trace_generator, (safe_mult(14, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow797 = pow228
        * pow796; // pow(trace_generator, (safe_mult(14, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow798 = pow228
        * pow797; // pow(trace_generator, (safe_mult(14, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow799 = pow228
        * pow798; // pow(trace_generator, (safe_mult(14, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow800 = pow302
        * pow798; // pow(trace_generator, (safe_mult(14, keccak_row_ratio)) + (safe_div((safe_mult(19, keccak_row_ratio)), 128))).
    let pow801 = pow244
        * pow800; // pow(trace_generator, (safe_mult(14, keccak_row_ratio)) + (safe_div((safe_mult(21, keccak_row_ratio)), 128))).
    let pow802 = pow210
        * pow801; // pow(trace_generator, (safe_div(keccak_row_ratio, 2048)) + (safe_mult(14, keccak_row_ratio)) + (safe_div((safe_mult(21, keccak_row_ratio)), 128))).
    let pow803 = pow262
        * pow801; // pow(trace_generator, (safe_mult(14, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow804 = pow260
        * pow803; // pow(trace_generator, (safe_mult(14, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow805 = pow193
        * pow804; // pow(trace_generator, (safe_mult(14, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow806 = pow193
        * pow800; // pow(trace_generator, (safe_mult(14, keccak_row_ratio)) + (safe_div((safe_mult(19, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow807 = pow228
        * pow792; // pow(trace_generator, (safe_div((safe_mult(61, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow808 = pow254
        * pow807; // pow(trace_generator, (safe_div((safe_mult(61, keccak_row_ratio)), 4)) + (safe_div((safe_mult(9, keccak_row_ratio)), 128))).
    let pow809 = pow235
        * pow808; // pow(trace_generator, (safe_div((safe_mult(61, keccak_row_ratio)), 4)) + (safe_div((safe_mult(5, keccak_row_ratio)), 64))).
    let pow810 = pow193
        * pow808; // pow(trace_generator, (safe_div((safe_mult(61, keccak_row_ratio)), 4)) + (safe_div((safe_mult(9, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow811 = pow260
        * pow793; // pow(trace_generator, (safe_div((safe_mult(61, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow812 = pow192
        * pow811; // pow(trace_generator, (safe_div((safe_mult(61, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio))).
    let pow813 = pow240
        * pow811; // pow(trace_generator, (safe_div((safe_mult(31, keccak_row_ratio)), 2))).
    let pow814 = pow220
        * pow813; // pow(trace_generator, (safe_div((safe_mult(7937, keccak_row_ratio)), 512))).
    let pow815 = pow220
        * pow814; // pow(trace_generator, (safe_div((safe_mult(3969, keccak_row_ratio)), 256))).
    let pow816 = pow220
        * pow815; // pow(trace_generator, (safe_div((safe_mult(31, keccak_row_ratio)), 2)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow817 = pow228
        * pow816; // pow(trace_generator, (safe_div((safe_mult(31, keccak_row_ratio)), 2)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow818 = pow228
        * pow817; // pow(trace_generator, (safe_div((safe_mult(31, keccak_row_ratio)), 2)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow819 = pow228
        * pow818; // pow(trace_generator, (safe_div((safe_mult(31, keccak_row_ratio)), 2)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow820 = pow228
        * pow819; // pow(trace_generator, (safe_div((safe_mult(31, keccak_row_ratio)), 2)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow821 = pow228
        * pow820; // pow(trace_generator, (safe_div((safe_mult(31, keccak_row_ratio)), 2)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow822 = pow228
        * pow821; // pow(trace_generator, (safe_div((safe_mult(31, keccak_row_ratio)), 2)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow823 = pow228
        * pow822; // pow(trace_generator, (safe_div((safe_mult(31, keccak_row_ratio)), 2)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow824 = pow299
        * pow823; // pow(trace_generator, (safe_div((safe_mult(31, keccak_row_ratio)), 2)) + (safe_div((safe_mult(5, keccak_row_ratio)), 32))).
    let pow825 = pow235
        * pow824; // pow(trace_generator, (safe_div((safe_mult(31, keccak_row_ratio)), 2)) + (safe_div((safe_mult(21, keccak_row_ratio)), 128))).
    let pow826 = pow193
        * pow824; // pow(trace_generator, (safe_div((safe_mult(31, keccak_row_ratio)), 2)) + (safe_div((safe_mult(5, keccak_row_ratio)), 32)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow827 = pow220
        * pow825; // pow(trace_generator, (safe_div((safe_mult(7937, keccak_row_ratio)), 512)) + (safe_div((safe_mult(21, keccak_row_ratio)), 128))).
    let pow828 = pow220
        * pow827; // pow(trace_generator, (safe_div((safe_mult(3969, keccak_row_ratio)), 256)) + (safe_div((safe_mult(21, keccak_row_ratio)), 128))).
    let pow829 = pow254
        * pow827; // pow(trace_generator, (safe_div((safe_mult(31, keccak_row_ratio)), 2)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow830 = pow220
        * pow829; // pow(trace_generator, (safe_div((safe_mult(7937, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow831 = pow220
        * pow830; // pow(trace_generator, (safe_div((safe_mult(3969, keccak_row_ratio)), 256)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow832 = pow266
        * pow830; // pow(trace_generator, (safe_div((safe_mult(31, keccak_row_ratio)), 2)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow833 = pow235
        * pow832; // pow(trace_generator, (safe_div((safe_mult(63, keccak_row_ratio)), 4))).
    let pow834 = pow202
        * pow833; // pow(trace_generator, (safe_div((safe_mult(63, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 4096))).
    let pow835 = pow202
        * pow834; // pow(trace_generator, (safe_div(keccak_row_ratio, 2048)) + (safe_div((safe_mult(63, keccak_row_ratio)), 4))).
    let pow836 = pow191
        * pow833; // pow(trace_generator, (safe_div((safe_mult(63, keccak_row_ratio)), 4)) + (safe_mult(keccak_keccak_diluted_column2_suboffset, diluted_units_row_ratio))).
    let pow837 = pow192
        * pow833; // pow(trace_generator, (safe_div((safe_mult(63, keccak_row_ratio)), 4)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio))).
    let pow838 = pow227
        * pow835; // pow(trace_generator, (safe_div((safe_mult(63, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512))).
    let pow839 = pow219
        * pow838; // pow(trace_generator, (safe_div((safe_mult(15, keccak_row_ratio)), 2048)) + (safe_div((safe_mult(63, keccak_row_ratio)), 4))).
    let pow840 = pow202
        * pow839; // pow(trace_generator, (safe_div((safe_mult(31, keccak_row_ratio)), 4096)) + (safe_div((safe_mult(63, keccak_row_ratio)), 4))).
    let pow841 = pow202
        * pow840; // pow(trace_generator, (safe_div((safe_mult(63, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 128))).
    let pow842 = pow235
        * pow841; // pow(trace_generator, (safe_div((safe_mult(63, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 64))).
    let pow843 = pow329
        * pow842; // pow(trace_generator, (safe_div((safe_mult(63, keccak_row_ratio)), 4)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow844 = pow192
        * pow843; // pow(trace_generator, (safe_div((safe_mult(63, keccak_row_ratio)), 4)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio))).
    let pow845 = pow228
        * pow843; // pow(trace_generator, (safe_div((safe_mult(63, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128))).
    let pow846 = pow191
        * pow843; // pow(trace_generator, (safe_div((safe_mult(63, keccak_row_ratio)), 4)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column2_suboffset, diluted_units_row_ratio))).
    let pow847 = pow192
        * pow845; // pow(trace_generator, (safe_div((safe_mult(63, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio))).
    let pow848 = pow193
        * pow832; // pow(trace_generator, (safe_div((safe_mult(31, keccak_row_ratio)), 2)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow849 = pow193
        * pow833; // pow(trace_generator, (safe_div((safe_mult(63, keccak_row_ratio)), 4)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow850 = pow193
        * pow841; // pow(trace_generator, (safe_div((safe_mult(2017, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow851 = pow193
        * pow842; // pow(trace_generator, (safe_div((safe_mult(63, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 64)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio))).
    let pow852 = pow194
        * pow202; // pow(trace_generator, (safe_div(keccak_row_ratio, 4096)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow853 = pow194
        * pow235; // pow(trace_generator, (safe_div(keccak_row_ratio, 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow854 = pow194
        * pow244; // pow(trace_generator, (safe_div(keccak_row_ratio, 64)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow855 = pow194
        * pow249; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow856 = pow194
        * pow645; // pow(trace_generator, (safe_mult(9, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow857 = pow194
        * pow252; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 128)) + (safe_div(keccak_row_ratio, 4096)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow858 = pow194
        * pow256; // pow(trace_generator, (safe_div(keccak_row_ratio, 32)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow859 = pow194
        * pow261; // pow(trace_generator, (safe_div(keccak_row_ratio, 32)) + (safe_div(keccak_row_ratio, 4096)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow860 = pow194
        * pow264; // pow(trace_generator, (safe_div((safe_mult(5, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow861 = pow194
        * pow269; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 64)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow862 = pow194
        * pow273; // pow(trace_generator, (safe_div((safe_mult(7, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow863 = pow194
        * pow277; // pow(trace_generator, (safe_div(keccak_row_ratio, 16)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow864 = pow194
        * pow279; // pow(trace_generator, (safe_div(keccak_row_ratio, 512)) + (safe_div(keccak_row_ratio, 16)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow865 = pow194
        * pow280; // pow(trace_generator, (safe_div(keccak_row_ratio, 256)) + (safe_div(keccak_row_ratio, 16)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow866 = pow194
        * pow283; // pow(trace_generator, (safe_div((safe_mult(9, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow867 = pow194
        * pow287; // pow(trace_generator, (safe_div((safe_mult(5, keccak_row_ratio)), 64)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow868 = pow194
        * pow809; // pow(trace_generator, (safe_div((safe_mult(61, keccak_row_ratio)), 4)) + (safe_div((safe_mult(5, keccak_row_ratio)), 64)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow869 = pow194
        * pow291; // pow(trace_generator, (safe_div((safe_mult(11, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow870 = pow194
        * pow295; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 32)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow871 = pow194
        * pow297; // pow(trace_generator, (safe_div((safe_mult(13, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow872 = pow194
        * pow299; // pow(trace_generator, (safe_div((safe_mult(7, keccak_row_ratio)), 64)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow873 = pow194
        * pow301; // pow(trace_generator, (safe_div(keccak_row_ratio, 512)) + (safe_div((safe_mult(7, keccak_row_ratio)), 64)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow874 = pow194
        * pow302; // pow(trace_generator, (safe_div(keccak_row_ratio, 256)) + (safe_div((safe_mult(7, keccak_row_ratio)), 64)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow875 = pow194
        * pow303; // pow(trace_generator, (safe_div((safe_mult(15, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow876 = pow194
        * pow304; // pow(trace_generator, (safe_div(keccak_row_ratio, 512)) + (safe_div((safe_mult(15, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow877 = pow194
        * pow305; // pow(trace_generator, (safe_div(keccak_row_ratio, 256)) + (safe_div((safe_mult(15, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow878 = pow194
        * pow307; // pow(trace_generator, (safe_div(keccak_row_ratio, 8)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow879 = pow194
        * pow309; // pow(trace_generator, (safe_div((safe_mult(17, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow880 = pow194
        * pow557; // pow(trace_generator, (safe_div((safe_mult(19, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 8)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow881 = pow194
        * pow311; // pow(trace_generator, (safe_div((safe_mult(9, keccak_row_ratio)), 64)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow882 = pow194
        * pow313; // pow(trace_generator, (safe_div((safe_mult(19, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow883 = pow194
        * pow315; // pow(trace_generator, (safe_div((safe_mult(5, keccak_row_ratio)), 32)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow884 = pow194
        * pow317; // pow(trace_generator, (safe_div((safe_mult(21, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow885 = pow194
        * pow319; // pow(trace_generator, (safe_div(keccak_row_ratio, 512)) + (safe_div((safe_mult(21, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow886 = pow194
        * pow321; // pow(trace_generator, (safe_div(keccak_row_ratio, 256)) + (safe_div((safe_mult(21, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow887 = pow194
        * pow323; // pow(trace_generator, (safe_div((safe_mult(11, keccak_row_ratio)), 64)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow888 = pow194
        * pow329; // pow(trace_generator, (safe_div((safe_mult(23, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow889 = pow194
        * pow335; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 16)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow890 = pow194
        * pow341; // pow(trace_generator, (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow891 = pow194
        * pow346; // pow(trace_generator, (safe_div(keccak_row_ratio, 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow892 = pow194
        * pow348; // pow(trace_generator, (safe_div(keccak_row_ratio, 256)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow893 = pow194
        * pow481; // pow(trace_generator, (safe_mult(2, keccak_row_ratio)) + (safe_div((safe_mult(23, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow894 = pow194
        * pow490; // pow(trace_generator, (safe_div((safe_mult(9, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 16)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow895 = pow194
        * pow759; // pow(trace_generator, (safe_div((safe_mult(27, keccak_row_ratio)), 2)) + (safe_div((safe_mult(11, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow896 = pow194
        * pow760; // pow(trace_generator, (safe_div((safe_mult(27, keccak_row_ratio)), 2)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow897 = pow194
        * pow610; // pow(trace_generator, (safe_div((safe_mult(25, keccak_row_ratio)), 4)) + (safe_div((safe_mult(7, keccak_row_ratio)), 64)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow898 = pow194
        * pow350; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow899 = pow194
        * pow352; // pow(trace_generator, (safe_div(keccak_row_ratio, 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow900 = pow194
        * pow353; // pow(trace_generator, (safe_div(keccak_row_ratio, 256)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow901 = pow194
        * pow558; // pow(trace_generator, (safe_div((safe_mult(19, keccak_row_ratio)), 4)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow902 = pow194
        * pow566; // pow(trace_generator, (safe_mult(5, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 64)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow903 = pow194
        * pow568; // pow(trace_generator, (safe_mult(5, keccak_row_ratio)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow904 = pow194
        * pow577; // pow(trace_generator, (safe_div((safe_mult(21, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 32)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow905 = pow194
        * pow354; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow906 = pow194
        * pow356; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow907 = pow194
        * pow491; // pow(trace_generator, (safe_div((safe_mult(1153, keccak_row_ratio)), 512)) + (safe_div(keccak_row_ratio, 16)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow908 = pow194
        * pow611; // pow(trace_generator, (safe_div((safe_mult(3201, keccak_row_ratio)), 512)) + (safe_div((safe_mult(7, keccak_row_ratio)), 64)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow909 = pow194
        * pow492; // pow(trace_generator, (safe_div((safe_mult(577, keccak_row_ratio)), 256)) + (safe_div(keccak_row_ratio, 16)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow910 = pow194
        * pow358; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow911 = pow194
        * pow365; // pow(trace_generator, (safe_div(keccak_row_ratio, 4)) + (safe_div(keccak_row_ratio, 4096)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow912 = pow194
        * pow411; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 4096)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow913 = pow194
        * pow464; // pow(trace_generator, (safe_div((safe_mult(7, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 4096)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow914 = pow194
        * pow525; // pow(trace_generator, (safe_div((safe_mult(15, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 4096)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow915 = pow194
        * pow631; // pow(trace_generator, (safe_div((safe_mult(31, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 4096)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow916 = pow194
        * pow360; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow917 = pow194
        * pow361; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow918 = pow194
        * pow420; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 4)) + (safe_div((safe_mult(11, keccak_row_ratio)), 64)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow919 = pow194
        * pow581; // pow(trace_generator, (safe_div((safe_mult(23, keccak_row_ratio)), 4)) + (safe_div((safe_mult(15, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow920 = pow194
        * pow582; // pow(trace_generator, (safe_div((safe_mult(2945, keccak_row_ratio)), 512)) + (safe_div((safe_mult(15, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow921 = pow194
        * pow825; // pow(trace_generator, (safe_div((safe_mult(31, keccak_row_ratio)), 2)) + (safe_div((safe_mult(21, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow922 = pow194
        * pow583; // pow(trace_generator, (safe_div((safe_mult(1473, keccak_row_ratio)), 256)) + (safe_div((safe_mult(15, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow923 = pow194
        * pow674; // pow(trace_generator, (safe_div((safe_mult(39, keccak_row_ratio)), 4)) + (safe_div((safe_mult(13, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow924 = pow194
        * pow827; // pow(trace_generator, (safe_div((safe_mult(7937, keccak_row_ratio)), 512)) + (safe_div((safe_mult(21, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow925 = pow194
        * pow828; // pow(trace_generator, (safe_div((safe_mult(3969, keccak_row_ratio)), 256)) + (safe_div((safe_mult(21, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow926 = pow194
        * pow829; // pow(trace_generator, (safe_div((safe_mult(31, keccak_row_ratio)), 2)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow927 = pow194
        * pow830; // pow(trace_generator, (safe_div((safe_mult(7937, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow928 = pow194
        * pow831; // pow(trace_generator, (safe_div((safe_mult(3969, keccak_row_ratio)), 256)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow929 = pow194
        * pow833; // pow(trace_generator, (safe_div((safe_mult(63, keccak_row_ratio)), 4)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow930 = pow194
        * pow834; // pow(trace_generator, (safe_div((safe_mult(63, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 4096)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow931 = pow194
        * pow838; // pow(trace_generator, (safe_div((safe_mult(63, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow932 = pow194
        * pow841; // pow(trace_generator, (safe_div((safe_mult(63, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow933 = pow194
        * pow613; // pow(trace_generator, (safe_div((safe_mult(25, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow934 = pow194
        * pow614; // pow(trace_generator, (safe_div((safe_mult(3201, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow935 = pow194
        * pow658; // pow(trace_generator, (safe_div((safe_mult(37, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow936 = pow194
        * pow708; // pow(trace_generator, (safe_mult(11, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow937 = pow194
        * pow698; // pow(trace_generator, (safe_div((safe_mult(43, keccak_row_ratio)), 4)) + (safe_div((safe_mult(9, keccak_row_ratio)), 64)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow938 = pow194
        * pow742; // pow(trace_generator, (safe_div((safe_mult(23, keccak_row_ratio)), 2)) + (safe_div((safe_mult(5, keccak_row_ratio)), 32)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow939 = pow194
        * pow709; // pow(trace_generator, (safe_mult(11, keccak_row_ratio)) + (safe_div((safe_mult(9, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow940 = pow194
        * pow843; // pow(trace_generator, (safe_div((safe_mult(63, keccak_row_ratio)), 4)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow941 = pow194
        * pow518; // pow(trace_generator, (safe_div((safe_mult(7, keccak_row_ratio)), 2)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow942 = pow194
        * pow612; // pow(trace_generator, (safe_div((safe_mult(1601, keccak_row_ratio)), 256)) + (safe_div((safe_mult(7, keccak_row_ratio)), 64)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow943 = pow194
        * pow615; // pow(trace_generator, (safe_div((safe_mult(1601, keccak_row_ratio)), 256)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow944 = pow194
        * pow654; // pow(trace_generator, (safe_mult(7, keccak_row_ratio)) + (safe_div((safe_mult(5, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow945 = pow194
        * pow659; // pow(trace_generator, (safe_div((safe_mult(37, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 32)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow946 = pow194
        * pow778; // pow(trace_generator, (safe_div((safe_mult(29, keccak_row_ratio)), 2)) + (safe_div((safe_mult(7, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow947 = pow194
        * pow362; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow948 = pow194
        * pow363; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow949 = pow194
        * pow399; // pow(trace_generator, (safe_div(keccak_row_ratio, 2)) + (safe_div(keccak_row_ratio, 64)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow950 = pow194
        * pow756; // pow(trace_generator, (safe_div((safe_mult(25, keccak_row_ratio)), 2)) + (safe_div((safe_mult(3, keccak_row_ratio)), 16)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow951 = pow194
        * pow786; // pow(trace_generator, (safe_div((safe_mult(25, keccak_row_ratio)), 2)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow952 = pow194
        * pow749; // pow(trace_generator, (safe_div((safe_mult(49, keccak_row_ratio)), 4)) + (safe_div((safe_mult(17, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow953 = pow194
        * pow800; // pow(trace_generator, (safe_mult(14, keccak_row_ratio)) + (safe_div((safe_mult(19, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow954 = pow194
        * pow803; // pow(trace_generator, (safe_mult(14, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow955 = pow194
        * pow845; // pow(trace_generator, (safe_div((safe_mult(63, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow956 = pow194
        * pow616; // pow(trace_generator, (safe_div((safe_mult(25, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow957 = pow194
        * pow740; // pow(trace_generator, (safe_div((safe_mult(45, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio))).
    let pow958 = pow(
        trace_generator, (keccak_input_output_suboffset * memory_units_row_ratio).into()
    );
    let pow959 = pow277
        * pow958; // pow(trace_generator, (safe_div(keccak_row_ratio, 16)) + (safe_mult(keccak_input_output_suboffset, memory_units_row_ratio))).
    let pow960 = pow277
        * pow959; // pow(trace_generator, (safe_div(keccak_row_ratio, 8)) + (safe_mult(keccak_input_output_suboffset, memory_units_row_ratio))).
    let pow961 = pow277
        * pow960; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 16)) + (safe_mult(keccak_input_output_suboffset, memory_units_row_ratio))).
    let pow962 = pow277
        * pow961; // pow(trace_generator, (safe_div(keccak_row_ratio, 4)) + (safe_mult(keccak_input_output_suboffset, memory_units_row_ratio))).
    let pow963 = pow277
        * pow962; // pow(trace_generator, (safe_div((safe_mult(5, keccak_row_ratio)), 16)) + (safe_mult(keccak_input_output_suboffset, memory_units_row_ratio))).
    let pow964 = pow277
        * pow963; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 8)) + (safe_mult(keccak_input_output_suboffset, memory_units_row_ratio))).
    let pow965 = pow277
        * pow964; // pow(trace_generator, (safe_div((safe_mult(7, keccak_row_ratio)), 16)) + (safe_mult(keccak_input_output_suboffset, memory_units_row_ratio))).
    let pow966 = pow277
        * pow965; // pow(trace_generator, (safe_div(keccak_row_ratio, 2)) + (safe_mult(keccak_input_output_suboffset, memory_units_row_ratio))).
    let pow967 = pow277
        * pow966; // pow(trace_generator, (safe_div(keccak_row_ratio, 2)) + (safe_div(keccak_row_ratio, 16)) + (safe_mult(keccak_input_output_suboffset, memory_units_row_ratio))).
    let pow968 = pow277
        * pow967; // pow(trace_generator, (safe_div(keccak_row_ratio, 2)) + (safe_div(keccak_row_ratio, 8)) + (safe_mult(keccak_input_output_suboffset, memory_units_row_ratio))).
    let pow969 = pow277
        * pow968; // pow(trace_generator, (safe_div(keccak_row_ratio, 2)) + (safe_div((safe_mult(3, keccak_row_ratio)), 16)) + (safe_mult(keccak_input_output_suboffset, memory_units_row_ratio))).
    let pow970 = pow277
        * pow969; // pow(trace_generator, (safe_div(keccak_row_ratio, 2)) + (safe_div(keccak_row_ratio, 4)) + (safe_mult(keccak_input_output_suboffset, memory_units_row_ratio))).
    let pow971 = pow277
        * pow970; // pow(trace_generator, (safe_div(keccak_row_ratio, 2)) + (safe_div((safe_mult(5, keccak_row_ratio)), 16)) + (safe_mult(keccak_input_output_suboffset, memory_units_row_ratio))).
    let pow972 = pow277
        * pow971; // pow(trace_generator, (safe_div(keccak_row_ratio, 2)) + (safe_div((safe_mult(3, keccak_row_ratio)), 8)) + (safe_mult(keccak_input_output_suboffset, memory_units_row_ratio))).
    let pow973 = pow277
        * pow972; // pow(trace_generator, (safe_div(keccak_row_ratio, 2)) + (safe_div((safe_mult(7, keccak_row_ratio)), 16)) + (safe_mult(keccak_input_output_suboffset, memory_units_row_ratio))).
    let pow974 = pow(trace_generator, (255 * ec_op_builtin_row_ratio / 256).into());
    let pow975 = pow(trace_generator, (251 * ec_op_builtin_row_ratio / 256).into());
    let pow976 = pow(trace_generator, (49 * ec_op_builtin_row_ratio / 64).into());
    let pow977 = pow(trace_generator, (3 * ec_op_builtin_row_ratio / 4).into());
    let pow978 = pow(trace_generator, (ec_op_builtin_row_ratio / 256).into());
    let pow979 = pow974 * pow978; // pow(trace_generator, ec_op_builtin_row_ratio).
    let pow980 = pow976
        * pow978; // pow(trace_generator, (safe_div((safe_mult(197, ec_op_builtin_row_ratio)), 256))).
    let pow981 = pow975
        * pow978; // pow(trace_generator, (safe_div((safe_mult(63, ec_op_builtin_row_ratio)), 64))).
    let pow982 = pow977
        * pow978; // pow(trace_generator, (safe_div((safe_mult(193, ec_op_builtin_row_ratio)), 256))).
    let pow983 = pow(trace_generator, (ec_op_r_y_suboffset * memory_units_row_ratio).into());
    let pow984 = pow(trace_generator, (ec_op_r_x_suboffset * memory_units_row_ratio).into());
    let pow985 = pow(trace_generator, (ec_op_m_suboffset * memory_units_row_ratio).into());
    let pow986 = pow(trace_generator, (ec_op_q_y_suboffset * memory_units_row_ratio).into());
    let pow987 = pow(trace_generator, (ec_op_q_x_suboffset * memory_units_row_ratio).into());
    let pow988 = pow(trace_generator, (ec_op_p_y_suboffset * memory_units_row_ratio).into());
    let pow989 = pow(trace_generator, (ec_op_p_x_suboffset * memory_units_row_ratio).into());
    let pow990 = pow979
        * pow989; // pow(trace_generator, ec_op_builtin_row_ratio + (safe_mult(ec_op_p_x_suboffset, memory_units_row_ratio))).
    let pow991 = pow(
        trace_generator, (bitwise_trim_unpacking195_suboffset * diluted_units_row_ratio).into()
    );
    let pow992 = pow(
        trace_generator, (bitwise_trim_unpacking194_suboffset * diluted_units_row_ratio).into()
    );
    let pow993 = pow(
        trace_generator, (bitwise_trim_unpacking193_suboffset * diluted_units_row_ratio).into()
    );
    let pow994 = pow(
        trace_generator, (bitwise_trim_unpacking192_suboffset * diluted_units_row_ratio).into()
    );
    let pow995 = pow(
        trace_generator, (bitwise_diluted_var_pool_suboffset * diluted_units_row_ratio).into()
    );
    let pow996 = pow3
        * pow995; // pow(trace_generator, (safe_div(bitwise_row_ratio, 64)) + (safe_mult(bitwise_diluted_var_pool_suboffset, diluted_units_row_ratio))).
    let pow997 = pow3
        * pow996; // pow(trace_generator, (safe_div(bitwise_row_ratio, 32)) + (safe_mult(bitwise_diluted_var_pool_suboffset, diluted_units_row_ratio))).
    let pow998 = pow3
        * pow997; // pow(trace_generator, (safe_div((safe_mult(3, bitwise_row_ratio)), 64)) + (safe_mult(bitwise_diluted_var_pool_suboffset, diluted_units_row_ratio))).
    let pow999 = pow3
        * pow998; // pow(trace_generator, (safe_div(bitwise_row_ratio, 16)) + (safe_mult(bitwise_diluted_var_pool_suboffset, diluted_units_row_ratio))).
    let pow1000 = pow3
        * pow999; // pow(trace_generator, (safe_div((safe_mult(5, bitwise_row_ratio)), 64)) + (safe_mult(bitwise_diluted_var_pool_suboffset, diluted_units_row_ratio))).
    let pow1001 = pow3
        * pow1000; // pow(trace_generator, (safe_div((safe_mult(3, bitwise_row_ratio)), 32)) + (safe_mult(bitwise_diluted_var_pool_suboffset, diluted_units_row_ratio))).
    let pow1002 = pow3
        * pow1001; // pow(trace_generator, (safe_div((safe_mult(7, bitwise_row_ratio)), 64)) + (safe_mult(bitwise_diluted_var_pool_suboffset, diluted_units_row_ratio))).
    let pow1003 = pow3
        * pow1002; // pow(trace_generator, (safe_div(bitwise_row_ratio, 8)) + (safe_mult(bitwise_diluted_var_pool_suboffset, diluted_units_row_ratio))).
    let pow1004 = pow3
        * pow1003; // pow(trace_generator, (safe_div((safe_mult(9, bitwise_row_ratio)), 64)) + (safe_mult(bitwise_diluted_var_pool_suboffset, diluted_units_row_ratio))).
    let pow1005 = pow3
        * pow1004; // pow(trace_generator, (safe_div((safe_mult(5, bitwise_row_ratio)), 32)) + (safe_mult(bitwise_diluted_var_pool_suboffset, diluted_units_row_ratio))).
    let pow1006 = pow3
        * pow1005; // pow(trace_generator, (safe_div((safe_mult(11, bitwise_row_ratio)), 64)) + (safe_mult(bitwise_diluted_var_pool_suboffset, diluted_units_row_ratio))).
    let pow1007 = pow3
        * pow1006; // pow(trace_generator, (safe_div((safe_mult(3, bitwise_row_ratio)), 16)) + (safe_mult(bitwise_diluted_var_pool_suboffset, diluted_units_row_ratio))).
    let pow1008 = pow3
        * pow1007; // pow(trace_generator, (safe_div((safe_mult(13, bitwise_row_ratio)), 64)) + (safe_mult(bitwise_diluted_var_pool_suboffset, diluted_units_row_ratio))).
    let pow1009 = pow3
        * pow1008; // pow(trace_generator, (safe_div((safe_mult(7, bitwise_row_ratio)), 32)) + (safe_mult(bitwise_diluted_var_pool_suboffset, diluted_units_row_ratio))).
    let pow1010 = pow3
        * pow1009; // pow(trace_generator, (safe_div((safe_mult(15, bitwise_row_ratio)), 64)) + (safe_mult(bitwise_diluted_var_pool_suboffset, diluted_units_row_ratio))).
    let pow1011 = pow3
        * pow1010; // pow(trace_generator, (safe_div(bitwise_row_ratio, 4)) + (safe_mult(bitwise_diluted_var_pool_suboffset, diluted_units_row_ratio))).
    let pow1012 = pow18
        * pow1011; // pow(trace_generator, (safe_div(bitwise_row_ratio, 2)) + (safe_mult(bitwise_diluted_var_pool_suboffset, diluted_units_row_ratio))).
    let pow1013 = pow14
        * pow1012; // pow(trace_generator, (safe_div((safe_mult(3, bitwise_row_ratio)), 16)) + (safe_div(bitwise_row_ratio, 2)) + (safe_mult(bitwise_diluted_var_pool_suboffset, diluted_units_row_ratio))).
    let pow1014 = pow3
        * pow1013; // pow(trace_generator, (safe_div((safe_mult(13, bitwise_row_ratio)), 64)) + (safe_div(bitwise_row_ratio, 2)) + (safe_mult(bitwise_diluted_var_pool_suboffset, diluted_units_row_ratio))).
    let pow1015 = pow3
        * pow1014; // pow(trace_generator, (safe_div((safe_mult(7, bitwise_row_ratio)), 32)) + (safe_div(bitwise_row_ratio, 2)) + (safe_mult(bitwise_diluted_var_pool_suboffset, diluted_units_row_ratio))).
    let pow1016 = pow3
        * pow1015; // pow(trace_generator, (safe_div((safe_mult(15, bitwise_row_ratio)), 64)) + (safe_div(bitwise_row_ratio, 2)) + (safe_mult(bitwise_diluted_var_pool_suboffset, diluted_units_row_ratio))).
    let pow1017 = pow3
        * pow1016; // pow(trace_generator, (safe_div((safe_mult(3, bitwise_row_ratio)), 4)) + (safe_mult(bitwise_diluted_var_pool_suboffset, diluted_units_row_ratio))).
    let pow1018 = pow14
        * pow1017; // pow(trace_generator, (safe_div((safe_mult(3, bitwise_row_ratio)), 16)) + (safe_div((safe_mult(3, bitwise_row_ratio)), 4)) + (safe_mult(bitwise_diluted_var_pool_suboffset, diluted_units_row_ratio))).
    let pow1019 = pow3
        * pow1018; // pow(trace_generator, (safe_div((safe_mult(13, bitwise_row_ratio)), 64)) + (safe_div((safe_mult(3, bitwise_row_ratio)), 4)) + (safe_mult(bitwise_diluted_var_pool_suboffset, diluted_units_row_ratio))).
    let pow1020 = pow3
        * pow1019; // pow(trace_generator, (safe_div((safe_mult(7, bitwise_row_ratio)), 32)) + (safe_div((safe_mult(3, bitwise_row_ratio)), 4)) + (safe_mult(bitwise_diluted_var_pool_suboffset, diluted_units_row_ratio))).
    let pow1021 = pow3
        * pow1020; // pow(trace_generator, (safe_div((safe_mult(15, bitwise_row_ratio)), 64)) + (safe_div((safe_mult(3, bitwise_row_ratio)), 4)) + (safe_mult(bitwise_diluted_var_pool_suboffset, diluted_units_row_ratio))).
    let pow1022 = pow(trace_generator, (bitwise_x_or_y_suboffset * memory_units_row_ratio).into());
    let pow1023 = pow(
        trace_generator, (bitwise_var_pool_suboffset * memory_units_row_ratio).into()
    );
    let pow1024 = pow18
        * pow1023; // pow(trace_generator, (safe_div(bitwise_row_ratio, 4)) + (safe_mult(bitwise_var_pool_suboffset, memory_units_row_ratio))).
    let pow1025 = pow18
        * pow1024; // pow(trace_generator, (safe_div(bitwise_row_ratio, 2)) + (safe_mult(bitwise_var_pool_suboffset, memory_units_row_ratio))).
    let pow1026 = pow18
        * pow1025; // pow(trace_generator, (safe_div((safe_mult(3, bitwise_row_ratio)), 4)) + (safe_mult(bitwise_var_pool_suboffset, memory_units_row_ratio))).
    let pow1027 = pow18
        * pow1026; // pow(trace_generator, bitwise_row_ratio + (safe_mult(bitwise_var_pool_suboffset, memory_units_row_ratio))).
    let pow1028 = pow(trace_generator, (ecdsa_message_suboffset * memory_units_row_ratio).into());
    let pow1029 = pow(trace_generator, (ecdsa_pubkey_suboffset * memory_units_row_ratio).into());
    let pow1030 = pow(trace_generator, (255 * ecdsa_builtin_row_ratio / 512).into());
    let pow1031 = pow1030
        * pow1030; // pow(trace_generator, (safe_div((safe_mult(255, ecdsa_builtin_row_ratio)), 256))).
    let pow1032 = pow(trace_generator, (ecdsa_builtin_row_ratio / 512).into());
    let pow1033 = pow1030
        * pow1032; // pow(trace_generator, (safe_div(ecdsa_builtin_row_ratio, 2))).
    let pow1034 = pow1030
        * pow1033; // pow(trace_generator, (safe_div(ecdsa_builtin_row_ratio, 2)) + (safe_div((safe_mult(255, ecdsa_builtin_row_ratio)), 512))).
    let pow1035 = pow1032
        * pow1032; // pow(trace_generator, (safe_div(ecdsa_builtin_row_ratio, 256))).
    let pow1036 = pow1031 * pow1035; // pow(trace_generator, ecdsa_builtin_row_ratio).
    let pow1037 = pow1029
        * pow1036; // pow(trace_generator, ecdsa_builtin_row_ratio + (safe_mult(ecdsa_pubkey_suboffset, memory_units_row_ratio))).
    let pow1038 = pow(
        trace_generator,
        (range_check_builtin_inner_range_check_suboffset * range_check_units_row_ratio).into(),
    );
    let pow1039 = pow30
        * pow1038; // pow(trace_generator, (safe_div(range_check_builtin_row_ratio, 8)) + (safe_mult(range_check_builtin_inner_range_check_suboffset, range_check_units_row_ratio))).
    let pow1040 = pow30
        * pow1039; // pow(trace_generator, (safe_div(range_check_builtin_row_ratio, 4)) + (safe_mult(range_check_builtin_inner_range_check_suboffset, range_check_units_row_ratio))).
    let pow1041 = pow30
        * pow1040; // pow(trace_generator, (safe_div((safe_mult(3, range_check_builtin_row_ratio)), 8)) + (safe_mult(range_check_builtin_inner_range_check_suboffset, range_check_units_row_ratio))).
    let pow1042 = pow30
        * pow1041; // pow(trace_generator, (safe_div(range_check_builtin_row_ratio, 2)) + (safe_mult(range_check_builtin_inner_range_check_suboffset, range_check_units_row_ratio))).
    let pow1043 = pow30
        * pow1042; // pow(trace_generator, (safe_div((safe_mult(5, range_check_builtin_row_ratio)), 8)) + (safe_mult(range_check_builtin_inner_range_check_suboffset, range_check_units_row_ratio))).
    let pow1044 = pow30
        * pow1043; // pow(trace_generator, (safe_div((safe_mult(3, range_check_builtin_row_ratio)), 4)) + (safe_mult(range_check_builtin_inner_range_check_suboffset, range_check_units_row_ratio))).
    let pow1045 = pow30
        * pow1044; // pow(trace_generator, (safe_div((safe_mult(7, range_check_builtin_row_ratio)), 8)) + (safe_mult(range_check_builtin_inner_range_check_suboffset, range_check_units_row_ratio))).
    let pow1046 = pow(
        trace_generator, (range_check_builtin_mem_suboffset * memory_units_row_ratio).into()
    );
    let pow1047 = pow37
        * pow1046; // pow(trace_generator, range_check_builtin_row_ratio + (safe_mult(range_check_builtin_mem_suboffset, memory_units_row_ratio))).
    let pow1048 = pow(trace_generator, (pedersen_input1_suboffset * memory_units_row_ratio).into());
    let pow1049 = pow(trace_generator, (pedersen_output_suboffset * memory_units_row_ratio).into());
    let pow1050 = pow(trace_generator, (pedersen_input0_suboffset * memory_units_row_ratio).into());
    let pow1051 = pow(trace_generator, (255 * pedersen_builtin_row_ratio / 512).into());
    let pow1052 = pow(trace_generator, (251 * pedersen_builtin_row_ratio / 512).into());
    let pow1053 = pow(trace_generator, (49 * pedersen_builtin_row_ratio / 128).into());
    let pow1054 = pow(trace_generator, (3 * pedersen_builtin_row_ratio / 8).into());
    let pow1055 = pow(trace_generator, (pedersen_builtin_row_ratio / 512).into());
    let pow1056 = pow1054
        * pow1055; // pow(trace_generator, (safe_div((safe_mult(193, pedersen_builtin_row_ratio)), 512))).
    let pow1057 = pow1051
        * pow1055; // pow(trace_generator, (safe_div(pedersen_builtin_row_ratio, 2))).
    let pow1058 = pow1051
        * pow1057; // pow(trace_generator, (safe_div(pedersen_builtin_row_ratio, 2)) + (safe_div((safe_mult(255, pedersen_builtin_row_ratio)), 512))).
    let pow1059 = pow1055 * pow1058; // pow(trace_generator, pedersen_builtin_row_ratio).
    let pow1060 = pow1050
        * pow1059; // pow(trace_generator, pedersen_builtin_row_ratio + (safe_mult(pedersen_input0_suboffset, memory_units_row_ratio))).
    let pow1061 = pow1053
        * pow1055; // pow(trace_generator, (safe_div((safe_mult(197, pedersen_builtin_row_ratio)), 512))).
    let pow1062 = pow1052
        * pow1055; // pow(trace_generator, (safe_div((safe_mult(63, pedersen_builtin_row_ratio)), 128))).
    let pow1063 = pow(trace_generator, diluted_units_row_ratio.into());
    let pow1064 = pow(trace_generator, range_check_units_row_ratio.into());
    let pow1065 = pow(
        trace_generator, (orig_public_memory_suboffset * memory_units_row_ratio).into()
    );
    let pow1066 = pow(trace_generator, memory_units_row_ratio.into());
    let pow1067 = pow(
        trace_generator, (cpu_operands_mem_op1_suboffset * memory_units_row_ratio).into()
    );
    let pow1068 = pow(
        trace_generator, (cpu_operands_mem_op0_suboffset * memory_units_row_ratio).into()
    );
    let pow1069 = pow(
        trace_generator, (cpu_operands_mem_dst_suboffset * memory_units_row_ratio).into()
    );
    let pow1070 = pow(
        trace_generator, (cpu_decode_off0_suboffset * range_check_units_row_ratio).into()
    );
    let pow1071 = pow(
        trace_generator, (cpu_decode_off1_suboffset * range_check_units_row_ratio).into()
    );
    let pow1072 = pow(
        trace_generator, (cpu_decode_off2_suboffset * range_check_units_row_ratio).into()
    );
    let pow1073 = pow(
        trace_generator, (cpu_decode_mem_inst_suboffset * memory_units_row_ratio).into()
    );
    let pow1074 = pow(trace_generator, cpu_component_step.into());
    let pow1075 = pow1074 * pow1074; // pow(trace_generator, (safe_mult(2, cpu_component_step))).
    let pow1076 = pow1074
        * pow1075; // pow(trace_generator, (safe_mult(2, cpu_component_step)) + cpu_component_step).
    let pow1077 = pow1074 * pow1076; // pow(trace_generator, (safe_mult(4, cpu_component_step))).
    let pow1078 = pow1074
        * pow1077; // pow(trace_generator, (safe_mult(4, cpu_component_step)) + cpu_component_step).
    let pow1079 = pow1074
        * pow1078; // pow(trace_generator, (safe_mult(5, cpu_component_step)) + cpu_component_step).
    let pow1080 = pow1074
        * pow1079; // pow(trace_generator, (safe_mult(6, cpu_component_step)) + cpu_component_step).
    let pow1081 = pow1074
        * pow1080; // pow(trace_generator, (safe_mult(7, cpu_component_step)) + cpu_component_step).
    let pow1082 = pow1074 * pow1081; // pow(trace_generator, (safe_mult(9, cpu_component_step))).
    let pow1083 = pow1074
        * pow1082; // pow(trace_generator, (safe_mult(9, cpu_component_step)) + cpu_component_step).
    let pow1084 = pow1074
        * pow1083; // pow(trace_generator, (safe_mult(10, cpu_component_step)) + cpu_component_step).
    let pow1085 = pow1074 * pow1084; // pow(trace_generator, (safe_mult(12, cpu_component_step))).
    let pow1086 = pow1074
        * pow1085; // pow(trace_generator, (safe_mult(12, cpu_component_step)) + cpu_component_step).
    let pow1087 = pow1074
        * pow1086; // pow(trace_generator, (safe_mult(13, cpu_component_step)) + cpu_component_step).
    let pow1088 = pow1074
        * pow1087; // pow(trace_generator, (safe_mult(14, cpu_component_step)) + cpu_component_step).
    let pow1089 = pow1074 * pow1088; // pow(trace_generator, (safe_mult(16, cpu_component_step))).
    let pow1090 = pow1073
        * pow1089; // pow(trace_generator, (safe_mult(16, cpu_component_step)) + (safe_mult(cpu_decode_mem_inst_suboffset, memory_units_row_ratio))).
    let pow1091 = pow(trace_generator, diluted_check_cumulative_value_offset.into());
    let pow1092 = pow1063
        * pow1091; // pow(trace_generator, diluted_units_row_ratio + diluted_check_cumulative_value_offset).
    let pow1093 = pow(trace_generator, diluted_check_permutation_cum_prod0_offset.into());
    let pow1094 = pow1063
        * pow1093; // pow(trace_generator, diluted_units_row_ratio + diluted_check_permutation_cum_prod0_offset).
    let pow1095 = pow(trace_generator, range_check16_perm_cum_prod0_offset.into());
    let pow1096 = pow1064
        * pow1095; // pow(trace_generator, range_check_units_row_ratio + range_check16_perm_cum_prod0_offset).
    let pow1097 = pow(trace_generator, memory_multi_column_perm_perm_cum_prod0_offset.into());
    let pow1098 = pow1066
        * pow1097; // pow(trace_generator, memory_units_row_ratio + memory_multi_column_perm_perm_cum_prod0_offset).
    let pow1099 = pow(trace_generator, add_mod_carry3_sign_offset.into());
    let pow1100 = pow(trace_generator, add_mod_carry3_bit_offset.into());
    let pow1101 = pow(trace_generator, add_mod_carry2_sign_offset.into());
    let pow1102 = pow(trace_generator, add_mod_carry2_bit_offset.into());
    let pow1103 = pow(trace_generator, add_mod_carry1_sign_offset.into());
    let pow1104 = pow(trace_generator, add_mod_carry1_bit_offset.into());
    let pow1105 = pow(trace_generator, add_mod_sub_p_bit_offset.into());
    let pow1106 = pow(trace_generator, poseidon_poseidon_partial_rounds_state1_offset.into());
    let pow1107 = pow172
        * pow1106; // pow(trace_generator, (safe_div(poseidon_row_ratio, 32)) + poseidon_poseidon_partial_rounds_state1_offset).
    let pow1108 = pow172
        * pow1107; // pow(trace_generator, (safe_div(poseidon_row_ratio, 16)) + poseidon_poseidon_partial_rounds_state1_offset).
    let pow1109 = pow172
        * pow1108; // pow(trace_generator, (safe_div((safe_mult(3, poseidon_row_ratio)), 32)) + poseidon_poseidon_partial_rounds_state1_offset).
    let pow1110 = pow178
        * pow1109; // pow(trace_generator, (safe_div((safe_mult(19, poseidon_row_ratio)), 32)) + poseidon_poseidon_partial_rounds_state1_offset).
    let pow1111 = pow172
        * pow1110; // pow(trace_generator, (safe_div((safe_mult(5, poseidon_row_ratio)), 8)) + poseidon_poseidon_partial_rounds_state1_offset).
    let pow1112 = pow172
        * pow1111; // pow(trace_generator, (safe_div((safe_mult(21, poseidon_row_ratio)), 32)) + poseidon_poseidon_partial_rounds_state1_offset).
    let pow1113 = pow(
        trace_generator, poseidon_poseidon_partial_rounds_state1_squared_offset.into()
    );
    let pow1114 = pow179
        * pow1113; // pow(trace_generator, (safe_div((safe_mult(19, poseidon_row_ratio)), 32)) + poseidon_poseidon_partial_rounds_state1_squared_offset).
    let pow1115 = pow172
        * pow1113; // pow(trace_generator, (safe_div(poseidon_row_ratio, 32)) + poseidon_poseidon_partial_rounds_state1_squared_offset).
    let pow1116 = pow172
        * pow1115; // pow(trace_generator, (safe_div(poseidon_row_ratio, 16)) + poseidon_poseidon_partial_rounds_state1_squared_offset).
    let pow1117 = pow172
        * pow1114; // pow(trace_generator, (safe_div((safe_mult(5, poseidon_row_ratio)), 8)) + poseidon_poseidon_partial_rounds_state1_squared_offset).
    let pow1118 = pow172
        * pow1117; // pow(trace_generator, (safe_div((safe_mult(21, poseidon_row_ratio)), 32)) + poseidon_poseidon_partial_rounds_state1_squared_offset).
    let pow1119 = pow(trace_generator, poseidon_poseidon_partial_rounds_state0_offset.into());
    let pow1120 = pow170
        * pow1119; // pow(trace_generator, (safe_div(poseidon_row_ratio, 64)) + poseidon_poseidon_partial_rounds_state0_offset).
    let pow1121 = pow170
        * pow1120; // pow(trace_generator, (safe_div(poseidon_row_ratio, 32)) + poseidon_poseidon_partial_rounds_state0_offset).
    let pow1122 = pow170
        * pow1121; // pow(trace_generator, (safe_div((safe_mult(3, poseidon_row_ratio)), 64)) + poseidon_poseidon_partial_rounds_state0_offset).
    let pow1123 = pow176
        * pow1119; // pow(trace_generator, (safe_div((safe_mult(61, poseidon_row_ratio)), 64)) + poseidon_poseidon_partial_rounds_state0_offset).
    let pow1124 = pow170
        * pow1123; // pow(trace_generator, (safe_div((safe_mult(31, poseidon_row_ratio)), 32)) + poseidon_poseidon_partial_rounds_state0_offset).
    let pow1125 = pow170
        * pow1124; // pow(trace_generator, (safe_div((safe_mult(63, poseidon_row_ratio)), 64)) + poseidon_poseidon_partial_rounds_state0_offset).
    let pow1126 = pow(
        trace_generator, poseidon_poseidon_partial_rounds_state0_squared_offset.into()
    );
    let pow1127 = pow170
        * pow1126; // pow(trace_generator, (safe_div(poseidon_row_ratio, 64)) + poseidon_poseidon_partial_rounds_state0_squared_offset).
    let pow1128 = pow170
        * pow1127; // pow(trace_generator, (safe_div(poseidon_row_ratio, 32)) + poseidon_poseidon_partial_rounds_state0_squared_offset).
    let pow1129 = pow(trace_generator, poseidon_poseidon_full_rounds_state2_offset.into());
    let pow1130 = pow171
        * pow1129; // pow(trace_generator, (safe_div((safe_mult(3, poseidon_row_ratio)), 8)) + poseidon_poseidon_full_rounds_state2_offset).
    let pow1131 = pow177
        * pow1129; // pow(trace_generator, (safe_div(poseidon_row_ratio, 8)) + poseidon_poseidon_full_rounds_state2_offset).
    let pow1132 = pow171
        * pow1131; // pow(trace_generator, (safe_div(poseidon_row_ratio, 2)) + poseidon_poseidon_full_rounds_state2_offset).
    let pow1133 = pow171
        * pow1132; // pow(trace_generator, (safe_div((safe_mult(7, poseidon_row_ratio)), 8)) + poseidon_poseidon_full_rounds_state2_offset).
    let pow1134 = pow(trace_generator, poseidon_poseidon_full_rounds_state2_squared_offset.into());
    let pow1135 = pow171
        * pow1134; // pow(trace_generator, (safe_div((safe_mult(3, poseidon_row_ratio)), 8)) + poseidon_poseidon_full_rounds_state2_squared_offset).
    let pow1136 = pow178
        * pow1135; // pow(trace_generator, (safe_div((safe_mult(7, poseidon_row_ratio)), 8)) + poseidon_poseidon_full_rounds_state2_squared_offset).
    let pow1137 = pow(trace_generator, poseidon_poseidon_full_rounds_state1_offset.into());
    let pow1138 = pow177
        * pow1137; // pow(trace_generator, (safe_div(poseidon_row_ratio, 8)) + poseidon_poseidon_full_rounds_state1_offset).
    let pow1139 = pow171
        * pow1137; // pow(trace_generator, (safe_div((safe_mult(3, poseidon_row_ratio)), 8)) + poseidon_poseidon_full_rounds_state1_offset).
    let pow1140 = pow171
        * pow1138; // pow(trace_generator, (safe_div(poseidon_row_ratio, 2)) + poseidon_poseidon_full_rounds_state1_offset).
    let pow1141 = pow171
        * pow1140; // pow(trace_generator, (safe_div((safe_mult(7, poseidon_row_ratio)), 8)) + poseidon_poseidon_full_rounds_state1_offset).
    let pow1142 = pow(trace_generator, poseidon_poseidon_full_rounds_state1_squared_offset.into());
    let pow1143 = pow171
        * pow1142; // pow(trace_generator, (safe_div((safe_mult(3, poseidon_row_ratio)), 8)) + poseidon_poseidon_full_rounds_state1_squared_offset).
    let pow1144 = pow178
        * pow1143; // pow(trace_generator, (safe_div((safe_mult(7, poseidon_row_ratio)), 8)) + poseidon_poseidon_full_rounds_state1_squared_offset).
    let pow1145 = pow(trace_generator, poseidon_poseidon_full_rounds_state0_offset.into());
    let pow1146 = pow171
        * pow1145; // pow(trace_generator, (safe_div((safe_mult(3, poseidon_row_ratio)), 8)) + poseidon_poseidon_full_rounds_state0_offset).
    let pow1147 = pow177
        * pow1145; // pow(trace_generator, (safe_div(poseidon_row_ratio, 8)) + poseidon_poseidon_full_rounds_state0_offset).
    let pow1148 = pow171
        * pow1147; // pow(trace_generator, (safe_div(poseidon_row_ratio, 2)) + poseidon_poseidon_full_rounds_state0_offset).
    let pow1149 = pow171
        * pow1148; // pow(trace_generator, (safe_div((safe_mult(7, poseidon_row_ratio)), 8)) + poseidon_poseidon_full_rounds_state0_offset).
    let pow1150 = pow(trace_generator, poseidon_poseidon_full_rounds_state0_squared_offset.into());
    let pow1151 = pow171
        * pow1150; // pow(trace_generator, (safe_div((safe_mult(3, poseidon_row_ratio)), 8)) + poseidon_poseidon_full_rounds_state0_squared_offset).
    let pow1152 = pow178
        * pow1151; // pow(trace_generator, (safe_div((safe_mult(7, poseidon_row_ratio)), 8)) + poseidon_poseidon_full_rounds_state0_squared_offset).
    let pow1153 = pow(trace_generator, keccak_keccak_rotated_parity4_offset.into());
    let pow1154 = pow220
        * pow1153; // pow(trace_generator, (safe_div(keccak_row_ratio, 512)) + keccak_keccak_rotated_parity4_offset).
    let pow1155 = pow220
        * pow1154; // pow(trace_generator, (safe_div(keccak_row_ratio, 256)) + keccak_keccak_rotated_parity4_offset).
    let pow1156 = pow364
        * pow1153; // pow(trace_generator, (safe_div(keccak_row_ratio, 4)) + keccak_keccak_rotated_parity4_offset).
    let pow1157 = pow460
        * pow1156; // pow(trace_generator, (safe_mult(2, keccak_row_ratio)) + keccak_keccak_rotated_parity4_offset).
    let pow1158 = pow364
        * pow1157; // pow(trace_generator, (safe_div((safe_mult(9, keccak_row_ratio)), 4)) + keccak_keccak_rotated_parity4_offset).
    let pow1159 = pow220
        * pow1158; // pow(trace_generator, (safe_div((safe_mult(1153, keccak_row_ratio)), 512)) + keccak_keccak_rotated_parity4_offset).
    let pow1160 = pow220
        * pow1159; // pow(trace_generator, (safe_div((safe_mult(577, keccak_row_ratio)), 256)) + keccak_keccak_rotated_parity4_offset).
    let pow1161 = pow617
        * pow1158; // pow(trace_generator, (safe_mult(9, keccak_row_ratio)) + keccak_keccak_rotated_parity4_offset).
    let pow1162 = pow410
        * pow1161; // pow(trace_generator, (safe_div((safe_mult(39, keccak_row_ratio)), 4)) + keccak_keccak_rotated_parity4_offset).
    let pow1163 = pow452
        * pow1162; // pow(trace_generator, (safe_div((safe_mult(43, keccak_row_ratio)), 4)) + keccak_keccak_rotated_parity4_offset).
    let pow1164 = pow(trace_generator, keccak_keccak_rotated_parity3_offset.into());
    let pow1165 = pow364
        * pow1164; // pow(trace_generator, (safe_div(keccak_row_ratio, 4)) + keccak_keccak_rotated_parity3_offset).
    let pow1166 = pow364
        * pow1165; // pow(trace_generator, (safe_div(keccak_row_ratio, 2)) + keccak_keccak_rotated_parity3_offset).
    let pow1167 = pow364
        * pow1166; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 4)) + keccak_keccak_rotated_parity3_offset).
    let pow1168 = pow540
        * pow1167; // pow(trace_generator, (safe_div((safe_mult(21, keccak_row_ratio)), 4)) + keccak_keccak_rotated_parity3_offset).
    let pow1169 = pow624
        * pow1168; // pow(trace_generator, (safe_div((safe_mult(49, keccak_row_ratio)), 4)) + keccak_keccak_rotated_parity3_offset).
    let pow1170 = pow486
        * pow1169; // pow(trace_generator, (safe_div((safe_mult(29, keccak_row_ratio)), 2)) + keccak_keccak_rotated_parity3_offset).
    let pow1171 = pow(trace_generator, keccak_keccak_rotated_parity2_offset.into());
    let pow1172 = pow758
        * pow1171; // pow(trace_generator, (safe_div((safe_mult(27, keccak_row_ratio)), 2)) + keccak_keccak_rotated_parity2_offset).
    let pow1173 = pow220
        * pow1171; // pow(trace_generator, (safe_div(keccak_row_ratio, 512)) + keccak_keccak_rotated_parity2_offset).
    let pow1174 = pow220
        * pow1173; // pow(trace_generator, (safe_div(keccak_row_ratio, 256)) + keccak_keccak_rotated_parity2_offset).
    let pow1175 = pow364
        * pow1171; // pow(trace_generator, (safe_div(keccak_row_ratio, 4)) + keccak_keccak_rotated_parity2_offset).
    let pow1176 = pow540
        * pow1175; // pow(trace_generator, (safe_div((safe_mult(19, keccak_row_ratio)), 4)) + keccak_keccak_rotated_parity2_offset).
    let pow1177 = pow364
        * pow1176; // pow(trace_generator, (safe_mult(5, keccak_row_ratio)) + keccak_keccak_rotated_parity2_offset).
    let pow1178 = pow469
        * pow1172; // pow(trace_generator, (safe_div((safe_mult(31, keccak_row_ratio)), 2)) + keccak_keccak_rotated_parity2_offset).
    let pow1179 = pow220
        * pow1178; // pow(trace_generator, (safe_div((safe_mult(7937, keccak_row_ratio)), 512)) + keccak_keccak_rotated_parity2_offset).
    let pow1180 = pow220
        * pow1179; // pow(trace_generator, (safe_div((safe_mult(3969, keccak_row_ratio)), 256)) + keccak_keccak_rotated_parity2_offset).
    let pow1181 = pow364
        * pow1178; // pow(trace_generator, (safe_div((safe_mult(63, keccak_row_ratio)), 4)) + keccak_keccak_rotated_parity2_offset).
    let pow1182 = pow(trace_generator, keccak_keccak_rotated_parity1_offset.into());
    let pow1183 = pow572
        * pow1182; // pow(trace_generator, (safe_div((safe_mult(23, keccak_row_ratio)), 4)) + keccak_keccak_rotated_parity1_offset).
    let pow1184 = pow220
        * pow1182; // pow(trace_generator, (safe_div(keccak_row_ratio, 512)) + keccak_keccak_rotated_parity1_offset).
    let pow1185 = pow220
        * pow1183; // pow(trace_generator, (safe_div((safe_mult(2945, keccak_row_ratio)), 512)) + keccak_keccak_rotated_parity1_offset).
    let pow1186 = pow220
        * pow1184; // pow(trace_generator, (safe_div(keccak_row_ratio, 256)) + keccak_keccak_rotated_parity1_offset).
    let pow1187 = pow220
        * pow1185; // pow(trace_generator, (safe_div((safe_mult(1473, keccak_row_ratio)), 256)) + keccak_keccak_rotated_parity1_offset).
    let pow1188 = pow364
        * pow1182; // pow(trace_generator, (safe_div(keccak_row_ratio, 4)) + keccak_keccak_rotated_parity1_offset).
    let pow1189 = pow617
        * pow1188; // pow(trace_generator, (safe_mult(7, keccak_row_ratio)) + keccak_keccak_rotated_parity1_offset).
    let pow1190 = pow540
        * pow1189; // pow(trace_generator, (safe_div((safe_mult(23, keccak_row_ratio)), 2)) + keccak_keccak_rotated_parity1_offset).
    let pow1191 = pow520
        * pow1190; // pow(trace_generator, (safe_div((safe_mult(61, keccak_row_ratio)), 4)) + keccak_keccak_rotated_parity1_offset).
    let pow1192 = pow(trace_generator, keccak_keccak_rotated_parity0_offset.into());
    let pow1193 = pow220
        * pow1192; // pow(trace_generator, (safe_div(keccak_row_ratio, 512)) + keccak_keccak_rotated_parity0_offset).
    let pow1194 = pow220
        * pow1193; // pow(trace_generator, (safe_div(keccak_row_ratio, 256)) + keccak_keccak_rotated_parity0_offset).
    let pow1195 = pow364
        * pow1192; // pow(trace_generator, (safe_div(keccak_row_ratio, 4)) + keccak_keccak_rotated_parity0_offset).
    let pow1196 = pow593
        * pow1195; // pow(trace_generator, (safe_div((safe_mult(25, keccak_row_ratio)), 4)) + keccak_keccak_rotated_parity0_offset).
    let pow1197 = pow220
        * pow1196; // pow(trace_generator, (safe_div((safe_mult(3201, keccak_row_ratio)), 512)) + keccak_keccak_rotated_parity0_offset).
    let pow1198 = pow220
        * pow1197; // pow(trace_generator, (safe_div((safe_mult(1601, keccak_row_ratio)), 256)) + keccak_keccak_rotated_parity0_offset).
    let pow1199 = pow509
        * pow1196; // pow(trace_generator, (safe_div((safe_mult(37, keccak_row_ratio)), 4)) + keccak_keccak_rotated_parity0_offset).
    let pow1200 = pow460
        * pow1199; // pow(trace_generator, (safe_mult(11, keccak_row_ratio)) + keccak_keccak_rotated_parity0_offset).
    let pow1201 = pow453
        * pow1200; // pow(trace_generator, (safe_div((safe_mult(25, keccak_row_ratio)), 2)) + keccak_keccak_rotated_parity0_offset).
    let pow1202 = pow453
        * pow1201; // pow(trace_generator, (safe_mult(14, keccak_row_ratio)) + keccak_keccak_rotated_parity0_offset).
    let pow1203 = pow(trace_generator, keccak_keccak_parse_to_diluted_cumulative_sum_offset.into());
    let pow1204 = pow210
        * pow1203; // pow(trace_generator, (safe_div(keccak_row_ratio, 2048)) + keccak_keccak_parse_to_diluted_cumulative_sum_offset).
    let pow1205 = pow232
        * pow1204; // pow(trace_generator, (safe_div((safe_mult(15, keccak_row_ratio)), 2048)) + keccak_keccak_parse_to_diluted_cumulative_sum_offset).
    let pow1206 = pow202
        * pow1205; // pow(trace_generator, (safe_div((safe_mult(31, keccak_row_ratio)), 4096)) + keccak_keccak_parse_to_diluted_cumulative_sum_offset).
    let pow1207 = pow202
        * pow1206; // pow(trace_generator, (safe_div(keccak_row_ratio, 128)) + keccak_keccak_parse_to_diluted_cumulative_sum_offset).
    let pow1208 = pow210
        * pow1207; // pow(trace_generator, (safe_div(keccak_row_ratio, 2048)) + (safe_div(keccak_row_ratio, 128)) + keccak_keccak_parse_to_diluted_cumulative_sum_offset).
    let pow1209 = pow232
        * pow1208; // pow(trace_generator, (safe_div((safe_mult(15, keccak_row_ratio)), 2048)) + (safe_div(keccak_row_ratio, 128)) + keccak_keccak_parse_to_diluted_cumulative_sum_offset).
    let pow1210 = pow202
        * pow1209; // pow(trace_generator, (safe_div((safe_mult(31, keccak_row_ratio)), 4096)) + (safe_div(keccak_row_ratio, 128)) + keccak_keccak_parse_to_diluted_cumulative_sum_offset).
    let pow1211 = pow474
        * pow1203; // pow(trace_generator, (safe_mult(2, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 128)) + keccak_keccak_parse_to_diluted_cumulative_sum_offset).
    let pow1212 = pow474
        * pow1211; // pow(trace_generator, (safe_mult(4, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 64)) + keccak_keccak_parse_to_diluted_cumulative_sum_offset).
    let pow1213 = pow474
        * pow1212; // pow(trace_generator, (safe_mult(6, keccak_row_ratio)) + (safe_div((safe_mult(9, keccak_row_ratio)), 128)) + keccak_keccak_parse_to_diluted_cumulative_sum_offset).
    let pow1214 = pow210
        * pow1211; // pow(trace_generator, (safe_div(keccak_row_ratio, 2048)) + (safe_mult(2, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 128)) + keccak_keccak_parse_to_diluted_cumulative_sum_offset).
    let pow1215 = pow210
        * pow1212; // pow(trace_generator, (safe_div(keccak_row_ratio, 2048)) + (safe_mult(4, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 64)) + keccak_keccak_parse_to_diluted_cumulative_sum_offset).
    let pow1216 = pow474
        * pow1213; // pow(trace_generator, (safe_mult(8, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 32)) + keccak_keccak_parse_to_diluted_cumulative_sum_offset).
    let pow1217 = pow210
        * pow1213; // pow(trace_generator, (safe_div(keccak_row_ratio, 2048)) + (safe_mult(6, keccak_row_ratio)) + (safe_div((safe_mult(9, keccak_row_ratio)), 128)) + keccak_keccak_parse_to_diluted_cumulative_sum_offset).
    let pow1218 = pow210
        * pow1216; // pow(trace_generator, (safe_div(keccak_row_ratio, 2048)) + (safe_mult(8, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 32)) + keccak_keccak_parse_to_diluted_cumulative_sum_offset).
    let pow1219 = pow335
        * pow1207; // pow(trace_generator, (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + keccak_keccak_parse_to_diluted_cumulative_sum_offset).
    let pow1220 = pow273
        * pow1219; // pow(trace_generator, (safe_div(keccak_row_ratio, 4)) + keccak_keccak_parse_to_diluted_cumulative_sum_offset).
    let pow1221 = pow474
        * pow1216; // pow(trace_generator, (safe_mult(10, keccak_row_ratio)) + (safe_div((safe_mult(15, keccak_row_ratio)), 128)) + keccak_keccak_parse_to_diluted_cumulative_sum_offset).
    let pow1222 = pow474
        * pow1221; // pow(trace_generator, (safe_mult(12, keccak_row_ratio)) + (safe_div((safe_mult(9, keccak_row_ratio)), 64)) + keccak_keccak_parse_to_diluted_cumulative_sum_offset).
    let pow1223 = pow474
        * pow1222; // pow(trace_generator, (safe_mult(14, keccak_row_ratio)) + (safe_div((safe_mult(21, keccak_row_ratio)), 128)) + keccak_keccak_parse_to_diluted_cumulative_sum_offset).
    let pow1224 = pow456
        * pow1223; // pow(trace_generator, (safe_div((safe_mult(63, keccak_row_ratio)), 4)) + keccak_keccak_parse_to_diluted_cumulative_sum_offset).
    let pow1225 = pow210
        * pow1219; // pow(trace_generator, (safe_div(keccak_row_ratio, 2048)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + keccak_keccak_parse_to_diluted_cumulative_sum_offset).
    let pow1226 = pow210
        * pow1221; // pow(trace_generator, (safe_div(keccak_row_ratio, 2048)) + (safe_mult(10, keccak_row_ratio)) + (safe_div((safe_mult(15, keccak_row_ratio)), 128)) + keccak_keccak_parse_to_diluted_cumulative_sum_offset).
    let pow1227 = pow210
        * pow1222; // pow(trace_generator, (safe_div(keccak_row_ratio, 2048)) + (safe_mult(12, keccak_row_ratio)) + (safe_div((safe_mult(9, keccak_row_ratio)), 64)) + keccak_keccak_parse_to_diluted_cumulative_sum_offset).
    let pow1228 = pow210
        * pow1220; // pow(trace_generator, (safe_div(keccak_row_ratio, 2048)) + (safe_div(keccak_row_ratio, 4)) + keccak_keccak_parse_to_diluted_cumulative_sum_offset).
    let pow1229 = pow232
        * pow1228; // pow(trace_generator, (safe_div((safe_mult(15, keccak_row_ratio)), 2048)) + (safe_div(keccak_row_ratio, 4)) + keccak_keccak_parse_to_diluted_cumulative_sum_offset).
    let pow1230 = pow202
        * pow1229; // pow(trace_generator, (safe_div((safe_mult(31, keccak_row_ratio)), 4096)) + (safe_div(keccak_row_ratio, 4)) + keccak_keccak_parse_to_diluted_cumulative_sum_offset).
    let pow1231 = pow210
        * pow1223; // pow(trace_generator, (safe_div(keccak_row_ratio, 2048)) + (safe_mult(14, keccak_row_ratio)) + (safe_div((safe_mult(21, keccak_row_ratio)), 128)) + keccak_keccak_parse_to_diluted_cumulative_sum_offset).
    let pow1232 = pow210
        * pow1224; // pow(trace_generator, (safe_div(keccak_row_ratio, 2048)) + (safe_div((safe_mult(63, keccak_row_ratio)), 4)) + keccak_keccak_parse_to_diluted_cumulative_sum_offset).
    let pow1233 = pow232
        * pow1232; // pow(trace_generator, (safe_div((safe_mult(15, keccak_row_ratio)), 2048)) + (safe_div((safe_mult(63, keccak_row_ratio)), 4)) + keccak_keccak_parse_to_diluted_cumulative_sum_offset).
    let pow1234 = pow202
        * pow1233; // pow(trace_generator, (safe_div((safe_mult(31, keccak_row_ratio)), 4096)) + (safe_div((safe_mult(63, keccak_row_ratio)), 4)) + keccak_keccak_parse_to_diluted_cumulative_sum_offset).
    let pow1235 = pow(
        trace_generator, keccak_keccak_parse_to_diluted_final_reshaped_input_offset.into()
    );
    let pow1236 = pow195
        * pow1235; // pow(trace_generator, (safe_div(keccak_row_ratio, 32768)) + keccak_keccak_parse_to_diluted_final_reshaped_input_offset).
    let pow1237 = pow195
        * pow1236; // pow(trace_generator, (safe_div(keccak_row_ratio, 16384)) + keccak_keccak_parse_to_diluted_final_reshaped_input_offset).
    let pow1238 = pow195
        * pow1237; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 32768)) + keccak_keccak_parse_to_diluted_final_reshaped_input_offset).
    let pow1239 = pow195
        * pow1238; // pow(trace_generator, (safe_div(keccak_row_ratio, 8192)) + keccak_keccak_parse_to_diluted_final_reshaped_input_offset).
    let pow1240 = pow195
        * pow1239; // pow(trace_generator, (safe_div((safe_mult(5, keccak_row_ratio)), 32768)) + keccak_keccak_parse_to_diluted_final_reshaped_input_offset).
    let pow1241 = pow195
        * pow1240; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 16384)) + keccak_keccak_parse_to_diluted_final_reshaped_input_offset).
    let pow1242 = pow195
        * pow1241; // pow(trace_generator, (safe_div((safe_mult(7, keccak_row_ratio)), 32768)) + keccak_keccak_parse_to_diluted_final_reshaped_input_offset).
    let pow1243 = pow203
        * pow1242; // pow(trace_generator, (safe_div(keccak_row_ratio, 2048)) + keccak_keccak_parse_to_diluted_final_reshaped_input_offset).
    let pow1244 = pow195
        * pow1243; // pow(trace_generator, (safe_div(keccak_row_ratio, 2048)) + (safe_div(keccak_row_ratio, 32768)) + keccak_keccak_parse_to_diluted_final_reshaped_input_offset).
    let pow1245 = pow195
        * pow1244; // pow(trace_generator, (safe_div(keccak_row_ratio, 2048)) + (safe_div(keccak_row_ratio, 16384)) + keccak_keccak_parse_to_diluted_final_reshaped_input_offset).
    let pow1246 = pow195
        * pow1245; // pow(trace_generator, (safe_div(keccak_row_ratio, 2048)) + (safe_div((safe_mult(3, keccak_row_ratio)), 32768)) + keccak_keccak_parse_to_diluted_final_reshaped_input_offset).
    let pow1247 = pow195
        * pow1246; // pow(trace_generator, (safe_div(keccak_row_ratio, 2048)) + (safe_div(keccak_row_ratio, 8192)) + keccak_keccak_parse_to_diluted_final_reshaped_input_offset).
    let pow1248 = pow195
        * pow1247; // pow(trace_generator, (safe_div(keccak_row_ratio, 2048)) + (safe_div((safe_mult(5, keccak_row_ratio)), 32768)) + keccak_keccak_parse_to_diluted_final_reshaped_input_offset).
    let pow1249 = pow195
        * pow1248; // pow(trace_generator, (safe_div(keccak_row_ratio, 2048)) + (safe_div((safe_mult(3, keccak_row_ratio)), 16384)) + keccak_keccak_parse_to_diluted_final_reshaped_input_offset).
    let pow1250 = pow195
        * pow1249; // pow(trace_generator, (safe_div(keccak_row_ratio, 2048)) + (safe_div((safe_mult(7, keccak_row_ratio)), 32768)) + keccak_keccak_parse_to_diluted_final_reshaped_input_offset).
    let pow1251 = pow203
        * pow1250; // pow(trace_generator, (safe_div(keccak_row_ratio, 1024)) + keccak_keccak_parse_to_diluted_final_reshaped_input_offset).
    let pow1252 = pow210
        * pow1251; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 2048)) + keccak_keccak_parse_to_diluted_final_reshaped_input_offset).
    let pow1253 = pow210
        * pow1252; // pow(trace_generator, (safe_div(keccak_row_ratio, 512)) + keccak_keccak_parse_to_diluted_final_reshaped_input_offset).
    let pow1254 = pow210
        * pow1253; // pow(trace_generator, (safe_div((safe_mult(5, keccak_row_ratio)), 2048)) + keccak_keccak_parse_to_diluted_final_reshaped_input_offset).
    let pow1255 = pow210
        * pow1254; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 1024)) + keccak_keccak_parse_to_diluted_final_reshaped_input_offset).
    let pow1256 = pow210
        * pow1255; // pow(trace_generator, (safe_div((safe_mult(7, keccak_row_ratio)), 2048)) + keccak_keccak_parse_to_diluted_final_reshaped_input_offset).
    let pow1257 = pow210
        * pow1256; // pow(trace_generator, (safe_div(keccak_row_ratio, 256)) + keccak_keccak_parse_to_diluted_final_reshaped_input_offset).
    let pow1258 = pow210
        * pow1257; // pow(trace_generator, (safe_div((safe_mult(9, keccak_row_ratio)), 2048)) + keccak_keccak_parse_to_diluted_final_reshaped_input_offset).
    let pow1259 = pow210
        * pow1258; // pow(trace_generator, (safe_div((safe_mult(5, keccak_row_ratio)), 1024)) + keccak_keccak_parse_to_diluted_final_reshaped_input_offset).
    let pow1260 = pow210
        * pow1259; // pow(trace_generator, (safe_div((safe_mult(11, keccak_row_ratio)), 2048)) + keccak_keccak_parse_to_diluted_final_reshaped_input_offset).
    let pow1261 = pow210
        * pow1260; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + keccak_keccak_parse_to_diluted_final_reshaped_input_offset).
    let pow1262 = pow210
        * pow1261; // pow(trace_generator, (safe_div((safe_mult(13, keccak_row_ratio)), 2048)) + keccak_keccak_parse_to_diluted_final_reshaped_input_offset).
    let pow1263 = pow210
        * pow1262; // pow(trace_generator, (safe_div((safe_mult(7, keccak_row_ratio)), 1024)) + keccak_keccak_parse_to_diluted_final_reshaped_input_offset).
    let pow1264 = pow210
        * pow1263; // pow(trace_generator, (safe_div((safe_mult(15, keccak_row_ratio)), 2048)) + keccak_keccak_parse_to_diluted_final_reshaped_input_offset).
    let pow1265 = pow(
        trace_generator, keccak_keccak_parse_to_diluted_reshaped_intermediate_offset.into()
    );
    let pow1266 = pow452
        * pow1265; // pow(trace_generator, keccak_row_ratio + keccak_keccak_parse_to_diluted_reshaped_intermediate_offset).
    let pow1267 = pow452
        * pow1266; // pow(trace_generator, (safe_mult(2, keccak_row_ratio)) + keccak_keccak_parse_to_diluted_reshaped_intermediate_offset).
    let pow1268 = pow452
        * pow1267; // pow(trace_generator, (safe_mult(3, keccak_row_ratio)) + keccak_keccak_parse_to_diluted_reshaped_intermediate_offset).
    let pow1269 = pow452
        * pow1268; // pow(trace_generator, (safe_mult(4, keccak_row_ratio)) + keccak_keccak_parse_to_diluted_reshaped_intermediate_offset).
    let pow1270 = pow195
        * pow1265; // pow(trace_generator, (safe_div(keccak_row_ratio, 32768)) + keccak_keccak_parse_to_diluted_reshaped_intermediate_offset).
    let pow1271 = pow195
        * pow1270; // pow(trace_generator, (safe_div(keccak_row_ratio, 16384)) + keccak_keccak_parse_to_diluted_reshaped_intermediate_offset).
    let pow1272 = pow195
        * pow1271; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 32768)) + keccak_keccak_parse_to_diluted_reshaped_intermediate_offset).
    let pow1273 = pow195
        * pow1272; // pow(trace_generator, (safe_div(keccak_row_ratio, 8192)) + keccak_keccak_parse_to_diluted_reshaped_intermediate_offset).
    let pow1274 = pow195
        * pow1273; // pow(trace_generator, (safe_div((safe_mult(5, keccak_row_ratio)), 32768)) + keccak_keccak_parse_to_diluted_reshaped_intermediate_offset).
    let pow1275 = pow195
        * pow1274; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 16384)) + keccak_keccak_parse_to_diluted_reshaped_intermediate_offset).
    let pow1276 = pow195
        * pow1275; // pow(trace_generator, (safe_div((safe_mult(7, keccak_row_ratio)), 32768)) + keccak_keccak_parse_to_diluted_reshaped_intermediate_offset).
    let pow1277 = pow195
        * pow1276; // pow(trace_generator, (safe_div(keccak_row_ratio, 4096)) + keccak_keccak_parse_to_diluted_reshaped_intermediate_offset).
    let pow1278 = pow195
        * pow1277; // pow(trace_generator, (safe_div(keccak_row_ratio, 4096)) + (safe_div(keccak_row_ratio, 32768)) + keccak_keccak_parse_to_diluted_reshaped_intermediate_offset).
    let pow1279 = pow195
        * pow1278; // pow(trace_generator, (safe_div(keccak_row_ratio, 4096)) + (safe_div(keccak_row_ratio, 16384)) + keccak_keccak_parse_to_diluted_reshaped_intermediate_offset).
    let pow1280 = pow195
        * pow1279; // pow(trace_generator, (safe_div(keccak_row_ratio, 4096)) + (safe_div((safe_mult(3, keccak_row_ratio)), 32768)) + keccak_keccak_parse_to_diluted_reshaped_intermediate_offset).
    let pow1281 = pow195
        * pow1280; // pow(trace_generator, (safe_div(keccak_row_ratio, 4096)) + (safe_div(keccak_row_ratio, 8192)) + keccak_keccak_parse_to_diluted_reshaped_intermediate_offset).
    let pow1282 = pow195
        * pow1281; // pow(trace_generator, (safe_div(keccak_row_ratio, 4096)) + (safe_div((safe_mult(5, keccak_row_ratio)), 32768)) + keccak_keccak_parse_to_diluted_reshaped_intermediate_offset).
    let pow1283 = pow195
        * pow1282; // pow(trace_generator, (safe_div(keccak_row_ratio, 4096)) + (safe_div((safe_mult(3, keccak_row_ratio)), 16384)) + keccak_keccak_parse_to_diluted_reshaped_intermediate_offset).
    let pow1284 = pow195
        * pow1283; // pow(trace_generator, (safe_div(keccak_row_ratio, 4096)) + (safe_div((safe_mult(7, keccak_row_ratio)), 32768)) + keccak_keccak_parse_to_diluted_reshaped_intermediate_offset).
    let pow1285 = pow452
        * pow1269; // pow(trace_generator, (safe_mult(5, keccak_row_ratio)) + keccak_keccak_parse_to_diluted_reshaped_intermediate_offset).
    let pow1286 = pow452
        * pow1285; // pow(trace_generator, (safe_mult(6, keccak_row_ratio)) + keccak_keccak_parse_to_diluted_reshaped_intermediate_offset).
    let pow1287 = pow452
        * pow1286; // pow(trace_generator, (safe_mult(7, keccak_row_ratio)) + keccak_keccak_parse_to_diluted_reshaped_intermediate_offset).
    let pow1288 = pow452
        * pow1287; // pow(trace_generator, (safe_mult(8, keccak_row_ratio)) + keccak_keccak_parse_to_diluted_reshaped_intermediate_offset).
    let pow1289 = pow452
        * pow1288; // pow(trace_generator, (safe_mult(9, keccak_row_ratio)) + keccak_keccak_parse_to_diluted_reshaped_intermediate_offset).
    let pow1290 = pow452
        * pow1289; // pow(trace_generator, (safe_mult(10, keccak_row_ratio)) + keccak_keccak_parse_to_diluted_reshaped_intermediate_offset).
    let pow1291 = pow452
        * pow1290; // pow(trace_generator, (safe_mult(11, keccak_row_ratio)) + keccak_keccak_parse_to_diluted_reshaped_intermediate_offset).
    let pow1292 = pow452
        * pow1291; // pow(trace_generator, (safe_mult(12, keccak_row_ratio)) + keccak_keccak_parse_to_diluted_reshaped_intermediate_offset).
    let pow1293 = pow452
        * pow1292; // pow(trace_generator, (safe_mult(13, keccak_row_ratio)) + keccak_keccak_parse_to_diluted_reshaped_intermediate_offset).
    let pow1294 = pow452
        * pow1293; // pow(trace_generator, (safe_mult(14, keccak_row_ratio)) + keccak_keccak_parse_to_diluted_reshaped_intermediate_offset).
    let pow1295 = pow452
        * pow1294; // pow(trace_generator, (safe_mult(15, keccak_row_ratio)) + keccak_keccak_parse_to_diluted_reshaped_intermediate_offset).
    let pow1296 = pow(trace_generator, ec_op_ec_subset_sum_x_diff_inv_offset.into());
    let pow1297 = pow(trace_generator, ec_op_ec_subset_sum_slope_offset.into());
    let pow1298 = pow(trace_generator, ec_op_ec_subset_sum_partial_sum_y_offset.into());
    let pow1299 = pow974
        * pow1298; // pow(trace_generator, (safe_div((safe_mult(255, ec_op_builtin_row_ratio)), 256)) + ec_op_ec_subset_sum_partial_sum_y_offset).
    let pow1300 = pow978
        * pow1298; // pow(trace_generator, (safe_div(ec_op_builtin_row_ratio, 256)) + ec_op_ec_subset_sum_partial_sum_y_offset).
    let pow1301 = pow(trace_generator, ec_op_ec_subset_sum_partial_sum_x_offset.into());
    let pow1302 = pow974
        * pow1301; // pow(trace_generator, (safe_div((safe_mult(255, ec_op_builtin_row_ratio)), 256)) + ec_op_ec_subset_sum_partial_sum_x_offset).
    let pow1303 = pow978
        * pow1301; // pow(trace_generator, (safe_div(ec_op_builtin_row_ratio, 256)) + ec_op_ec_subset_sum_partial_sum_x_offset).
    let pow1304 = pow(
        trace_generator, ec_op_ec_subset_sum_bit_unpacking_prod_ones196_offset.into()
    );
    let pow1305 = pow(trace_generator, ec_op_ec_subset_sum_selector_offset.into());
    let pow1306 = pow978
        * pow1305; // pow(trace_generator, (safe_div(ec_op_builtin_row_ratio, 256)) + ec_op_ec_subset_sum_selector_offset).
    let pow1307 = pow975
        * pow1305; // pow(trace_generator, (safe_div((safe_mult(251, ec_op_builtin_row_ratio)), 256)) + ec_op_ec_subset_sum_selector_offset).
    let pow1308 = pow975
        * pow1306; // pow(trace_generator, (safe_div((safe_mult(63, ec_op_builtin_row_ratio)), 64)) + ec_op_ec_subset_sum_selector_offset).
    let pow1309 = pow976
        * pow1305; // pow(trace_generator, (safe_div((safe_mult(49, ec_op_builtin_row_ratio)), 64)) + ec_op_ec_subset_sum_selector_offset).
    let pow1310 = pow976
        * pow1306; // pow(trace_generator, (safe_div((safe_mult(197, ec_op_builtin_row_ratio)), 256)) + ec_op_ec_subset_sum_selector_offset).
    let pow1311 = pow977
        * pow1305; // pow(trace_generator, (safe_div((safe_mult(3, ec_op_builtin_row_ratio)), 4)) + ec_op_ec_subset_sum_selector_offset).
    let pow1312 = pow977
        * pow1306; // pow(trace_generator, (safe_div((safe_mult(193, ec_op_builtin_row_ratio)), 256)) + ec_op_ec_subset_sum_selector_offset).
    let pow1313 = pow(
        trace_generator, ec_op_ec_subset_sum_bit_unpacking_prod_ones192_offset.into()
    );
    let pow1314 = pow(trace_generator, ec_op_doubled_points_y_offset.into());
    let pow1315 = pow978
        * pow1314; // pow(trace_generator, (safe_div(ec_op_builtin_row_ratio, 256)) + ec_op_doubled_points_y_offset).
    let pow1316 = pow(trace_generator, ec_op_doubled_points_x_offset.into());
    let pow1317 = pow978
        * pow1316; // pow(trace_generator, (safe_div(ec_op_builtin_row_ratio, 256)) + ec_op_doubled_points_x_offset).
    let pow1318 = pow(trace_generator, ec_op_doubling_slope_offset.into());
    let pow1319 = pow(trace_generator, ecdsa_signature0_q_x_squared_offset.into());
    let pow1320 = pow(trace_generator, ecdsa_signature0_r_w_inv_offset.into());
    let pow1321 = pow(trace_generator, ecdsa_signature0_z_inv_offset.into());
    let pow1322 = pow(trace_generator, ecdsa_signature0_extract_r_inv_offset.into());
    let pow1323 = pow(trace_generator, ecdsa_signature0_extract_r_slope_offset.into());
    let pow1324 = pow(trace_generator, ecdsa_signature0_add_results_inv_offset.into());
    let pow1325 = pow(trace_generator, ecdsa_signature0_add_results_slope_offset.into());
    let pow1326 = pow(trace_generator, ecdsa_signature0_exponentiate_key_x_diff_inv_offset.into());
    let pow1327 = pow(trace_generator, ecdsa_signature0_exponentiate_key_slope_offset.into());
    let pow1328 = pow(
        trace_generator, ecdsa_signature0_exponentiate_key_partial_sum_y_offset.into()
    );
    let pow1329 = pow1032
        * pow1328; // pow(trace_generator, (safe_div(ecdsa_builtin_row_ratio, 512)) + ecdsa_signature0_exponentiate_key_partial_sum_y_offset).
    let pow1330 = pow1030
        * pow1328; // pow(trace_generator, (safe_div((safe_mult(255, ecdsa_builtin_row_ratio)), 512)) + ecdsa_signature0_exponentiate_key_partial_sum_y_offset).
    let pow1331 = pow1031
        * pow1329; // pow(trace_generator, (safe_div(ecdsa_builtin_row_ratio, 2)) + (safe_div((safe_mult(255, ecdsa_builtin_row_ratio)), 512)) + ecdsa_signature0_exponentiate_key_partial_sum_y_offset).
    let pow1332 = pow(
        trace_generator, ecdsa_signature0_exponentiate_key_partial_sum_x_offset.into()
    );
    let pow1333 = pow1032
        * pow1332; // pow(trace_generator, (safe_div(ecdsa_builtin_row_ratio, 512)) + ecdsa_signature0_exponentiate_key_partial_sum_x_offset).
    let pow1334 = pow1030
        * pow1332; // pow(trace_generator, (safe_div((safe_mult(255, ecdsa_builtin_row_ratio)), 512)) + ecdsa_signature0_exponentiate_key_partial_sum_x_offset).
    let pow1335 = pow1031
        * pow1333; // pow(trace_generator, (safe_div(ecdsa_builtin_row_ratio, 2)) + (safe_div((safe_mult(255, ecdsa_builtin_row_ratio)), 512)) + ecdsa_signature0_exponentiate_key_partial_sum_x_offset).
    let pow1336 = pow(trace_generator, ecdsa_signature0_exponentiate_key_selector_offset.into());
    let pow1337 = pow1032
        * pow1336; // pow(trace_generator, (safe_div(ecdsa_builtin_row_ratio, 512)) + ecdsa_signature0_exponentiate_key_selector_offset).
    let pow1338 = pow(
        trace_generator, ecdsa_signature0_exponentiate_generator_x_diff_inv_offset.into()
    );
    let pow1339 = pow(trace_generator, ecdsa_signature0_exponentiate_generator_slope_offset.into());
    let pow1340 = pow(
        trace_generator, ecdsa_signature0_exponentiate_generator_partial_sum_y_offset.into()
    );
    let pow1341 = pow1035
        * pow1340; // pow(trace_generator, (safe_div(ecdsa_builtin_row_ratio, 256)) + ecdsa_signature0_exponentiate_generator_partial_sum_y_offset).
    let pow1342 = pow1031
        * pow1340; // pow(trace_generator, (safe_div((safe_mult(255, ecdsa_builtin_row_ratio)), 256)) + ecdsa_signature0_exponentiate_generator_partial_sum_y_offset).
    let pow1343 = pow(
        trace_generator, ecdsa_signature0_exponentiate_generator_partial_sum_x_offset.into()
    );
    let pow1344 = pow1035
        * pow1343; // pow(trace_generator, (safe_div(ecdsa_builtin_row_ratio, 256)) + ecdsa_signature0_exponentiate_generator_partial_sum_x_offset).
    let pow1345 = pow1031
        * pow1343; // pow(trace_generator, (safe_div((safe_mult(255, ecdsa_builtin_row_ratio)), 256)) + ecdsa_signature0_exponentiate_generator_partial_sum_x_offset).
    let pow1346 = pow(
        trace_generator, ecdsa_signature0_exponentiate_generator_selector_offset.into()
    );
    let pow1347 = pow1035
        * pow1346; // pow(trace_generator, (safe_div(ecdsa_builtin_row_ratio, 256)) + ecdsa_signature0_exponentiate_generator_selector_offset).
    let pow1348 = pow(trace_generator, ecdsa_signature0_doubling_slope_offset.into());
    let pow1349 = pow(trace_generator, ecdsa_signature0_key_points_y_offset.into());
    let pow1350 = pow1032
        * pow1349; // pow(trace_generator, (safe_div(ecdsa_builtin_row_ratio, 512)) + ecdsa_signature0_key_points_y_offset).
    let pow1351 = pow1030
        * pow1350; // pow(trace_generator, (safe_div(ecdsa_builtin_row_ratio, 2)) + ecdsa_signature0_key_points_y_offset).
    let pow1352 = pow(trace_generator, ecdsa_signature0_key_points_x_offset.into());
    let pow1353 = pow1032
        * pow1352; // pow(trace_generator, (safe_div(ecdsa_builtin_row_ratio, 512)) + ecdsa_signature0_key_points_x_offset).
    let pow1354 = pow1030
        * pow1353; // pow(trace_generator, (safe_div(ecdsa_builtin_row_ratio, 2)) + ecdsa_signature0_key_points_x_offset).
    let pow1355 = pow(trace_generator, pedersen_hash0_ec_subset_sum_slope_offset.into());
    let pow1356 = pow(trace_generator, pedersen_hash0_ec_subset_sum_partial_sum_y_offset.into());
    let pow1357 = pow1051
        * pow1356; // pow(trace_generator, (safe_div((safe_mult(255, pedersen_builtin_row_ratio)), 512)) + pedersen_hash0_ec_subset_sum_partial_sum_y_offset).
    let pow1358 = pow1055
        * pow1356; // pow(trace_generator, (safe_div(pedersen_builtin_row_ratio, 512)) + pedersen_hash0_ec_subset_sum_partial_sum_y_offset).
    let pow1359 = pow1051
        * pow1358; // pow(trace_generator, (safe_div(pedersen_builtin_row_ratio, 2)) + pedersen_hash0_ec_subset_sum_partial_sum_y_offset).
    let pow1360 = pow(trace_generator, pedersen_hash0_ec_subset_sum_partial_sum_x_offset.into());
    let pow1361 = pow1051
        * pow1360; // pow(trace_generator, (safe_div((safe_mult(255, pedersen_builtin_row_ratio)), 512)) + pedersen_hash0_ec_subset_sum_partial_sum_x_offset).
    let pow1362 = pow1055
        * pow1360; // pow(trace_generator, (safe_div(pedersen_builtin_row_ratio, 512)) + pedersen_hash0_ec_subset_sum_partial_sum_x_offset).
    let pow1363 = pow1051
        * pow1362; // pow(trace_generator, (safe_div(pedersen_builtin_row_ratio, 2)) + pedersen_hash0_ec_subset_sum_partial_sum_x_offset).
    let pow1364 = pow1051
        * pow1363; // pow(trace_generator, (safe_div(pedersen_builtin_row_ratio, 2)) + (safe_div((safe_mult(255, pedersen_builtin_row_ratio)), 512)) + pedersen_hash0_ec_subset_sum_partial_sum_x_offset).
    let pow1365 = pow(
        trace_generator, pedersen_hash0_ec_subset_sum_bit_unpacking_prod_ones196_offset.into()
    );
    let pow1366 = pow(trace_generator, pedersen_hash0_ec_subset_sum_selector_offset.into());
    let pow1367 = pow1052
        * pow1366; // pow(trace_generator, (safe_div((safe_mult(251, pedersen_builtin_row_ratio)), 512)) + pedersen_hash0_ec_subset_sum_selector_offset).
    let pow1368 = pow1053
        * pow1366; // pow(trace_generator, (safe_div((safe_mult(49, pedersen_builtin_row_ratio)), 128)) + pedersen_hash0_ec_subset_sum_selector_offset).
    let pow1369 = pow1054
        * pow1366; // pow(trace_generator, (safe_div((safe_mult(3, pedersen_builtin_row_ratio)), 8)) + pedersen_hash0_ec_subset_sum_selector_offset).
    let pow1370 = pow1055
        * pow1366; // pow(trace_generator, (safe_div(pedersen_builtin_row_ratio, 512)) + pedersen_hash0_ec_subset_sum_selector_offset).
    let pow1371 = pow1053
        * pow1370; // pow(trace_generator, (safe_div((safe_mult(197, pedersen_builtin_row_ratio)), 512)) + pedersen_hash0_ec_subset_sum_selector_offset).
    let pow1372 = pow1052
        * pow1370; // pow(trace_generator, (safe_div((safe_mult(63, pedersen_builtin_row_ratio)), 128)) + pedersen_hash0_ec_subset_sum_selector_offset).
    let pow1373 = pow1054
        * pow1370; // pow(trace_generator, (safe_div((safe_mult(193, pedersen_builtin_row_ratio)), 512)) + pedersen_hash0_ec_subset_sum_selector_offset).
    let pow1374 = pow1051
        * pow1370; // pow(trace_generator, (safe_div(pedersen_builtin_row_ratio, 2)) + pedersen_hash0_ec_subset_sum_selector_offset).
    let pow1375 = pow(
        trace_generator, pedersen_hash0_ec_subset_sum_bit_unpacking_prod_ones192_offset.into()
    );
    let pow1376 = pow(trace_generator, diluted_pool_offset.into());
    let pow1377 = pow191
        * pow1376; // pow(trace_generator, (safe_mult(keccak_keccak_diluted_column2_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1378 = pow249
        * pow1377; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column2_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1379 = pow235
        * pow1378; // pow(trace_generator, (safe_div(keccak_row_ratio, 32)) + (safe_mult(keccak_keccak_diluted_column2_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1380 = pow192
        * pow1376; // pow(trace_generator, (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1381 = pow249
        * pow1380; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1382 = pow235
        * pow1381; // pow(trace_generator, (safe_div(keccak_row_ratio, 32)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1383 = pow193
        * pow1376; // pow(trace_generator, (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1384 = pow228
        * pow1383; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1385 = pow220
        * pow1384; // pow(trace_generator, (safe_div(keccak_row_ratio, 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1386 = pow228
        * pow1385; // pow(trace_generator, (safe_div((safe_mult(7, keccak_row_ratio)), 512)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1387 = pow220
        * pow1386; // pow(trace_generator, (safe_div(keccak_row_ratio, 64)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1388 = pow228
        * pow1387; // pow(trace_generator, (safe_div((safe_mult(11, keccak_row_ratio)), 512)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1389 = pow220
        * pow1388; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1390 = pow228
        * pow1389; // pow(trace_generator, (safe_div((safe_mult(15, keccak_row_ratio)), 512)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1391 = pow220
        * pow1390; // pow(trace_generator, (safe_div(keccak_row_ratio, 32)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1392 = pow228
        * pow1391; // pow(trace_generator, (safe_div((safe_mult(19, keccak_row_ratio)), 512)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1393 = pow220
        * pow1392; // pow(trace_generator, (safe_div((safe_mult(5, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1394 = pow228
        * pow1393; // pow(trace_generator, (safe_div((safe_mult(23, keccak_row_ratio)), 512)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1395 = pow220
        * pow1394; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 64)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1396 = pow228
        * pow1395; // pow(trace_generator, (safe_div((safe_mult(27, keccak_row_ratio)), 512)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1397 = pow220
        * pow1396; // pow(trace_generator, (safe_div((safe_mult(7, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1398 = pow228
        * pow1397; // pow(trace_generator, (safe_div((safe_mult(31, keccak_row_ratio)), 512)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1399 = pow760
        * pow1398; // pow(trace_generator, (safe_div((safe_mult(55, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1400 = pow220
        * pow1398; // pow(trace_generator, (safe_div(keccak_row_ratio, 16)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1401 = pow228
        * pow1400; // pow(trace_generator, (safe_div((safe_mult(35, keccak_row_ratio)), 512)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1402 = pow220
        * pow1401; // pow(trace_generator, (safe_div((safe_mult(9, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1403 = pow228
        * pow1402; // pow(trace_generator, (safe_div((safe_mult(39, keccak_row_ratio)), 512)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1404 = pow220
        * pow1403; // pow(trace_generator, (safe_div((safe_mult(5, keccak_row_ratio)), 64)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1405 = pow228
        * pow1404; // pow(trace_generator, (safe_div((safe_mult(43, keccak_row_ratio)), 512)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1406 = pow235
        * pow1399; // pow(trace_generator, (safe_div((safe_mult(55, keccak_row_ratio)), 4)) + (safe_div((safe_mult(7, keccak_row_ratio)), 512)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1407 = pow235
        * pow1406; // pow(trace_generator, (safe_div((safe_mult(55, keccak_row_ratio)), 4)) + (safe_div((safe_mult(11, keccak_row_ratio)), 512)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1408 = pow220
        * pow1405; // pow(trace_generator, (safe_div((safe_mult(11, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1409 = pow228
        * pow1408; // pow(trace_generator, (safe_div((safe_mult(47, keccak_row_ratio)), 512)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1410 = pow220
        * pow1409; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 32)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1411 = pow235
        * pow1410; // pow(trace_generator, (safe_div((safe_mult(13, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1412 = pow235
        * pow1411; // pow(trace_generator, (safe_div((safe_mult(7, keccak_row_ratio)), 64)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1413 = pow540
        * pow1412; // pow(trace_generator, (safe_div((safe_mult(9, keccak_row_ratio)), 2)) + (safe_div((safe_mult(7, keccak_row_ratio)), 64)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1414 = pow453
        * pow1408; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 2)) + (safe_div((safe_mult(11, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1415 = pow399
        * pow1414; // pow(trace_generator, (safe_mult(2, keccak_row_ratio)) + (safe_div((safe_mult(13, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1416 = pow235
        * pow1412; // pow(trace_generator, (safe_div((safe_mult(15, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1417 = pow235
        * pow1416; // pow(trace_generator, (safe_div(keccak_row_ratio, 8)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1418 = pow235
        * pow1417; // pow(trace_generator, (safe_div((safe_mult(17, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1419 = pow235
        * pow1418; // pow(trace_generator, (safe_div((safe_mult(9, keccak_row_ratio)), 64)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1420 = pow235
        * pow1419; // pow(trace_generator, (safe_div((safe_mult(19, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1421 = pow235
        * pow1420; // pow(trace_generator, (safe_div((safe_mult(5, keccak_row_ratio)), 32)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1422 = pow235
        * pow1421; // pow(trace_generator, (safe_div((safe_mult(21, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1423 = pow220
        * pow1422; // pow(trace_generator, (safe_div(keccak_row_ratio, 512)) + (safe_div((safe_mult(21, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1424 = pow220
        * pow1423; // pow(trace_generator, (safe_div(keccak_row_ratio, 256)) + (safe_div((safe_mult(21, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1425 = pow224
        * pow1424; // pow(trace_generator, (safe_div((safe_mult(11, keccak_row_ratio)), 64)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1426 = pow394
        * pow1413; // pow(trace_generator, (safe_mult(5, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 64)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1427 = pow557
        * pow1426; // pow(trace_generator, (safe_div((safe_mult(39, keccak_row_ratio)), 4)) + (safe_div((safe_mult(11, keccak_row_ratio)), 64)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1428 = pow220
        * pow1425; // pow(trace_generator, (safe_div(keccak_row_ratio, 512)) + (safe_div((safe_mult(11, keccak_row_ratio)), 64)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1429 = pow220
        * pow1427; // pow(trace_generator, (safe_div((safe_mult(39, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 512)) + (safe_div((safe_mult(11, keccak_row_ratio)), 64)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1430 = pow220
        * pow1428; // pow(trace_generator, (safe_div(keccak_row_ratio, 256)) + (safe_div((safe_mult(11, keccak_row_ratio)), 64)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1431 = pow224
        * pow1430; // pow(trace_generator, (safe_div((safe_mult(23, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1432 = pow220
        * pow1431; // pow(trace_generator, (safe_div(keccak_row_ratio, 512)) + (safe_div((safe_mult(23, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1433 = pow220
        * pow1432; // pow(trace_generator, (safe_div(keccak_row_ratio, 256)) + (safe_div((safe_mult(23, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1434 = pow224
        * pow1433; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 16)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1435 = pow220
        * pow1434; // pow(trace_generator, (safe_div(keccak_row_ratio, 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 16)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1436 = pow220
        * pow1435; // pow(trace_generator, (safe_div(keccak_row_ratio, 256)) + (safe_div((safe_mult(3, keccak_row_ratio)), 16)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1437 = pow224
        * pow1436; // pow(trace_generator, (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1438 = pow228
        * pow1437; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1439 = pow393
        * pow1438; // pow(trace_generator, (safe_div(keccak_row_ratio, 2)) + (safe_div((safe_mult(39, keccak_row_ratio)), 512)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1440 = pow607
        * pow1439; // pow(trace_generator, (safe_div((safe_mult(27, keccak_row_ratio)), 4)) + (safe_div((safe_mult(15, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1441 = pow228
        * pow1438; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1442 = pow228
        * pow1441; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1443 = pow228
        * pow1442; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1444 = pow228
        * pow1443; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1445 = pow228
        * pow1444; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1446 = pow228
        * pow1445; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1447 = pow228
        * pow1446; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1448 = pow235
        * pow1447; // pow(trace_generator, (safe_div(keccak_row_ratio, 4)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1449 = pow235
        * pow1448; // pow(trace_generator, (safe_div((safe_mult(33, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1450 = pow235
        * pow1449; // pow(trace_generator, (safe_div(keccak_row_ratio, 4)) + (safe_div(keccak_row_ratio, 64)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1451 = pow301
        * pow1439; // pow(trace_generator, (safe_div(keccak_row_ratio, 2)) + (safe_div((safe_mult(3, keccak_row_ratio)), 16)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1452 = pow220
        * pow1451; // pow(trace_generator, (safe_div(keccak_row_ratio, 2)) + (safe_div(keccak_row_ratio, 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 16)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1453 = pow604
        * pow1452; // pow(trace_generator, (safe_div((safe_mult(27, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1454 = pow220
        * pow1452; // pow(trace_generator, (safe_div(keccak_row_ratio, 2)) + (safe_div(keccak_row_ratio, 256)) + (safe_div((safe_mult(3, keccak_row_ratio)), 16)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1455 = pow277
        * pow1450; // pow(trace_generator, (safe_div(keccak_row_ratio, 4)) + (safe_div((safe_mult(5, keccak_row_ratio)), 64)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1456 = pow759
        * pow1455; // pow(trace_generator, (safe_div((safe_mult(55, keccak_row_ratio)), 4)) + (safe_div((safe_mult(21, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1457 = pow220
        * pow1456; // pow(trace_generator, (safe_div((safe_mult(55, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 512)) + (safe_div((safe_mult(21, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1458 = pow235
        * pow1439; // pow(trace_generator, (safe_div(keccak_row_ratio, 2)) + (safe_div((safe_mult(43, keccak_row_ratio)), 512)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1459 = pow235
        * pow1458; // pow(trace_generator, (safe_div(keccak_row_ratio, 2)) + (safe_div((safe_mult(47, keccak_row_ratio)), 512)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1460 = pow573
        * pow1459; // pow(trace_generator, (safe_div((safe_mult(25, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 32)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1461 = pow274
        * pow1452; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 4)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1462 = pow350
        * pow1461; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1463 = pow305
        * pow1414; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 2)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1464 = pow235
        * pow1461; // pow(trace_generator, (safe_div((safe_mult(97, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1465 = pow235
        * pow1464; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 64)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1466 = pow264
        * pow1465; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 4)) + (safe_div((safe_mult(7, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1467 = pow317
        * pow1414; // pow(trace_generator, (safe_div((safe_mult(7, keccak_row_ratio)), 4)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1468 = pow514
        * pow1467; // pow(trace_generator, (safe_div((safe_mult(21, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1469 = pow323
        * pow1468; // pow(trace_generator, (safe_div((safe_mult(21, keccak_row_ratio)), 4)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1470 = pow581
        * pow1469; // pow(trace_generator, (safe_div((safe_mult(45, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 16)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1471 = pow235
        * pow1467; // pow(trace_generator, (safe_div((safe_mult(225, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1472 = pow419
        * pow1471; // pow(trace_generator, (safe_div((safe_mult(5, keccak_row_ratio)), 2)) + (safe_div((safe_mult(17, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1473 = pow616
        * pow1472; // pow(trace_generator, (safe_mult(9, keccak_row_ratio)) + (safe_div(keccak_row_ratio, 8)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1474 = pow292
        * pow1472; // pow(trace_generator, (safe_div((safe_mult(5, keccak_row_ratio)), 2)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1475 = pow220
        * pow1429; // pow(trace_generator, (safe_div((safe_mult(39, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 256)) + (safe_div((safe_mult(11, keccak_row_ratio)), 64)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1476 = pow220
        * pow1457; // pow(trace_generator, (safe_div((safe_mult(55, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 256)) + (safe_div((safe_mult(21, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1477 = pow235
        * pow1471; // pow(trace_generator, (safe_div((safe_mult(7, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 64)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1478 = pow466
        * pow1477; // pow(trace_generator, (safe_div((safe_mult(7, keccak_row_ratio)), 2)) + (safe_div(keccak_row_ratio, 32)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1479 = pow358
        * pow1478; // pow(trace_generator, (safe_div((safe_mult(15, keccak_row_ratio)), 4)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1480 = pow539
        * pow1479; // pow(trace_generator, (safe_div((safe_mult(31, keccak_row_ratio)), 4)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1481 = pow476
        * pow1480; // pow(trace_generator, (safe_div((safe_mult(39, keccak_row_ratio)), 4)) + (safe_div((safe_mult(15, keccak_row_ratio)), 512)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1482 = pow235
        * pow1479; // pow(trace_generator, (safe_div((safe_mult(481, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1483 = pow235
        * pow1480; // pow(trace_generator, (safe_div((safe_mult(993, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1484 = pow235
        * pow1481; // pow(trace_generator, (safe_div((safe_mult(39, keccak_row_ratio)), 4)) + (safe_div((safe_mult(19, keccak_row_ratio)), 512)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1485 = pow582
        * pow1484; // pow(trace_generator, (safe_div((safe_mult(31, keccak_row_ratio)), 2)) + (safe_div((safe_mult(5, keccak_row_ratio)), 32)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1486 = pow399
        * pow1484; // pow(trace_generator, (safe_div((safe_mult(41, keccak_row_ratio)), 4)) + (safe_div((safe_mult(27, keccak_row_ratio)), 512)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1487 = pow361
        * pow1479; // pow(trace_generator, (safe_div((safe_mult(15, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1488 = pow235
        * pow1482; // pow(trace_generator, (safe_div((safe_mult(15, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 64)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1489 = pow235
        * pow1483; // pow(trace_generator, (safe_div((safe_mult(31, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 64)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1490 = pow307
        * pow1488; // pow(trace_generator, (safe_div((safe_mult(15, keccak_row_ratio)), 4)) + (safe_div((safe_mult(9, keccak_row_ratio)), 64)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1491 = pow285
        * pow1453; // pow(trace_generator, (safe_mult(7, keccak_row_ratio)) + (safe_div((safe_mult(5, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1492 = pow295
        * pow1473; // pow(trace_generator, (safe_mult(9, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1493 = pow562
        * pow1492; // pow(trace_generator, (safe_mult(14, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1494 = pow291
        * pow1485; // pow(trace_generator, (safe_div((safe_mult(31, keccak_row_ratio)), 2)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1495 = pow235
        * pow1484; // pow(trace_generator, (safe_div((safe_mult(39, keccak_row_ratio)), 4)) + (safe_div((safe_mult(23, keccak_row_ratio)), 512)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1496 = pow235
        * pow1486; // pow(trace_generator, (safe_div((safe_mult(41, keccak_row_ratio)), 4)) + (safe_div((safe_mult(31, keccak_row_ratio)), 512)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1497 = pow235
        * pow1496; // pow(trace_generator, (safe_div((safe_mult(41, keccak_row_ratio)), 4)) + (safe_div((safe_mult(35, keccak_row_ratio)), 512)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1498 = pow301
        * pow1497; // pow(trace_generator, (safe_div((safe_mult(41, keccak_row_ratio)), 4)) + (safe_div((safe_mult(23, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1499 = pow220
        * pow1498; // pow(trace_generator, (safe_div((safe_mult(41, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 512)) + (safe_div((safe_mult(23, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1500 = pow220
        * pow1499; // pow(trace_generator, (safe_div((safe_mult(41, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 256)) + (safe_div((safe_mult(23, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1501 = pow361
        * pow1476; // pow(trace_generator, (safe_mult(14, keccak_row_ratio)) + (safe_div((safe_mult(19, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1502 = pow562
        * pow1486; // pow(trace_generator, (safe_div((safe_mult(61, keccak_row_ratio)), 4)) + (safe_div((safe_mult(9, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1503 = pow509
        * pow1489; // pow(trace_generator, (safe_div((safe_mult(43, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 64)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1504 = pow363
        * pow1503; // pow(trace_generator, (safe_mult(11, keccak_row_ratio)) + (safe_div(keccak_row_ratio, 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1505 = pow235
        * pow1494; // pow(trace_generator, (safe_div((safe_mult(63, keccak_row_ratio)), 4)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1506 = pow235
        * pow1505; // pow(trace_generator, (safe_div((safe_mult(2017, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1507 = pow235
        * pow1506; // pow(trace_generator, (safe_div((safe_mult(63, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 64)) + (safe_mult(keccak_keccak_diluted_column3_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1508 = pow317
        * pow1379; // pow(trace_generator, (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column2_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1509 = pow469
        * pow1508; // pow(trace_generator, (safe_mult(2, keccak_row_ratio)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column2_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1510 = pow220
        * pow1508; // pow(trace_generator, (safe_div(keccak_row_ratio, 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column2_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1511 = pow220
        * pow1510; // pow(trace_generator, (safe_div(keccak_row_ratio, 256)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column2_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1512 = pow317
        * pow1382; // pow(trace_generator, (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1513 = pow228
        * pow1512; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1514 = pow220
        * pow1513; // pow(trace_generator, (safe_div(keccak_row_ratio, 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1515 = pow220
        * pow1514; // pow(trace_generator, (safe_div(keccak_row_ratio, 256)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1516 = pow220
        * pow1515; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1517 = pow396
        * pow1512; // pow(trace_generator, (safe_div(keccak_row_ratio, 2)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1518 = pow228
        * pow1516; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1519 = pow228
        * pow1518; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1520 = pow228
        * pow1519; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1521 = pow228
        * pow1520; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1522 = pow228
        * pow1521; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1523 = pow228
        * pow1522; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1524 = pow235
        * pow1523; // pow(trace_generator, (safe_div(keccak_row_ratio, 4)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1525 = pow273
        * pow1517; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 4)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1526 = pow341
        * pow1525; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 4)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1527 = pow598
        * pow1526; // pow(trace_generator, (safe_mult(7, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1528 = pow560
        * pow1526; // pow(trace_generator, (safe_div((safe_mult(23, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1529 = pow220
        * pow1528; // pow(trace_generator, (safe_div((safe_mult(2945, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1530 = pow220
        * pow1529; // pow(trace_generator, (safe_div((safe_mult(1473, keccak_row_ratio)), 256)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1531 = pow254
        * pow1527; // pow(trace_generator, (safe_mult(7, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1532 = pow417
        * pow1526; // pow(trace_generator, (safe_div((safe_mult(7, keccak_row_ratio)), 4)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1533 = pow469
        * pow1532; // pow(trace_generator, (safe_div((safe_mult(15, keccak_row_ratio)), 4)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1534 = pow539
        * pow1533; // pow(trace_generator, (safe_div((safe_mult(31, keccak_row_ratio)), 4)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1535 = pow636
        * pow1534; // pow(trace_generator, (safe_div((safe_mult(63, keccak_row_ratio)), 4)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1536 = pow540
        * pow1526; // pow(trace_generator, (safe_div((safe_mult(21, keccak_row_ratio)), 4)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1537 = pow616
        * pow1529; // pow(trace_generator, (safe_div((safe_mult(49, keccak_row_ratio)), 4)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1538 = pow341
        * pow1535; // pow(trace_generator, (safe_div((safe_mult(63, keccak_row_ratio)), 4)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1539 = pow486
        * pow1537; // pow(trace_generator, (safe_div((safe_mult(29, keccak_row_ratio)), 2)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1540 = pow540
        * pow1527; // pow(trace_generator, (safe_div((safe_mult(23, keccak_row_ratio)), 2)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1541 = pow412
        * pow1539; // pow(trace_generator, (safe_div((safe_mult(61, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1542 = pow228
        * pow1538; // pow(trace_generator, (safe_div((safe_mult(63, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1543 = pow469
        * pow1523; // pow(trace_generator, (safe_mult(2, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1544 = pow260
        * pow1541; // pow(trace_generator, (safe_div((safe_mult(61, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1545 = pow576
        * pow1528; // pow(trace_generator, (safe_mult(11, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column1_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1546 = pow220
        * pow1511; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column2_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1547 = pow228
        * pow1546; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column2_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1548 = pow228
        * pow1547; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column2_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1549 = pow228
        * pow1548; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column2_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1550 = pow228
        * pow1549; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column2_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1551 = pow228
        * pow1550; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column2_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1552 = pow559
        * pow1551; // pow(trace_generator, (safe_mult(5, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column2_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1553 = pow228
        * pow1551; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column2_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1554 = pow228
        * pow1553; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column2_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1555 = pow235
        * pow1554; // pow(trace_generator, (safe_div(keccak_row_ratio, 4)) + (safe_mult(keccak_keccak_diluted_column2_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1556 = pow396
        * pow1555; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 4)) + (safe_mult(keccak_keccak_diluted_column2_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1557 = pow452
        * pow1556; // pow(trace_generator, (safe_div((safe_mult(7, keccak_row_ratio)), 4)) + (safe_mult(keccak_keccak_diluted_column2_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1558 = pow364
        * pow1509; // pow(trace_generator, (safe_div((safe_mult(9, keccak_row_ratio)), 4)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column2_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1559 = pow220
        * pow1558; // pow(trace_generator, (safe_div((safe_mult(1153, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column2_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1560 = pow220
        * pow1559; // pow(trace_generator, (safe_div((safe_mult(577, keccak_row_ratio)), 256)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column2_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1561 = pow469
        * pow1557; // pow(trace_generator, (safe_div((safe_mult(15, keccak_row_ratio)), 4)) + (safe_mult(keccak_keccak_diluted_column2_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1562 = pow578
        * pow1561; // pow(trace_generator, (safe_mult(9, keccak_row_ratio)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column2_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1563 = pow539
        * pow1561; // pow(trace_generator, (safe_div((safe_mult(31, keccak_row_ratio)), 4)) + (safe_mult(keccak_keccak_diluted_column2_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1564 = pow410
        * pow1562; // pow(trace_generator, (safe_div((safe_mult(39, keccak_row_ratio)), 4)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column2_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1565 = pow452
        * pow1564; // pow(trace_generator, (safe_div((safe_mult(43, keccak_row_ratio)), 4)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column2_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1566 = pow540
        * pow1554; // pow(trace_generator, (safe_div((safe_mult(9, keccak_row_ratio)), 2)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column2_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1567 = pow636
        * pow1563; // pow(trace_generator, (safe_div((safe_mult(63, keccak_row_ratio)), 4)) + (safe_mult(keccak_keccak_diluted_column2_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1568 = pow341
        * pow1567; // pow(trace_generator, (safe_div((safe_mult(63, keccak_row_ratio)), 4)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column2_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1569 = pow254
        * pow1565; // pow(trace_generator, (safe_div((safe_mult(43, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column2_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1570 = pow362
        * pow1555; // pow(trace_generator, (safe_div(keccak_row_ratio, 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column2_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1571 = pow194
        * pow1376; // pow(trace_generator, (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1572 = pow228
        * pow1571; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1573 = pow202
        * pow1571; // pow(trace_generator, (safe_div(keccak_row_ratio, 4096)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1574 = pow220
        * pow1572; // pow(trace_generator, (safe_div(keccak_row_ratio, 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1575 = pow235
        * pow1574; // pow(trace_generator, (safe_div(keccak_row_ratio, 64)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1576 = pow235
        * pow1575; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1577 = pow638
        * pow1576; // pow(trace_generator, (safe_mult(9, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1578 = pow202
        * pow1576; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 128)) + (safe_div(keccak_row_ratio, 4096)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1579 = pow234
        * pow1578; // pow(trace_generator, (safe_div(keccak_row_ratio, 32)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1580 = pow202
        * pow1579; // pow(trace_generator, (safe_div(keccak_row_ratio, 32)) + (safe_div(keccak_row_ratio, 4096)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1581 = pow234
        * pow1580; // pow(trace_generator, (safe_div((safe_mult(5, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1582 = pow235
        * pow1581; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 64)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1583 = pow235
        * pow1582; // pow(trace_generator, (safe_div((safe_mult(7, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1584 = pow235
        * pow1583; // pow(trace_generator, (safe_div(keccak_row_ratio, 16)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1585 = pow220
        * pow1584; // pow(trace_generator, (safe_div(keccak_row_ratio, 512)) + (safe_div(keccak_row_ratio, 16)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1586 = pow220
        * pow1585; // pow(trace_generator, (safe_div(keccak_row_ratio, 256)) + (safe_div(keccak_row_ratio, 16)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1587 = pow224
        * pow1586; // pow(trace_generator, (safe_div((safe_mult(9, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1588 = pow235
        * pow1587; // pow(trace_generator, (safe_div((safe_mult(5, keccak_row_ratio)), 64)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1589 = pow780
        * pow1588; // pow(trace_generator, (safe_div((safe_mult(61, keccak_row_ratio)), 4)) + (safe_div((safe_mult(5, keccak_row_ratio)), 64)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1590 = pow235
        * pow1588; // pow(trace_generator, (safe_div((safe_mult(11, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1591 = pow235
        * pow1590; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 32)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1592 = pow235
        * pow1591; // pow(trace_generator, (safe_div((safe_mult(13, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1593 = pow235
        * pow1592; // pow(trace_generator, (safe_div((safe_mult(7, keccak_row_ratio)), 64)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1594 = pow220
        * pow1593; // pow(trace_generator, (safe_div(keccak_row_ratio, 512)) + (safe_div((safe_mult(7, keccak_row_ratio)), 64)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1595 = pow220
        * pow1594; // pow(trace_generator, (safe_div(keccak_row_ratio, 256)) + (safe_div((safe_mult(7, keccak_row_ratio)), 64)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1596 = pow224
        * pow1595; // pow(trace_generator, (safe_div((safe_mult(15, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1597 = pow220
        * pow1596; // pow(trace_generator, (safe_div(keccak_row_ratio, 512)) + (safe_div((safe_mult(15, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1598 = pow220
        * pow1597; // pow(trace_generator, (safe_div(keccak_row_ratio, 256)) + (safe_div((safe_mult(15, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1599 = pow224
        * pow1598; // pow(trace_generator, (safe_div(keccak_row_ratio, 8)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1600 = pow235
        * pow1599; // pow(trace_generator, (safe_div((safe_mult(17, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1601 = pow235
        * pow1600; // pow(trace_generator, (safe_div((safe_mult(9, keccak_row_ratio)), 64)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1602 = pow235
        * pow1601; // pow(trace_generator, (safe_div((safe_mult(19, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1603 = pow554
        * pow1600; // pow(trace_generator, (safe_div((safe_mult(19, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 8)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1604 = pow235
        * pow1602; // pow(trace_generator, (safe_div((safe_mult(5, keccak_row_ratio)), 32)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1605 = pow235
        * pow1604; // pow(trace_generator, (safe_div((safe_mult(21, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1606 = pow220
        * pow1605; // pow(trace_generator, (safe_div(keccak_row_ratio, 512)) + (safe_div((safe_mult(21, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1607 = pow220
        * pow1606; // pow(trace_generator, (safe_div(keccak_row_ratio, 256)) + (safe_div((safe_mult(21, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1608 = pow224
        * pow1607; // pow(trace_generator, (safe_div((safe_mult(11, keccak_row_ratio)), 64)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1609 = pow235
        * pow1608; // pow(trace_generator, (safe_div((safe_mult(23, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1610 = pow469
        * pow1609; // pow(trace_generator, (safe_mult(2, keccak_row_ratio)) + (safe_div((safe_mult(23, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1611 = pow309
        * pow1610; // pow(trace_generator, (safe_div((safe_mult(9, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 16)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1612 = pow734
        * pow1611; // pow(trace_generator, (safe_div((safe_mult(27, keccak_row_ratio)), 2)) + (safe_div((safe_mult(11, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1613 = pow549
        * pow1611; // pow(trace_generator, (safe_div((safe_mult(25, keccak_row_ratio)), 4)) + (safe_div((safe_mult(7, keccak_row_ratio)), 64)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1614 = pow235
        * pow1609; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 16)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1615 = pow235
        * pow1614; // pow(trace_generator, (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1616 = pow299
        * pow1612; // pow(trace_generator, (safe_div((safe_mult(27, keccak_row_ratio)), 2)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1617 = pow220
        * pow1615; // pow(trace_generator, (safe_div(keccak_row_ratio, 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1618 = pow220
        * pow1617; // pow(trace_generator, (safe_div(keccak_row_ratio, 256)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1619 = pow220
        * pow1618; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1620 = pow220
        * pow1619; // pow(trace_generator, (safe_div(keccak_row_ratio, 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1621 = pow220
        * pow1620; // pow(trace_generator, (safe_div(keccak_row_ratio, 256)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1622 = pow220
        * pow1621; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1623 = pow283
        * pow1603; // pow(trace_generator, (safe_div((safe_mult(19, keccak_row_ratio)), 4)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1624 = pow297
        * pow1623; // pow(trace_generator, (safe_mult(5, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 64)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1625 = pow313
        * pow1624; // pow(trace_generator, (safe_mult(5, keccak_row_ratio)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1626 = pow313
        * pow1625; // pow(trace_generator, (safe_div((safe_mult(21, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 32)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1627 = pow228
        * pow1622; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1628 = pow228
        * pow1627; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1629 = pow228
        * pow1628; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1630 = pow261
        * pow1628; // pow(trace_generator, (safe_div(keccak_row_ratio, 4)) + (safe_div(keccak_row_ratio, 4096)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1631 = pow396
        * pow1630; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 4096)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1632 = pow452
        * pow1631; // pow(trace_generator, (safe_div((safe_mult(7, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 4096)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1633 = pow469
        * pow1632; // pow(trace_generator, (safe_div((safe_mult(15, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 4096)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1634 = pow539
        * pow1633; // pow(trace_generator, (safe_div((safe_mult(31, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 4096)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1635 = pow228
        * pow1629; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1636 = pow408
        * pow1635; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 4)) + (safe_div((safe_mult(11, keccak_row_ratio)), 64)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1637 = pow420
        * pow1623; // pow(trace_generator, (safe_div((safe_mult(23, keccak_row_ratio)), 4)) + (safe_div((safe_mult(15, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1638 = pow220
        * pow1637; // pow(trace_generator, (safe_div((safe_mult(2945, keccak_row_ratio)), 512)) + (safe_div((safe_mult(15, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1639 = pow292
        * pow1613; // pow(trace_generator, (safe_div((safe_mult(25, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1640 = pow509
        * pow1639; // pow(trace_generator, (safe_div((safe_mult(37, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1641 = pow460
        * pow1640; // pow(trace_generator, (safe_mult(11, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1642 = pow673
        * pow1638; // pow(trace_generator, (safe_div((safe_mult(31, keccak_row_ratio)), 2)) + (safe_div((safe_mult(21, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1643 = pow510
        * pow1635; // pow(trace_generator, (safe_div((safe_mult(7, keccak_row_ratio)), 2)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1644 = pow220
        * pow1611; // pow(trace_generator, (safe_div((safe_mult(1153, keccak_row_ratio)), 512)) + (safe_div(keccak_row_ratio, 16)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1645 = pow228
        * pow1635; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1646 = pow378
        * pow1641; // pow(trace_generator, (safe_div((safe_mult(45, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1647 = pow228
        * pow1645; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1648 = pow750
        * pow1647; // pow(trace_generator, (safe_div((safe_mult(25, keccak_row_ratio)), 2)) + (safe_div((safe_mult(3, keccak_row_ratio)), 16)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1649 = pow240
        * pow1648; // pow(trace_generator, (safe_div((safe_mult(25, keccak_row_ratio)), 2)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1650 = pow374
        * pow1647; // pow(trace_generator, (safe_div(keccak_row_ratio, 2)) + (safe_div(keccak_row_ratio, 64)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1651 = pow220
        * pow1644; // pow(trace_generator, (safe_div((safe_mult(577, keccak_row_ratio)), 256)) + (safe_div(keccak_row_ratio, 16)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1652 = pow220
        * pow1638; // pow(trace_generator, (safe_div((safe_mult(1473, keccak_row_ratio)), 256)) + (safe_div((safe_mult(15, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1653 = pow535
        * pow1652; // pow(trace_generator, (safe_div((safe_mult(39, keccak_row_ratio)), 4)) + (safe_div((safe_mult(13, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1654 = pow220
        * pow1642; // pow(trace_generator, (safe_div((safe_mult(7937, keccak_row_ratio)), 512)) + (safe_div((safe_mult(21, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1655 = pow220
        * pow1654; // pow(trace_generator, (safe_div((safe_mult(3969, keccak_row_ratio)), 256)) + (safe_div((safe_mult(21, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1656 = pow254
        * pow1654; // pow(trace_generator, (safe_div((safe_mult(31, keccak_row_ratio)), 2)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1657 = pow220
        * pow1656; // pow(trace_generator, (safe_div((safe_mult(7937, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1658 = pow220
        * pow1657; // pow(trace_generator, (safe_div((safe_mult(3969, keccak_row_ratio)), 256)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1659 = pow220
        * pow1613; // pow(trace_generator, (safe_div((safe_mult(3201, keccak_row_ratio)), 512)) + (safe_div((safe_mult(7, keccak_row_ratio)), 64)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1660 = pow220
        * pow1639; // pow(trace_generator, (safe_div((safe_mult(3201, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1661 = pow220
        * pow1659; // pow(trace_generator, (safe_div((safe_mult(1601, keccak_row_ratio)), 256)) + (safe_div((safe_mult(7, keccak_row_ratio)), 64)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1662 = pow220
        * pow1660; // pow(trace_generator, (safe_div((safe_mult(1601, keccak_row_ratio)), 256)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1663 = pow403
        * pow1662; // pow(trace_generator, (safe_mult(7, keccak_row_ratio)) + (safe_div((safe_mult(5, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1664 = pow577
        * pow1663; // pow(trace_generator, (safe_div((safe_mult(49, keccak_row_ratio)), 4)) + (safe_div((safe_mult(17, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1665 = pow400
        * pow1612; // pow(trace_generator, (safe_mult(14, keccak_row_ratio)) + (safe_div((safe_mult(19, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1666 = pow270
        * pow1665; // pow(trace_generator, (safe_mult(14, keccak_row_ratio)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1667 = pow370
        * pow1577; // pow(trace_generator, (safe_div((safe_mult(37, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 32)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1668 = pow576
        * pow1667; // pow(trace_generator, (safe_div((safe_mult(29, keccak_row_ratio)), 2)) + (safe_div((safe_mult(7, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1669 = pow262
        * pow1662; // pow(trace_generator, (safe_div((safe_mult(25, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1670 = pow545
        * pow1659; // pow(trace_generator, (safe_div((safe_mult(43, keccak_row_ratio)), 4)) + (safe_div((safe_mult(9, keccak_row_ratio)), 64)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1671 = pow329
        * pow1670; // pow(trace_generator, (safe_mult(11, keccak_row_ratio)) + (safe_div((safe_mult(9, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1672 = pow416
        * pow1670; // pow(trace_generator, (safe_div((safe_mult(23, keccak_row_ratio)), 2)) + (safe_div((safe_mult(5, keccak_row_ratio)), 32)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1673 = pow270
        * pow1657; // pow(trace_generator, (safe_div((safe_mult(63, keccak_row_ratio)), 4)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1674 = pow228
        * pow1673; // pow(trace_generator, (safe_div((safe_mult(63, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1675 = pow202
        * pow1673; // pow(trace_generator, (safe_div((safe_mult(63, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 4096)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1676 = pow220
        * pow1674; // pow(trace_generator, (safe_div((safe_mult(63, keccak_row_ratio)), 4)) + (safe_div(keccak_row_ratio, 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1677 = pow335
        * pow1676; // pow(trace_generator, (safe_div((safe_mult(63, keccak_row_ratio)), 4)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1678 = pow228
        * pow1677; // pow(trace_generator, (safe_div((safe_mult(63, keccak_row_ratio)), 4)) + (safe_div((safe_mult(3, keccak_row_ratio)), 512)) + (safe_div((safe_mult(25, keccak_row_ratio)), 128)) + (safe_mult(keccak_keccak_diluted_column0_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1679 = pow991
        * pow1376; // pow(trace_generator, (safe_mult(bitwise_trim_unpacking195_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1680 = pow992
        * pow1376; // pow(trace_generator, (safe_mult(bitwise_trim_unpacking194_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1681 = pow993
        * pow1376; // pow(trace_generator, (safe_mult(bitwise_trim_unpacking193_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1682 = pow994
        * pow1376; // pow(trace_generator, (safe_mult(bitwise_trim_unpacking192_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1683 = pow995
        * pow1376; // pow(trace_generator, (safe_mult(bitwise_diluted_var_pool_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1684 = pow3
        * pow1683; // pow(trace_generator, (safe_div(bitwise_row_ratio, 64)) + (safe_mult(bitwise_diluted_var_pool_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1685 = pow3
        * pow1684; // pow(trace_generator, (safe_div(bitwise_row_ratio, 32)) + (safe_mult(bitwise_diluted_var_pool_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1686 = pow3
        * pow1685; // pow(trace_generator, (safe_div((safe_mult(3, bitwise_row_ratio)), 64)) + (safe_mult(bitwise_diluted_var_pool_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1687 = pow3
        * pow1686; // pow(trace_generator, (safe_div(bitwise_row_ratio, 16)) + (safe_mult(bitwise_diluted_var_pool_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1688 = pow3
        * pow1687; // pow(trace_generator, (safe_div((safe_mult(5, bitwise_row_ratio)), 64)) + (safe_mult(bitwise_diluted_var_pool_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1689 = pow3
        * pow1688; // pow(trace_generator, (safe_div((safe_mult(3, bitwise_row_ratio)), 32)) + (safe_mult(bitwise_diluted_var_pool_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1690 = pow3
        * pow1689; // pow(trace_generator, (safe_div((safe_mult(7, bitwise_row_ratio)), 64)) + (safe_mult(bitwise_diluted_var_pool_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1691 = pow3
        * pow1690; // pow(trace_generator, (safe_div(bitwise_row_ratio, 8)) + (safe_mult(bitwise_diluted_var_pool_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1692 = pow3
        * pow1691; // pow(trace_generator, (safe_div((safe_mult(9, bitwise_row_ratio)), 64)) + (safe_mult(bitwise_diluted_var_pool_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1693 = pow3
        * pow1692; // pow(trace_generator, (safe_div((safe_mult(5, bitwise_row_ratio)), 32)) + (safe_mult(bitwise_diluted_var_pool_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1694 = pow3
        * pow1693; // pow(trace_generator, (safe_div((safe_mult(11, bitwise_row_ratio)), 64)) + (safe_mult(bitwise_diluted_var_pool_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1695 = pow3
        * pow1694; // pow(trace_generator, (safe_div((safe_mult(3, bitwise_row_ratio)), 16)) + (safe_mult(bitwise_diluted_var_pool_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1696 = pow3
        * pow1695; // pow(trace_generator, (safe_div((safe_mult(13, bitwise_row_ratio)), 64)) + (safe_mult(bitwise_diluted_var_pool_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1697 = pow3
        * pow1696; // pow(trace_generator, (safe_div((safe_mult(7, bitwise_row_ratio)), 32)) + (safe_mult(bitwise_diluted_var_pool_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1698 = pow3
        * pow1697; // pow(trace_generator, (safe_div((safe_mult(15, bitwise_row_ratio)), 64)) + (safe_mult(bitwise_diluted_var_pool_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1699 = pow3
        * pow1698; // pow(trace_generator, (safe_div(bitwise_row_ratio, 4)) + (safe_mult(bitwise_diluted_var_pool_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1700 = pow18
        * pow1699; // pow(trace_generator, (safe_div(bitwise_row_ratio, 2)) + (safe_mult(bitwise_diluted_var_pool_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1701 = pow14
        * pow1700; // pow(trace_generator, (safe_div((safe_mult(3, bitwise_row_ratio)), 16)) + (safe_div(bitwise_row_ratio, 2)) + (safe_mult(bitwise_diluted_var_pool_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1702 = pow3
        * pow1701; // pow(trace_generator, (safe_div((safe_mult(13, bitwise_row_ratio)), 64)) + (safe_div(bitwise_row_ratio, 2)) + (safe_mult(bitwise_diluted_var_pool_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1703 = pow3
        * pow1702; // pow(trace_generator, (safe_div((safe_mult(7, bitwise_row_ratio)), 32)) + (safe_div(bitwise_row_ratio, 2)) + (safe_mult(bitwise_diluted_var_pool_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1704 = pow3
        * pow1703; // pow(trace_generator, (safe_div((safe_mult(15, bitwise_row_ratio)), 64)) + (safe_div(bitwise_row_ratio, 2)) + (safe_mult(bitwise_diluted_var_pool_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1705 = pow3
        * pow1704; // pow(trace_generator, (safe_div((safe_mult(3, bitwise_row_ratio)), 4)) + (safe_mult(bitwise_diluted_var_pool_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1706 = pow14
        * pow1705; // pow(trace_generator, (safe_div((safe_mult(3, bitwise_row_ratio)), 16)) + (safe_div((safe_mult(3, bitwise_row_ratio)), 4)) + (safe_mult(bitwise_diluted_var_pool_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1707 = pow3
        * pow1706; // pow(trace_generator, (safe_div((safe_mult(13, bitwise_row_ratio)), 64)) + (safe_div((safe_mult(3, bitwise_row_ratio)), 4)) + (safe_mult(bitwise_diluted_var_pool_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1708 = pow3
        * pow1707; // pow(trace_generator, (safe_div((safe_mult(7, bitwise_row_ratio)), 32)) + (safe_div((safe_mult(3, bitwise_row_ratio)), 4)) + (safe_mult(bitwise_diluted_var_pool_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1709 = pow3
        * pow1708; // pow(trace_generator, (safe_div((safe_mult(15, bitwise_row_ratio)), 64)) + (safe_div((safe_mult(3, bitwise_row_ratio)), 4)) + (safe_mult(bitwise_diluted_var_pool_suboffset, diluted_units_row_ratio)) + diluted_pool_offset).
    let pow1710 = pow1063
        * pow1376; // pow(trace_generator, diluted_units_row_ratio + diluted_pool_offset).
    let pow1711 = pow(trace_generator, diluted_check_permuted_values_offset.into());
    let pow1712 = pow1063
        * pow1711; // pow(trace_generator, diluted_units_row_ratio + diluted_check_permuted_values_offset).
    let pow1713 = pow(trace_generator, range_check16_pool_offset.into());
    let pow1714 = pow38
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_carry0_part6_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1715 = pow39
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_carry0_part5_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1716 = pow40
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_carry0_part4_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1717 = pow41
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_carry0_part3_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1718 = pow42
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_carry0_part2_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1719 = pow43
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_carry0_part1_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1720 = pow44
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_carry0_part0_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1721 = pow45
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_carry5_part6_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1722 = pow46
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_carry5_part5_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1723 = pow47
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_carry5_part4_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1724 = pow48
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_carry5_part3_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1725 = pow49
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_carry5_part2_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1726 = pow50
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_carry5_part1_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1727 = pow51
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_carry5_part0_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1728 = pow52
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_carry4_part6_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1729 = pow53
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_carry4_part5_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1730 = pow54
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_carry4_part4_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1731 = pow55
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_carry4_part3_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1732 = pow56
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_carry4_part2_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1733 = pow57
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_carry4_part1_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1734 = pow58
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_carry4_part0_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1735 = pow59
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_carry3_part6_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1736 = pow60
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_carry3_part5_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1737 = pow61
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_carry3_part4_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1738 = pow62
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_carry3_part3_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1739 = pow63
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_carry3_part2_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1740 = pow64
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_carry3_part1_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1741 = pow65
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_carry3_part0_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1742 = pow66
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_carry2_part6_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1743 = pow67
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_carry2_part5_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1744 = pow68
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_carry2_part4_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1745 = pow69
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_carry2_part3_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1746 = pow70
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_carry2_part2_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1747 = pow71
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_carry2_part1_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1748 = pow72
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_carry2_part0_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1749 = pow73
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_carry1_part6_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1750 = pow74
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_carry1_part5_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1751 = pow75
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_carry1_part4_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1752 = pow76
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_carry1_part3_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1753 = pow77
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_carry1_part2_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1754 = pow78
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_carry1_part1_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1755 = pow79
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_carry1_part0_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1756 = pow80
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_p_multiplier0_part5_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1757 = pow81
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_p_multiplier0_part4_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1758 = pow82
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_p_multiplier0_part3_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1759 = pow83
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_p_multiplier0_part2_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1760 = pow84
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_p_multiplier0_part1_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1761 = pow85
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_p_multiplier0_part0_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1762 = pow86
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_p_multiplier3_part5_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1763 = pow87
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_p_multiplier3_part4_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1764 = pow88
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_p_multiplier3_part3_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1765 = pow89
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_p_multiplier3_part2_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1766 = pow90
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_p_multiplier3_part1_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1767 = pow91
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_p_multiplier3_part0_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1768 = pow92
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_p_multiplier2_part5_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1769 = pow93
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_p_multiplier2_part4_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1770 = pow94
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_p_multiplier2_part3_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1771 = pow95
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_p_multiplier2_part2_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1772 = pow96
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_p_multiplier2_part1_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1773 = pow97
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_p_multiplier2_part0_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1774 = pow98
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_p_multiplier1_part5_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1775 = pow99
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_p_multiplier1_part4_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1776 = pow100
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_p_multiplier1_part3_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1777 = pow101
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_p_multiplier1_part2_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1778 = pow102
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_p_multiplier1_part1_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1779 = pow103
        * pow1713; // pow(trace_generator, (safe_mult(mul_mod_p_multiplier1_part0_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1780 = pow162
        * pow1713; // pow(trace_generator, (safe_mult(range_check96_builtin_inner_range_check5_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1781 = pow163
        * pow1713; // pow(trace_generator, (safe_mult(range_check96_builtin_inner_range_check4_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1782 = pow164
        * pow1713; // pow(trace_generator, (safe_mult(range_check96_builtin_inner_range_check3_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1783 = pow165
        * pow1713; // pow(trace_generator, (safe_mult(range_check96_builtin_inner_range_check2_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1784 = pow166
        * pow1713; // pow(trace_generator, (safe_mult(range_check96_builtin_inner_range_check1_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1785 = pow167
        * pow1713; // pow(trace_generator, (safe_mult(range_check96_builtin_inner_range_check0_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1786 = pow1038
        * pow1713; // pow(trace_generator, (safe_mult(range_check_builtin_inner_range_check_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1787 = pow30
        * pow1786; // pow(trace_generator, (safe_div(range_check_builtin_row_ratio, 8)) + (safe_mult(range_check_builtin_inner_range_check_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1788 = pow30
        * pow1787; // pow(trace_generator, (safe_div(range_check_builtin_row_ratio, 4)) + (safe_mult(range_check_builtin_inner_range_check_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1789 = pow30
        * pow1788; // pow(trace_generator, (safe_div((safe_mult(3, range_check_builtin_row_ratio)), 8)) + (safe_mult(range_check_builtin_inner_range_check_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1790 = pow30
        * pow1789; // pow(trace_generator, (safe_div(range_check_builtin_row_ratio, 2)) + (safe_mult(range_check_builtin_inner_range_check_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1791 = pow30
        * pow1790; // pow(trace_generator, (safe_div((safe_mult(5, range_check_builtin_row_ratio)), 8)) + (safe_mult(range_check_builtin_inner_range_check_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1792 = pow30
        * pow1791; // pow(trace_generator, (safe_div((safe_mult(3, range_check_builtin_row_ratio)), 4)) + (safe_mult(range_check_builtin_inner_range_check_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1793 = pow30
        * pow1792; // pow(trace_generator, (safe_div((safe_mult(7, range_check_builtin_row_ratio)), 8)) + (safe_mult(range_check_builtin_inner_range_check_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow1794 = pow1064
        * pow1713; // pow(trace_generator, range_check_units_row_ratio + range_check16_pool_offset).
    let pow1795 = pow(trace_generator, range_check16_sorted_offset.into());
    let pow1796 = pow1064
        * pow1795; // pow(trace_generator, range_check_units_row_ratio + range_check16_sorted_offset).
    let pow1797 = pow(trace_generator, mem_pool_value_offset.into());
    let pow1798 = pow107
        * pow1797; // pow(trace_generator, (safe_mult(mul_mod_c0_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1799 = pow104
        * pow1797; // pow(trace_generator, (safe_mult(mul_mod_c3_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1800 = pow105
        * pow1797; // pow(trace_generator, (safe_mult(mul_mod_c2_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1801 = pow106
        * pow1797; // pow(trace_generator, (safe_mult(mul_mod_c1_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1802 = pow111
        * pow1797; // pow(trace_generator, (safe_mult(mul_mod_b0_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1803 = pow108
        * pow1797; // pow(trace_generator, (safe_mult(mul_mod_b3_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1804 = pow109
        * pow1797; // pow(trace_generator, (safe_mult(mul_mod_b2_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1805 = pow110
        * pow1797; // pow(trace_generator, (safe_mult(mul_mod_b1_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1806 = pow115
        * pow1797; // pow(trace_generator, (safe_mult(mul_mod_a0_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1807 = pow112
        * pow1797; // pow(trace_generator, (safe_mult(mul_mod_a3_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1808 = pow113
        * pow1797; // pow(trace_generator, (safe_mult(mul_mod_a2_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1809 = pow114
        * pow1797; // pow(trace_generator, (safe_mult(mul_mod_a1_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1810 = pow116
        * pow1797; // pow(trace_generator, (safe_mult(mul_mod_c_offset_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1811 = pow117
        * pow1797; // pow(trace_generator, (safe_mult(mul_mod_b_offset_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1812 = pow118
        * pow1797; // pow(trace_generator, (safe_mult(mul_mod_a_offset_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1813 = pow121
        * pow1797; // pow(trace_generator, (safe_mult(mul_mod_offsets_ptr_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1814 = pow0
        * pow1813; // pow(trace_generator, mul_mod_row_ratio + (safe_mult(mul_mod_offsets_ptr_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1815 = pow123
        * pow1797; // pow(trace_generator, (safe_mult(mul_mod_values_ptr_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1816 = pow0
        * pow1815; // pow(trace_generator, mul_mod_row_ratio + (safe_mult(mul_mod_values_ptr_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1817 = pow125
        * pow1797; // pow(trace_generator, (safe_mult(mul_mod_p3_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1818 = pow0
        * pow1817; // pow(trace_generator, mul_mod_row_ratio + (safe_mult(mul_mod_p3_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1819 = pow127
        * pow1797; // pow(trace_generator, (safe_mult(mul_mod_p2_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1820 = pow0
        * pow1819; // pow(trace_generator, mul_mod_row_ratio + (safe_mult(mul_mod_p2_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1821 = pow129
        * pow1797; // pow(trace_generator, (safe_mult(mul_mod_p1_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1822 = pow0
        * pow1821; // pow(trace_generator, mul_mod_row_ratio + (safe_mult(mul_mod_p1_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1823 = pow119
        * pow1797; // pow(trace_generator, (safe_mult(mul_mod_n_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1824 = pow0
        * pow1823; // pow(trace_generator, mul_mod_row_ratio + (safe_mult(mul_mod_n_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1825 = pow131
        * pow1797; // pow(trace_generator, (safe_mult(mul_mod_p0_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1826 = pow0
        * pow1825; // pow(trace_generator, mul_mod_row_ratio + (safe_mult(mul_mod_p0_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1827 = pow136
        * pow1797; // pow(trace_generator, (safe_mult(add_mod_c0_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1828 = pow133
        * pow1797; // pow(trace_generator, (safe_mult(add_mod_c3_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1829 = pow134
        * pow1797; // pow(trace_generator, (safe_mult(add_mod_c2_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1830 = pow135
        * pow1797; // pow(trace_generator, (safe_mult(add_mod_c1_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1831 = pow140
        * pow1797; // pow(trace_generator, (safe_mult(add_mod_b0_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1832 = pow137
        * pow1797; // pow(trace_generator, (safe_mult(add_mod_b3_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1833 = pow138
        * pow1797; // pow(trace_generator, (safe_mult(add_mod_b2_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1834 = pow139
        * pow1797; // pow(trace_generator, (safe_mult(add_mod_b1_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1835 = pow144
        * pow1797; // pow(trace_generator, (safe_mult(add_mod_a0_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1836 = pow141
        * pow1797; // pow(trace_generator, (safe_mult(add_mod_a3_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1837 = pow142
        * pow1797; // pow(trace_generator, (safe_mult(add_mod_a2_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1838 = pow143
        * pow1797; // pow(trace_generator, (safe_mult(add_mod_a1_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1839 = pow145
        * pow1797; // pow(trace_generator, (safe_mult(add_mod_c_offset_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1840 = pow146
        * pow1797; // pow(trace_generator, (safe_mult(add_mod_b_offset_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1841 = pow147
        * pow1797; // pow(trace_generator, (safe_mult(add_mod_a_offset_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1842 = pow150
        * pow1797; // pow(trace_generator, (safe_mult(add_mod_offsets_ptr_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1843 = pow1
        * pow1842; // pow(trace_generator, add_mod_row_ratio + (safe_mult(add_mod_offsets_ptr_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1844 = pow152
        * pow1797; // pow(trace_generator, (safe_mult(add_mod_values_ptr_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1845 = pow1
        * pow1844; // pow(trace_generator, add_mod_row_ratio + (safe_mult(add_mod_values_ptr_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1846 = pow154
        * pow1797; // pow(trace_generator, (safe_mult(add_mod_p3_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1847 = pow1
        * pow1846; // pow(trace_generator, add_mod_row_ratio + (safe_mult(add_mod_p3_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1848 = pow156
        * pow1797; // pow(trace_generator, (safe_mult(add_mod_p2_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1849 = pow158
        * pow1797; // pow(trace_generator, (safe_mult(add_mod_p1_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1850 = pow1
        * pow1849; // pow(trace_generator, add_mod_row_ratio + (safe_mult(add_mod_p1_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1851 = pow148
        * pow1797; // pow(trace_generator, (safe_mult(add_mod_n_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1852 = pow1
        * pow1851; // pow(trace_generator, add_mod_row_ratio + (safe_mult(add_mod_n_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1853 = pow160
        * pow1797; // pow(trace_generator, (safe_mult(add_mod_p0_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1854 = pow168
        * pow1797; // pow(trace_generator, (safe_mult(range_check96_builtin_mem_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1855 = pow1
        * pow1848; // pow(trace_generator, add_mod_row_ratio + (safe_mult(add_mod_p2_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1856 = pow958
        * pow1797; // pow(trace_generator, (safe_mult(keccak_input_output_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1857 = pow277
        * pow1856; // pow(trace_generator, (safe_div(keccak_row_ratio, 16)) + (safe_mult(keccak_input_output_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1858 = pow277
        * pow1857; // pow(trace_generator, (safe_div(keccak_row_ratio, 8)) + (safe_mult(keccak_input_output_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1859 = pow277
        * pow1858; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 16)) + (safe_mult(keccak_input_output_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1860 = pow277
        * pow1859; // pow(trace_generator, (safe_div(keccak_row_ratio, 4)) + (safe_mult(keccak_input_output_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1861 = pow277
        * pow1860; // pow(trace_generator, (safe_div((safe_mult(5, keccak_row_ratio)), 16)) + (safe_mult(keccak_input_output_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1862 = pow277
        * pow1861; // pow(trace_generator, (safe_div((safe_mult(3, keccak_row_ratio)), 8)) + (safe_mult(keccak_input_output_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1863 = pow277
        * pow1862; // pow(trace_generator, (safe_div((safe_mult(7, keccak_row_ratio)), 16)) + (safe_mult(keccak_input_output_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1864 = pow277
        * pow1863; // pow(trace_generator, (safe_div(keccak_row_ratio, 2)) + (safe_mult(keccak_input_output_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1865 = pow277
        * pow1864; // pow(trace_generator, (safe_div(keccak_row_ratio, 2)) + (safe_div(keccak_row_ratio, 16)) + (safe_mult(keccak_input_output_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1866 = pow277
        * pow1865; // pow(trace_generator, (safe_div(keccak_row_ratio, 2)) + (safe_div(keccak_row_ratio, 8)) + (safe_mult(keccak_input_output_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1867 = pow277
        * pow1866; // pow(trace_generator, (safe_div(keccak_row_ratio, 2)) + (safe_div((safe_mult(3, keccak_row_ratio)), 16)) + (safe_mult(keccak_input_output_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1868 = pow277
        * pow1867; // pow(trace_generator, (safe_div(keccak_row_ratio, 2)) + (safe_div(keccak_row_ratio, 4)) + (safe_mult(keccak_input_output_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1869 = pow277
        * pow1868; // pow(trace_generator, (safe_div(keccak_row_ratio, 2)) + (safe_div((safe_mult(5, keccak_row_ratio)), 16)) + (safe_mult(keccak_input_output_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1870 = pow277
        * pow1869; // pow(trace_generator, (safe_div(keccak_row_ratio, 2)) + (safe_div((safe_mult(3, keccak_row_ratio)), 8)) + (safe_mult(keccak_input_output_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1871 = pow277
        * pow1870; // pow(trace_generator, (safe_div(keccak_row_ratio, 2)) + (safe_div((safe_mult(7, keccak_row_ratio)), 16)) + (safe_mult(keccak_input_output_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1872 = pow983
        * pow1797; // pow(trace_generator, (safe_mult(ec_op_r_y_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1873 = pow984
        * pow1797; // pow(trace_generator, (safe_mult(ec_op_r_x_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1874 = pow988
        * pow1797; // pow(trace_generator, (safe_mult(ec_op_p_y_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1875 = pow989
        * pow1797; // pow(trace_generator, (safe_mult(ec_op_p_x_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1876 = pow985
        * pow1797; // pow(trace_generator, (safe_mult(ec_op_m_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1877 = pow1
        * pow1853; // pow(trace_generator, add_mod_row_ratio + (safe_mult(add_mod_p0_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1878 = pow986
        * pow1797; // pow(trace_generator, (safe_mult(ec_op_q_y_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1879 = pow987
        * pow1797; // pow(trace_generator, (safe_mult(ec_op_q_x_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1880 = pow185
        * pow1797; // pow(trace_generator, (safe_mult(poseidon_param_2_input_output_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1881 = pow178
        * pow1880; // pow(trace_generator, (safe_div(poseidon_row_ratio, 2)) + (safe_mult(poseidon_param_2_input_output_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1882 = pow187
        * pow1797; // pow(trace_generator, (safe_mult(poseidon_param_1_input_output_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1883 = pow178
        * pow1882; // pow(trace_generator, (safe_div(poseidon_row_ratio, 2)) + (safe_mult(poseidon_param_1_input_output_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1884 = pow189
        * pow1797; // pow(trace_generator, (safe_mult(poseidon_param_0_input_output_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1885 = pow178
        * pow1884; // pow(trace_generator, (safe_div(poseidon_row_ratio, 2)) + (safe_mult(poseidon_param_0_input_output_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1886 = pow1022
        * pow1797; // pow(trace_generator, (safe_mult(bitwise_x_or_y_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1887 = pow1023
        * pow1797; // pow(trace_generator, (safe_mult(bitwise_var_pool_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1888 = pow19
        * pow1887; // pow(trace_generator, (safe_div(bitwise_row_ratio, 2)) + (safe_mult(bitwise_var_pool_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1889 = pow18
        * pow1888; // pow(trace_generator, (safe_div((safe_mult(3, bitwise_row_ratio)), 4)) + (safe_mult(bitwise_var_pool_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1890 = pow1029
        * pow1797; // pow(trace_generator, (safe_mult(ecdsa_pubkey_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1891 = pow1028
        * pow1797; // pow(trace_generator, (safe_mult(ecdsa_message_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1892 = pow1046
        * pow1797; // pow(trace_generator, (safe_mult(range_check_builtin_mem_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1893 = pow1049
        * pow1797; // pow(trace_generator, (safe_mult(pedersen_output_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1894 = pow1048
        * pow1797; // pow(trace_generator, (safe_mult(pedersen_input1_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1895 = pow1050
        * pow1797; // pow(trace_generator, (safe_mult(pedersen_input0_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1896 = pow1065
        * pow1797; // pow(trace_generator, (safe_mult(orig_public_memory_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1897 = pow1066
        * pow1797; // pow(trace_generator, memory_units_row_ratio + mem_pool_value_offset).
    let pow1898 = pow(trace_generator, mem_pool_addr_offset.into());
    let pow1899 = pow104
        * pow1898; // pow(trace_generator, (safe_mult(mul_mod_c3_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1900 = pow105
        * pow1898; // pow(trace_generator, (safe_mult(mul_mod_c2_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1901 = pow106
        * pow1898; // pow(trace_generator, (safe_mult(mul_mod_c1_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1902 = pow107
        * pow1898; // pow(trace_generator, (safe_mult(mul_mod_c0_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1903 = pow108
        * pow1898; // pow(trace_generator, (safe_mult(mul_mod_b3_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1904 = pow109
        * pow1898; // pow(trace_generator, (safe_mult(mul_mod_b2_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1905 = pow110
        * pow1898; // pow(trace_generator, (safe_mult(mul_mod_b1_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1906 = pow111
        * pow1898; // pow(trace_generator, (safe_mult(mul_mod_b0_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1907 = pow112
        * pow1898; // pow(trace_generator, (safe_mult(mul_mod_a3_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1908 = pow113
        * pow1898; // pow(trace_generator, (safe_mult(mul_mod_a2_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1909 = pow114
        * pow1898; // pow(trace_generator, (safe_mult(mul_mod_a1_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1910 = pow115
        * pow1898; // pow(trace_generator, (safe_mult(mul_mod_a0_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1911 = pow116
        * pow1898; // pow(trace_generator, (safe_mult(mul_mod_c_offset_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1912 = pow117
        * pow1898; // pow(trace_generator, (safe_mult(mul_mod_b_offset_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1913 = pow118
        * pow1898; // pow(trace_generator, (safe_mult(mul_mod_a_offset_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1914 = pow119
        * pow1898; // pow(trace_generator, (safe_mult(mul_mod_n_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1915 = pow121
        * pow1898; // pow(trace_generator, (safe_mult(mul_mod_offsets_ptr_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1916 = pow123
        * pow1898; // pow(trace_generator, (safe_mult(mul_mod_values_ptr_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1917 = pow125
        * pow1898; // pow(trace_generator, (safe_mult(mul_mod_p3_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1918 = pow127
        * pow1898; // pow(trace_generator, (safe_mult(mul_mod_p2_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1919 = pow129
        * pow1898; // pow(trace_generator, (safe_mult(mul_mod_p1_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1920 = pow131
        * pow1898; // pow(trace_generator, (safe_mult(mul_mod_p0_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1921 = pow0
        * pow1920; // pow(trace_generator, mul_mod_row_ratio + (safe_mult(mul_mod_p0_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1922 = pow133
        * pow1898; // pow(trace_generator, (safe_mult(add_mod_c3_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1923 = pow134
        * pow1898; // pow(trace_generator, (safe_mult(add_mod_c2_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1924 = pow135
        * pow1898; // pow(trace_generator, (safe_mult(add_mod_c1_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1925 = pow136
        * pow1898; // pow(trace_generator, (safe_mult(add_mod_c0_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1926 = pow137
        * pow1898; // pow(trace_generator, (safe_mult(add_mod_b3_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1927 = pow138
        * pow1898; // pow(trace_generator, (safe_mult(add_mod_b2_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1928 = pow139
        * pow1898; // pow(trace_generator, (safe_mult(add_mod_b1_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1929 = pow140
        * pow1898; // pow(trace_generator, (safe_mult(add_mod_b0_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1930 = pow141
        * pow1898; // pow(trace_generator, (safe_mult(add_mod_a3_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1931 = pow142
        * pow1898; // pow(trace_generator, (safe_mult(add_mod_a2_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1932 = pow143
        * pow1898; // pow(trace_generator, (safe_mult(add_mod_a1_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1933 = pow144
        * pow1898; // pow(trace_generator, (safe_mult(add_mod_a0_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1934 = pow145
        * pow1898; // pow(trace_generator, (safe_mult(add_mod_c_offset_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1935 = pow146
        * pow1898; // pow(trace_generator, (safe_mult(add_mod_b_offset_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1936 = pow147
        * pow1898; // pow(trace_generator, (safe_mult(add_mod_a_offset_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1937 = pow148
        * pow1898; // pow(trace_generator, (safe_mult(add_mod_n_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1938 = pow150
        * pow1898; // pow(trace_generator, (safe_mult(add_mod_offsets_ptr_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1939 = pow152
        * pow1898; // pow(trace_generator, (safe_mult(add_mod_values_ptr_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1940 = pow154
        * pow1898; // pow(trace_generator, (safe_mult(add_mod_p3_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1941 = pow156
        * pow1898; // pow(trace_generator, (safe_mult(add_mod_p2_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1942 = pow158
        * pow1898; // pow(trace_generator, (safe_mult(add_mod_p1_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1943 = pow160
        * pow1898; // pow(trace_generator, (safe_mult(add_mod_p0_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1944 = pow1
        * pow1943; // pow(trace_generator, add_mod_row_ratio + (safe_mult(add_mod_p0_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1945 = pow168
        * pow1898; // pow(trace_generator, (safe_mult(range_check96_builtin_mem_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1946 = pow2
        * pow1945; // pow(trace_generator, range_check96_builtin_row_ratio + (safe_mult(range_check96_builtin_mem_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1947 = pow958
        * pow1898; // pow(trace_generator, (safe_mult(keccak_input_output_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1948 = pow277
        * pow1947; // pow(trace_generator, (safe_div(keccak_row_ratio, 16)) + (safe_mult(keccak_input_output_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1949 = pow983
        * pow1898; // pow(trace_generator, (safe_mult(ec_op_r_y_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1950 = pow984
        * pow1898; // pow(trace_generator, (safe_mult(ec_op_r_x_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1951 = pow985
        * pow1898; // pow(trace_generator, (safe_mult(ec_op_m_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1952 = pow986
        * pow1898; // pow(trace_generator, (safe_mult(ec_op_q_y_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1953 = pow987
        * pow1898; // pow(trace_generator, (safe_mult(ec_op_q_x_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1954 = pow988
        * pow1898; // pow(trace_generator, (safe_mult(ec_op_p_y_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1955 = pow989
        * pow1898; // pow(trace_generator, (safe_mult(ec_op_p_x_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1956 = pow979
        * pow1955; // pow(trace_generator, ec_op_builtin_row_ratio + (safe_mult(ec_op_p_x_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1957 = pow185
        * pow1898; // pow(trace_generator, (safe_mult(poseidon_param_2_input_output_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1958 = pow178
        * pow1957; // pow(trace_generator, (safe_div(poseidon_row_ratio, 2)) + (safe_mult(poseidon_param_2_input_output_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1959 = pow187
        * pow1898; // pow(trace_generator, (safe_mult(poseidon_param_1_input_output_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1960 = pow178
        * pow1959; // pow(trace_generator, (safe_div(poseidon_row_ratio, 2)) + (safe_mult(poseidon_param_1_input_output_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1961 = pow189
        * pow1898; // pow(trace_generator, (safe_mult(poseidon_param_0_input_output_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1962 = pow178
        * pow1961; // pow(trace_generator, (safe_div(poseidon_row_ratio, 2)) + (safe_mult(poseidon_param_0_input_output_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1963 = pow1022
        * pow1898; // pow(trace_generator, (safe_mult(bitwise_x_or_y_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1964 = pow1023
        * pow1898; // pow(trace_generator, (safe_mult(bitwise_var_pool_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1965 = pow18
        * pow1964; // pow(trace_generator, (safe_div(bitwise_row_ratio, 4)) + (safe_mult(bitwise_var_pool_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1966 = pow19
        * pow1965; // pow(trace_generator, (safe_div((safe_mult(3, bitwise_row_ratio)), 4)) + (safe_mult(bitwise_var_pool_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1967 = pow18
        * pow1966; // pow(trace_generator, bitwise_row_ratio + (safe_mult(bitwise_var_pool_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1968 = pow1028
        * pow1898; // pow(trace_generator, (safe_mult(ecdsa_message_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1969 = pow1029
        * pow1898; // pow(trace_generator, (safe_mult(ecdsa_pubkey_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1970 = pow1036
        * pow1969; // pow(trace_generator, ecdsa_builtin_row_ratio + (safe_mult(ecdsa_pubkey_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1971 = pow1046
        * pow1898; // pow(trace_generator, (safe_mult(range_check_builtin_mem_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1972 = pow37
        * pow1971; // pow(trace_generator, range_check_builtin_row_ratio + (safe_mult(range_check_builtin_mem_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1973 = pow1048
        * pow1898; // pow(trace_generator, (safe_mult(pedersen_input1_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1974 = pow1050
        * pow1898; // pow(trace_generator, (safe_mult(pedersen_input0_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1975 = pow1049
        * pow1898; // pow(trace_generator, (safe_mult(pedersen_output_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1976 = pow1059
        * pow1974; // pow(trace_generator, pedersen_builtin_row_ratio + (safe_mult(pedersen_input0_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1977 = pow1065
        * pow1898; // pow(trace_generator, (safe_mult(orig_public_memory_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1978 = pow1066
        * pow1898; // pow(trace_generator, memory_units_row_ratio + mem_pool_addr_offset).
    let pow1979 = pow(trace_generator, memory_sorted_value_offset.into());
    let pow1980 = pow1066
        * pow1979; // pow(trace_generator, memory_units_row_ratio + memory_sorted_value_offset).
    let pow1981 = pow(trace_generator, memory_sorted_addr_offset.into());
    let pow1982 = pow1066
        * pow1981; // pow(trace_generator, memory_units_row_ratio + memory_sorted_addr_offset).
    let pow1983 = pow(trace_generator, cpu_update_registers_update_pc_tmp1_offset.into());
    let pow1984 = pow1069
        * pow1797; // pow(trace_generator, (safe_mult(cpu_operands_mem_dst_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1985 = pow(trace_generator, cpu_update_registers_update_pc_tmp0_offset.into());
    let pow1986 = pow(trace_generator, cpu_operands_res_offset.into());
    let pow1987 = pow1067
        * pow1797; // pow(trace_generator, (safe_mult(cpu_operands_mem_op1_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1988 = pow(trace_generator, cpu_operands_ops_mul_offset.into());
    let pow1989 = pow1068
        * pow1797; // pow(trace_generator, (safe_mult(cpu_operands_mem_op0_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow1990 = pow1073
        * pow1898; // pow(trace_generator, (safe_mult(cpu_decode_mem_inst_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1991 = pow1089
        * pow1990; // pow(trace_generator, (safe_mult(16, cpu_component_step)) + (safe_mult(cpu_decode_mem_inst_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1992 = pow1067
        * pow1898; // pow(trace_generator, (safe_mult(cpu_operands_mem_op1_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1993 = pow1068
        * pow1898; // pow(trace_generator, (safe_mult(cpu_operands_mem_op0_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1994 = pow(trace_generator, cpu_registers_ap_offset.into());
    let pow1995 = pow1089
        * pow1994; // pow(trace_generator, (safe_mult(16, cpu_component_step)) + cpu_registers_ap_offset).
    let pow1996 = pow(trace_generator, cpu_registers_fp_offset.into());
    let pow1997 = pow1089
        * pow1996; // pow(trace_generator, (safe_mult(16, cpu_component_step)) + cpu_registers_fp_offset).
    let pow1998 = pow1069
        * pow1898; // pow(trace_generator, (safe_mult(cpu_operands_mem_dst_suboffset, memory_units_row_ratio)) + mem_pool_addr_offset).
    let pow1999 = pow1070
        * pow1713; // pow(trace_generator, (safe_mult(cpu_decode_off0_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow2000 = pow1071
        * pow1713; // pow(trace_generator, (safe_mult(cpu_decode_off1_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow2001 = pow1072
        * pow1713; // pow(trace_generator, (safe_mult(cpu_decode_off2_suboffset, range_check_units_row_ratio)) + range_check16_pool_offset).
    let pow2002 = pow1073
        * pow1797; // pow(trace_generator, (safe_mult(cpu_decode_mem_inst_suboffset, memory_units_row_ratio)) + mem_pool_value_offset).
    let pow2003 = pow(trace_generator, cpu_decode_opcode_range_check_column_offset.into());
    let pow2004 = pow1074
        * pow2003; // pow(trace_generator, cpu_component_step + cpu_decode_opcode_range_check_column_offset).
    let pow2005 = pow1074
        * pow2004; // pow(trace_generator, (safe_mult(2, cpu_component_step)) + cpu_decode_opcode_range_check_column_offset).
    let pow2006 = pow1074
        * pow2005; // pow(trace_generator, (safe_mult(2, cpu_component_step)) + cpu_component_step + cpu_decode_opcode_range_check_column_offset).
    let pow2007 = pow1074
        * pow2006; // pow(trace_generator, (safe_mult(4, cpu_component_step)) + cpu_decode_opcode_range_check_column_offset).
    let pow2008 = pow1074
        * pow2007; // pow(trace_generator, (safe_mult(4, cpu_component_step)) + cpu_component_step + cpu_decode_opcode_range_check_column_offset).
    let pow2009 = pow1074
        * pow2008; // pow(trace_generator, (safe_mult(5, cpu_component_step)) + cpu_component_step + cpu_decode_opcode_range_check_column_offset).
    let pow2010 = pow1074
        * pow2009; // pow(trace_generator, (safe_mult(6, cpu_component_step)) + cpu_component_step + cpu_decode_opcode_range_check_column_offset).
    let pow2011 = pow1074
        * pow2010; // pow(trace_generator, (safe_mult(7, cpu_component_step)) + cpu_component_step + cpu_decode_opcode_range_check_column_offset).
    let pow2012 = pow1074
        * pow2011; // pow(trace_generator, (safe_mult(9, cpu_component_step)) + cpu_decode_opcode_range_check_column_offset).
    let pow2013 = pow1074
        * pow2012; // pow(trace_generator, (safe_mult(9, cpu_component_step)) + cpu_component_step + cpu_decode_opcode_range_check_column_offset).
    let pow2014 = pow1074
        * pow2013; // pow(trace_generator, (safe_mult(10, cpu_component_step)) + cpu_component_step + cpu_decode_opcode_range_check_column_offset).
    let pow2015 = pow1074
        * pow2014; // pow(trace_generator, (safe_mult(12, cpu_component_step)) + cpu_decode_opcode_range_check_column_offset).
    let pow2016 = pow1074
        * pow2015; // pow(trace_generator, (safe_mult(12, cpu_component_step)) + cpu_component_step + cpu_decode_opcode_range_check_column_offset).
    let pow2017 = pow1074
        * pow2016; // pow(trace_generator, (safe_mult(13, cpu_component_step)) + cpu_component_step + cpu_decode_opcode_range_check_column_offset).
    let pow2018 = pow1074
        * pow2017; // pow(trace_generator, (safe_mult(14, cpu_component_step)) + cpu_component_step + cpu_decode_opcode_range_check_column_offset).

    // Fetch columns.

    // Sum the OODS constraints on the trace polynomials.
    let mut total_sum: felt252 = 0;
    let mut value: felt252 = 0;

    value =
        (*column_values.at(cpu_decode_opcode_range_check_column_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow2003 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(cpu_decode_opcode_range_check_column_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow2004 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow2002 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow2001 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow2000 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1999 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(cpu_decode_opcode_range_check_column_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow2005 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(cpu_decode_opcode_range_check_column_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow2006 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(cpu_decode_opcode_range_check_column_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow2007 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(cpu_decode_opcode_range_check_column_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow2008 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(cpu_decode_opcode_range_check_column_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow2006 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(cpu_decode_opcode_range_check_column_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow2007 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(cpu_decode_opcode_range_check_column_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow2008 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(cpu_decode_opcode_range_check_column_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow2009 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(cpu_decode_opcode_range_check_column_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow2009 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(cpu_decode_opcode_range_check_column_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow2010 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(cpu_decode_opcode_range_check_column_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow2012 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(cpu_decode_opcode_range_check_column_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow2013 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(cpu_decode_opcode_range_check_column_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow2010 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(cpu_decode_opcode_range_check_column_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow2011 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(cpu_decode_opcode_range_check_column_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow2011 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(cpu_decode_opcode_range_check_column_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow2012 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(cpu_decode_opcode_range_check_column_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow2015 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(cpu_decode_opcode_range_check_column_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow2016 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(cpu_decode_opcode_range_check_column_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow2016 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(cpu_decode_opcode_range_check_column_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow2017 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1998 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(cpu_registers_fp_column) - *oods_values.pop_front().unwrap())
        / (point - pow1996 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(cpu_registers_ap_column) - *oods_values.pop_front().unwrap())
        / (point - pow1994 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1993 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(cpu_decode_opcode_range_check_column_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow2005 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1992 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1990 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1989 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(cpu_operands_ops_mul_column) - *oods_values.pop_front().unwrap())
        / (point - pow1988 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1987 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(cpu_operands_res_column) - *oods_values.pop_front().unwrap())
        / (point - pow1986 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(cpu_update_registers_update_pc_tmp0_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1985 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1984 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(cpu_update_registers_update_pc_tmp1_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1983 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1991 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(cpu_registers_ap_column) - *oods_values.pop_front().unwrap())
        / (point - pow1995 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(cpu_decode_opcode_range_check_column_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow2013 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(cpu_decode_opcode_range_check_column_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow2014 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(cpu_decode_opcode_range_check_column_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow2014 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(cpu_decode_opcode_range_check_column_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow2015 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(cpu_registers_fp_column) - *oods_values.pop_front().unwrap())
        / (point - pow1997 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(cpu_decode_opcode_range_check_column_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow2017 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(cpu_decode_opcode_range_check_column_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow2018 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(memory_sorted_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1981 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(memory_sorted_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1979 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1898 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1797 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(memory_sorted_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1982 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(memory_sorted_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1980 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1978 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1897 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1977 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1896 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_sorted_column) - *oods_values.pop_front().unwrap())
        / (point - pow1795 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1713 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_sorted_column) - *oods_values.pop_front().unwrap())
        / (point - pow1796 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1794 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(diluted_check_permuted_values_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1711 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1376 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(diluted_check_permuted_values_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1712 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1710 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(pedersen_hash0_ec_subset_sum_bit_unpacking_prod_ones192_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1375 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(pedersen_hash0_ec_subset_sum_selector_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1366 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(pedersen_hash0_ec_subset_sum_selector_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1370 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(pedersen_hash0_ec_subset_sum_selector_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1369 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(pedersen_hash0_ec_subset_sum_bit_unpacking_prod_ones196_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1365 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(pedersen_hash0_ec_subset_sum_selector_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1373 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(pedersen_hash0_ec_subset_sum_selector_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1368 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(pedersen_hash0_ec_subset_sum_selector_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1367 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(pedersen_hash0_ec_subset_sum_selector_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1372 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(pedersen_hash0_ec_subset_sum_selector_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1371 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(pedersen_hash0_ec_subset_sum_partial_sum_x_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1360 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(pedersen_hash0_ec_subset_sum_partial_sum_y_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1356 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(pedersen_hash0_ec_subset_sum_partial_sum_x_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1362 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(pedersen_hash0_ec_subset_sum_partial_sum_y_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1358 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(pedersen_hash0_ec_subset_sum_slope_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1355 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(pedersen_hash0_ec_subset_sum_partial_sum_x_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1361 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(pedersen_hash0_ec_subset_sum_partial_sum_y_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1357 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(pedersen_hash0_ec_subset_sum_partial_sum_x_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1363 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(pedersen_hash0_ec_subset_sum_partial_sum_y_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1359 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1895 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1976 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1975 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1974 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(pedersen_hash0_ec_subset_sum_selector_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1374 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1894 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1973 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1893 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(pedersen_hash0_ec_subset_sum_partial_sum_x_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1364 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1892 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1786 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1787 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1788 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1789 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1790 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1791 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1792 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1793 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1972 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1971 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(ecdsa_signature0_key_points_x_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1352 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(ecdsa_signature0_key_points_y_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1349 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(ecdsa_signature0_key_points_x_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1353 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(ecdsa_signature0_key_points_y_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1350 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(ecdsa_signature0_doubling_slope_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1348 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(ecdsa_signature0_exponentiate_generator_selector_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1346 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(ecdsa_signature0_exponentiate_generator_selector_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1347 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(ecdsa_signature0_exponentiate_generator_partial_sum_x_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1343 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(ecdsa_signature0_exponentiate_generator_partial_sum_y_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1340 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(ecdsa_signature0_exponentiate_generator_partial_sum_x_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1344 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(ecdsa_signature0_exponentiate_generator_partial_sum_y_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1341 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(ecdsa_signature0_exponentiate_generator_slope_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1339 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(ecdsa_signature0_exponentiate_generator_x_diff_inv_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1338 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(ecdsa_signature0_exponentiate_key_selector_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1336 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(ecdsa_signature0_exponentiate_key_selector_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1337 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(ecdsa_signature0_exponentiate_key_partial_sum_x_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1332 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(ecdsa_signature0_exponentiate_key_partial_sum_y_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1328 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(ecdsa_signature0_exponentiate_key_partial_sum_x_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1333 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(ecdsa_signature0_exponentiate_key_partial_sum_y_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1329 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(ecdsa_signature0_exponentiate_key_slope_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1327 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(ecdsa_signature0_exponentiate_key_x_diff_inv_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1326 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(ecdsa_signature0_exponentiate_generator_partial_sum_x_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1345 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(ecdsa_signature0_exponentiate_generator_partial_sum_y_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1342 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(ecdsa_signature0_exponentiate_key_partial_sum_x_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1334 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(ecdsa_signature0_exponentiate_key_partial_sum_y_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1330 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(ecdsa_signature0_key_points_x_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1354 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(ecdsa_signature0_key_points_y_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1351 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(ecdsa_signature0_add_results_slope_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1325 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(ecdsa_signature0_add_results_inv_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1324 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(ecdsa_signature0_exponentiate_key_partial_sum_x_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1335 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(ecdsa_signature0_exponentiate_key_partial_sum_y_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1331 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(ecdsa_signature0_extract_r_slope_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1323 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(ecdsa_signature0_extract_r_inv_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1322 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(ecdsa_signature0_z_inv_column) - *oods_values.pop_front().unwrap())
        / (point - pow1321 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(ecdsa_signature0_r_w_inv_column) - *oods_values.pop_front().unwrap())
        / (point - pow1320 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(ecdsa_signature0_q_x_squared_column) - *oods_values.pop_front().unwrap())
        / (point - pow1319 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1969 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1968 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1970 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1891 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1890 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1964 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1965 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1963 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1966 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1967 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1887 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1683 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1684 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1685 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1686 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1687 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1688 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1689 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1690 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1691 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1692 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1693 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1694 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1695 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1696 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1697 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1698 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1886 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1888 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1889 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1700 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1699 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1705 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1682 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1701 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1706 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1681 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1702 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1707 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1680 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1703 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1708 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1679 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1704 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1709 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1955 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1956 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1954 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1953 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1952 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1951 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1950 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1949 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(ec_op_doubling_slope_column) - *oods_values.pop_front().unwrap())
        / (point - pow1318 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(ec_op_doubled_points_x_column) - *oods_values.pop_front().unwrap())
        / (point - pow1316 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(ec_op_doubled_points_y_column) - *oods_values.pop_front().unwrap())
        / (point - pow1314 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(ec_op_doubled_points_x_column) - *oods_values.pop_front().unwrap())
        / (point - pow1317 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(ec_op_doubled_points_y_column) - *oods_values.pop_front().unwrap())
        / (point - pow1315 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1879 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1878 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(ec_op_ec_subset_sum_bit_unpacking_prod_ones192_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1313 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(ec_op_ec_subset_sum_selector_column) - *oods_values.pop_front().unwrap())
        / (point - pow1305 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(ec_op_ec_subset_sum_selector_column) - *oods_values.pop_front().unwrap())
        / (point - pow1306 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(ec_op_ec_subset_sum_selector_column) - *oods_values.pop_front().unwrap())
        / (point - pow1311 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(ec_op_ec_subset_sum_bit_unpacking_prod_ones196_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1304 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(ec_op_ec_subset_sum_selector_column) - *oods_values.pop_front().unwrap())
        / (point - pow1312 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(ec_op_ec_subset_sum_selector_column) - *oods_values.pop_front().unwrap())
        / (point - pow1309 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(ec_op_ec_subset_sum_selector_column) - *oods_values.pop_front().unwrap())
        / (point - pow1307 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(ec_op_ec_subset_sum_selector_column) - *oods_values.pop_front().unwrap())
        / (point - pow1308 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(ec_op_ec_subset_sum_selector_column) - *oods_values.pop_front().unwrap())
        / (point - pow1310 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(ec_op_ec_subset_sum_partial_sum_x_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1301 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(ec_op_ec_subset_sum_partial_sum_y_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1298 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(ec_op_ec_subset_sum_partial_sum_x_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1303 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(ec_op_ec_subset_sum_partial_sum_y_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1300 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(ec_op_ec_subset_sum_slope_column) - *oods_values.pop_front().unwrap())
        / (point - pow1297 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(ec_op_ec_subset_sum_x_diff_inv_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1296 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1876 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1875 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1874 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1873 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(ec_op_ec_subset_sum_partial_sum_x_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1302 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1872 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(ec_op_ec_subset_sum_partial_sum_y_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1299 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1947 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1948 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_reshaped_intermediate_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1265 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1856 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_reshaped_intermediate_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1270 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1857 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_reshaped_intermediate_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1271 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1858 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_reshaped_intermediate_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1272 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1859 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_reshaped_intermediate_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1273 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1860 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_reshaped_intermediate_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1274 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1861 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_reshaped_intermediate_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1275 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1862 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_reshaped_intermediate_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1276 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1863 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_reshaped_intermediate_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1277 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1864 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_reshaped_intermediate_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1278 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1865 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_reshaped_intermediate_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1279 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1866 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_reshaped_intermediate_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1280 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1867 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_reshaped_intermediate_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1281 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1868 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_reshaped_intermediate_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1282 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1869 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_reshaped_intermediate_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1283 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1870 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_reshaped_intermediate_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1284 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1871 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_final_reshaped_input_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1235 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_final_reshaped_input_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1243 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_reshaped_intermediate_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1266 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_final_reshaped_input_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1251 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_reshaped_intermediate_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1267 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_final_reshaped_input_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1252 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_reshaped_intermediate_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1268 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_final_reshaped_input_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1253 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_reshaped_intermediate_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1269 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_final_reshaped_input_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1254 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_reshaped_intermediate_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1285 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_final_reshaped_input_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1255 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_reshaped_intermediate_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1286 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_final_reshaped_input_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1256 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_reshaped_intermediate_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1287 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_final_reshaped_input_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1257 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_reshaped_intermediate_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1288 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_final_reshaped_input_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1258 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_reshaped_intermediate_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1289 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_final_reshaped_input_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1259 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_reshaped_intermediate_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1290 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_final_reshaped_input_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1260 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_reshaped_intermediate_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1291 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_final_reshaped_input_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1261 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_reshaped_intermediate_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1292 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_final_reshaped_input_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1262 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_reshaped_intermediate_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1293 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_final_reshaped_input_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1263 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_reshaped_intermediate_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1294 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_final_reshaped_input_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1264 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_reshaped_intermediate_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1295 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_cumulative_sum_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1219 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_cumulative_sum_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1203 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_cumulative_sum_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1211 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_cumulative_sum_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1204 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_cumulative_sum_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1214 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_cumulative_sum_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1212 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_final_reshaped_input_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1236 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_cumulative_sum_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1215 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_final_reshaped_input_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1244 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_cumulative_sum_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1213 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_final_reshaped_input_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1237 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_cumulative_sum_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1217 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_final_reshaped_input_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1245 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_cumulative_sum_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1216 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_final_reshaped_input_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1238 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_cumulative_sum_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1218 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_final_reshaped_input_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1246 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_cumulative_sum_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1221 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_final_reshaped_input_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1239 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_cumulative_sum_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1226 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_final_reshaped_input_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1247 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_cumulative_sum_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1222 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_final_reshaped_input_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1240 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_cumulative_sum_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1227 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_final_reshaped_input_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1248 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_cumulative_sum_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1223 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_final_reshaped_input_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1241 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_cumulative_sum_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1231 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_final_reshaped_input_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1249 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_final_reshaped_input_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1242 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_cumulative_sum_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1225 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_final_reshaped_input_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1250 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_cumulative_sum_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1224 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_cumulative_sum_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1207 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_cumulative_sum_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1232 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_cumulative_sum_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1208 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1673 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_cumulative_sum_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1233 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_cumulative_sum_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1209 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1674 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_cumulative_sum_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1234 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_cumulative_sum_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1210 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_cumulative_sum_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1220 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_cumulative_sum_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1228 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1571 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_cumulative_sum_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1205 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_cumulative_sum_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1229 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1572 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_cumulative_sum_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1206 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_parse_to_diluted_cumulative_sum_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1230 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1615 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1581 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1588 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1596 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1604 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1546 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1518 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1512 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1574 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1582 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1590 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1599 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1605 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1622 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1548 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1508 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1575 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1583 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1591 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1600 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1608 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1516 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1628 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1619 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1576 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1584 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1592 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1601 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1609 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1547 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1519 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1513 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1579 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1587 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1593 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1602 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1614 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1627 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1549 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_rotated_parity0_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1195 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_rotated_parity0_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1192 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1677 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_rotated_parity1_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1188 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_rotated_parity1_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1182 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1538 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_rotated_parity2_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1175 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_rotated_parity2_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1171 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1568 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_rotated_parity3_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1165 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_rotated_parity3_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1164 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1678 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_rotated_parity4_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1156 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_rotated_parity4_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1153 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1542 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1383 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1629 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1404 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1455 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1570 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_rotated_parity2_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1181 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1676 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1553 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1421 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1485 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1494 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1517 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_rotated_parity3_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1166 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1650 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1447 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1393 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1491 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1531 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1562 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_rotated_parity4_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1161 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1577 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1521 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1416 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1440 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1453 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1640 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_rotated_parity0_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1199 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1667 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1442 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1417 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1473 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1492 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1527 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_rotated_parity1_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1189 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1663 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1443 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1385 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1504 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1545 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1625 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_rotated_parity2_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1177 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1624 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1520 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1408 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1414 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1463 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1539 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_rotated_parity3_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1170 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1668 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1441 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1424 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1456 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1399 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1510 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_rotated_parity4_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1154 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1585 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1457 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1406 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1511 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_rotated_parity4_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1155 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1586 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1476 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1407 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1558 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_rotated_parity4_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1158 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1611 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1422 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1384 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1559 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_rotated_parity4_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1159 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1644 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1423 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1386 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1560 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_rotated_parity4_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1160 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1651 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1388 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1395 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1426 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1552 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1641 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_rotated_parity0_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1200 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1671 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1551 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1397 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1466 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1462 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1541 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_rotated_parity1_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1191 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1589 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1438 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1418 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1472 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1474 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1616 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_rotated_parity2_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1172 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1612 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1444 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1387 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1503 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1569 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1536 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_rotated_parity3_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1168 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1626 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1550 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1410 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1460 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1669 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1564 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_rotated_parity4_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1162 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1653 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1647 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1430 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1427 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1481 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1620 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_rotated_parity0_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1193 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1594 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1429 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1484 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1621 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_rotated_parity0_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1194 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1595 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1475 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1495 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1639 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_rotated_parity0_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1196 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1613 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1425 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1390 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1660 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_rotated_parity0_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1197 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1659 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1428 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1392 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1662 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_rotated_parity0_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1198 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1661 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1394 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1433 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1498 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1486 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1514 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_rotated_parity1_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1184 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1597 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1499 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1496 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1515 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_rotated_parity1_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1186 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1598 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1500 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1497 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1528 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_rotated_parity1_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1183 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1637 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1431 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1396 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1529 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_rotated_parity1_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1185 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1638 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1432 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1398 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1530 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_rotated_parity1_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1187 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1652 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1401 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1400 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1470 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1646 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1623 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_rotated_parity2_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1176 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1603 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1645 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1419 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1490 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1487 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1537 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_rotated_parity3_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1169 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1664 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1445 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1389 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1468 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1469 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1565 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_rotated_parity4_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1163 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1670 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1437 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1411 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1415 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1543 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1666 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_rotated_parity0_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1202 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1665 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1523 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1412 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1413 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1566 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1540 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_rotated_parity1_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1190 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1672 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1554 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1436 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1451 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1439 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1617 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_rotated_parity2_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1173 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1606 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1452 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1458 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1618 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_rotated_parity2_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1174 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1607 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1454 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1459 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1656 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_rotated_parity2_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1178 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1642 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1434 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1403 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1657 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_rotated_parity2_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1179 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1654 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1435 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1405 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1658 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_rotated_parity2_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1180 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1655 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1409 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1402 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1502 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1544 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1526 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_rotated_parity3_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1167 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1636 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1522 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1420 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1501 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1493 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1509 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_rotated_parity4_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1157 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1610 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1446 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1391 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1478 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1643 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1649 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(keccak_keccak_rotated_parity0_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1201 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1648 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1635 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1573 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1380 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1377 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1630 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1448 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1449 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1450 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1524 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1555 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1631 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1461 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1464 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1465 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1525 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1556 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1632 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1467 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1471 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1477 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1532 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1557 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1633 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1479 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1482 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1488 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1533 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1561 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1634 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1480 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1483 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1489 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1534 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1563 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1675 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1505 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1506 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1507 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1535 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1567 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1580 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1382 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1379 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1578 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1381 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(diluted_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1378 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1961 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1962 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1959 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1960 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1957 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1958 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(poseidon_poseidon_full_rounds_state0_squared_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1150 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(poseidon_poseidon_full_rounds_state0_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1145 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(poseidon_poseidon_full_rounds_state1_squared_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1142 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(poseidon_poseidon_full_rounds_state1_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1137 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(poseidon_poseidon_full_rounds_state2_squared_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1134 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(poseidon_poseidon_full_rounds_state2_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1129 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(poseidon_poseidon_partial_rounds_state0_squared_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1126 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(poseidon_poseidon_partial_rounds_state0_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1119 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(poseidon_poseidon_partial_rounds_state1_squared_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1113 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(poseidon_poseidon_partial_rounds_state1_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1106 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1884 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1882 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1880 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(poseidon_poseidon_full_rounds_state0_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1147 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(poseidon_poseidon_full_rounds_state1_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1138 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(poseidon_poseidon_full_rounds_state2_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1131 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1885 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(poseidon_poseidon_full_rounds_state0_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1149 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(poseidon_poseidon_full_rounds_state0_squared_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1152 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(poseidon_poseidon_full_rounds_state1_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1141 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(poseidon_poseidon_full_rounds_state1_squared_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1144 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(poseidon_poseidon_full_rounds_state2_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1133 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(poseidon_poseidon_full_rounds_state2_squared_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1136 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1883 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1881 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(poseidon_poseidon_partial_rounds_state0_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1123 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(poseidon_poseidon_partial_rounds_state1_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1107 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(poseidon_poseidon_partial_rounds_state0_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1124 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(poseidon_poseidon_partial_rounds_state1_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1108 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(poseidon_poseidon_partial_rounds_state0_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1125 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(poseidon_poseidon_full_rounds_state0_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1146 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(poseidon_poseidon_full_rounds_state0_squared_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1151 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(poseidon_poseidon_full_rounds_state1_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1139 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(poseidon_poseidon_full_rounds_state1_squared_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1143 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(poseidon_poseidon_full_rounds_state2_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1130 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(poseidon_poseidon_full_rounds_state2_squared_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1135 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(poseidon_poseidon_partial_rounds_state0_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1120 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(poseidon_poseidon_partial_rounds_state0_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1121 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(poseidon_poseidon_partial_rounds_state0_squared_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1127 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(poseidon_poseidon_partial_rounds_state0_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1122 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(poseidon_poseidon_partial_rounds_state0_squared_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1128 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(poseidon_poseidon_partial_rounds_state1_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1109 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(poseidon_poseidon_partial_rounds_state1_squared_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1115 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(poseidon_poseidon_partial_rounds_state1_squared_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1116 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(poseidon_poseidon_full_rounds_state0_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1148 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(poseidon_poseidon_partial_rounds_state1_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1110 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(poseidon_poseidon_partial_rounds_state1_squared_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1114 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(poseidon_poseidon_partial_rounds_state1_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1111 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(poseidon_poseidon_partial_rounds_state1_squared_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1117 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(poseidon_poseidon_partial_rounds_state1_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1112 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(poseidon_poseidon_partial_rounds_state1_squared_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1118 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(poseidon_poseidon_full_rounds_state1_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1140 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(poseidon_poseidon_full_rounds_state2_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1132 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1854 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1785 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1784 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1783 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1782 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1781 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1780 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1946 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1945 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1943 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1942 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1941 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1940 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1939 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1938 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1937 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1944 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1877 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1853 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1851 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1850 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1849 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1855 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1848 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1847 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1846 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1845 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1844 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1843 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1842 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1852 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1936 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1935 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1934 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1933 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1841 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1932 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1931 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1930 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1929 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1840 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1928 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1927 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1926 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1925 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1839 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1924 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1923 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1922 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(add_mod_sub_p_bit_column) - *oods_values.pop_front().unwrap())
        / (point - pow1105 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(add_mod_carry1_bit_column) - *oods_values.pop_front().unwrap())
        / (point - pow1104 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(add_mod_carry1_sign_column) - *oods_values.pop_front().unwrap())
        / (point - pow1103 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(add_mod_carry2_bit_column) - *oods_values.pop_front().unwrap())
        / (point - pow1102 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(add_mod_carry2_sign_column) - *oods_values.pop_front().unwrap())
        / (point - pow1101 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(add_mod_carry3_bit_column) - *oods_values.pop_front().unwrap())
        / (point - pow1100 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(add_mod_carry3_sign_column) - *oods_values.pop_front().unwrap())
        / (point - pow1099 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1838 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1837 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1836 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1835 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1834 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1833 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1832 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1831 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1830 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1829 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1828 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1827 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1920 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1919 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1918 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1917 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1916 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1915 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1914 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1921 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1826 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1825 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1823 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1822 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1821 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1820 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1819 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1818 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1817 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1816 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1815 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1814 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1813 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1824 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1913 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1912 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1911 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1910 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1812 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1909 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1908 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1907 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1906 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1811 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1905 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1904 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1903 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1902 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1810 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1901 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1900 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_addr_column) - *oods_values.pop_front().unwrap())
        / (point - pow1899 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1809 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1808 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1807 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1806 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1805 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1804 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1803 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1802 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1801 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1800 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1799 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(mem_pool_value_column) - *oods_values.pop_front().unwrap())
        / (point - pow1798 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1779 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1778 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1777 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1776 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1775 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1774 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1773 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1772 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1771 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1770 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1769 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1768 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1767 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1766 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1765 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1764 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1763 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1762 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1761 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1760 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1759 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1758 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1757 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1756 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1755 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1754 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1753 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1752 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1751 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1750 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1749 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1748 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1747 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1746 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1745 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1744 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1743 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1742 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1741 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1740 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1739 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1738 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1737 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1736 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1735 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1734 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1733 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1732 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1731 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1730 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1729 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1728 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1727 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1726 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1725 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1724 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1723 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1722 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1721 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1720 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1719 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1718 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1717 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1716 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1715 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value = (*column_values.at(range_check16_pool_column) - *oods_values.pop_front().unwrap())
        / (point - pow1714 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(memory_multi_column_perm_perm_cum_prod0_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1097 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(memory_multi_column_perm_perm_cum_prod0_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1098 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(range_check16_perm_cum_prod0_column) - *oods_values.pop_front().unwrap())
        / (point - pow1095 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(range_check16_perm_cum_prod0_column) - *oods_values.pop_front().unwrap())
        / (point - pow1096 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(diluted_check_permutation_cum_prod0_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1093 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(diluted_check_permutation_cum_prod0_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1094 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(diluted_check_cumulative_value_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1091 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(diluted_check_cumulative_value_column)
            - *oods_values.pop_front().unwrap())
        / (point - pow1092 * oods_point);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    // Sum the OODS boundary constraints on the composition polynomials.
    let oods_point_to_deg = pow(oods_point, CONSTRAINT_DEGREE.into());

    value =
        (*column_values.at(num_columns_first + num_columns_second)
            - *oods_values.pop_front().unwrap())
        / (point - oods_point_to_deg);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    value =
        (*column_values.at(num_columns_first + num_columns_second + 1)
            - *oods_values.pop_front().unwrap())
        / (point - oods_point_to_deg);
    total_sum = total_sum + *constraint_coefficients.pop_front().unwrap() * value;

    total_sum
}

fn check_asserts(dynamic_params: DynamicParams, stark_domains: @StarkDomains) {
    let trace_length: u256 = (*stark_domains.trace_domain_size).into();

    let mut x: u256 = 0;

    // Coset step (dynamicparam(diluted_units_row_ratio)) must be a power of two.
    x = dynamic_params.diluted_units_row_ratio.into();
    assert_is_power_of_2(x);
    // Dimension should be a power of 2.
    x = trace_length / dynamic_params.diluted_units_row_ratio.into();
    assert_is_power_of_2(x);
    // Index out of range.
    x = (trace_length / dynamic_params.diluted_units_row_ratio.into()) - 1;
    assert_range_u128_from_u256(x);

    // Coset step (memberexpression(trace_length)) must be a power of two.
    x = trace_length;
    assert_is_power_of_2(x);
    // Index should be non negative.
    x = (trace_length / dynamic_params.diluted_units_row_ratio.into());
    assert_range_u128_from_u256(x);

    // Coset step (dynamicparam(range_check_units_row_ratio)) must be a power of two.
    x = dynamic_params.range_check_units_row_ratio.into();
    assert_is_power_of_2(x);
    // Dimension should be a power of 2.
    x = (trace_length / dynamic_params.range_check_units_row_ratio.into());
    assert_is_power_of_2(x);
    // Index out of range.
    x = (trace_length / dynamic_params.range_check_units_row_ratio.into()) - 1;
    assert_range_u128_from_u256(x);

    // Index should be non negative.
    x = (trace_length / dynamic_params.range_check_units_row_ratio.into());
    assert_range_u128_from_u256(x);

    // Coset step ((8) * (dynamicparam(memory_units_row_ratio))) must be a power of two.
    x = (8 * dynamic_params.memory_units_row_ratio.into());
    assert_is_power_of_2(x);
    // Dimension should be a power of 2.
    x = (trace_length / (8 * dynamic_params.memory_units_row_ratio.into()));
    assert_is_power_of_2(x);
    // Coset step (dynamicparam(memory_units_row_ratio)) must be a power of two.
    x = dynamic_params.memory_units_row_ratio.into();
    assert_is_power_of_2(x);
    // Dimension should be a power of 2.
    x = (trace_length / dynamic_params.memory_units_row_ratio.into());
    assert_is_power_of_2(x);
    // Index out of range.
    x = (trace_length / dynamic_params.memory_units_row_ratio.into()) - 1;
    assert_range_u128_from_u256(x);

    // Index should be non negative.
    x = (trace_length / dynamic_params.memory_units_row_ratio.into());
    assert_range_u128_from_u256(x);

    // Coset step ((16) * (dynamicparam(cpu_component_step))) must be a power of two.
    x = (16 * dynamic_params.cpu_component_step.into());
    assert_is_power_of_2(x);
    // Dimension should be a power of 2.
    x = (trace_length / (16 * dynamic_params.cpu_component_step.into()));
    assert_is_power_of_2(x);
    // Step must not exceed dimension.
    x = (trace_length / (16 * dynamic_params.cpu_component_step.into())) - 1;
    assert_range_u128_from_u256(x);

    // Coset step (dynamicparam(cpu_component_step)) must be a power of two.
    x = dynamic_params.cpu_component_step.into();
    assert_is_power_of_2(x);
    // Index out of range.
    x = (trace_length / (16 * dynamic_params.cpu_component_step.into()));
    assert_range_u128_from_u256(x);

    // Cpu_component_step is out of range.
    x = 256 - dynamic_params.cpu_component_step.into();
    assert_range_u128_from_u256(x);

    // Memory_units_row_ratio is out of range.
    x = 16 * dynamic_params.cpu_component_step.into()
        - 4 * dynamic_params.memory_units_row_ratio.into();
    assert_range_u128_from_u256(x);

    // Offset of cpu/decode/mem_inst must be nonnegative.
    x = dynamic_params.cpu_decode_mem_inst_suboffset.into();
    assert_range_u128_from_u256(x);

    // Offset of cpu/decode/mem_inst is too big.
    x = trace_length - dynamic_params.cpu_decode_mem_inst_suboffset.into() - 1;
    assert_range_u128_from_u256(x);

    // Offset of cpu/decode/mem_inst is too big.
    x =
        (16 * dynamic_params.cpu_component_step.into()
            - dynamic_params.cpu_decode_mem_inst_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into())
        - 1;
    assert_range_u128_from_u256(x);

    // Offset of cpu/decode/off0 must be nonnegative.
    x = dynamic_params.cpu_decode_off0_suboffset.into();
    assert_range_u128_from_u256(x);

    // Offset of cpu/decode/off0 is too big.
    x = trace_length - dynamic_params.cpu_decode_off0_suboffset.into() - 1;
    assert_range_u128_from_u256(x);

    // Offset of cpu/decode/off0 is too big.
    x =
        (16 * dynamic_params.cpu_component_step.into()
            - dynamic_params.cpu_decode_off0_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into())
        - 1;
    assert_range_u128_from_u256(x);

    // Offset of cpu/decode/off1 must be nonnegative.
    x = dynamic_params.cpu_decode_off1_suboffset.into();
    assert_range_u128_from_u256(x);

    // Offset of cpu/decode/off1 is too big.
    x = trace_length - dynamic_params.cpu_decode_off1_suboffset.into() - 1;
    assert_range_u128_from_u256(x);

    // Offset of cpu/decode/off1 is too big.
    x =
        (16 * dynamic_params.cpu_component_step.into()
            - dynamic_params.cpu_decode_off1_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into())
        - 1;
    assert_range_u128_from_u256(x);

    // Offset of cpu/decode/off2 must be nonnegative.
    x = dynamic_params.cpu_decode_off2_suboffset.into();
    assert_range_u128_from_u256(x);

    // Offset of cpu/decode/off2 is too big.
    x = trace_length - dynamic_params.cpu_decode_off2_suboffset.into() - 1;
    assert_range_u128_from_u256(x);

    // Offset of cpu/decode/off2 is too big.
    x =
        (16 * dynamic_params.cpu_component_step.into()
            - dynamic_params.cpu_decode_off2_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into())
        - 1;
    assert_range_u128_from_u256(x);

    // Offset of cpu/operands/mem_dst must be nonnegative.
    x = dynamic_params.cpu_operands_mem_dst_suboffset.into();
    assert_range_u128_from_u256(x);

    // Offset of cpu/operands/mem_dst is too big.
    x = trace_length - dynamic_params.cpu_operands_mem_dst_suboffset.into() - 1;
    assert_range_u128_from_u256(x);

    // Offset of cpu/operands/mem_dst is too big.
    x =
        (16 * dynamic_params.cpu_component_step.into()
            - dynamic_params.cpu_operands_mem_dst_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into())
        - 1;
    assert_range_u128_from_u256(x);

    // Offset of cpu/operands/mem_op0 must be nonnegative.
    x = dynamic_params.cpu_operands_mem_op0_suboffset.into();
    assert_range_u128_from_u256(x);

    // Offset of cpu/operands/mem_op0 is too big.
    x = trace_length - dynamic_params.cpu_operands_mem_op0_suboffset.into() - 1;
    assert_range_u128_from_u256(x);

    // Offset of cpu/operands/mem_op0 is too big.
    x =
        (16 * dynamic_params.cpu_component_step.into()
            - dynamic_params.cpu_operands_mem_op0_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into())
        - 1;
    assert_range_u128_from_u256(x);

    // Offset of cpu/operands/mem_op1 must be nonnegative.
    x = dynamic_params.cpu_operands_mem_op1_suboffset.into();
    assert_range_u128_from_u256(x);

    // Offset of cpu/operands/mem_op1 is too big.
    x = trace_length - dynamic_params.cpu_operands_mem_op1_suboffset.into() - 1;
    assert_range_u128_from_u256(x);

    // Offset of cpu/operands/mem_op1 is too big.
    x =
        (16 * dynamic_params.cpu_component_step.into()
            - dynamic_params.cpu_operands_mem_op1_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into())
        - 1;
    assert_range_u128_from_u256(x);

    // Offset of orig/public_memory must be nonnegative.
    x = dynamic_params.orig_public_memory_suboffset.into();
    assert_range_u128_from_u256(x);

    // Offset of orig/public_memory is too big.
    x = trace_length - dynamic_params.orig_public_memory_suboffset.into() - 1;
    assert_range_u128_from_u256(x);

    // Offset of orig/public_memory is too big.
    x =
        (8 * dynamic_params.memory_units_row_ratio.into()
            - dynamic_params.orig_public_memory_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into())
        - 1;
    assert_range_u128_from_u256(x);

    // Uses_pedersen_builtin should be a boolean.
    assert(
        dynamic_params.uses_pedersen_builtin.into() * dynamic_params.uses_pedersen_builtin.into()
            - dynamic_params.uses_pedersen_builtin.into() == 0,
        'Invalid value'
    );
    // Uses_range_check_builtin should be a boolean.
    assert(
        dynamic_params.uses_range_check_builtin.into()
            * dynamic_params.uses_range_check_builtin.into()
            - dynamic_params.uses_range_check_builtin.into() == 0,
        'Invalid value'
    );
    // Uses_ecdsa_builtin should be a boolean.
    assert(
        dynamic_params.uses_ecdsa_builtin.into() * dynamic_params.uses_ecdsa_builtin.into()
            - dynamic_params.uses_ecdsa_builtin.into() == 0,
        'Invalid value'
    );
    // Uses_bitwise_builtin should be a boolean.
    assert(
        dynamic_params.uses_bitwise_builtin.into() * dynamic_params.uses_bitwise_builtin.into()
            - dynamic_params.uses_bitwise_builtin.into() == 0,
        'Invalid value'
    );
    // Uses_ec_op_builtin should be a boolean.
    assert(
        dynamic_params.uses_ec_op_builtin.into() * dynamic_params.uses_ec_op_builtin.into()
            - dynamic_params.uses_ec_op_builtin.into() == 0,
        'Invalid value'
    );
    // Uses_keccak_builtin should be a boolean.
    assert(
        dynamic_params.uses_keccak_builtin.into() * dynamic_params.uses_keccak_builtin.into()
            - dynamic_params.uses_keccak_builtin.into() == 0,
        'Invalid value'
    );
    // Uses_poseidon_builtin should be a boolean.
    assert(
        dynamic_params.uses_poseidon_builtin.into() * dynamic_params.uses_poseidon_builtin.into()
            - dynamic_params.uses_poseidon_builtin.into() == 0,
        'Invalid value'
    );
    // Uses_range_check96_builtin should be a boolean.
    assert(
        dynamic_params.uses_range_check96_builtin.into()
            * dynamic_params.uses_range_check96_builtin.into()
            - dynamic_params.uses_range_check96_builtin.into() == 0,
        'Invalid value'
    );
    // Uses_add_mod_builtin should be a boolean.
    assert(
        dynamic_params.uses_add_mod_builtin.into() * dynamic_params.uses_add_mod_builtin.into()
            - dynamic_params.uses_add_mod_builtin.into() == 0,
        'Invalid value'
    );
    // Uses_mul_mod_builtin should be a boolean.
    assert(
        dynamic_params.uses_mul_mod_builtin.into() * dynamic_params.uses_mul_mod_builtin.into()
            - dynamic_params.uses_mul_mod_builtin.into() == 0,
        'Invalid value'
    );
    // Num_columns_first is out of range.
    x = 65536 - dynamic_params.num_columns_first.into() - 1;
    assert_range_u128_from_u256(x);

    // Num_columns_second is out of range.
    x = 65536 - dynamic_params.num_columns_second.into() - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.mem_pool_addr_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into() - dynamic_params.mem_pool_addr_column.into() - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.mem_pool_addr_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length - dynamic_params.mem_pool_addr_offset.into() - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.mem_pool_value_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into() - dynamic_params.mem_pool_value_column.into() - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.mem_pool_value_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length - dynamic_params.mem_pool_value_offset.into() - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.range_check16_pool_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.range_check16_pool_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.range_check16_pool_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length - dynamic_params.range_check16_pool_offset.into() - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.cpu_decode_opcode_range_check_column_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.cpu_decode_opcode_range_check_column_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.cpu_decode_opcode_range_check_column_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length - dynamic_params.cpu_decode_opcode_range_check_column_offset.into() - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.cpu_registers_ap_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into() - dynamic_params.cpu_registers_ap_column.into() - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.cpu_registers_ap_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length - dynamic_params.cpu_registers_ap_offset.into() - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.cpu_registers_fp_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into() - dynamic_params.cpu_registers_fp_column.into() - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.cpu_registers_fp_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length - dynamic_params.cpu_registers_fp_offset.into() - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.cpu_operands_ops_mul_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.cpu_operands_ops_mul_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.cpu_operands_ops_mul_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length - dynamic_params.cpu_operands_ops_mul_offset.into() - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.cpu_operands_res_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into() - dynamic_params.cpu_operands_res_column.into() - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.cpu_operands_res_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length - dynamic_params.cpu_operands_res_offset.into() - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.cpu_update_registers_update_pc_tmp0_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.cpu_update_registers_update_pc_tmp0_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.cpu_update_registers_update_pc_tmp0_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length - dynamic_params.cpu_update_registers_update_pc_tmp0_offset.into() - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.cpu_update_registers_update_pc_tmp1_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.cpu_update_registers_update_pc_tmp1_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.cpu_update_registers_update_pc_tmp1_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length - dynamic_params.cpu_update_registers_update_pc_tmp1_offset.into() - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.memory_sorted_addr_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.memory_sorted_addr_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.memory_sorted_addr_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length - dynamic_params.memory_sorted_addr_offset.into() - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.memory_sorted_value_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.memory_sorted_value_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.memory_sorted_value_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length - dynamic_params.memory_sorted_value_offset.into() - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.range_check16_sorted_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.range_check16_sorted_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.range_check16_sorted_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length - dynamic_params.range_check16_sorted_offset.into() - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.diluted_pool_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into() - dynamic_params.diluted_pool_column.into() - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.diluted_pool_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length - dynamic_params.diluted_pool_offset.into() - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.diluted_check_permuted_values_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.diluted_check_permuted_values_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.diluted_check_permuted_values_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length - dynamic_params.diluted_check_permuted_values_offset.into() - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.pedersen_hash0_ec_subset_sum_partial_sum_x_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.pedersen_hash0_ec_subset_sum_partial_sum_x_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.pedersen_hash0_ec_subset_sum_partial_sum_x_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length - dynamic_params.pedersen_hash0_ec_subset_sum_partial_sum_x_offset.into() - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.pedersen_hash0_ec_subset_sum_partial_sum_y_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.pedersen_hash0_ec_subset_sum_partial_sum_y_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.pedersen_hash0_ec_subset_sum_partial_sum_y_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length - dynamic_params.pedersen_hash0_ec_subset_sum_partial_sum_y_offset.into() - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.pedersen_hash0_ec_subset_sum_slope_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.pedersen_hash0_ec_subset_sum_slope_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.pedersen_hash0_ec_subset_sum_slope_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length - dynamic_params.pedersen_hash0_ec_subset_sum_slope_offset.into() - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.pedersen_hash0_ec_subset_sum_selector_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.pedersen_hash0_ec_subset_sum_selector_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.pedersen_hash0_ec_subset_sum_selector_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length - dynamic_params.pedersen_hash0_ec_subset_sum_selector_offset.into() - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.pedersen_hash0_ec_subset_sum_bit_unpacking_prod_ones196_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.pedersen_hash0_ec_subset_sum_bit_unpacking_prod_ones196_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.pedersen_hash0_ec_subset_sum_bit_unpacking_prod_ones196_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length
        - dynamic_params.pedersen_hash0_ec_subset_sum_bit_unpacking_prod_ones196_offset.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.pedersen_hash0_ec_subset_sum_bit_unpacking_prod_ones192_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.pedersen_hash0_ec_subset_sum_bit_unpacking_prod_ones192_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.pedersen_hash0_ec_subset_sum_bit_unpacking_prod_ones192_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length
        - dynamic_params.pedersen_hash0_ec_subset_sum_bit_unpacking_prod_ones192_offset.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.ecdsa_signature0_key_points_x_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.ecdsa_signature0_key_points_x_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.ecdsa_signature0_key_points_x_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length - dynamic_params.ecdsa_signature0_key_points_x_offset.into() - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.ecdsa_signature0_key_points_y_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.ecdsa_signature0_key_points_y_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.ecdsa_signature0_key_points_y_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length - dynamic_params.ecdsa_signature0_key_points_y_offset.into() - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.ecdsa_signature0_doubling_slope_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.ecdsa_signature0_doubling_slope_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.ecdsa_signature0_doubling_slope_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length - dynamic_params.ecdsa_signature0_doubling_slope_offset.into() - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.ecdsa_signature0_exponentiate_generator_partial_sum_x_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.ecdsa_signature0_exponentiate_generator_partial_sum_x_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.ecdsa_signature0_exponentiate_generator_partial_sum_x_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length
        - dynamic_params.ecdsa_signature0_exponentiate_generator_partial_sum_x_offset.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.ecdsa_signature0_exponentiate_generator_partial_sum_y_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.ecdsa_signature0_exponentiate_generator_partial_sum_y_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.ecdsa_signature0_exponentiate_generator_partial_sum_y_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length
        - dynamic_params.ecdsa_signature0_exponentiate_generator_partial_sum_y_offset.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.ecdsa_signature0_exponentiate_generator_slope_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.ecdsa_signature0_exponentiate_generator_slope_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.ecdsa_signature0_exponentiate_generator_slope_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length
        - dynamic_params.ecdsa_signature0_exponentiate_generator_slope_offset.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.ecdsa_signature0_exponentiate_generator_selector_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.ecdsa_signature0_exponentiate_generator_selector_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.ecdsa_signature0_exponentiate_generator_selector_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length
        - dynamic_params.ecdsa_signature0_exponentiate_generator_selector_offset.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.ecdsa_signature0_exponentiate_generator_x_diff_inv_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.ecdsa_signature0_exponentiate_generator_x_diff_inv_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.ecdsa_signature0_exponentiate_generator_x_diff_inv_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length
        - dynamic_params.ecdsa_signature0_exponentiate_generator_x_diff_inv_offset.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.ecdsa_signature0_exponentiate_key_partial_sum_x_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.ecdsa_signature0_exponentiate_key_partial_sum_x_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.ecdsa_signature0_exponentiate_key_partial_sum_x_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length
        - dynamic_params.ecdsa_signature0_exponentiate_key_partial_sum_x_offset.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.ecdsa_signature0_exponentiate_key_partial_sum_y_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.ecdsa_signature0_exponentiate_key_partial_sum_y_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.ecdsa_signature0_exponentiate_key_partial_sum_y_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length
        - dynamic_params.ecdsa_signature0_exponentiate_key_partial_sum_y_offset.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.ecdsa_signature0_exponentiate_key_slope_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.ecdsa_signature0_exponentiate_key_slope_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.ecdsa_signature0_exponentiate_key_slope_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length - dynamic_params.ecdsa_signature0_exponentiate_key_slope_offset.into() - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.ecdsa_signature0_exponentiate_key_selector_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.ecdsa_signature0_exponentiate_key_selector_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.ecdsa_signature0_exponentiate_key_selector_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length - dynamic_params.ecdsa_signature0_exponentiate_key_selector_offset.into() - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.ecdsa_signature0_exponentiate_key_x_diff_inv_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.ecdsa_signature0_exponentiate_key_x_diff_inv_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.ecdsa_signature0_exponentiate_key_x_diff_inv_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length
        - dynamic_params.ecdsa_signature0_exponentiate_key_x_diff_inv_offset.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.ecdsa_signature0_add_results_slope_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.ecdsa_signature0_add_results_slope_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.ecdsa_signature0_add_results_slope_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length - dynamic_params.ecdsa_signature0_add_results_slope_offset.into() - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.ecdsa_signature0_add_results_inv_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.ecdsa_signature0_add_results_inv_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.ecdsa_signature0_add_results_inv_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length - dynamic_params.ecdsa_signature0_add_results_inv_offset.into() - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.ecdsa_signature0_extract_r_slope_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.ecdsa_signature0_extract_r_slope_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.ecdsa_signature0_extract_r_slope_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length - dynamic_params.ecdsa_signature0_extract_r_slope_offset.into() - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.ecdsa_signature0_extract_r_inv_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.ecdsa_signature0_extract_r_inv_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.ecdsa_signature0_extract_r_inv_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length - dynamic_params.ecdsa_signature0_extract_r_inv_offset.into() - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.ecdsa_signature0_z_inv_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.ecdsa_signature0_z_inv_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.ecdsa_signature0_z_inv_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length - dynamic_params.ecdsa_signature0_z_inv_offset.into() - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.ecdsa_signature0_r_w_inv_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.ecdsa_signature0_r_w_inv_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.ecdsa_signature0_r_w_inv_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length - dynamic_params.ecdsa_signature0_r_w_inv_offset.into() - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.ecdsa_signature0_q_x_squared_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.ecdsa_signature0_q_x_squared_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.ecdsa_signature0_q_x_squared_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length - dynamic_params.ecdsa_signature0_q_x_squared_offset.into() - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.ec_op_doubled_points_x_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.ec_op_doubled_points_x_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.ec_op_doubled_points_x_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length - dynamic_params.ec_op_doubled_points_x_offset.into() - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.ec_op_doubled_points_y_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.ec_op_doubled_points_y_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.ec_op_doubled_points_y_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length - dynamic_params.ec_op_doubled_points_y_offset.into() - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.ec_op_doubling_slope_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.ec_op_doubling_slope_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.ec_op_doubling_slope_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length - dynamic_params.ec_op_doubling_slope_offset.into() - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.ec_op_ec_subset_sum_partial_sum_x_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.ec_op_ec_subset_sum_partial_sum_x_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.ec_op_ec_subset_sum_partial_sum_x_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length - dynamic_params.ec_op_ec_subset_sum_partial_sum_x_offset.into() - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.ec_op_ec_subset_sum_partial_sum_y_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.ec_op_ec_subset_sum_partial_sum_y_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.ec_op_ec_subset_sum_partial_sum_y_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length - dynamic_params.ec_op_ec_subset_sum_partial_sum_y_offset.into() - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.ec_op_ec_subset_sum_slope_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.ec_op_ec_subset_sum_slope_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.ec_op_ec_subset_sum_slope_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length - dynamic_params.ec_op_ec_subset_sum_slope_offset.into() - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.ec_op_ec_subset_sum_selector_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.ec_op_ec_subset_sum_selector_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.ec_op_ec_subset_sum_selector_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length - dynamic_params.ec_op_ec_subset_sum_selector_offset.into() - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.ec_op_ec_subset_sum_x_diff_inv_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.ec_op_ec_subset_sum_x_diff_inv_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.ec_op_ec_subset_sum_x_diff_inv_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length - dynamic_params.ec_op_ec_subset_sum_x_diff_inv_offset.into() - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.ec_op_ec_subset_sum_bit_unpacking_prod_ones196_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.ec_op_ec_subset_sum_bit_unpacking_prod_ones196_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.ec_op_ec_subset_sum_bit_unpacking_prod_ones196_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length
        - dynamic_params.ec_op_ec_subset_sum_bit_unpacking_prod_ones196_offset.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.ec_op_ec_subset_sum_bit_unpacking_prod_ones192_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.ec_op_ec_subset_sum_bit_unpacking_prod_ones192_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.ec_op_ec_subset_sum_bit_unpacking_prod_ones192_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length
        - dynamic_params.ec_op_ec_subset_sum_bit_unpacking_prod_ones192_offset.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.keccak_keccak_parse_to_diluted_reshaped_intermediate_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.keccak_keccak_parse_to_diluted_reshaped_intermediate_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.keccak_keccak_parse_to_diluted_reshaped_intermediate_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length
        - dynamic_params.keccak_keccak_parse_to_diluted_reshaped_intermediate_offset.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.keccak_keccak_parse_to_diluted_final_reshaped_input_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.keccak_keccak_parse_to_diluted_final_reshaped_input_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.keccak_keccak_parse_to_diluted_final_reshaped_input_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length
        - dynamic_params.keccak_keccak_parse_to_diluted_final_reshaped_input_offset.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.keccak_keccak_parse_to_diluted_cumulative_sum_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.keccak_keccak_parse_to_diluted_cumulative_sum_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.keccak_keccak_parse_to_diluted_cumulative_sum_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length
        - dynamic_params.keccak_keccak_parse_to_diluted_cumulative_sum_offset.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.keccak_keccak_rotated_parity0_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.keccak_keccak_rotated_parity0_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.keccak_keccak_rotated_parity0_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length - dynamic_params.keccak_keccak_rotated_parity0_offset.into() - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.keccak_keccak_rotated_parity1_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.keccak_keccak_rotated_parity1_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.keccak_keccak_rotated_parity1_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length - dynamic_params.keccak_keccak_rotated_parity1_offset.into() - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.keccak_keccak_rotated_parity2_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.keccak_keccak_rotated_parity2_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.keccak_keccak_rotated_parity2_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length - dynamic_params.keccak_keccak_rotated_parity2_offset.into() - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.keccak_keccak_rotated_parity3_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.keccak_keccak_rotated_parity3_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.keccak_keccak_rotated_parity3_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length - dynamic_params.keccak_keccak_rotated_parity3_offset.into() - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.keccak_keccak_rotated_parity4_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.keccak_keccak_rotated_parity4_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.keccak_keccak_rotated_parity4_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length - dynamic_params.keccak_keccak_rotated_parity4_offset.into() - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.poseidon_poseidon_full_rounds_state0_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.poseidon_poseidon_full_rounds_state0_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.poseidon_poseidon_full_rounds_state0_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length - dynamic_params.poseidon_poseidon_full_rounds_state0_offset.into() - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.poseidon_poseidon_full_rounds_state1_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.poseidon_poseidon_full_rounds_state1_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.poseidon_poseidon_full_rounds_state1_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length - dynamic_params.poseidon_poseidon_full_rounds_state1_offset.into() - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.poseidon_poseidon_full_rounds_state2_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.poseidon_poseidon_full_rounds_state2_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.poseidon_poseidon_full_rounds_state2_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length - dynamic_params.poseidon_poseidon_full_rounds_state2_offset.into() - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.poseidon_poseidon_full_rounds_state0_squared_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.poseidon_poseidon_full_rounds_state0_squared_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.poseidon_poseidon_full_rounds_state0_squared_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length
        - dynamic_params.poseidon_poseidon_full_rounds_state0_squared_offset.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.poseidon_poseidon_full_rounds_state1_squared_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.poseidon_poseidon_full_rounds_state1_squared_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.poseidon_poseidon_full_rounds_state1_squared_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length
        - dynamic_params.poseidon_poseidon_full_rounds_state1_squared_offset.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.poseidon_poseidon_full_rounds_state2_squared_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.poseidon_poseidon_full_rounds_state2_squared_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.poseidon_poseidon_full_rounds_state2_squared_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length
        - dynamic_params.poseidon_poseidon_full_rounds_state2_squared_offset.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.poseidon_poseidon_partial_rounds_state0_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.poseidon_poseidon_partial_rounds_state0_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.poseidon_poseidon_partial_rounds_state0_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length - dynamic_params.poseidon_poseidon_partial_rounds_state0_offset.into() - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.poseidon_poseidon_partial_rounds_state1_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.poseidon_poseidon_partial_rounds_state1_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.poseidon_poseidon_partial_rounds_state1_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length - dynamic_params.poseidon_poseidon_partial_rounds_state1_offset.into() - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.poseidon_poseidon_partial_rounds_state0_squared_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.poseidon_poseidon_partial_rounds_state0_squared_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.poseidon_poseidon_partial_rounds_state0_squared_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length
        - dynamic_params.poseidon_poseidon_partial_rounds_state0_squared_offset.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.poseidon_poseidon_partial_rounds_state1_squared_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.poseidon_poseidon_partial_rounds_state1_squared_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.poseidon_poseidon_partial_rounds_state1_squared_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length
        - dynamic_params.poseidon_poseidon_partial_rounds_state1_squared_offset.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.add_mod_sub_p_bit_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.add_mod_sub_p_bit_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.add_mod_sub_p_bit_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length - dynamic_params.add_mod_sub_p_bit_offset.into() - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.add_mod_carry1_bit_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.add_mod_carry1_bit_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.add_mod_carry1_bit_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length - dynamic_params.add_mod_carry1_bit_offset.into() - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.add_mod_carry2_bit_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.add_mod_carry2_bit_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.add_mod_carry2_bit_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length - dynamic_params.add_mod_carry2_bit_offset.into() - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.add_mod_carry3_bit_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.add_mod_carry3_bit_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.add_mod_carry3_bit_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length - dynamic_params.add_mod_carry3_bit_offset.into() - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.add_mod_carry1_sign_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.add_mod_carry1_sign_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.add_mod_carry1_sign_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length - dynamic_params.add_mod_carry1_sign_offset.into() - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.add_mod_carry2_sign_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.add_mod_carry2_sign_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.add_mod_carry2_sign_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length - dynamic_params.add_mod_carry2_sign_offset.into() - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.add_mod_carry3_sign_column.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        - dynamic_params.add_mod_carry3_sign_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.add_mod_carry3_sign_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length - dynamic_params.add_mod_carry3_sign_offset.into() - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.memory_multi_column_perm_perm_cum_prod0_column.into()
        - dynamic_params.num_columns_first.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        + dynamic_params.num_columns_second.into()
        - dynamic_params.memory_multi_column_perm_perm_cum_prod0_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.memory_multi_column_perm_perm_cum_prod0_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length - dynamic_params.memory_multi_column_perm_perm_cum_prod0_offset.into() - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.range_check16_perm_cum_prod0_column.into()
        - dynamic_params.num_columns_first.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        + dynamic_params.num_columns_second.into()
        - dynamic_params.range_check16_perm_cum_prod0_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.range_check16_perm_cum_prod0_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length - dynamic_params.range_check16_perm_cum_prod0_offset.into() - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.diluted_check_cumulative_value_column.into()
        - dynamic_params.num_columns_first.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        + dynamic_params.num_columns_second.into()
        - dynamic_params.diluted_check_cumulative_value_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.diluted_check_cumulative_value_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length - dynamic_params.diluted_check_cumulative_value_offset.into() - 1;
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.diluted_check_permutation_cum_prod0_column.into()
        - dynamic_params.num_columns_first.into();
    assert_range_u128_from_u256(x);

    // Column index out of range.
    x = dynamic_params.num_columns_first.into()
        + dynamic_params.num_columns_second.into()
        - dynamic_params.diluted_check_permutation_cum_prod0_column.into()
        - 1;
    assert_range_u128_from_u256(x);

    // Offset must be nonnegative.
    x = dynamic_params.diluted_check_permutation_cum_prod0_offset.into();
    assert_range_u128_from_u256(x);

    // Offset must be smaller than trace length.
    x = trace_length - dynamic_params.diluted_check_permutation_cum_prod0_offset.into() - 1;
    assert_range_u128_from_u256(x);

    if (dynamic_params.uses_pedersen_builtin.into() != 0) {
        // Row ratio should be a power of 2, smaller than trace length.
        x = dynamic_params.pedersen_builtin_row_ratio.into();
        assert_is_power_of_2(x);
        // Dimension should be a power of 2.
        x = (trace_length / dynamic_params.pedersen_builtin_row_ratio.into());
        assert_is_power_of_2(x);
        // Coset step ((dynamicparam(pedersen_builtin_row_ratio)) / (512)) must be a power of two.
        x = dynamic_params.pedersen_builtin_row_ratio.into() / 512;
        assert_is_power_of_2(x);
        // Coset step ((dynamicparam(pedersen_builtin_row_ratio)) / (2)) must be a power of two.
        x = dynamic_params.pedersen_builtin_row_ratio.into() / 2;
        assert_is_power_of_2(x);
        // Step must not exceed dimension.
        x = (trace_length / dynamic_params.pedersen_builtin_row_ratio.into()) - 1;
        assert_range_u128_from_u256(x);

        // Index should be non negative.
        x = (trace_length / dynamic_params.pedersen_builtin_row_ratio.into());
        assert_range_u128_from_u256(x);

        // Coset step (memberexpression(trace_length)) must be a power of two.
        x = trace_length;
        assert_is_power_of_2(x);
        // Offset of pedersen/input0 must be nonnegative.
        x = dynamic_params.pedersen_input0_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of pedersen/input0 is too big.
        x = trace_length - dynamic_params.pedersen_input0_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of pedersen/input0 is too big.
        x = dynamic_params.pedersen_builtin_row_ratio.into()
            - dynamic_params.pedersen_input0_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of pedersen/input1 must be nonnegative.
        x = dynamic_params.pedersen_input1_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of pedersen/input1 is too big.
        x = trace_length - dynamic_params.pedersen_input1_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of pedersen/input1 is too big.
        x = dynamic_params.pedersen_builtin_row_ratio.into()
            - dynamic_params.pedersen_input1_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of pedersen/output must be nonnegative.
        x = dynamic_params.pedersen_output_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of pedersen/output is too big.
        x = trace_length - dynamic_params.pedersen_output_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of pedersen/output is too big.
        x = dynamic_params.pedersen_builtin_row_ratio.into()
            - dynamic_params.pedersen_output_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);
    }

    if (dynamic_params.uses_range_check_builtin.into() != 0) {
        // Coset step (memberexpression(trace_length)) must be a power of two.
        x = trace_length;
        assert_is_power_of_2(x);
        // Row ratio should be a power of 2, smaller than trace length.
        x = dynamic_params.range_check_builtin_row_ratio.into();
        assert_is_power_of_2(x);
        // Dimension should be a power of 2.
        x = (trace_length / dynamic_params.range_check_builtin_row_ratio.into());
        assert_is_power_of_2(x);
        // Step must not exceed dimension.
        x = (trace_length / dynamic_params.range_check_builtin_row_ratio.into()) - 1;
        assert_range_u128_from_u256(x);

        // Index should be non negative.
        x = (trace_length / dynamic_params.range_check_builtin_row_ratio.into());
        assert_range_u128_from_u256(x);

        // Coset step ((dynamicparam(range_check_builtin_row_ratio)) / (8)) must be a power of two.
        x = dynamic_params.range_check_builtin_row_ratio.into() / 8;
        assert_is_power_of_2(x);
        // Offset of range_check_builtin/mem must be nonnegative.
        x = dynamic_params.range_check_builtin_mem_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of range_check_builtin/mem is too big.
        x = trace_length - dynamic_params.range_check_builtin_mem_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of range_check_builtin/mem is too big.
        x = dynamic_params.range_check_builtin_row_ratio.into()
            - dynamic_params.range_check_builtin_mem_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of range_check_builtin/inner_range_check must be nonnegative.
        x = dynamic_params.range_check_builtin_inner_range_check_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of range_check_builtin/inner_range_check is too big.
        x = trace_length
            - dynamic_params.range_check_builtin_inner_range_check_suboffset.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of range_check_builtin/inner_range_check is too big.
        x = dynamic_params.range_check_builtin_row_ratio.into() / 8
            - dynamic_params.range_check_builtin_inner_range_check_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);
    }

    if (dynamic_params.uses_ecdsa_builtin.into() != 0) {
        // Row ratio should be a power of 2, smaller than trace length.
        x = dynamic_params.ecdsa_builtin_row_ratio.into();
        assert_is_power_of_2(x);
        // Dimension should be a power of 2.
        x = (trace_length / dynamic_params.ecdsa_builtin_row_ratio.into());
        assert_is_power_of_2(x);
        // Coset step ((dynamicparam(ecdsa_builtin_row_ratio)) / (512)) must be a power of two.
        x = dynamic_params.ecdsa_builtin_row_ratio.into() / 512;
        assert_is_power_of_2(x);
        // Step must not exceed dimension.
        x = (trace_length / dynamic_params.ecdsa_builtin_row_ratio.into()) - 1;
        assert_range_u128_from_u256(x);

        // Index should be non negative.
        x = (trace_length / dynamic_params.ecdsa_builtin_row_ratio.into());
        assert_range_u128_from_u256(x);

        // Coset step ((dynamicparam(ecdsa_builtin_row_ratio)) / (256)) must be a power of two.
        x = dynamic_params.ecdsa_builtin_row_ratio.into() / 256;
        assert_is_power_of_2(x);
        // Coset step (memberexpression(trace_length)) must be a power of two.
        x = trace_length;
        assert_is_power_of_2(x);
        // Coset step ((dynamicparam(ecdsa_builtin_row_ratio)) / (2)) must be a power of two.
        x = dynamic_params.ecdsa_builtin_row_ratio.into() / 2;
        assert_is_power_of_2(x);
        // Offset of ecdsa/pubkey must be nonnegative.
        x = dynamic_params.ecdsa_pubkey_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of ecdsa/pubkey is too big.
        x = trace_length - dynamic_params.ecdsa_pubkey_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of ecdsa/pubkey is too big.
        x = dynamic_params.ecdsa_builtin_row_ratio.into()
            - dynamic_params.ecdsa_pubkey_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of ecdsa/message must be nonnegative.
        x = dynamic_params.ecdsa_message_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of ecdsa/message is too big.
        x = trace_length - dynamic_params.ecdsa_message_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of ecdsa/message is too big.
        x = dynamic_params.ecdsa_builtin_row_ratio.into()
            - dynamic_params.ecdsa_message_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);
    }

    if (dynamic_params.uses_bitwise_builtin.into() != 0) {
        // Row ratio should be a power of 2, smaller than trace length.
        x = dynamic_params.bitwise_row_ratio.into();
        assert_is_power_of_2(x);
        // Dimension should be a power of 2.
        x = (trace_length / dynamic_params.bitwise_row_ratio.into());
        assert_is_power_of_2(x);
        // Coset step ((dynamicparam(bitwise_row_ratio)) / (64)) must be a power of two.
        x = dynamic_params.bitwise_row_ratio.into() / 64;
        assert_is_power_of_2(x);
        // Coset step ((dynamicparam(bitwise_row_ratio)) / (4)) must be a power of two.
        x = dynamic_params.bitwise_row_ratio.into() / 4;
        assert_is_power_of_2(x);
        // Index out of range.
        x = trace_length / dynamic_params.bitwise_row_ratio.into() - 1;
        assert_range_u128_from_u256(x);

        // Index should be non negative.
        x = (trace_length / dynamic_params.bitwise_row_ratio.into());
        assert_range_u128_from_u256(x);

        // Coset step (memberexpression(trace_length)) must be a power of two.
        x = trace_length;
        assert_is_power_of_2(x);
        // Offset of bitwise/var_pool must be nonnegative.
        x = dynamic_params.bitwise_var_pool_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of bitwise/var_pool is too big.
        x = trace_length - dynamic_params.bitwise_var_pool_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of bitwise/var_pool is too big.
        x = dynamic_params.bitwise_row_ratio.into() / 4
            - dynamic_params.bitwise_var_pool_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of bitwise/x_or_y must be nonnegative.
        x = dynamic_params.bitwise_x_or_y_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of bitwise/x_or_y is too big.
        x = trace_length - dynamic_params.bitwise_x_or_y_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of bitwise/x_or_y is too big.
        x = dynamic_params.bitwise_row_ratio.into()
            - dynamic_params.bitwise_x_or_y_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of bitwise/diluted_var_pool must be nonnegative.
        x = dynamic_params.bitwise_diluted_var_pool_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of bitwise/diluted_var_pool is too big.
        x = trace_length - dynamic_params.bitwise_diluted_var_pool_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of bitwise/diluted_var_pool is too big.
        x = dynamic_params.bitwise_row_ratio.into() / 64
            - dynamic_params.bitwise_diluted_var_pool_suboffset.into()
                * dynamic_params.diluted_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of bitwise/trim_unpacking192 must be nonnegative.
        x = dynamic_params.bitwise_trim_unpacking192_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of bitwise/trim_unpacking192 is too big.
        x = trace_length - dynamic_params.bitwise_trim_unpacking192_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of bitwise/trim_unpacking192 is too big.
        x = dynamic_params.bitwise_row_ratio.into()
            - dynamic_params.bitwise_trim_unpacking192_suboffset.into()
                * dynamic_params.diluted_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of bitwise/trim_unpacking193 must be nonnegative.
        x = dynamic_params.bitwise_trim_unpacking193_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of bitwise/trim_unpacking193 is too big.
        x = trace_length - dynamic_params.bitwise_trim_unpacking193_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of bitwise/trim_unpacking193 is too big.
        x = dynamic_params.bitwise_row_ratio.into()
            - dynamic_params.bitwise_trim_unpacking193_suboffset.into()
                * dynamic_params.diluted_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of bitwise/trim_unpacking194 must be nonnegative.
        x = dynamic_params.bitwise_trim_unpacking194_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of bitwise/trim_unpacking194 is too big.
        x = trace_length - dynamic_params.bitwise_trim_unpacking194_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of bitwise/trim_unpacking194 is too big.
        x = dynamic_params.bitwise_row_ratio.into()
            - dynamic_params.bitwise_trim_unpacking194_suboffset.into()
                * dynamic_params.diluted_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of bitwise/trim_unpacking195 must be nonnegative.
        x = dynamic_params.bitwise_trim_unpacking195_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of bitwise/trim_unpacking195 is too big.
        x = trace_length - dynamic_params.bitwise_trim_unpacking195_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of bitwise/trim_unpacking195 is too big.
        x = dynamic_params.bitwise_row_ratio.into()
            - dynamic_params.bitwise_trim_unpacking195_suboffset.into()
                * dynamic_params.diluted_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);
    }

    if (dynamic_params.uses_ec_op_builtin.into() != 0) {
        // Row ratio should be a power of 2, smaller than trace length.
        x = dynamic_params.ec_op_builtin_row_ratio.into();
        assert_is_power_of_2(x);
        // Dimension should be a power of 2.
        x = (trace_length / dynamic_params.ec_op_builtin_row_ratio.into());
        assert_is_power_of_2(x);
        // Coset step ((dynamicparam(ec_op_builtin_row_ratio)) / (256)) must be a power of two.
        x = dynamic_params.ec_op_builtin_row_ratio.into() / 256;
        assert_is_power_of_2(x);
        // Index out of range.
        x = (trace_length / dynamic_params.ec_op_builtin_row_ratio.into()) - 1;
        assert_range_u128_from_u256(x);

        // Index should be non negative.
        x = (trace_length / dynamic_params.ec_op_builtin_row_ratio.into());
        assert_range_u128_from_u256(x);

        // Coset step (memberexpression(trace_length)) must be a power of two.
        x = trace_length;
        assert_is_power_of_2(x);
        // Offset of ec_op/p_x must be nonnegative.
        x = dynamic_params.ec_op_p_x_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of ec_op/p_x is too big.
        x = trace_length - dynamic_params.ec_op_p_x_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of ec_op/p_x is too big.
        x = dynamic_params.ec_op_builtin_row_ratio.into()
            - dynamic_params.ec_op_p_x_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of ec_op/p_y must be nonnegative.
        x = dynamic_params.ec_op_p_y_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of ec_op/p_y is too big.
        x = trace_length - dynamic_params.ec_op_p_y_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of ec_op/p_y is too big.
        x = dynamic_params.ec_op_builtin_row_ratio.into()
            - dynamic_params.ec_op_p_y_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of ec_op/q_x must be nonnegative.
        x = dynamic_params.ec_op_q_x_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of ec_op/q_x is too big.
        x = trace_length - dynamic_params.ec_op_q_x_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of ec_op/q_x is too big.
        x = dynamic_params.ec_op_builtin_row_ratio.into()
            - dynamic_params.ec_op_q_x_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of ec_op/q_y must be nonnegative.
        x = dynamic_params.ec_op_q_y_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of ec_op/q_y is too big.
        x = trace_length - dynamic_params.ec_op_q_y_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of ec_op/q_y is too big.
        x = dynamic_params.ec_op_builtin_row_ratio.into()
            - dynamic_params.ec_op_q_y_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of ec_op/m must be nonnegative.
        x = dynamic_params.ec_op_m_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of ec_op/m is too big.
        x = trace_length - dynamic_params.ec_op_m_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of ec_op/m is too big.
        x = dynamic_params.ec_op_builtin_row_ratio.into()
            - dynamic_params.ec_op_m_suboffset.into() * dynamic_params.memory_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of ec_op/r_x must be nonnegative.
        x = dynamic_params.ec_op_r_x_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of ec_op/r_x is too big.
        x = trace_length - dynamic_params.ec_op_r_x_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of ec_op/r_x is too big.
        x = dynamic_params.ec_op_builtin_row_ratio.into()
            - dynamic_params.ec_op_r_x_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of ec_op/r_y must be nonnegative.
        x = dynamic_params.ec_op_r_y_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of ec_op/r_y is too big.
        x = trace_length - dynamic_params.ec_op_r_y_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of ec_op/r_y is too big.
        x = dynamic_params.ec_op_builtin_row_ratio.into()
            - dynamic_params.ec_op_r_y_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);
    }

    if (dynamic_params.uses_keccak_builtin.into() != 0) {
        // Coset step ((dynamicparam(keccak_row_ratio)) / (4096)) must be a power of two.
        x = dynamic_params.keccak_row_ratio.into() / 4096;
        assert_is_power_of_2(x);
        // Dimension should be a power of 2.
        x = (trace_length / (16 * dynamic_params.keccak_row_ratio.into()));
        assert_is_power_of_2(x);
        // Coset step ((dynamicparam(keccak_row_ratio)) / (128)) must be a power of two.
        x = dynamic_params.keccak_row_ratio.into() / 128;
        assert_is_power_of_2(x);
        // Coset step ((dynamicparam(keccak_row_ratio)) / (32768)) must be a power of two.
        x = dynamic_params.keccak_row_ratio.into() / 32768;
        assert_is_power_of_2(x);
        // Row ratio should be a power of 2, smaller than trace length.
        x = dynamic_params.keccak_row_ratio.into();
        assert_is_power_of_2(x);
        // Coset step ((dynamicparam(keccak_row_ratio)) / (16)) must be a power of two.
        x = dynamic_params.keccak_row_ratio.into() / 16;
        assert_is_power_of_2(x);
        // Dimension should be a power of 2.
        x = (16 * trace_length) / dynamic_params.keccak_row_ratio.into();
        assert_is_power_of_2(x);
        // Index out of range.
        x = (16 * trace_length) / dynamic_params.keccak_row_ratio.into() - 1;
        assert_range_u128_from_u256(x);

        // Index should be non negative.
        x = (16 * trace_length) / dynamic_params.keccak_row_ratio.into();
        assert_range_u128_from_u256(x);

        // Coset step (memberexpression(trace_length)) must be a power of two.
        x = trace_length;
        assert_is_power_of_2(x);
        // Offset of keccak/input_output must be nonnegative.
        x = dynamic_params.keccak_input_output_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of keccak/input_output is too big.
        x = trace_length - dynamic_params.keccak_input_output_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of keccak/input_output is too big.
        x = dynamic_params.keccak_row_ratio.into() / 16
            - dynamic_params.keccak_input_output_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of keccak/keccak/diluted_column0 must be nonnegative.
        x = dynamic_params.keccak_keccak_diluted_column0_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of keccak/keccak/diluted_column0 is too big.
        x = trace_length - dynamic_params.keccak_keccak_diluted_column0_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of keccak/keccak/diluted_column0 is too big.
        x = dynamic_params.keccak_row_ratio.into() / 4096
            - dynamic_params.keccak_keccak_diluted_column0_suboffset.into()
                * dynamic_params.diluted_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of keccak/keccak/diluted_column1 must be nonnegative.
        x = dynamic_params.keccak_keccak_diluted_column1_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of keccak/keccak/diluted_column1 is too big.
        x = trace_length - dynamic_params.keccak_keccak_diluted_column1_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of keccak/keccak/diluted_column1 is too big.
        x = dynamic_params.keccak_row_ratio.into() / 4096
            - dynamic_params.keccak_keccak_diluted_column1_suboffset.into()
                * dynamic_params.diluted_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of keccak/keccak/diluted_column2 must be nonnegative.
        x = dynamic_params.keccak_keccak_diluted_column2_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of keccak/keccak/diluted_column2 is too big.
        x = trace_length - dynamic_params.keccak_keccak_diluted_column2_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of keccak/keccak/diluted_column2 is too big.
        x = dynamic_params.keccak_row_ratio.into() / 4096
            - dynamic_params.keccak_keccak_diluted_column2_suboffset.into()
                * dynamic_params.diluted_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of keccak/keccak/diluted_column3 must be nonnegative.
        x = dynamic_params.keccak_keccak_diluted_column3_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of keccak/keccak/diluted_column3 is too big.
        x = trace_length - dynamic_params.keccak_keccak_diluted_column3_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of keccak/keccak/diluted_column3 is too big.
        x = dynamic_params.keccak_row_ratio.into() / 4096
            - dynamic_params.keccak_keccak_diluted_column3_suboffset.into()
                * dynamic_params.diluted_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);
    }

    if (dynamic_params.uses_poseidon_builtin.into() != 0) {
        // Row ratio should be a power of 2, smaller than trace length.
        x = dynamic_params.poseidon_row_ratio.into();
        assert_is_power_of_2(x);
        // Dimension should be a power of 2.
        x = (trace_length / dynamic_params.poseidon_row_ratio.into());
        assert_is_power_of_2(x);
        // Coset step ((dynamicparam(poseidon_row_ratio)) / (32)) must be a power of two.
        x = dynamic_params.poseidon_row_ratio.into() / 32;
        assert_is_power_of_2(x);
        // Coset step ((dynamicparam(poseidon_row_ratio)) / (8)) must be a power of two.
        x = dynamic_params.poseidon_row_ratio.into() / 8;
        assert_is_power_of_2(x);
        // Coset step ((dynamicparam(poseidon_row_ratio)) / (64)) must be a power of two.
        x = dynamic_params.poseidon_row_ratio.into() / 64;
        assert_is_power_of_2(x);
        // Coset step ((dynamicparam(poseidon_row_ratio)) / (2)) must be a power of two.
        x = dynamic_params.poseidon_row_ratio.into() / 2;
        assert_is_power_of_2(x);
        // Dimension should be a power of 2.
        x = 2 * trace_length / dynamic_params.poseidon_row_ratio.into();
        assert_is_power_of_2(x);
        // Index out of range.
        x = 2 * trace_length / dynamic_params.poseidon_row_ratio.into() - 1;
        assert_range_u128_from_u256(x);

        // Index should be non negative.
        x = 2 * trace_length / dynamic_params.poseidon_row_ratio.into();
        assert_range_u128_from_u256(x);

        // Coset step (memberexpression(trace_length)) must be a power of two.
        x = trace_length;
        assert_is_power_of_2(x);
        // Offset of poseidon/param_0/input_output must be nonnegative.
        x = dynamic_params.poseidon_param_0_input_output_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of poseidon/param_0/input_output is too big.
        x = trace_length - dynamic_params.poseidon_param_0_input_output_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of poseidon/param_0/input_output is too big.
        x = dynamic_params.poseidon_row_ratio.into() / 2
            - dynamic_params.poseidon_param_0_input_output_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of poseidon/param_1/input_output must be nonnegative.
        x = dynamic_params.poseidon_param_1_input_output_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of poseidon/param_1/input_output is too big.
        x = trace_length - dynamic_params.poseidon_param_1_input_output_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of poseidon/param_1/input_output is too big.
        x = dynamic_params.poseidon_row_ratio.into() / 2
            - dynamic_params.poseidon_param_1_input_output_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of poseidon/param_2/input_output must be nonnegative.
        x = dynamic_params.poseidon_param_2_input_output_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of poseidon/param_2/input_output is too big.
        x = trace_length - dynamic_params.poseidon_param_2_input_output_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of poseidon/param_2/input_output is too big.
        x = dynamic_params.poseidon_row_ratio.into() / 2
            - dynamic_params.poseidon_param_2_input_output_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);
    }

    if (dynamic_params.uses_range_check96_builtin.into() != 0) {
        // Coset step (memberexpression(trace_length)) must be a power of two.
        x = trace_length;
        assert_is_power_of_2(x);
        // Row ratio should be a power of 2, smaller than trace length.
        x = dynamic_params.range_check96_builtin_row_ratio.into();
        assert_is_power_of_2(x);
        // Dimension should be a power of 2.
        x = (trace_length / dynamic_params.range_check96_builtin_row_ratio.into());
        assert_is_power_of_2(x);
        // Step must not exceed dimension.
        x = (trace_length / dynamic_params.range_check96_builtin_row_ratio.into()) - 1;
        assert_range_u128_from_u256(x);

        // Index should be non negative.
        x = (trace_length / dynamic_params.range_check96_builtin_row_ratio.into());
        assert_range_u128_from_u256(x);

        // Offset of range_check96_builtin/mem must be nonnegative.
        x = dynamic_params.range_check96_builtin_mem_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of range_check96_builtin/mem is too big.
        x = trace_length - dynamic_params.range_check96_builtin_mem_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of range_check96_builtin/mem is too big.
        x = dynamic_params.range_check96_builtin_row_ratio.into()
            - dynamic_params.range_check96_builtin_mem_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of range_check96_builtin/inner_range_check0 must be nonnegative.
        x = dynamic_params.range_check96_builtin_inner_range_check0_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of range_check96_builtin/inner_range_check0 is too big.
        x = trace_length
            - dynamic_params.range_check96_builtin_inner_range_check0_suboffset.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of range_check96_builtin/inner_range_check0 is too big.
        x = dynamic_params.range_check96_builtin_row_ratio.into()
            - dynamic_params.range_check96_builtin_inner_range_check0_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of range_check96_builtin/inner_range_check1 must be nonnegative.
        x = dynamic_params.range_check96_builtin_inner_range_check1_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of range_check96_builtin/inner_range_check1 is too big.
        x = trace_length
            - dynamic_params.range_check96_builtin_inner_range_check1_suboffset.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of range_check96_builtin/inner_range_check1 is too big.
        x = dynamic_params.range_check96_builtin_row_ratio.into()
            - dynamic_params.range_check96_builtin_inner_range_check1_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of range_check96_builtin/inner_range_check2 must be nonnegative.
        x = dynamic_params.range_check96_builtin_inner_range_check2_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of range_check96_builtin/inner_range_check2 is too big.
        x = trace_length
            - dynamic_params.range_check96_builtin_inner_range_check2_suboffset.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of range_check96_builtin/inner_range_check2 is too big.
        x = dynamic_params.range_check96_builtin_row_ratio.into()
            - dynamic_params.range_check96_builtin_inner_range_check2_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of range_check96_builtin/inner_range_check3 must be nonnegative.
        x = dynamic_params.range_check96_builtin_inner_range_check3_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of range_check96_builtin/inner_range_check3 is too big.
        x = trace_length
            - dynamic_params.range_check96_builtin_inner_range_check3_suboffset.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of range_check96_builtin/inner_range_check3 is too big.
        x = dynamic_params.range_check96_builtin_row_ratio.into()
            - dynamic_params.range_check96_builtin_inner_range_check3_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of range_check96_builtin/inner_range_check4 must be nonnegative.
        x = dynamic_params.range_check96_builtin_inner_range_check4_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of range_check96_builtin/inner_range_check4 is too big.
        x = trace_length
            - dynamic_params.range_check96_builtin_inner_range_check4_suboffset.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of range_check96_builtin/inner_range_check4 is too big.
        x = dynamic_params.range_check96_builtin_row_ratio.into()
            - dynamic_params.range_check96_builtin_inner_range_check4_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of range_check96_builtin/inner_range_check5 must be nonnegative.
        x = dynamic_params.range_check96_builtin_inner_range_check5_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of range_check96_builtin/inner_range_check5 is too big.
        x = trace_length
            - dynamic_params.range_check96_builtin_inner_range_check5_suboffset.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of range_check96_builtin/inner_range_check5 is too big.
        x = dynamic_params.range_check96_builtin_row_ratio.into()
            - dynamic_params.range_check96_builtin_inner_range_check5_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);
    }

    if (dynamic_params.uses_add_mod_builtin.into() != 0) {
        // Row ratio should be a power of 2, smaller than trace length.
        x = dynamic_params.add_mod_row_ratio.into();
        assert_is_power_of_2(x);
        // Dimension should be a power of 2.
        x = (trace_length / dynamic_params.add_mod_row_ratio.into());
        assert_is_power_of_2(x);
        // Index out of range.
        x = (trace_length / dynamic_params.add_mod_row_ratio.into()) - 1;
        assert_range_u128_from_u256(x);

        // Index should be non negative.
        x = (trace_length / dynamic_params.add_mod_row_ratio.into());
        assert_range_u128_from_u256(x);

        // Coset step (memberexpression(trace_length)) must be a power of two.
        x = trace_length;
        assert_is_power_of_2(x);
        // Offset of add_mod/p0 must be nonnegative.
        x = dynamic_params.add_mod_p0_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of add_mod/p0 is too big.
        x = trace_length - dynamic_params.add_mod_p0_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of add_mod/p0 is too big.
        x = dynamic_params.add_mod_row_ratio.into()
            - dynamic_params.add_mod_p0_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of add_mod/p1 must be nonnegative.
        x = dynamic_params.add_mod_p1_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of add_mod/p1 is too big.
        x = trace_length - dynamic_params.add_mod_p1_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of add_mod/p1 is too big.
        x = dynamic_params.add_mod_row_ratio.into()
            - dynamic_params.add_mod_p1_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of add_mod/p2 must be nonnegative.
        x = dynamic_params.add_mod_p2_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of add_mod/p2 is too big.
        x = trace_length - dynamic_params.add_mod_p2_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of add_mod/p2 is too big.
        x = dynamic_params.add_mod_row_ratio.into()
            - dynamic_params.add_mod_p2_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of add_mod/p3 must be nonnegative.
        x = dynamic_params.add_mod_p3_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of add_mod/p3 is too big.
        x = trace_length - dynamic_params.add_mod_p3_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of add_mod/p3 is too big.
        x = dynamic_params.add_mod_row_ratio.into()
            - dynamic_params.add_mod_p3_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of add_mod/values_ptr must be nonnegative.
        x = dynamic_params.add_mod_values_ptr_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of add_mod/values_ptr is too big.
        x = trace_length - dynamic_params.add_mod_values_ptr_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of add_mod/values_ptr is too big.
        x = dynamic_params.add_mod_row_ratio.into()
            - dynamic_params.add_mod_values_ptr_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of add_mod/offsets_ptr must be nonnegative.
        x = dynamic_params.add_mod_offsets_ptr_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of add_mod/offsets_ptr is too big.
        x = trace_length - dynamic_params.add_mod_offsets_ptr_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of add_mod/offsets_ptr is too big.
        x = dynamic_params.add_mod_row_ratio.into()
            - dynamic_params.add_mod_offsets_ptr_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of add_mod/n must be nonnegative.
        x = dynamic_params.add_mod_n_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of add_mod/n is too big.
        x = trace_length - dynamic_params.add_mod_n_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of add_mod/n is too big.
        x = dynamic_params.add_mod_row_ratio.into()
            - dynamic_params.add_mod_n_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of add_mod/a_offset must be nonnegative.
        x = dynamic_params.add_mod_a_offset_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of add_mod/a_offset is too big.
        x = trace_length - dynamic_params.add_mod_a_offset_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of add_mod/a_offset is too big.
        x = dynamic_params.add_mod_row_ratio.into()
            - dynamic_params.add_mod_a_offset_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of add_mod/b_offset must be nonnegative.
        x = dynamic_params.add_mod_b_offset_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of add_mod/b_offset is too big.
        x = trace_length - dynamic_params.add_mod_b_offset_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of add_mod/b_offset is too big.
        x = dynamic_params.add_mod_row_ratio.into()
            - dynamic_params.add_mod_b_offset_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of add_mod/c_offset must be nonnegative.
        x = dynamic_params.add_mod_c_offset_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of add_mod/c_offset is too big.
        x = trace_length - dynamic_params.add_mod_c_offset_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of add_mod/c_offset is too big.
        x = dynamic_params.add_mod_row_ratio.into()
            - dynamic_params.add_mod_c_offset_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of add_mod/a0 must be nonnegative.
        x = dynamic_params.add_mod_a0_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of add_mod/a0 is too big.
        x = trace_length - dynamic_params.add_mod_a0_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of add_mod/a0 is too big.
        x = dynamic_params.add_mod_row_ratio.into()
            - dynamic_params.add_mod_a0_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of add_mod/a1 must be nonnegative.
        x = dynamic_params.add_mod_a1_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of add_mod/a1 is too big.
        x = trace_length - dynamic_params.add_mod_a1_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of add_mod/a1 is too big.
        x = dynamic_params.add_mod_row_ratio.into()
            - dynamic_params.add_mod_a1_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of add_mod/a2 must be nonnegative.
        x = dynamic_params.add_mod_a2_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of add_mod/a2 is too big.
        x = trace_length - dynamic_params.add_mod_a2_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of add_mod/a2 is too big.
        x = dynamic_params.add_mod_row_ratio.into()
            - dynamic_params.add_mod_a2_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of add_mod/a3 must be nonnegative.
        x = dynamic_params.add_mod_a3_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of add_mod/a3 is too big.
        x = trace_length - dynamic_params.add_mod_a3_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of add_mod/a3 is too big.
        x = dynamic_params.add_mod_row_ratio.into()
            - dynamic_params.add_mod_a3_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of add_mod/b0 must be nonnegative.
        x = dynamic_params.add_mod_b0_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of add_mod/b0 is too big.
        x = trace_length - dynamic_params.add_mod_b0_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of add_mod/b0 is too big.
        x = dynamic_params.add_mod_row_ratio.into()
            - dynamic_params.add_mod_b0_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of add_mod/b1 must be nonnegative.
        x = dynamic_params.add_mod_b1_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of add_mod/b1 is too big.
        x = trace_length - dynamic_params.add_mod_b1_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of add_mod/b1 is too big.
        x = dynamic_params.add_mod_row_ratio.into()
            - dynamic_params.add_mod_b1_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of add_mod/b2 must be nonnegative.
        x = dynamic_params.add_mod_b2_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of add_mod/b2 is too big.
        x = trace_length - dynamic_params.add_mod_b2_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of add_mod/b2 is too big.
        x = dynamic_params.add_mod_row_ratio.into()
            - dynamic_params.add_mod_b2_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of add_mod/b3 must be nonnegative.
        x = dynamic_params.add_mod_b3_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of add_mod/b3 is too big.
        x = trace_length - dynamic_params.add_mod_b3_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of add_mod/b3 is too big.
        x = dynamic_params.add_mod_row_ratio.into()
            - dynamic_params.add_mod_b3_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of add_mod/c0 must be nonnegative.
        x = dynamic_params.add_mod_c0_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of add_mod/c0 is too big.
        x = trace_length - dynamic_params.add_mod_c0_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of add_mod/c0 is too big.
        x = dynamic_params.add_mod_row_ratio.into()
            - dynamic_params.add_mod_c0_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of add_mod/c1 must be nonnegative.
        x = dynamic_params.add_mod_c1_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of add_mod/c1 is too big.
        x = trace_length - dynamic_params.add_mod_c1_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of add_mod/c1 is too big.
        x = dynamic_params.add_mod_row_ratio.into()
            - dynamic_params.add_mod_c1_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of add_mod/c2 must be nonnegative.
        x = dynamic_params.add_mod_c2_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of add_mod/c2 is too big.
        x = trace_length - dynamic_params.add_mod_c2_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of add_mod/c2 is too big.
        x = dynamic_params.add_mod_row_ratio.into()
            - dynamic_params.add_mod_c2_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of add_mod/c3 must be nonnegative.
        x = dynamic_params.add_mod_c3_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of add_mod/c3 is too big.
        x = trace_length - dynamic_params.add_mod_c3_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of add_mod/c3 is too big.
        x = dynamic_params.add_mod_row_ratio.into()
            - dynamic_params.add_mod_c3_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);
    }

    if (dynamic_params.uses_mul_mod_builtin.into() != 0) {
        // Row ratio should be a power of 2, smaller than trace length.
        x = dynamic_params.mul_mod_row_ratio.into();
        assert_is_power_of_2(x);
        // Dimension should be a power of 2.
        x = (trace_length / dynamic_params.mul_mod_row_ratio.into());
        assert_is_power_of_2(x);
        // Index out of range.
        x = (trace_length / dynamic_params.mul_mod_row_ratio.into()) - 1;
        assert_range_u128_from_u256(x);

        // Index should be non negative.
        x = (trace_length / dynamic_params.mul_mod_row_ratio.into());
        assert_range_u128_from_u256(x);

        // Coset step (memberexpression(trace_length)) must be a power of two.
        x = trace_length;
        assert_is_power_of_2(x);
        // Offset of mul_mod/p0 must be nonnegative.
        x = dynamic_params.mul_mod_p0_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p0 is too big.
        x = trace_length - dynamic_params.mul_mod_p0_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p0 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_p0_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p1 must be nonnegative.
        x = dynamic_params.mul_mod_p1_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p1 is too big.
        x = trace_length - dynamic_params.mul_mod_p1_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p1 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_p1_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p2 must be nonnegative.
        x = dynamic_params.mul_mod_p2_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p2 is too big.
        x = trace_length - dynamic_params.mul_mod_p2_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p2 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_p2_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p3 must be nonnegative.
        x = dynamic_params.mul_mod_p3_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p3 is too big.
        x = trace_length - dynamic_params.mul_mod_p3_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p3 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_p3_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/values_ptr must be nonnegative.
        x = dynamic_params.mul_mod_values_ptr_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/values_ptr is too big.
        x = trace_length - dynamic_params.mul_mod_values_ptr_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/values_ptr is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_values_ptr_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/offsets_ptr must be nonnegative.
        x = dynamic_params.mul_mod_offsets_ptr_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/offsets_ptr is too big.
        x = trace_length - dynamic_params.mul_mod_offsets_ptr_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/offsets_ptr is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_offsets_ptr_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/n must be nonnegative.
        x = dynamic_params.mul_mod_n_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/n is too big.
        x = trace_length - dynamic_params.mul_mod_n_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/n is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_n_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/a_offset must be nonnegative.
        x = dynamic_params.mul_mod_a_offset_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/a_offset is too big.
        x = trace_length - dynamic_params.mul_mod_a_offset_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/a_offset is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_a_offset_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/b_offset must be nonnegative.
        x = dynamic_params.mul_mod_b_offset_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/b_offset is too big.
        x = trace_length - dynamic_params.mul_mod_b_offset_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/b_offset is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_b_offset_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/c_offset must be nonnegative.
        x = dynamic_params.mul_mod_c_offset_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/c_offset is too big.
        x = trace_length - dynamic_params.mul_mod_c_offset_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/c_offset is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_c_offset_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/a0 must be nonnegative.
        x = dynamic_params.mul_mod_a0_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/a0 is too big.
        x = trace_length - dynamic_params.mul_mod_a0_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/a0 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_a0_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/a1 must be nonnegative.
        x = dynamic_params.mul_mod_a1_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/a1 is too big.
        x = trace_length - dynamic_params.mul_mod_a1_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/a1 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_a1_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/a2 must be nonnegative.
        x = dynamic_params.mul_mod_a2_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/a2 is too big.
        x = trace_length - dynamic_params.mul_mod_a2_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/a2 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_a2_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/a3 must be nonnegative.
        x = dynamic_params.mul_mod_a3_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/a3 is too big.
        x = trace_length - dynamic_params.mul_mod_a3_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/a3 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_a3_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/b0 must be nonnegative.
        x = dynamic_params.mul_mod_b0_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/b0 is too big.
        x = trace_length - dynamic_params.mul_mod_b0_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/b0 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_b0_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/b1 must be nonnegative.
        x = dynamic_params.mul_mod_b1_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/b1 is too big.
        x = trace_length - dynamic_params.mul_mod_b1_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/b1 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_b1_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/b2 must be nonnegative.
        x = dynamic_params.mul_mod_b2_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/b2 is too big.
        x = trace_length - dynamic_params.mul_mod_b2_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/b2 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_b2_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/b3 must be nonnegative.
        x = dynamic_params.mul_mod_b3_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/b3 is too big.
        x = trace_length - dynamic_params.mul_mod_b3_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/b3 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_b3_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/c0 must be nonnegative.
        x = dynamic_params.mul_mod_c0_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/c0 is too big.
        x = trace_length - dynamic_params.mul_mod_c0_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/c0 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_c0_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/c1 must be nonnegative.
        x = dynamic_params.mul_mod_c1_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/c1 is too big.
        x = trace_length - dynamic_params.mul_mod_c1_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/c1 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_c1_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/c2 must be nonnegative.
        x = dynamic_params.mul_mod_c2_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/c2 is too big.
        x = trace_length - dynamic_params.mul_mod_c2_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/c2 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_c2_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/c3 must be nonnegative.
        x = dynamic_params.mul_mod_c3_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/c3 is too big.
        x = trace_length - dynamic_params.mul_mod_c3_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/c3 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_c3_suboffset.into()
                * dynamic_params.memory_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier0/part0 must be nonnegative.
        x = dynamic_params.mul_mod_p_multiplier0_part0_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier0/part0 is too big.
        x = trace_length - dynamic_params.mul_mod_p_multiplier0_part0_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier0/part0 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_p_multiplier0_part0_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier0/part1 must be nonnegative.
        x = dynamic_params.mul_mod_p_multiplier0_part1_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier0/part1 is too big.
        x = trace_length - dynamic_params.mul_mod_p_multiplier0_part1_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier0/part1 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_p_multiplier0_part1_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier0/part2 must be nonnegative.
        x = dynamic_params.mul_mod_p_multiplier0_part2_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier0/part2 is too big.
        x = trace_length - dynamic_params.mul_mod_p_multiplier0_part2_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier0/part2 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_p_multiplier0_part2_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier0/part3 must be nonnegative.
        x = dynamic_params.mul_mod_p_multiplier0_part3_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier0/part3 is too big.
        x = trace_length - dynamic_params.mul_mod_p_multiplier0_part3_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier0/part3 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_p_multiplier0_part3_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier0/part4 must be nonnegative.
        x = dynamic_params.mul_mod_p_multiplier0_part4_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier0/part4 is too big.
        x = trace_length - dynamic_params.mul_mod_p_multiplier0_part4_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier0/part4 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_p_multiplier0_part4_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier0/part5 must be nonnegative.
        x = dynamic_params.mul_mod_p_multiplier0_part5_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier0/part5 is too big.
        x = trace_length - dynamic_params.mul_mod_p_multiplier0_part5_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier0/part5 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_p_multiplier0_part5_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier1/part0 must be nonnegative.
        x = dynamic_params.mul_mod_p_multiplier1_part0_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier1/part0 is too big.
        x = trace_length - dynamic_params.mul_mod_p_multiplier1_part0_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier1/part0 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_p_multiplier1_part0_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier1/part1 must be nonnegative.
        x = dynamic_params.mul_mod_p_multiplier1_part1_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier1/part1 is too big.
        x = trace_length - dynamic_params.mul_mod_p_multiplier1_part1_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier1/part1 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_p_multiplier1_part1_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier1/part2 must be nonnegative.
        x = dynamic_params.mul_mod_p_multiplier1_part2_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier1/part2 is too big.
        x = trace_length - dynamic_params.mul_mod_p_multiplier1_part2_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier1/part2 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_p_multiplier1_part2_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier1/part3 must be nonnegative.
        x = dynamic_params.mul_mod_p_multiplier1_part3_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier1/part3 is too big.
        x = trace_length - dynamic_params.mul_mod_p_multiplier1_part3_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier1/part3 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_p_multiplier1_part3_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier1/part4 must be nonnegative.
        x = dynamic_params.mul_mod_p_multiplier1_part4_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier1/part4 is too big.
        x = trace_length - dynamic_params.mul_mod_p_multiplier1_part4_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier1/part4 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_p_multiplier1_part4_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier1/part5 must be nonnegative.
        x = dynamic_params.mul_mod_p_multiplier1_part5_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier1/part5 is too big.
        x = trace_length - dynamic_params.mul_mod_p_multiplier1_part5_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier1/part5 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_p_multiplier1_part5_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier2/part0 must be nonnegative.
        x = dynamic_params.mul_mod_p_multiplier2_part0_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier2/part0 is too big.
        x = trace_length - dynamic_params.mul_mod_p_multiplier2_part0_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier2/part0 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_p_multiplier2_part0_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier2/part1 must be nonnegative.
        x = dynamic_params.mul_mod_p_multiplier2_part1_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier2/part1 is too big.
        x = trace_length - dynamic_params.mul_mod_p_multiplier2_part1_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier2/part1 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_p_multiplier2_part1_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier2/part2 must be nonnegative.
        x = dynamic_params.mul_mod_p_multiplier2_part2_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier2/part2 is too big.
        x = trace_length - dynamic_params.mul_mod_p_multiplier2_part2_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier2/part2 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_p_multiplier2_part2_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier2/part3 must be nonnegative.
        x = dynamic_params.mul_mod_p_multiplier2_part3_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier2/part3 is too big.
        x = trace_length - dynamic_params.mul_mod_p_multiplier2_part3_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier2/part3 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_p_multiplier2_part3_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier2/part4 must be nonnegative.
        x = dynamic_params.mul_mod_p_multiplier2_part4_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier2/part4 is too big.
        x = trace_length - dynamic_params.mul_mod_p_multiplier2_part4_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier2/part4 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_p_multiplier2_part4_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier2/part5 must be nonnegative.
        x = dynamic_params.mul_mod_p_multiplier2_part5_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier2/part5 is too big.
        x = trace_length - dynamic_params.mul_mod_p_multiplier2_part5_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier2/part5 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_p_multiplier2_part5_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier3/part0 must be nonnegative.
        x = dynamic_params.mul_mod_p_multiplier3_part0_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier3/part0 is too big.
        x = trace_length - dynamic_params.mul_mod_p_multiplier3_part0_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier3/part0 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_p_multiplier3_part0_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier3/part1 must be nonnegative.
        x = dynamic_params.mul_mod_p_multiplier3_part1_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier3/part1 is too big.
        x = trace_length - dynamic_params.mul_mod_p_multiplier3_part1_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier3/part1 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_p_multiplier3_part1_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier3/part2 must be nonnegative.
        x = dynamic_params.mul_mod_p_multiplier3_part2_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier3/part2 is too big.
        x = trace_length - dynamic_params.mul_mod_p_multiplier3_part2_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier3/part2 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_p_multiplier3_part2_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier3/part3 must be nonnegative.
        x = dynamic_params.mul_mod_p_multiplier3_part3_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier3/part3 is too big.
        x = trace_length - dynamic_params.mul_mod_p_multiplier3_part3_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier3/part3 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_p_multiplier3_part3_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier3/part4 must be nonnegative.
        x = dynamic_params.mul_mod_p_multiplier3_part4_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier3/part4 is too big.
        x = trace_length - dynamic_params.mul_mod_p_multiplier3_part4_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier3/part4 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_p_multiplier3_part4_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier3/part5 must be nonnegative.
        x = dynamic_params.mul_mod_p_multiplier3_part5_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier3/part5 is too big.
        x = trace_length - dynamic_params.mul_mod_p_multiplier3_part5_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/p_multiplier3/part5 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_p_multiplier3_part5_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry0/part0 must be nonnegative.
        x = dynamic_params.mul_mod_carry0_part0_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry0/part0 is too big.
        x = trace_length - dynamic_params.mul_mod_carry0_part0_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry0/part0 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_carry0_part0_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry0/part1 must be nonnegative.
        x = dynamic_params.mul_mod_carry0_part1_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry0/part1 is too big.
        x = trace_length - dynamic_params.mul_mod_carry0_part1_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry0/part1 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_carry0_part1_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry0/part2 must be nonnegative.
        x = dynamic_params.mul_mod_carry0_part2_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry0/part2 is too big.
        x = trace_length - dynamic_params.mul_mod_carry0_part2_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry0/part2 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_carry0_part2_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry0/part3 must be nonnegative.
        x = dynamic_params.mul_mod_carry0_part3_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry0/part3 is too big.
        x = trace_length - dynamic_params.mul_mod_carry0_part3_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry0/part3 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_carry0_part3_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry0/part4 must be nonnegative.
        x = dynamic_params.mul_mod_carry0_part4_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry0/part4 is too big.
        x = trace_length - dynamic_params.mul_mod_carry0_part4_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry0/part4 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_carry0_part4_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry0/part5 must be nonnegative.
        x = dynamic_params.mul_mod_carry0_part5_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry0/part5 is too big.
        x = trace_length - dynamic_params.mul_mod_carry0_part5_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry0/part5 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_carry0_part5_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry0/part6 must be nonnegative.
        x = dynamic_params.mul_mod_carry0_part6_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry0/part6 is too big.
        x = trace_length - dynamic_params.mul_mod_carry0_part6_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry0/part6 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_carry0_part6_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry1/part0 must be nonnegative.
        x = dynamic_params.mul_mod_carry1_part0_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry1/part0 is too big.
        x = trace_length - dynamic_params.mul_mod_carry1_part0_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry1/part0 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_carry1_part0_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry1/part1 must be nonnegative.
        x = dynamic_params.mul_mod_carry1_part1_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry1/part1 is too big.
        x = trace_length - dynamic_params.mul_mod_carry1_part1_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry1/part1 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_carry1_part1_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry1/part2 must be nonnegative.
        x = dynamic_params.mul_mod_carry1_part2_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry1/part2 is too big.
        x = trace_length - dynamic_params.mul_mod_carry1_part2_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry1/part2 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_carry1_part2_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry1/part3 must be nonnegative.
        x = dynamic_params.mul_mod_carry1_part3_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry1/part3 is too big.
        x = trace_length - dynamic_params.mul_mod_carry1_part3_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry1/part3 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_carry1_part3_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry1/part4 must be nonnegative.
        x = dynamic_params.mul_mod_carry1_part4_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry1/part4 is too big.
        x = trace_length - dynamic_params.mul_mod_carry1_part4_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry1/part4 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_carry1_part4_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry1/part5 must be nonnegative.
        x = dynamic_params.mul_mod_carry1_part5_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry1/part5 is too big.
        x = trace_length - dynamic_params.mul_mod_carry1_part5_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry1/part5 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_carry1_part5_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry1/part6 must be nonnegative.
        x = dynamic_params.mul_mod_carry1_part6_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry1/part6 is too big.
        x = trace_length - dynamic_params.mul_mod_carry1_part6_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry1/part6 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_carry1_part6_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry2/part0 must be nonnegative.
        x = dynamic_params.mul_mod_carry2_part0_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry2/part0 is too big.
        x = trace_length - dynamic_params.mul_mod_carry2_part0_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry2/part0 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_carry2_part0_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry2/part1 must be nonnegative.
        x = dynamic_params.mul_mod_carry2_part1_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry2/part1 is too big.
        x = trace_length - dynamic_params.mul_mod_carry2_part1_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry2/part1 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_carry2_part1_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry2/part2 must be nonnegative.
        x = dynamic_params.mul_mod_carry2_part2_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry2/part2 is too big.
        x = trace_length - dynamic_params.mul_mod_carry2_part2_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry2/part2 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_carry2_part2_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry2/part3 must be nonnegative.
        x = dynamic_params.mul_mod_carry2_part3_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry2/part3 is too big.
        x = trace_length - dynamic_params.mul_mod_carry2_part3_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry2/part3 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_carry2_part3_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry2/part4 must be nonnegative.
        x = dynamic_params.mul_mod_carry2_part4_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry2/part4 is too big.
        x = trace_length - dynamic_params.mul_mod_carry2_part4_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry2/part4 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_carry2_part4_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry2/part5 must be nonnegative.
        x = dynamic_params.mul_mod_carry2_part5_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry2/part5 is too big.
        x = trace_length - dynamic_params.mul_mod_carry2_part5_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry2/part5 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_carry2_part5_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry2/part6 must be nonnegative.
        x = dynamic_params.mul_mod_carry2_part6_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry2/part6 is too big.
        x = trace_length - dynamic_params.mul_mod_carry2_part6_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry2/part6 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_carry2_part6_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry3/part0 must be nonnegative.
        x = dynamic_params.mul_mod_carry3_part0_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry3/part0 is too big.
        x = trace_length - dynamic_params.mul_mod_carry3_part0_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry3/part0 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_carry3_part0_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry3/part1 must be nonnegative.
        x = dynamic_params.mul_mod_carry3_part1_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry3/part1 is too big.
        x = trace_length - dynamic_params.mul_mod_carry3_part1_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry3/part1 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_carry3_part1_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry3/part2 must be nonnegative.
        x = dynamic_params.mul_mod_carry3_part2_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry3/part2 is too big.
        x = trace_length - dynamic_params.mul_mod_carry3_part2_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry3/part2 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_carry3_part2_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry3/part3 must be nonnegative.
        x = dynamic_params.mul_mod_carry3_part3_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry3/part3 is too big.
        x = trace_length - dynamic_params.mul_mod_carry3_part3_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry3/part3 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_carry3_part3_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry3/part4 must be nonnegative.
        x = dynamic_params.mul_mod_carry3_part4_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry3/part4 is too big.
        x = trace_length - dynamic_params.mul_mod_carry3_part4_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry3/part4 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_carry3_part4_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry3/part5 must be nonnegative.
        x = dynamic_params.mul_mod_carry3_part5_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry3/part5 is too big.
        x = trace_length - dynamic_params.mul_mod_carry3_part5_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry3/part5 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_carry3_part5_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry3/part6 must be nonnegative.
        x = dynamic_params.mul_mod_carry3_part6_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry3/part6 is too big.
        x = trace_length - dynamic_params.mul_mod_carry3_part6_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry3/part6 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_carry3_part6_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry4/part0 must be nonnegative.
        x = dynamic_params.mul_mod_carry4_part0_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry4/part0 is too big.
        x = trace_length - dynamic_params.mul_mod_carry4_part0_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry4/part0 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_carry4_part0_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry4/part1 must be nonnegative.
        x = dynamic_params.mul_mod_carry4_part1_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry4/part1 is too big.
        x = trace_length - dynamic_params.mul_mod_carry4_part1_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry4/part1 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_carry4_part1_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry4/part2 must be nonnegative.
        x = dynamic_params.mul_mod_carry4_part2_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry4/part2 is too big.
        x = trace_length - dynamic_params.mul_mod_carry4_part2_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry4/part2 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_carry4_part2_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry4/part3 must be nonnegative.
        x = dynamic_params.mul_mod_carry4_part3_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry4/part3 is too big.
        x = trace_length - dynamic_params.mul_mod_carry4_part3_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry4/part3 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_carry4_part3_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry4/part4 must be nonnegative.
        x = dynamic_params.mul_mod_carry4_part4_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry4/part4 is too big.
        x = trace_length - dynamic_params.mul_mod_carry4_part4_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry4/part4 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_carry4_part4_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry4/part5 must be nonnegative.
        x = dynamic_params.mul_mod_carry4_part5_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry4/part5 is too big.
        x = trace_length - dynamic_params.mul_mod_carry4_part5_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry4/part5 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_carry4_part5_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry4/part6 must be nonnegative.
        x = dynamic_params.mul_mod_carry4_part6_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry4/part6 is too big.
        x = trace_length - dynamic_params.mul_mod_carry4_part6_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry4/part6 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_carry4_part6_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry5/part0 must be nonnegative.
        x = dynamic_params.mul_mod_carry5_part0_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry5/part0 is too big.
        x = trace_length - dynamic_params.mul_mod_carry5_part0_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry5/part0 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_carry5_part0_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry5/part1 must be nonnegative.
        x = dynamic_params.mul_mod_carry5_part1_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry5/part1 is too big.
        x = trace_length - dynamic_params.mul_mod_carry5_part1_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry5/part1 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_carry5_part1_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry5/part2 must be nonnegative.
        x = dynamic_params.mul_mod_carry5_part2_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry5/part2 is too big.
        x = trace_length - dynamic_params.mul_mod_carry5_part2_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry5/part2 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_carry5_part2_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry5/part3 must be nonnegative.
        x = dynamic_params.mul_mod_carry5_part3_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry5/part3 is too big.
        x = trace_length - dynamic_params.mul_mod_carry5_part3_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry5/part3 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_carry5_part3_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry5/part4 must be nonnegative.
        x = dynamic_params.mul_mod_carry5_part4_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry5/part4 is too big.
        x = trace_length - dynamic_params.mul_mod_carry5_part4_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry5/part4 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_carry5_part4_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry5/part5 must be nonnegative.
        x = dynamic_params.mul_mod_carry5_part5_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry5/part5 is too big.
        x = trace_length - dynamic_params.mul_mod_carry5_part5_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry5/part5 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_carry5_part5_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry5/part6 must be nonnegative.
        x = dynamic_params.mul_mod_carry5_part6_suboffset.into();
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry5/part6 is too big.
        x = trace_length - dynamic_params.mul_mod_carry5_part6_suboffset.into() - 1;
        assert_range_u128_from_u256(x);

        // Offset of mul_mod/carry5/part6 is too big.
        x = dynamic_params.mul_mod_row_ratio.into()
            - dynamic_params.mul_mod_carry5_part6_suboffset.into()
                * dynamic_params.range_check_units_row_ratio.into()
            - 1;
        assert_range_u128_from_u256(x);
    }
}
