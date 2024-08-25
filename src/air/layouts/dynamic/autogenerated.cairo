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
) -> felt252 { // TODO REWRITE
    0
}

fn check_asserts(dynamic_params: @DynamicParams, stark_domains: @StarkDomains) {
    let trace_length: u256 = (*stark_domains.trace_domain_size).into();

    // Coset step (dynamicparam(diluted_units_row_ratio)) must be a power of two.
    assert_is_power_of_2(dynamic_params.diluted_units_row_ratio.into());
    // Dimension should be a power of 2.
    assert_is_power_of_2(trace_length / dynamic_params.diluted_units_row_ratio.into());
    // Index out of range.
    assert_range_u128_from_u256(trace_length / dynamic_params.diluted_units_row_ratio.into() - 1);
    // Coset step (memberexpression(trace_length)) must be a power of two.
    assert_is_power_of_2(trace_length);
    // Index should be non negative.
    assert_range_u128_from_u256(trace_length / dynamic_params.diluted_units_row_ratio.into());
    // Coset step (dynamicparam(range_check_units_row_ratio)) must be a power of two.
    assert_is_power_of_2(dynamic_params.range_check_units_row_ratio.into());
    // Dimension should be a power of 2.
    assert_is_power_of_2(trace_length / dynamic_params.range_check_units_row_ratio.into());
    // Index out of range.
    assert_range_u128_from_u256(trace_length / dynamic_params.range_check_units_row_ratio.into() - 1);
    // Index should be non negative.
    assert_range_u128_from_u256(trace_length / dynamic_params.range_check_units_row_ratio.into());
    // Coset step ((8) * (dynamicparam(memory_units_row_ratio))) must be a power of two.
    assert_is_power_of_2(8 * dynamic_params.memory_units_row_ratio.into());
    // Dimension should be a power of 2.
    assert_is_power_of_2(trace_length / (8 * dynamic_params.memory_units_row_ratio.into()));
    // Coset step (dynamicparam(memory_units_row_ratio)) must be a power of two.
    assert_is_power_of_2(dynamic_params.memory_units_row_ratio.into());
    // Dimension should be a power of 2.
    assert_is_power_of_2(trace_length / dynamic_params.memory_units_row_ratio.into());
    // Index out of range.
    assert_range_u128_from_u256(trace_length / dynamic_params.memory_units_row_ratio.into() - 1);
    // Index should be non negative.
    assert_range_u128_from_u256(trace_length / dynamic_params.memory_units_row_ratio.into());
    // Coset step ((16) * (dynamicparam(cpu_component_step))) must be a power of two.
    assert_is_power_of_2(16 * dynamic_params.cpu_component_step.into());
    // Dimension should be a power of 2.
    assert_is_power_of_2(trace_length / (16 * dynamic_params.cpu_component_step.into()));
    // Step must not exceed dimension.
    assert_range_u128_from_u256(trace_length / (16 * dynamic_params.cpu_component_step.into()) - 1);
    // Coset step (dynamicparam(cpu_component_step)) must be a power of two.
    assert_is_power_of_2(dynamic_params.cpu_component_step.into());
    // Index out of range.
    assert_range_u128_from_u256(trace_length / (16 * dynamic_params.cpu_component_step.into()));
    // Cpu_component_step is out of range.
    assert_range_u128_from_u256(256 - dynamic_params.cpu_component_step.into());
    // Memory_units_row_ratio is out of range.
    assert_range_u128_from_u256(16_u256 * dynamic_params.cpu_component_step.into() - 4_u256 * dynamic_params.memory_units_row_ratio.into());
    // Offset of cpu/decode/mem_inst must be nonnegative.
    tempvar x = dynamic_params.cpu__decode__mem_inst_suboffset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset of cpu/decode/mem_inst is too big.
    tempvar x = trace_length - dynamic_params.cpu__decode__mem_inst_suboffset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset of cpu/decode/mem_inst is too big.
    tempvar x = (safe_mult(16, dynamic_params.cpu_component_step)) - (
        safe_mult(
            dynamic_params.cpu__decode__mem_inst_suboffset, dynamic_params.memory_units_row_ratio
        )
    ) - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset of cpu/decode/off0 must be nonnegative.
    tempvar x = dynamic_params.cpu__decode__off0_suboffset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset of cpu/decode/off0 is too big.
    tempvar x = trace_length - dynamic_params.cpu__decode__off0_suboffset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset of cpu/decode/off0 is too big.
    tempvar x = (safe_mult(16, dynamic_params.cpu_component_step)) - (
        safe_mult(
            dynamic_params.cpu__decode__off0_suboffset, dynamic_params.range_check_units_row_ratio
        )
    ) - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset of cpu/decode/off1 must be nonnegative.
    tempvar x = dynamic_params.cpu__decode__off1_suboffset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset of cpu/decode/off1 is too big.
    tempvar x = trace_length - dynamic_params.cpu__decode__off1_suboffset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset of cpu/decode/off1 is too big.
    tempvar x = (safe_mult(16, dynamic_params.cpu_component_step)) - (
        safe_mult(
            dynamic_params.cpu__decode__off1_suboffset, dynamic_params.range_check_units_row_ratio
        )
    ) - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset of cpu/decode/off2 must be nonnegative.
    tempvar x = dynamic_params.cpu__decode__off2_suboffset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset of cpu/decode/off2 is too big.
    tempvar x = trace_length - dynamic_params.cpu__decode__off2_suboffset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset of cpu/decode/off2 is too big.
    tempvar x = (safe_mult(16, dynamic_params.cpu_component_step)) - (
        safe_mult(
            dynamic_params.cpu__decode__off2_suboffset, dynamic_params.range_check_units_row_ratio
        )
    ) - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset of cpu/operands/mem_dst must be nonnegative.
    tempvar x = dynamic_params.cpu__operands__mem_dst_suboffset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset of cpu/operands/mem_dst is too big.
    tempvar x = trace_length - dynamic_params.cpu__operands__mem_dst_suboffset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset of cpu/operands/mem_dst is too big.
    tempvar x = (safe_mult(16, dynamic_params.cpu_component_step)) - (
        safe_mult(
            dynamic_params.cpu__operands__mem_dst_suboffset, dynamic_params.memory_units_row_ratio
        )
    ) - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset of cpu/operands/mem_op0 must be nonnegative.
    tempvar x = dynamic_params.cpu__operands__mem_op0_suboffset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset of cpu/operands/mem_op0 is too big.
    tempvar x = trace_length - dynamic_params.cpu__operands__mem_op0_suboffset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset of cpu/operands/mem_op0 is too big.
    tempvar x = (safe_mult(16, dynamic_params.cpu_component_step)) - (
        safe_mult(
            dynamic_params.cpu__operands__mem_op0_suboffset, dynamic_params.memory_units_row_ratio
        )
    ) - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset of cpu/operands/mem_op1 must be nonnegative.
    tempvar x = dynamic_params.cpu__operands__mem_op1_suboffset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset of cpu/operands/mem_op1 is too big.
    tempvar x = trace_length - dynamic_params.cpu__operands__mem_op1_suboffset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset of cpu/operands/mem_op1 is too big.
    tempvar x = (safe_mult(16, dynamic_params.cpu_component_step)) - (
        safe_mult(
            dynamic_params.cpu__operands__mem_op1_suboffset, dynamic_params.memory_units_row_ratio
        )
    ) - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset of orig/public_memory must be nonnegative.
    tempvar x = dynamic_params.orig__public_memory_suboffset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset of orig/public_memory is too big.
    tempvar x = trace_length - dynamic_params.orig__public_memory_suboffset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset of orig/public_memory is too big.
    tempvar x = (safe_mult(8, dynamic_params.memory_units_row_ratio)) - (
        safe_mult(
            dynamic_params.orig__public_memory_suboffset, dynamic_params.memory_units_row_ratio
        )
    ) - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Uses_pedersen_builtin should be a boolean.
    assert (safe_mult(dynamic_params.uses_pedersen_builtin, dynamic_params.uses_pedersen_builtin)) -
        dynamic_params.uses_pedersen_builtin = 0;
    // Uses_range_check_builtin should be a boolean.
    assert (
        safe_mult(dynamic_params.uses_range_check_builtin, dynamic_params.uses_range_check_builtin)
    ) - dynamic_params.uses_range_check_builtin = 0;
    // Uses_ecdsa_builtin should be a boolean.
    assert (safe_mult(dynamic_params.uses_ecdsa_builtin, dynamic_params.uses_ecdsa_builtin)) -
        dynamic_params.uses_ecdsa_builtin = 0;
    // Uses_bitwise_builtin should be a boolean.
    assert (safe_mult(dynamic_params.uses_bitwise_builtin, dynamic_params.uses_bitwise_builtin)) -
        dynamic_params.uses_bitwise_builtin = 0;
    // Uses_ec_op_builtin should be a boolean.
    assert (safe_mult(dynamic_params.uses_ec_op_builtin, dynamic_params.uses_ec_op_builtin)) -
        dynamic_params.uses_ec_op_builtin = 0;
    // Uses_keccak_builtin should be a boolean.
    assert (safe_mult(dynamic_params.uses_keccak_builtin, dynamic_params.uses_keccak_builtin)) -
        dynamic_params.uses_keccak_builtin = 0;
    // Uses_poseidon_builtin should be a boolean.
    assert (safe_mult(dynamic_params.uses_poseidon_builtin, dynamic_params.uses_poseidon_builtin)) -
        dynamic_params.uses_poseidon_builtin = 0;
    // Uses_range_check96_builtin should be a boolean.
    assert (
        safe_mult(
            dynamic_params.uses_range_check96_builtin, dynamic_params.uses_range_check96_builtin
        )
    ) - dynamic_params.uses_range_check96_builtin = 0;
    // Uses_add_mod_builtin should be a boolean.
    assert (safe_mult(dynamic_params.uses_add_mod_builtin, dynamic_params.uses_add_mod_builtin)) -
        dynamic_params.uses_add_mod_builtin = 0;
    // Uses_mul_mod_builtin should be a boolean.
    assert (safe_mult(dynamic_params.uses_mul_mod_builtin, dynamic_params.uses_mul_mod_builtin)) -
        dynamic_params.uses_mul_mod_builtin = 0;
    // Num_columns_first is out of range.
    tempvar x = 65536 - dynamic_params.num_columns_first - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Num_columns_second is out of range.
    tempvar x = 65536 - dynamic_params.num_columns_second - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.mem_pool__addr_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first - dynamic_params.mem_pool__addr_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.mem_pool__addr_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length - dynamic_params.mem_pool__addr_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.mem_pool__value_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first - dynamic_params.mem_pool__value_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.mem_pool__value_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length - dynamic_params.mem_pool__value_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.range_check16_pool_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first - dynamic_params.range_check16_pool_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.range_check16_pool_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length - dynamic_params.range_check16_pool_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.cpu__decode__opcode_range_check__column_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first -
        dynamic_params.cpu__decode__opcode_range_check__column_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.cpu__decode__opcode_range_check__column_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length - dynamic_params.cpu__decode__opcode_range_check__column_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.cpu__registers__ap_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first - dynamic_params.cpu__registers__ap_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.cpu__registers__ap_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length - dynamic_params.cpu__registers__ap_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.cpu__registers__fp_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first - dynamic_params.cpu__registers__fp_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.cpu__registers__fp_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length - dynamic_params.cpu__registers__fp_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.cpu__operands__ops_mul_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first - dynamic_params.cpu__operands__ops_mul_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.cpu__operands__ops_mul_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length - dynamic_params.cpu__operands__ops_mul_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.cpu__operands__res_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first - dynamic_params.cpu__operands__res_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.cpu__operands__res_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length - dynamic_params.cpu__operands__res_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.cpu__update_registers__update_pc__tmp0_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first -
        dynamic_params.cpu__update_registers__update_pc__tmp0_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.cpu__update_registers__update_pc__tmp0_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length - dynamic_params.cpu__update_registers__update_pc__tmp0_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.cpu__update_registers__update_pc__tmp1_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first -
        dynamic_params.cpu__update_registers__update_pc__tmp1_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.cpu__update_registers__update_pc__tmp1_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length - dynamic_params.cpu__update_registers__update_pc__tmp1_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.memory__sorted__addr_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first - dynamic_params.memory__sorted__addr_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.memory__sorted__addr_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length - dynamic_params.memory__sorted__addr_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.memory__sorted__value_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first - dynamic_params.memory__sorted__value_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.memory__sorted__value_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length - dynamic_params.memory__sorted__value_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.range_check16__sorted_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first - dynamic_params.range_check16__sorted_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.range_check16__sorted_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length - dynamic_params.range_check16__sorted_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.diluted_pool_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first - dynamic_params.diluted_pool_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.diluted_pool_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length - dynamic_params.diluted_pool_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.diluted_check__permuted_values_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first -
        dynamic_params.diluted_check__permuted_values_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.diluted_check__permuted_values_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length - dynamic_params.diluted_check__permuted_values_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.pedersen__hash0__ec_subset_sum__partial_sum__x_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first -
        dynamic_params.pedersen__hash0__ec_subset_sum__partial_sum__x_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.pedersen__hash0__ec_subset_sum__partial_sum__x_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length -
        dynamic_params.pedersen__hash0__ec_subset_sum__partial_sum__x_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.pedersen__hash0__ec_subset_sum__partial_sum__y_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first -
        dynamic_params.pedersen__hash0__ec_subset_sum__partial_sum__y_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.pedersen__hash0__ec_subset_sum__partial_sum__y_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length -
        dynamic_params.pedersen__hash0__ec_subset_sum__partial_sum__y_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.pedersen__hash0__ec_subset_sum__slope_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first -
        dynamic_params.pedersen__hash0__ec_subset_sum__slope_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.pedersen__hash0__ec_subset_sum__slope_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length - dynamic_params.pedersen__hash0__ec_subset_sum__slope_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.pedersen__hash0__ec_subset_sum__selector_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first -
        dynamic_params.pedersen__hash0__ec_subset_sum__selector_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.pedersen__hash0__ec_subset_sum__selector_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length - dynamic_params.pedersen__hash0__ec_subset_sum__selector_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.pedersen__hash0__ec_subset_sum__bit_unpacking__prod_ones196_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first -
        dynamic_params.pedersen__hash0__ec_subset_sum__bit_unpacking__prod_ones196_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.pedersen__hash0__ec_subset_sum__bit_unpacking__prod_ones196_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length -
        dynamic_params.pedersen__hash0__ec_subset_sum__bit_unpacking__prod_ones196_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.pedersen__hash0__ec_subset_sum__bit_unpacking__prod_ones192_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first -
        dynamic_params.pedersen__hash0__ec_subset_sum__bit_unpacking__prod_ones192_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.pedersen__hash0__ec_subset_sum__bit_unpacking__prod_ones192_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length -
        dynamic_params.pedersen__hash0__ec_subset_sum__bit_unpacking__prod_ones192_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.ecdsa__signature0__key_points__x_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first -
        dynamic_params.ecdsa__signature0__key_points__x_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.ecdsa__signature0__key_points__x_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length - dynamic_params.ecdsa__signature0__key_points__x_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.ecdsa__signature0__key_points__y_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first -
        dynamic_params.ecdsa__signature0__key_points__y_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.ecdsa__signature0__key_points__y_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length - dynamic_params.ecdsa__signature0__key_points__y_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.ecdsa__signature0__doubling_slope_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first -
        dynamic_params.ecdsa__signature0__doubling_slope_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.ecdsa__signature0__doubling_slope_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length - dynamic_params.ecdsa__signature0__doubling_slope_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.ecdsa__signature0__exponentiate_generator__partial_sum__x_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first -
        dynamic_params.ecdsa__signature0__exponentiate_generator__partial_sum__x_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.ecdsa__signature0__exponentiate_generator__partial_sum__x_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length -
        dynamic_params.ecdsa__signature0__exponentiate_generator__partial_sum__x_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.ecdsa__signature0__exponentiate_generator__partial_sum__y_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first -
        dynamic_params.ecdsa__signature0__exponentiate_generator__partial_sum__y_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.ecdsa__signature0__exponentiate_generator__partial_sum__y_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length -
        dynamic_params.ecdsa__signature0__exponentiate_generator__partial_sum__y_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.ecdsa__signature0__exponentiate_generator__slope_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first -
        dynamic_params.ecdsa__signature0__exponentiate_generator__slope_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.ecdsa__signature0__exponentiate_generator__slope_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length -
        dynamic_params.ecdsa__signature0__exponentiate_generator__slope_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.ecdsa__signature0__exponentiate_generator__selector_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first -
        dynamic_params.ecdsa__signature0__exponentiate_generator__selector_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.ecdsa__signature0__exponentiate_generator__selector_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length -
        dynamic_params.ecdsa__signature0__exponentiate_generator__selector_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.ecdsa__signature0__exponentiate_generator__x_diff_inv_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first -
        dynamic_params.ecdsa__signature0__exponentiate_generator__x_diff_inv_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.ecdsa__signature0__exponentiate_generator__x_diff_inv_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length -
        dynamic_params.ecdsa__signature0__exponentiate_generator__x_diff_inv_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.ecdsa__signature0__exponentiate_key__partial_sum__x_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first -
        dynamic_params.ecdsa__signature0__exponentiate_key__partial_sum__x_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.ecdsa__signature0__exponentiate_key__partial_sum__x_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length -
        dynamic_params.ecdsa__signature0__exponentiate_key__partial_sum__x_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.ecdsa__signature0__exponentiate_key__partial_sum__y_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first -
        dynamic_params.ecdsa__signature0__exponentiate_key__partial_sum__y_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.ecdsa__signature0__exponentiate_key__partial_sum__y_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length -
        dynamic_params.ecdsa__signature0__exponentiate_key__partial_sum__y_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.ecdsa__signature0__exponentiate_key__slope_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first -
        dynamic_params.ecdsa__signature0__exponentiate_key__slope_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.ecdsa__signature0__exponentiate_key__slope_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length - dynamic_params.ecdsa__signature0__exponentiate_key__slope_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.ecdsa__signature0__exponentiate_key__selector_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first -
        dynamic_params.ecdsa__signature0__exponentiate_key__selector_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.ecdsa__signature0__exponentiate_key__selector_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length - dynamic_params.ecdsa__signature0__exponentiate_key__selector_offset -
        1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.ecdsa__signature0__exponentiate_key__x_diff_inv_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first -
        dynamic_params.ecdsa__signature0__exponentiate_key__x_diff_inv_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.ecdsa__signature0__exponentiate_key__x_diff_inv_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length -
        dynamic_params.ecdsa__signature0__exponentiate_key__x_diff_inv_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.ecdsa__signature0__add_results_slope_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first -
        dynamic_params.ecdsa__signature0__add_results_slope_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.ecdsa__signature0__add_results_slope_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length - dynamic_params.ecdsa__signature0__add_results_slope_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.ecdsa__signature0__add_results_inv_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first -
        dynamic_params.ecdsa__signature0__add_results_inv_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.ecdsa__signature0__add_results_inv_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length - dynamic_params.ecdsa__signature0__add_results_inv_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.ecdsa__signature0__extract_r_slope_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first -
        dynamic_params.ecdsa__signature0__extract_r_slope_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.ecdsa__signature0__extract_r_slope_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length - dynamic_params.ecdsa__signature0__extract_r_slope_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.ecdsa__signature0__extract_r_inv_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first -
        dynamic_params.ecdsa__signature0__extract_r_inv_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.ecdsa__signature0__extract_r_inv_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length - dynamic_params.ecdsa__signature0__extract_r_inv_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.ecdsa__signature0__z_inv_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first - dynamic_params.ecdsa__signature0__z_inv_column -
        1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.ecdsa__signature0__z_inv_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length - dynamic_params.ecdsa__signature0__z_inv_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.ecdsa__signature0__r_w_inv_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first -
        dynamic_params.ecdsa__signature0__r_w_inv_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.ecdsa__signature0__r_w_inv_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length - dynamic_params.ecdsa__signature0__r_w_inv_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.ecdsa__signature0__q_x_squared_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first -
        dynamic_params.ecdsa__signature0__q_x_squared_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.ecdsa__signature0__q_x_squared_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length - dynamic_params.ecdsa__signature0__q_x_squared_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.ec_op__doubled_points__x_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first - dynamic_params.ec_op__doubled_points__x_column -
        1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.ec_op__doubled_points__x_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length - dynamic_params.ec_op__doubled_points__x_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.ec_op__doubled_points__y_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first - dynamic_params.ec_op__doubled_points__y_column -
        1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.ec_op__doubled_points__y_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length - dynamic_params.ec_op__doubled_points__y_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.ec_op__doubling_slope_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first - dynamic_params.ec_op__doubling_slope_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.ec_op__doubling_slope_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length - dynamic_params.ec_op__doubling_slope_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.ec_op__ec_subset_sum__partial_sum__x_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first -
        dynamic_params.ec_op__ec_subset_sum__partial_sum__x_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.ec_op__ec_subset_sum__partial_sum__x_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length - dynamic_params.ec_op__ec_subset_sum__partial_sum__x_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.ec_op__ec_subset_sum__partial_sum__y_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first -
        dynamic_params.ec_op__ec_subset_sum__partial_sum__y_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.ec_op__ec_subset_sum__partial_sum__y_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length - dynamic_params.ec_op__ec_subset_sum__partial_sum__y_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.ec_op__ec_subset_sum__slope_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first -
        dynamic_params.ec_op__ec_subset_sum__slope_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.ec_op__ec_subset_sum__slope_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length - dynamic_params.ec_op__ec_subset_sum__slope_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.ec_op__ec_subset_sum__selector_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first -
        dynamic_params.ec_op__ec_subset_sum__selector_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.ec_op__ec_subset_sum__selector_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length - dynamic_params.ec_op__ec_subset_sum__selector_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.ec_op__ec_subset_sum__x_diff_inv_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first -
        dynamic_params.ec_op__ec_subset_sum__x_diff_inv_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.ec_op__ec_subset_sum__x_diff_inv_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length - dynamic_params.ec_op__ec_subset_sum__x_diff_inv_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.ec_op__ec_subset_sum__bit_unpacking__prod_ones196_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first -
        dynamic_params.ec_op__ec_subset_sum__bit_unpacking__prod_ones196_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.ec_op__ec_subset_sum__bit_unpacking__prod_ones196_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length -
        dynamic_params.ec_op__ec_subset_sum__bit_unpacking__prod_ones196_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.ec_op__ec_subset_sum__bit_unpacking__prod_ones192_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first -
        dynamic_params.ec_op__ec_subset_sum__bit_unpacking__prod_ones192_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.ec_op__ec_subset_sum__bit_unpacking__prod_ones192_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length -
        dynamic_params.ec_op__ec_subset_sum__bit_unpacking__prod_ones192_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.keccak__keccak__parse_to_diluted__reshaped_intermediate_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first -
        dynamic_params.keccak__keccak__parse_to_diluted__reshaped_intermediate_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.keccak__keccak__parse_to_diluted__reshaped_intermediate_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length -
        dynamic_params.keccak__keccak__parse_to_diluted__reshaped_intermediate_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.keccak__keccak__parse_to_diluted__final_reshaped_input_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first -
        dynamic_params.keccak__keccak__parse_to_diluted__final_reshaped_input_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.keccak__keccak__parse_to_diluted__final_reshaped_input_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length -
        dynamic_params.keccak__keccak__parse_to_diluted__final_reshaped_input_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.keccak__keccak__parse_to_diluted__cumulative_sum_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first -
        dynamic_params.keccak__keccak__parse_to_diluted__cumulative_sum_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.keccak__keccak__parse_to_diluted__cumulative_sum_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length -
        dynamic_params.keccak__keccak__parse_to_diluted__cumulative_sum_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.keccak__keccak__rotated_parity0_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first -
        dynamic_params.keccak__keccak__rotated_parity0_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.keccak__keccak__rotated_parity0_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length - dynamic_params.keccak__keccak__rotated_parity0_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.keccak__keccak__rotated_parity1_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first -
        dynamic_params.keccak__keccak__rotated_parity1_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.keccak__keccak__rotated_parity1_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length - dynamic_params.keccak__keccak__rotated_parity1_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.keccak__keccak__rotated_parity2_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first -
        dynamic_params.keccak__keccak__rotated_parity2_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.keccak__keccak__rotated_parity2_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length - dynamic_params.keccak__keccak__rotated_parity2_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.keccak__keccak__rotated_parity3_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first -
        dynamic_params.keccak__keccak__rotated_parity3_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.keccak__keccak__rotated_parity3_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length - dynamic_params.keccak__keccak__rotated_parity3_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.keccak__keccak__rotated_parity4_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first -
        dynamic_params.keccak__keccak__rotated_parity4_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.keccak__keccak__rotated_parity4_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length - dynamic_params.keccak__keccak__rotated_parity4_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.poseidon__poseidon__full_rounds_state0_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first -
        dynamic_params.poseidon__poseidon__full_rounds_state0_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.poseidon__poseidon__full_rounds_state0_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length - dynamic_params.poseidon__poseidon__full_rounds_state0_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.poseidon__poseidon__full_rounds_state1_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first -
        dynamic_params.poseidon__poseidon__full_rounds_state1_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.poseidon__poseidon__full_rounds_state1_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length - dynamic_params.poseidon__poseidon__full_rounds_state1_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.poseidon__poseidon__full_rounds_state2_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first -
        dynamic_params.poseidon__poseidon__full_rounds_state2_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.poseidon__poseidon__full_rounds_state2_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length - dynamic_params.poseidon__poseidon__full_rounds_state2_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.poseidon__poseidon__full_rounds_state0_squared_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first -
        dynamic_params.poseidon__poseidon__full_rounds_state0_squared_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.poseidon__poseidon__full_rounds_state0_squared_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length -
        dynamic_params.poseidon__poseidon__full_rounds_state0_squared_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.poseidon__poseidon__full_rounds_state1_squared_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first -
        dynamic_params.poseidon__poseidon__full_rounds_state1_squared_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.poseidon__poseidon__full_rounds_state1_squared_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length -
        dynamic_params.poseidon__poseidon__full_rounds_state1_squared_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.poseidon__poseidon__full_rounds_state2_squared_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first -
        dynamic_params.poseidon__poseidon__full_rounds_state2_squared_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.poseidon__poseidon__full_rounds_state2_squared_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length -
        dynamic_params.poseidon__poseidon__full_rounds_state2_squared_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.poseidon__poseidon__partial_rounds_state0_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first -
        dynamic_params.poseidon__poseidon__partial_rounds_state0_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.poseidon__poseidon__partial_rounds_state0_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length - dynamic_params.poseidon__poseidon__partial_rounds_state0_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.poseidon__poseidon__partial_rounds_state1_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first -
        dynamic_params.poseidon__poseidon__partial_rounds_state1_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.poseidon__poseidon__partial_rounds_state1_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length - dynamic_params.poseidon__poseidon__partial_rounds_state1_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.poseidon__poseidon__partial_rounds_state0_squared_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first -
        dynamic_params.poseidon__poseidon__partial_rounds_state0_squared_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.poseidon__poseidon__partial_rounds_state0_squared_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length -
        dynamic_params.poseidon__poseidon__partial_rounds_state0_squared_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.poseidon__poseidon__partial_rounds_state1_squared_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first -
        dynamic_params.poseidon__poseidon__partial_rounds_state1_squared_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.poseidon__poseidon__partial_rounds_state1_squared_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length -
        dynamic_params.poseidon__poseidon__partial_rounds_state1_squared_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.add_mod__sub_p_bit_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first - dynamic_params.add_mod__sub_p_bit_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.add_mod__sub_p_bit_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length - dynamic_params.add_mod__sub_p_bit_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.add_mod__carry1_bit_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first - dynamic_params.add_mod__carry1_bit_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.add_mod__carry1_bit_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length - dynamic_params.add_mod__carry1_bit_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.add_mod__carry2_bit_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first - dynamic_params.add_mod__carry2_bit_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.add_mod__carry2_bit_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length - dynamic_params.add_mod__carry2_bit_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.add_mod__carry3_bit_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first - dynamic_params.add_mod__carry3_bit_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.add_mod__carry3_bit_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length - dynamic_params.add_mod__carry3_bit_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.add_mod__carry1_sign_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first - dynamic_params.add_mod__carry1_sign_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.add_mod__carry1_sign_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length - dynamic_params.add_mod__carry1_sign_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.add_mod__carry2_sign_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first - dynamic_params.add_mod__carry2_sign_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.add_mod__carry2_sign_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length - dynamic_params.add_mod__carry2_sign_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.add_mod__carry3_sign_column;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first - dynamic_params.add_mod__carry3_sign_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.add_mod__carry3_sign_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length - dynamic_params.add_mod__carry3_sign_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.memory__multi_column_perm__perm__cum_prod0_column -
        dynamic_params.num_columns_first;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first + dynamic_params.num_columns_second -
        dynamic_params.memory__multi_column_perm__perm__cum_prod0_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.memory__multi_column_perm__perm__cum_prod0_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length - dynamic_params.memory__multi_column_perm__perm__cum_prod0_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.range_check16__perm__cum_prod0_column -
        dynamic_params.num_columns_first;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first + dynamic_params.num_columns_second -
        dynamic_params.range_check16__perm__cum_prod0_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.range_check16__perm__cum_prod0_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length - dynamic_params.range_check16__perm__cum_prod0_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.diluted_check__cumulative_value_column -
        dynamic_params.num_columns_first;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first + dynamic_params.num_columns_second -
        dynamic_params.diluted_check__cumulative_value_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.diluted_check__cumulative_value_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length - dynamic_params.diluted_check__cumulative_value_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.diluted_check__permutation__cum_prod0_column -
        dynamic_params.num_columns_first;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Column index out of range.
    tempvar x = dynamic_params.num_columns_first + dynamic_params.num_columns_second -
        dynamic_params.diluted_check__permutation__cum_prod0_column - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be nonnegative.
    tempvar x = dynamic_params.diluted_check__permutation__cum_prod0_offset;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;
    // Offset must be smaller than trace length.
    tempvar x = trace_length - dynamic_params.diluted_check__permutation__cum_prod0_offset - 1;
    assert [range_check_ptr] = x;
    let range_check_ptr = range_check_ptr + 1;

    if (dynamic_params.uses_pedersen_builtin != 0) {
        tempvar range_check_ptr = range_check_ptr;
        // Row ratio should be a power of 2, smaller than trace length.
        tempvar x = dynamic_params.pedersen_builtin_row_ratio;
        assert_is_power_of_2(x=x, max_pow=log_trace_length);
        // Dimension should be a power of 2.
        tempvar x = (safe_div(trace_length, dynamic_params.pedersen_builtin_row_ratio));
        assert_is_power_of_2(x=x, max_pow=log_trace_length);
        // Coset step ((dynamicparam(pedersen_builtin_row_ratio)) / (512)) must be a power of two.
        tempvar x = (safe_div(dynamic_params.pedersen_builtin_row_ratio, 512));
        assert_is_power_of_2(x=x, max_pow=log_trace_length);
        // Coset step ((dynamicparam(pedersen_builtin_row_ratio)) / (2)) must be a power of two.
        tempvar x = (safe_div(dynamic_params.pedersen_builtin_row_ratio, 2));
        assert_is_power_of_2(x=x, max_pow=log_trace_length);
        // Step must not exceed dimension.
        tempvar x = (safe_div(trace_length, dynamic_params.pedersen_builtin_row_ratio)) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Index should be non negative.
        tempvar x = (safe_div(trace_length, dynamic_params.pedersen_builtin_row_ratio));
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Coset step (memberexpression(trace_length)) must be a power of two.
        tempvar x = trace_length;
        assert_is_power_of_2(x=x, max_pow=log_trace_length);
        // Offset of pedersen/input0 must be nonnegative.
        tempvar x = dynamic_params.pedersen__input0_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of pedersen/input0 is too big.
        tempvar x = trace_length - dynamic_params.pedersen__input0_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of pedersen/input0 is too big.
        tempvar x = dynamic_params.pedersen_builtin_row_ratio - (
            safe_mult(
                dynamic_params.pedersen__input0_suboffset, dynamic_params.memory_units_row_ratio
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of pedersen/input1 must be nonnegative.
        tempvar x = dynamic_params.pedersen__input1_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of pedersen/input1 is too big.
        tempvar x = trace_length - dynamic_params.pedersen__input1_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of pedersen/input1 is too big.
        tempvar x = dynamic_params.pedersen_builtin_row_ratio - (
            safe_mult(
                dynamic_params.pedersen__input1_suboffset, dynamic_params.memory_units_row_ratio
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of pedersen/output must be nonnegative.
        tempvar x = dynamic_params.pedersen__output_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of pedersen/output is too big.
        tempvar x = trace_length - dynamic_params.pedersen__output_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of pedersen/output is too big.
        tempvar x = dynamic_params.pedersen_builtin_row_ratio - (
            safe_mult(
                dynamic_params.pedersen__output_suboffset, dynamic_params.memory_units_row_ratio
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;

        tempvar range_check_ptr = range_check_ptr;
    } else {
        tempvar range_check_ptr = range_check_ptr;
    }

    if (dynamic_params.uses_range_check_builtin != 0) {
        tempvar range_check_ptr = range_check_ptr;
        // Coset step (memberexpression(trace_length)) must be a power of two.
        tempvar x = trace_length;
        assert_is_power_of_2(x=x, max_pow=log_trace_length);
        // Row ratio should be a power of 2, smaller than trace length.
        tempvar x = dynamic_params.range_check_builtin_row_ratio;
        assert_is_power_of_2(x=x, max_pow=log_trace_length);
        // Dimension should be a power of 2.
        tempvar x = (safe_div(trace_length, dynamic_params.range_check_builtin_row_ratio));
        assert_is_power_of_2(x=x, max_pow=log_trace_length);
        // Step must not exceed dimension.
        tempvar x = (safe_div(trace_length, dynamic_params.range_check_builtin_row_ratio)) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Index should be non negative.
        tempvar x = (safe_div(trace_length, dynamic_params.range_check_builtin_row_ratio));
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Coset step ((dynamicparam(range_check_builtin_row_ratio)) / (8)) must be a power of two.
        tempvar x = (safe_div(dynamic_params.range_check_builtin_row_ratio, 8));
        assert_is_power_of_2(x=x, max_pow=log_trace_length);
        // Offset of range_check_builtin/mem must be nonnegative.
        tempvar x = dynamic_params.range_check_builtin__mem_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of range_check_builtin/mem is too big.
        tempvar x = trace_length - dynamic_params.range_check_builtin__mem_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of range_check_builtin/mem is too big.
        tempvar x = dynamic_params.range_check_builtin_row_ratio - (
            safe_mult(
                dynamic_params.range_check_builtin__mem_suboffset,
                dynamic_params.memory_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of range_check_builtin/inner_range_check must be nonnegative.
        tempvar x = dynamic_params.range_check_builtin__inner_range_check_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of range_check_builtin/inner_range_check is too big.
        tempvar x = trace_length - dynamic_params.range_check_builtin__inner_range_check_suboffset -
            1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of range_check_builtin/inner_range_check is too big.
        tempvar x = (safe_div(dynamic_params.range_check_builtin_row_ratio, 8)) - (
            safe_mult(
                dynamic_params.range_check_builtin__inner_range_check_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;

        tempvar range_check_ptr = range_check_ptr;
    } else {
        tempvar range_check_ptr = range_check_ptr;
    }

    if (dynamic_params.uses_ecdsa_builtin != 0) {
        tempvar range_check_ptr = range_check_ptr;
        // Row ratio should be a power of 2, smaller than trace length.
        tempvar x = dynamic_params.ecdsa_builtin_row_ratio;
        assert_is_power_of_2(x=x, max_pow=log_trace_length);
        // Dimension should be a power of 2.
        tempvar x = (safe_div(trace_length, dynamic_params.ecdsa_builtin_row_ratio));
        assert_is_power_of_2(x=x, max_pow=log_trace_length);
        // Coset step ((dynamicparam(ecdsa_builtin_row_ratio)) / (512)) must be a power of two.
        tempvar x = (safe_div(dynamic_params.ecdsa_builtin_row_ratio, 512));
        assert_is_power_of_2(x=x, max_pow=log_trace_length);
        // Step must not exceed dimension.
        tempvar x = (safe_div(trace_length, dynamic_params.ecdsa_builtin_row_ratio)) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Index should be non negative.
        tempvar x = (safe_div(trace_length, dynamic_params.ecdsa_builtin_row_ratio));
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Coset step ((dynamicparam(ecdsa_builtin_row_ratio)) / (256)) must be a power of two.
        tempvar x = (safe_div(dynamic_params.ecdsa_builtin_row_ratio, 256));
        assert_is_power_of_2(x=x, max_pow=log_trace_length);
        // Coset step (memberexpression(trace_length)) must be a power of two.
        tempvar x = trace_length;
        assert_is_power_of_2(x=x, max_pow=log_trace_length);
        // Coset step ((dynamicparam(ecdsa_builtin_row_ratio)) / (2)) must be a power of two.
        tempvar x = (safe_div(dynamic_params.ecdsa_builtin_row_ratio, 2));
        assert_is_power_of_2(x=x, max_pow=log_trace_length);
        // Offset of ecdsa/pubkey must be nonnegative.
        tempvar x = dynamic_params.ecdsa__pubkey_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of ecdsa/pubkey is too big.
        tempvar x = trace_length - dynamic_params.ecdsa__pubkey_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of ecdsa/pubkey is too big.
        tempvar x = dynamic_params.ecdsa_builtin_row_ratio - (
            safe_mult(dynamic_params.ecdsa__pubkey_suboffset, dynamic_params.memory_units_row_ratio)
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of ecdsa/message must be nonnegative.
        tempvar x = dynamic_params.ecdsa__message_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of ecdsa/message is too big.
        tempvar x = trace_length - dynamic_params.ecdsa__message_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of ecdsa/message is too big.
        tempvar x = dynamic_params.ecdsa_builtin_row_ratio - (
            safe_mult(
                dynamic_params.ecdsa__message_suboffset, dynamic_params.memory_units_row_ratio
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;

        tempvar range_check_ptr = range_check_ptr;
    } else {
        tempvar range_check_ptr = range_check_ptr;
    }

    if (dynamic_params.uses_bitwise_builtin != 0) {
        tempvar range_check_ptr = range_check_ptr;
        // Row ratio should be a power of 2, smaller than trace length.
        tempvar x = dynamic_params.bitwise__row_ratio;
        assert_is_power_of_2(x=x, max_pow=log_trace_length);
        // Dimension should be a power of 2.
        tempvar x = (safe_div(trace_length, dynamic_params.bitwise__row_ratio));
        assert_is_power_of_2(x=x, max_pow=log_trace_length);
        // Coset step ((dynamicparam(bitwise__row_ratio)) / (64)) must be a power of two.
        tempvar x = (safe_div(dynamic_params.bitwise__row_ratio, 64));
        assert_is_power_of_2(x=x, max_pow=log_trace_length);
        // Coset step ((dynamicparam(bitwise__row_ratio)) / (4)) must be a power of two.
        tempvar x = (safe_div(dynamic_params.bitwise__row_ratio, 4));
        assert_is_power_of_2(x=x, max_pow=log_trace_length);
        // Index out of range.
        tempvar x = (safe_div(trace_length, dynamic_params.bitwise__row_ratio)) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Index should be non negative.
        tempvar x = (safe_div(trace_length, dynamic_params.bitwise__row_ratio));
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Coset step (memberexpression(trace_length)) must be a power of two.
        tempvar x = trace_length;
        assert_is_power_of_2(x=x, max_pow=log_trace_length);
        // Offset of bitwise/var_pool must be nonnegative.
        tempvar x = dynamic_params.bitwise__var_pool_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of bitwise/var_pool is too big.
        tempvar x = trace_length - dynamic_params.bitwise__var_pool_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of bitwise/var_pool is too big.
        tempvar x = (safe_div(dynamic_params.bitwise__row_ratio, 4)) - (
            safe_mult(
                dynamic_params.bitwise__var_pool_suboffset, dynamic_params.memory_units_row_ratio
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of bitwise/x_or_y must be nonnegative.
        tempvar x = dynamic_params.bitwise__x_or_y_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of bitwise/x_or_y is too big.
        tempvar x = trace_length - dynamic_params.bitwise__x_or_y_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of bitwise/x_or_y is too big.
        tempvar x = dynamic_params.bitwise__row_ratio - (
            safe_mult(
                dynamic_params.bitwise__x_or_y_suboffset, dynamic_params.memory_units_row_ratio
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of bitwise/diluted_var_pool must be nonnegative.
        tempvar x = dynamic_params.bitwise__diluted_var_pool_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of bitwise/diluted_var_pool is too big.
        tempvar x = trace_length - dynamic_params.bitwise__diluted_var_pool_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of bitwise/diluted_var_pool is too big.
        tempvar x = (safe_div(dynamic_params.bitwise__row_ratio, 64)) - (
            safe_mult(
                dynamic_params.bitwise__diluted_var_pool_suboffset,
                dynamic_params.diluted_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of bitwise/trim_unpacking192 must be nonnegative.
        tempvar x = dynamic_params.bitwise__trim_unpacking192_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of bitwise/trim_unpacking192 is too big.
        tempvar x = trace_length - dynamic_params.bitwise__trim_unpacking192_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of bitwise/trim_unpacking192 is too big.
        tempvar x = dynamic_params.bitwise__row_ratio - (
            safe_mult(
                dynamic_params.bitwise__trim_unpacking192_suboffset,
                dynamic_params.diluted_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of bitwise/trim_unpacking193 must be nonnegative.
        tempvar x = dynamic_params.bitwise__trim_unpacking193_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of bitwise/trim_unpacking193 is too big.
        tempvar x = trace_length - dynamic_params.bitwise__trim_unpacking193_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of bitwise/trim_unpacking193 is too big.
        tempvar x = dynamic_params.bitwise__row_ratio - (
            safe_mult(
                dynamic_params.bitwise__trim_unpacking193_suboffset,
                dynamic_params.diluted_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of bitwise/trim_unpacking194 must be nonnegative.
        tempvar x = dynamic_params.bitwise__trim_unpacking194_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of bitwise/trim_unpacking194 is too big.
        tempvar x = trace_length - dynamic_params.bitwise__trim_unpacking194_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of bitwise/trim_unpacking194 is too big.
        tempvar x = dynamic_params.bitwise__row_ratio - (
            safe_mult(
                dynamic_params.bitwise__trim_unpacking194_suboffset,
                dynamic_params.diluted_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of bitwise/trim_unpacking195 must be nonnegative.
        tempvar x = dynamic_params.bitwise__trim_unpacking195_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of bitwise/trim_unpacking195 is too big.
        tempvar x = trace_length - dynamic_params.bitwise__trim_unpacking195_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of bitwise/trim_unpacking195 is too big.
        tempvar x = dynamic_params.bitwise__row_ratio - (
            safe_mult(
                dynamic_params.bitwise__trim_unpacking195_suboffset,
                dynamic_params.diluted_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;

        tempvar range_check_ptr = range_check_ptr;
    } else {
        tempvar range_check_ptr = range_check_ptr;
    }

    if (dynamic_params.uses_ec_op_builtin != 0) {
        tempvar range_check_ptr = range_check_ptr;
        // Row ratio should be a power of 2, smaller than trace length.
        tempvar x = dynamic_params.ec_op_builtin_row_ratio;
        assert_is_power_of_2(x=x, max_pow=log_trace_length);
        // Dimension should be a power of 2.
        tempvar x = (safe_div(trace_length, dynamic_params.ec_op_builtin_row_ratio));
        assert_is_power_of_2(x=x, max_pow=log_trace_length);
        // Coset step ((dynamicparam(ec_op_builtin_row_ratio)) / (256)) must be a power of two.
        tempvar x = (safe_div(dynamic_params.ec_op_builtin_row_ratio, 256));
        assert_is_power_of_2(x=x, max_pow=log_trace_length);
        // Index out of range.
        tempvar x = (safe_div(trace_length, dynamic_params.ec_op_builtin_row_ratio)) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Index should be non negative.
        tempvar x = (safe_div(trace_length, dynamic_params.ec_op_builtin_row_ratio));
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Coset step (memberexpression(trace_length)) must be a power of two.
        tempvar x = trace_length;
        assert_is_power_of_2(x=x, max_pow=log_trace_length);
        // Offset of ec_op/p_x must be nonnegative.
        tempvar x = dynamic_params.ec_op__p_x_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of ec_op/p_x is too big.
        tempvar x = trace_length - dynamic_params.ec_op__p_x_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of ec_op/p_x is too big.
        tempvar x = dynamic_params.ec_op_builtin_row_ratio - (
            safe_mult(dynamic_params.ec_op__p_x_suboffset, dynamic_params.memory_units_row_ratio)
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of ec_op/p_y must be nonnegative.
        tempvar x = dynamic_params.ec_op__p_y_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of ec_op/p_y is too big.
        tempvar x = trace_length - dynamic_params.ec_op__p_y_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of ec_op/p_y is too big.
        tempvar x = dynamic_params.ec_op_builtin_row_ratio - (
            safe_mult(dynamic_params.ec_op__p_y_suboffset, dynamic_params.memory_units_row_ratio)
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of ec_op/q_x must be nonnegative.
        tempvar x = dynamic_params.ec_op__q_x_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of ec_op/q_x is too big.
        tempvar x = trace_length - dynamic_params.ec_op__q_x_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of ec_op/q_x is too big.
        tempvar x = dynamic_params.ec_op_builtin_row_ratio - (
            safe_mult(dynamic_params.ec_op__q_x_suboffset, dynamic_params.memory_units_row_ratio)
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of ec_op/q_y must be nonnegative.
        tempvar x = dynamic_params.ec_op__q_y_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of ec_op/q_y is too big.
        tempvar x = trace_length - dynamic_params.ec_op__q_y_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of ec_op/q_y is too big.
        tempvar x = dynamic_params.ec_op_builtin_row_ratio - (
            safe_mult(dynamic_params.ec_op__q_y_suboffset, dynamic_params.memory_units_row_ratio)
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of ec_op/m must be nonnegative.
        tempvar x = dynamic_params.ec_op__m_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of ec_op/m is too big.
        tempvar x = trace_length - dynamic_params.ec_op__m_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of ec_op/m is too big.
        tempvar x = dynamic_params.ec_op_builtin_row_ratio - (
            safe_mult(dynamic_params.ec_op__m_suboffset, dynamic_params.memory_units_row_ratio)
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of ec_op/r_x must be nonnegative.
        tempvar x = dynamic_params.ec_op__r_x_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of ec_op/r_x is too big.
        tempvar x = trace_length - dynamic_params.ec_op__r_x_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of ec_op/r_x is too big.
        tempvar x = dynamic_params.ec_op_builtin_row_ratio - (
            safe_mult(dynamic_params.ec_op__r_x_suboffset, dynamic_params.memory_units_row_ratio)
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of ec_op/r_y must be nonnegative.
        tempvar x = dynamic_params.ec_op__r_y_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of ec_op/r_y is too big.
        tempvar x = trace_length - dynamic_params.ec_op__r_y_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of ec_op/r_y is too big.
        tempvar x = dynamic_params.ec_op_builtin_row_ratio - (
            safe_mult(dynamic_params.ec_op__r_y_suboffset, dynamic_params.memory_units_row_ratio)
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;

        tempvar range_check_ptr = range_check_ptr;
    } else {
        tempvar range_check_ptr = range_check_ptr;
    }

    if (dynamic_params.uses_keccak_builtin != 0) {
        tempvar range_check_ptr = range_check_ptr;
        // Coset step ((dynamicparam(keccak__row_ratio)) / (4096)) must be a power of two.
        tempvar x = (safe_div(dynamic_params.keccak__row_ratio, 4096));
        assert_is_power_of_2(x=x, max_pow=log_trace_length);
        // Dimension should be a power of 2.
        tempvar x = (safe_div(trace_length, (safe_mult(16, dynamic_params.keccak__row_ratio))));
        assert_is_power_of_2(x=x, max_pow=log_trace_length);
        // Coset step ((dynamicparam(keccak__row_ratio)) / (128)) must be a power of two.
        tempvar x = (safe_div(dynamic_params.keccak__row_ratio, 128));
        assert_is_power_of_2(x=x, max_pow=log_trace_length);
        // Coset step ((dynamicparam(keccak__row_ratio)) / (32768)) must be a power of two.
        tempvar x = (safe_div(dynamic_params.keccak__row_ratio, 32768));
        assert_is_power_of_2(x=x, max_pow=log_trace_length);
        // Row ratio should be a power of 2, smaller than trace length.
        tempvar x = dynamic_params.keccak__row_ratio;
        assert_is_power_of_2(x=x, max_pow=log_trace_length);
        // Coset step ((dynamicparam(keccak__row_ratio)) / (16)) must be a power of two.
        tempvar x = (safe_div(dynamic_params.keccak__row_ratio, 16));
        assert_is_power_of_2(x=x, max_pow=log_trace_length);
        // Dimension should be a power of 2.
        tempvar x = (safe_div((safe_mult(16, trace_length)), dynamic_params.keccak__row_ratio));
        assert_is_power_of_2(x=x, max_pow=log_trace_length);
        // Index out of range.
        tempvar x = (safe_div((safe_mult(16, trace_length)), dynamic_params.keccak__row_ratio)) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Index should be non negative.
        tempvar x = (safe_div((safe_mult(16, trace_length)), dynamic_params.keccak__row_ratio));
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Coset step (memberexpression(trace_length)) must be a power of two.
        tempvar x = trace_length;
        assert_is_power_of_2(x=x, max_pow=log_trace_length);
        // Offset of keccak/input_output must be nonnegative.
        tempvar x = dynamic_params.keccak__input_output_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of keccak/input_output is too big.
        tempvar x = trace_length - dynamic_params.keccak__input_output_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of keccak/input_output is too big.
        tempvar x = (safe_div(dynamic_params.keccak__row_ratio, 16)) - (
            safe_mult(
                dynamic_params.keccak__input_output_suboffset, dynamic_params.memory_units_row_ratio
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of keccak/keccak/diluted_column0 must be nonnegative.
        tempvar x = dynamic_params.keccak__keccak__diluted_column0_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of keccak/keccak/diluted_column0 is too big.
        tempvar x = trace_length - dynamic_params.keccak__keccak__diluted_column0_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of keccak/keccak/diluted_column0 is too big.
        tempvar x = (safe_div(dynamic_params.keccak__row_ratio, 4096)) - (
            safe_mult(
                dynamic_params.keccak__keccak__diluted_column0_suboffset,
                dynamic_params.diluted_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of keccak/keccak/diluted_column1 must be nonnegative.
        tempvar x = dynamic_params.keccak__keccak__diluted_column1_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of keccak/keccak/diluted_column1 is too big.
        tempvar x = trace_length - dynamic_params.keccak__keccak__diluted_column1_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of keccak/keccak/diluted_column1 is too big.
        tempvar x = (safe_div(dynamic_params.keccak__row_ratio, 4096)) - (
            safe_mult(
                dynamic_params.keccak__keccak__diluted_column1_suboffset,
                dynamic_params.diluted_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of keccak/keccak/diluted_column2 must be nonnegative.
        tempvar x = dynamic_params.keccak__keccak__diluted_column2_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of keccak/keccak/diluted_column2 is too big.
        tempvar x = trace_length - dynamic_params.keccak__keccak__diluted_column2_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of keccak/keccak/diluted_column2 is too big.
        tempvar x = (safe_div(dynamic_params.keccak__row_ratio, 4096)) - (
            safe_mult(
                dynamic_params.keccak__keccak__diluted_column2_suboffset,
                dynamic_params.diluted_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of keccak/keccak/diluted_column3 must be nonnegative.
        tempvar x = dynamic_params.keccak__keccak__diluted_column3_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of keccak/keccak/diluted_column3 is too big.
        tempvar x = trace_length - dynamic_params.keccak__keccak__diluted_column3_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of keccak/keccak/diluted_column3 is too big.
        tempvar x = (safe_div(dynamic_params.keccak__row_ratio, 4096)) - (
            safe_mult(
                dynamic_params.keccak__keccak__diluted_column3_suboffset,
                dynamic_params.diluted_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;

        tempvar range_check_ptr = range_check_ptr;
    } else {
        tempvar range_check_ptr = range_check_ptr;
    }

    if (dynamic_params.uses_poseidon_builtin != 0) {
        tempvar range_check_ptr = range_check_ptr;
        // Row ratio should be a power of 2, smaller than trace length.
        tempvar x = dynamic_params.poseidon__row_ratio;
        assert_is_power_of_2(x=x, max_pow=log_trace_length);
        // Dimension should be a power of 2.
        tempvar x = (safe_div(trace_length, dynamic_params.poseidon__row_ratio));
        assert_is_power_of_2(x=x, max_pow=log_trace_length);
        // Coset step ((dynamicparam(poseidon__row_ratio)) / (32)) must be a power of two.
        tempvar x = (safe_div(dynamic_params.poseidon__row_ratio, 32));
        assert_is_power_of_2(x=x, max_pow=log_trace_length);
        // Coset step ((dynamicparam(poseidon__row_ratio)) / (8)) must be a power of two.
        tempvar x = (safe_div(dynamic_params.poseidon__row_ratio, 8));
        assert_is_power_of_2(x=x, max_pow=log_trace_length);
        // Coset step ((dynamicparam(poseidon__row_ratio)) / (64)) must be a power of two.
        tempvar x = (safe_div(dynamic_params.poseidon__row_ratio, 64));
        assert_is_power_of_2(x=x, max_pow=log_trace_length);
        // Coset step ((dynamicparam(poseidon__row_ratio)) / (2)) must be a power of two.
        tempvar x = (safe_div(dynamic_params.poseidon__row_ratio, 2));
        assert_is_power_of_2(x=x, max_pow=log_trace_length);
        // Dimension should be a power of 2.
        tempvar x = (safe_div((safe_mult(2, trace_length)), dynamic_params.poseidon__row_ratio));
        assert_is_power_of_2(x=x, max_pow=log_trace_length);
        // Index out of range.
        tempvar x = (safe_div((safe_mult(2, trace_length)), dynamic_params.poseidon__row_ratio)) -
            1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Index should be non negative.
        tempvar x = (safe_div((safe_mult(2, trace_length)), dynamic_params.poseidon__row_ratio));
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Coset step (memberexpression(trace_length)) must be a power of two.
        tempvar x = trace_length;
        assert_is_power_of_2(x=x, max_pow=log_trace_length);
        // Offset of poseidon/param_0/input_output must be nonnegative.
        tempvar x = dynamic_params.poseidon__param_0__input_output_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of poseidon/param_0/input_output is too big.
        tempvar x = trace_length - dynamic_params.poseidon__param_0__input_output_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of poseidon/param_0/input_output is too big.
        tempvar x = (safe_div(dynamic_params.poseidon__row_ratio, 2)) - (
            safe_mult(
                dynamic_params.poseidon__param_0__input_output_suboffset,
                dynamic_params.memory_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of poseidon/param_1/input_output must be nonnegative.
        tempvar x = dynamic_params.poseidon__param_1__input_output_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of poseidon/param_1/input_output is too big.
        tempvar x = trace_length - dynamic_params.poseidon__param_1__input_output_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of poseidon/param_1/input_output is too big.
        tempvar x = (safe_div(dynamic_params.poseidon__row_ratio, 2)) - (
            safe_mult(
                dynamic_params.poseidon__param_1__input_output_suboffset,
                dynamic_params.memory_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of poseidon/param_2/input_output must be nonnegative.
        tempvar x = dynamic_params.poseidon__param_2__input_output_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of poseidon/param_2/input_output is too big.
        tempvar x = trace_length - dynamic_params.poseidon__param_2__input_output_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of poseidon/param_2/input_output is too big.
        tempvar x = (safe_div(dynamic_params.poseidon__row_ratio, 2)) - (
            safe_mult(
                dynamic_params.poseidon__param_2__input_output_suboffset,
                dynamic_params.memory_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;

        tempvar range_check_ptr = range_check_ptr;
    } else {
        tempvar range_check_ptr = range_check_ptr;
    }

    if (dynamic_params.uses_range_check96_builtin != 0) {
        tempvar range_check_ptr = range_check_ptr;
        // Coset step (memberexpression(trace_length)) must be a power of two.
        tempvar x = trace_length;
        assert_is_power_of_2(x=x, max_pow=log_trace_length);
        // Row ratio should be a power of 2, smaller than trace length.
        tempvar x = dynamic_params.range_check96_builtin_row_ratio;
        assert_is_power_of_2(x=x, max_pow=log_trace_length);
        // Dimension should be a power of 2.
        tempvar x = (safe_div(trace_length, dynamic_params.range_check96_builtin_row_ratio));
        assert_is_power_of_2(x=x, max_pow=log_trace_length);
        // Step must not exceed dimension.
        tempvar x = (safe_div(trace_length, dynamic_params.range_check96_builtin_row_ratio)) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Index should be non negative.
        tempvar x = (safe_div(trace_length, dynamic_params.range_check96_builtin_row_ratio));
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of range_check96_builtin/mem must be nonnegative.
        tempvar x = dynamic_params.range_check96_builtin__mem_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of range_check96_builtin/mem is too big.
        tempvar x = trace_length - dynamic_params.range_check96_builtin__mem_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of range_check96_builtin/mem is too big.
        tempvar x = dynamic_params.range_check96_builtin_row_ratio - (
            safe_mult(
                dynamic_params.range_check96_builtin__mem_suboffset,
                dynamic_params.memory_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of range_check96_builtin/inner_range_check0 must be nonnegative.
        tempvar x = dynamic_params.range_check96_builtin__inner_range_check0_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of range_check96_builtin/inner_range_check0 is too big.
        tempvar x = trace_length -
            dynamic_params.range_check96_builtin__inner_range_check0_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of range_check96_builtin/inner_range_check0 is too big.
        tempvar x = dynamic_params.range_check96_builtin_row_ratio - (
            safe_mult(
                dynamic_params.range_check96_builtin__inner_range_check0_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of range_check96_builtin/inner_range_check1 must be nonnegative.
        tempvar x = dynamic_params.range_check96_builtin__inner_range_check1_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of range_check96_builtin/inner_range_check1 is too big.
        tempvar x = trace_length -
            dynamic_params.range_check96_builtin__inner_range_check1_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of range_check96_builtin/inner_range_check1 is too big.
        tempvar x = dynamic_params.range_check96_builtin_row_ratio - (
            safe_mult(
                dynamic_params.range_check96_builtin__inner_range_check1_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of range_check96_builtin/inner_range_check2 must be nonnegative.
        tempvar x = dynamic_params.range_check96_builtin__inner_range_check2_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of range_check96_builtin/inner_range_check2 is too big.
        tempvar x = trace_length -
            dynamic_params.range_check96_builtin__inner_range_check2_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of range_check96_builtin/inner_range_check2 is too big.
        tempvar x = dynamic_params.range_check96_builtin_row_ratio - (
            safe_mult(
                dynamic_params.range_check96_builtin__inner_range_check2_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of range_check96_builtin/inner_range_check3 must be nonnegative.
        tempvar x = dynamic_params.range_check96_builtin__inner_range_check3_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of range_check96_builtin/inner_range_check3 is too big.
        tempvar x = trace_length -
            dynamic_params.range_check96_builtin__inner_range_check3_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of range_check96_builtin/inner_range_check3 is too big.
        tempvar x = dynamic_params.range_check96_builtin_row_ratio - (
            safe_mult(
                dynamic_params.range_check96_builtin__inner_range_check3_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of range_check96_builtin/inner_range_check4 must be nonnegative.
        tempvar x = dynamic_params.range_check96_builtin__inner_range_check4_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of range_check96_builtin/inner_range_check4 is too big.
        tempvar x = trace_length -
            dynamic_params.range_check96_builtin__inner_range_check4_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of range_check96_builtin/inner_range_check4 is too big.
        tempvar x = dynamic_params.range_check96_builtin_row_ratio - (
            safe_mult(
                dynamic_params.range_check96_builtin__inner_range_check4_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of range_check96_builtin/inner_range_check5 must be nonnegative.
        tempvar x = dynamic_params.range_check96_builtin__inner_range_check5_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of range_check96_builtin/inner_range_check5 is too big.
        tempvar x = trace_length -
            dynamic_params.range_check96_builtin__inner_range_check5_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of range_check96_builtin/inner_range_check5 is too big.
        tempvar x = dynamic_params.range_check96_builtin_row_ratio - (
            safe_mult(
                dynamic_params.range_check96_builtin__inner_range_check5_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;

        tempvar range_check_ptr = range_check_ptr;
    } else {
        tempvar range_check_ptr = range_check_ptr;
    }

    if (dynamic_params.uses_add_mod_builtin != 0) {
        tempvar range_check_ptr = range_check_ptr;
        // Row ratio should be a power of 2, smaller than trace length.
        tempvar x = dynamic_params.add_mod__row_ratio;
        assert_is_power_of_2(x=x, max_pow=log_trace_length);
        // Dimension should be a power of 2.
        tempvar x = (safe_div(trace_length, dynamic_params.add_mod__row_ratio));
        assert_is_power_of_2(x=x, max_pow=log_trace_length);
        // Index out of range.
        tempvar x = (safe_div(trace_length, dynamic_params.add_mod__row_ratio)) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Index should be non negative.
        tempvar x = (safe_div(trace_length, dynamic_params.add_mod__row_ratio));
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Coset step (memberexpression(trace_length)) must be a power of two.
        tempvar x = trace_length;
        assert_is_power_of_2(x=x, max_pow=log_trace_length);
        // Offset of add_mod/p0 must be nonnegative.
        tempvar x = dynamic_params.add_mod__p0_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/p0 is too big.
        tempvar x = trace_length - dynamic_params.add_mod__p0_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/p0 is too big.
        tempvar x = dynamic_params.add_mod__row_ratio - (
            safe_mult(dynamic_params.add_mod__p0_suboffset, dynamic_params.memory_units_row_ratio)
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/p1 must be nonnegative.
        tempvar x = dynamic_params.add_mod__p1_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/p1 is too big.
        tempvar x = trace_length - dynamic_params.add_mod__p1_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/p1 is too big.
        tempvar x = dynamic_params.add_mod__row_ratio - (
            safe_mult(dynamic_params.add_mod__p1_suboffset, dynamic_params.memory_units_row_ratio)
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/p2 must be nonnegative.
        tempvar x = dynamic_params.add_mod__p2_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/p2 is too big.
        tempvar x = trace_length - dynamic_params.add_mod__p2_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/p2 is too big.
        tempvar x = dynamic_params.add_mod__row_ratio - (
            safe_mult(dynamic_params.add_mod__p2_suboffset, dynamic_params.memory_units_row_ratio)
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/p3 must be nonnegative.
        tempvar x = dynamic_params.add_mod__p3_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/p3 is too big.
        tempvar x = trace_length - dynamic_params.add_mod__p3_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/p3 is too big.
        tempvar x = dynamic_params.add_mod__row_ratio - (
            safe_mult(dynamic_params.add_mod__p3_suboffset, dynamic_params.memory_units_row_ratio)
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/values_ptr must be nonnegative.
        tempvar x = dynamic_params.add_mod__values_ptr_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/values_ptr is too big.
        tempvar x = trace_length - dynamic_params.add_mod__values_ptr_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/values_ptr is too big.
        tempvar x = dynamic_params.add_mod__row_ratio - (
            safe_mult(
                dynamic_params.add_mod__values_ptr_suboffset, dynamic_params.memory_units_row_ratio
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/offsets_ptr must be nonnegative.
        tempvar x = dynamic_params.add_mod__offsets_ptr_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/offsets_ptr is too big.
        tempvar x = trace_length - dynamic_params.add_mod__offsets_ptr_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/offsets_ptr is too big.
        tempvar x = dynamic_params.add_mod__row_ratio - (
            safe_mult(
                dynamic_params.add_mod__offsets_ptr_suboffset, dynamic_params.memory_units_row_ratio
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/n must be nonnegative.
        tempvar x = dynamic_params.add_mod__n_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/n is too big.
        tempvar x = trace_length - dynamic_params.add_mod__n_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/n is too big.
        tempvar x = dynamic_params.add_mod__row_ratio - (
            safe_mult(dynamic_params.add_mod__n_suboffset, dynamic_params.memory_units_row_ratio)
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/a_offset must be nonnegative.
        tempvar x = dynamic_params.add_mod__a_offset_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/a_offset is too big.
        tempvar x = trace_length - dynamic_params.add_mod__a_offset_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/a_offset is too big.
        tempvar x = dynamic_params.add_mod__row_ratio - (
            safe_mult(
                dynamic_params.add_mod__a_offset_suboffset, dynamic_params.memory_units_row_ratio
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/b_offset must be nonnegative.
        tempvar x = dynamic_params.add_mod__b_offset_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/b_offset is too big.
        tempvar x = trace_length - dynamic_params.add_mod__b_offset_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/b_offset is too big.
        tempvar x = dynamic_params.add_mod__row_ratio - (
            safe_mult(
                dynamic_params.add_mod__b_offset_suboffset, dynamic_params.memory_units_row_ratio
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/c_offset must be nonnegative.
        tempvar x = dynamic_params.add_mod__c_offset_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/c_offset is too big.
        tempvar x = trace_length - dynamic_params.add_mod__c_offset_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/c_offset is too big.
        tempvar x = dynamic_params.add_mod__row_ratio - (
            safe_mult(
                dynamic_params.add_mod__c_offset_suboffset, dynamic_params.memory_units_row_ratio
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/a0 must be nonnegative.
        tempvar x = dynamic_params.add_mod__a0_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/a0 is too big.
        tempvar x = trace_length - dynamic_params.add_mod__a0_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/a0 is too big.
        tempvar x = dynamic_params.add_mod__row_ratio - (
            safe_mult(dynamic_params.add_mod__a0_suboffset, dynamic_params.memory_units_row_ratio)
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/a1 must be nonnegative.
        tempvar x = dynamic_params.add_mod__a1_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/a1 is too big.
        tempvar x = trace_length - dynamic_params.add_mod__a1_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/a1 is too big.
        tempvar x = dynamic_params.add_mod__row_ratio - (
            safe_mult(dynamic_params.add_mod__a1_suboffset, dynamic_params.memory_units_row_ratio)
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/a2 must be nonnegative.
        tempvar x = dynamic_params.add_mod__a2_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/a2 is too big.
        tempvar x = trace_length - dynamic_params.add_mod__a2_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/a2 is too big.
        tempvar x = dynamic_params.add_mod__row_ratio - (
            safe_mult(dynamic_params.add_mod__a2_suboffset, dynamic_params.memory_units_row_ratio)
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/a3 must be nonnegative.
        tempvar x = dynamic_params.add_mod__a3_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/a3 is too big.
        tempvar x = trace_length - dynamic_params.add_mod__a3_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/a3 is too big.
        tempvar x = dynamic_params.add_mod__row_ratio - (
            safe_mult(dynamic_params.add_mod__a3_suboffset, dynamic_params.memory_units_row_ratio)
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/b0 must be nonnegative.
        tempvar x = dynamic_params.add_mod__b0_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/b0 is too big.
        tempvar x = trace_length - dynamic_params.add_mod__b0_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/b0 is too big.
        tempvar x = dynamic_params.add_mod__row_ratio - (
            safe_mult(dynamic_params.add_mod__b0_suboffset, dynamic_params.memory_units_row_ratio)
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/b1 must be nonnegative.
        tempvar x = dynamic_params.add_mod__b1_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/b1 is too big.
        tempvar x = trace_length - dynamic_params.add_mod__b1_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/b1 is too big.
        tempvar x = dynamic_params.add_mod__row_ratio - (
            safe_mult(dynamic_params.add_mod__b1_suboffset, dynamic_params.memory_units_row_ratio)
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/b2 must be nonnegative.
        tempvar x = dynamic_params.add_mod__b2_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/b2 is too big.
        tempvar x = trace_length - dynamic_params.add_mod__b2_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/b2 is too big.
        tempvar x = dynamic_params.add_mod__row_ratio - (
            safe_mult(dynamic_params.add_mod__b2_suboffset, dynamic_params.memory_units_row_ratio)
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/b3 must be nonnegative.
        tempvar x = dynamic_params.add_mod__b3_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/b3 is too big.
        tempvar x = trace_length - dynamic_params.add_mod__b3_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/b3 is too big.
        tempvar x = dynamic_params.add_mod__row_ratio - (
            safe_mult(dynamic_params.add_mod__b3_suboffset, dynamic_params.memory_units_row_ratio)
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/c0 must be nonnegative.
        tempvar x = dynamic_params.add_mod__c0_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/c0 is too big.
        tempvar x = trace_length - dynamic_params.add_mod__c0_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/c0 is too big.
        tempvar x = dynamic_params.add_mod__row_ratio - (
            safe_mult(dynamic_params.add_mod__c0_suboffset, dynamic_params.memory_units_row_ratio)
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/c1 must be nonnegative.
        tempvar x = dynamic_params.add_mod__c1_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/c1 is too big.
        tempvar x = trace_length - dynamic_params.add_mod__c1_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/c1 is too big.
        tempvar x = dynamic_params.add_mod__row_ratio - (
            safe_mult(dynamic_params.add_mod__c1_suboffset, dynamic_params.memory_units_row_ratio)
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/c2 must be nonnegative.
        tempvar x = dynamic_params.add_mod__c2_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/c2 is too big.
        tempvar x = trace_length - dynamic_params.add_mod__c2_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/c2 is too big.
        tempvar x = dynamic_params.add_mod__row_ratio - (
            safe_mult(dynamic_params.add_mod__c2_suboffset, dynamic_params.memory_units_row_ratio)
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/c3 must be nonnegative.
        tempvar x = dynamic_params.add_mod__c3_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/c3 is too big.
        tempvar x = trace_length - dynamic_params.add_mod__c3_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of add_mod/c3 is too big.
        tempvar x = dynamic_params.add_mod__row_ratio - (
            safe_mult(dynamic_params.add_mod__c3_suboffset, dynamic_params.memory_units_row_ratio)
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;

        tempvar range_check_ptr = range_check_ptr;
    } else {
        tempvar range_check_ptr = range_check_ptr;
    }

    if (dynamic_params.uses_mul_mod_builtin != 0) {
        tempvar range_check_ptr = range_check_ptr;
        // Row ratio should be a power of 2, smaller than trace length.
        tempvar x = dynamic_params.mul_mod__row_ratio;
        assert_is_power_of_2(x=x, max_pow=log_trace_length);
        // Dimension should be a power of 2.
        tempvar x = (safe_div(trace_length, dynamic_params.mul_mod__row_ratio));
        assert_is_power_of_2(x=x, max_pow=log_trace_length);
        // Index out of range.
        tempvar x = (safe_div(trace_length, dynamic_params.mul_mod__row_ratio)) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Index should be non negative.
        tempvar x = (safe_div(trace_length, dynamic_params.mul_mod__row_ratio));
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Coset step (memberexpression(trace_length)) must be a power of two.
        tempvar x = trace_length;
        assert_is_power_of_2(x=x, max_pow=log_trace_length);
        // Offset of mul_mod/p0 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__p0_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p0 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__p0_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p0 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(dynamic_params.mul_mod__p0_suboffset, dynamic_params.memory_units_row_ratio)
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p1 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__p1_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p1 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__p1_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p1 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(dynamic_params.mul_mod__p1_suboffset, dynamic_params.memory_units_row_ratio)
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p2 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__p2_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p2 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__p2_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p2 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(dynamic_params.mul_mod__p2_suboffset, dynamic_params.memory_units_row_ratio)
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p3 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__p3_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p3 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__p3_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p3 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(dynamic_params.mul_mod__p3_suboffset, dynamic_params.memory_units_row_ratio)
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/values_ptr must be nonnegative.
        tempvar x = dynamic_params.mul_mod__values_ptr_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/values_ptr is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__values_ptr_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/values_ptr is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__values_ptr_suboffset, dynamic_params.memory_units_row_ratio
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/offsets_ptr must be nonnegative.
        tempvar x = dynamic_params.mul_mod__offsets_ptr_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/offsets_ptr is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__offsets_ptr_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/offsets_ptr is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__offsets_ptr_suboffset, dynamic_params.memory_units_row_ratio
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/n must be nonnegative.
        tempvar x = dynamic_params.mul_mod__n_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/n is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__n_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/n is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(dynamic_params.mul_mod__n_suboffset, dynamic_params.memory_units_row_ratio)
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/a_offset must be nonnegative.
        tempvar x = dynamic_params.mul_mod__a_offset_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/a_offset is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__a_offset_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/a_offset is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__a_offset_suboffset, dynamic_params.memory_units_row_ratio
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/b_offset must be nonnegative.
        tempvar x = dynamic_params.mul_mod__b_offset_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/b_offset is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__b_offset_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/b_offset is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__b_offset_suboffset, dynamic_params.memory_units_row_ratio
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/c_offset must be nonnegative.
        tempvar x = dynamic_params.mul_mod__c_offset_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/c_offset is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__c_offset_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/c_offset is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__c_offset_suboffset, dynamic_params.memory_units_row_ratio
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/a0 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__a0_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/a0 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__a0_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/a0 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(dynamic_params.mul_mod__a0_suboffset, dynamic_params.memory_units_row_ratio)
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/a1 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__a1_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/a1 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__a1_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/a1 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(dynamic_params.mul_mod__a1_suboffset, dynamic_params.memory_units_row_ratio)
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/a2 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__a2_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/a2 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__a2_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/a2 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(dynamic_params.mul_mod__a2_suboffset, dynamic_params.memory_units_row_ratio)
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/a3 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__a3_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/a3 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__a3_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/a3 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(dynamic_params.mul_mod__a3_suboffset, dynamic_params.memory_units_row_ratio)
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/b0 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__b0_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/b0 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__b0_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/b0 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(dynamic_params.mul_mod__b0_suboffset, dynamic_params.memory_units_row_ratio)
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/b1 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__b1_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/b1 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__b1_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/b1 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(dynamic_params.mul_mod__b1_suboffset, dynamic_params.memory_units_row_ratio)
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/b2 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__b2_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/b2 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__b2_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/b2 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(dynamic_params.mul_mod__b2_suboffset, dynamic_params.memory_units_row_ratio)
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/b3 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__b3_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/b3 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__b3_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/b3 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(dynamic_params.mul_mod__b3_suboffset, dynamic_params.memory_units_row_ratio)
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/c0 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__c0_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/c0 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__c0_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/c0 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(dynamic_params.mul_mod__c0_suboffset, dynamic_params.memory_units_row_ratio)
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/c1 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__c1_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/c1 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__c1_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/c1 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(dynamic_params.mul_mod__c1_suboffset, dynamic_params.memory_units_row_ratio)
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/c2 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__c2_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/c2 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__c2_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/c2 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(dynamic_params.mul_mod__c2_suboffset, dynamic_params.memory_units_row_ratio)
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/c3 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__c3_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/c3 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__c3_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/c3 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(dynamic_params.mul_mod__c3_suboffset, dynamic_params.memory_units_row_ratio)
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier0/part0 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__p_multiplier0__part0_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier0/part0 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__p_multiplier0__part0_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier0/part0 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__p_multiplier0__part0_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier0/part1 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__p_multiplier0__part1_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier0/part1 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__p_multiplier0__part1_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier0/part1 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__p_multiplier0__part1_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier0/part2 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__p_multiplier0__part2_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier0/part2 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__p_multiplier0__part2_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier0/part2 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__p_multiplier0__part2_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier0/part3 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__p_multiplier0__part3_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier0/part3 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__p_multiplier0__part3_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier0/part3 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__p_multiplier0__part3_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier0/part4 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__p_multiplier0__part4_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier0/part4 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__p_multiplier0__part4_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier0/part4 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__p_multiplier0__part4_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier0/part5 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__p_multiplier0__part5_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier0/part5 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__p_multiplier0__part5_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier0/part5 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__p_multiplier0__part5_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier1/part0 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__p_multiplier1__part0_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier1/part0 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__p_multiplier1__part0_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier1/part0 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__p_multiplier1__part0_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier1/part1 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__p_multiplier1__part1_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier1/part1 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__p_multiplier1__part1_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier1/part1 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__p_multiplier1__part1_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier1/part2 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__p_multiplier1__part2_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier1/part2 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__p_multiplier1__part2_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier1/part2 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__p_multiplier1__part2_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier1/part3 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__p_multiplier1__part3_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier1/part3 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__p_multiplier1__part3_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier1/part3 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__p_multiplier1__part3_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier1/part4 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__p_multiplier1__part4_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier1/part4 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__p_multiplier1__part4_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier1/part4 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__p_multiplier1__part4_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier1/part5 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__p_multiplier1__part5_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier1/part5 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__p_multiplier1__part5_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier1/part5 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__p_multiplier1__part5_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier2/part0 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__p_multiplier2__part0_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier2/part0 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__p_multiplier2__part0_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier2/part0 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__p_multiplier2__part0_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier2/part1 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__p_multiplier2__part1_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier2/part1 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__p_multiplier2__part1_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier2/part1 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__p_multiplier2__part1_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier2/part2 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__p_multiplier2__part2_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier2/part2 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__p_multiplier2__part2_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier2/part2 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__p_multiplier2__part2_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier2/part3 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__p_multiplier2__part3_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier2/part3 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__p_multiplier2__part3_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier2/part3 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__p_multiplier2__part3_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier2/part4 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__p_multiplier2__part4_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier2/part4 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__p_multiplier2__part4_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier2/part4 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__p_multiplier2__part4_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier2/part5 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__p_multiplier2__part5_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier2/part5 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__p_multiplier2__part5_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier2/part5 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__p_multiplier2__part5_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier3/part0 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__p_multiplier3__part0_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier3/part0 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__p_multiplier3__part0_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier3/part0 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__p_multiplier3__part0_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier3/part1 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__p_multiplier3__part1_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier3/part1 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__p_multiplier3__part1_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier3/part1 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__p_multiplier3__part1_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier3/part2 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__p_multiplier3__part2_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier3/part2 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__p_multiplier3__part2_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier3/part2 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__p_multiplier3__part2_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier3/part3 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__p_multiplier3__part3_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier3/part3 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__p_multiplier3__part3_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier3/part3 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__p_multiplier3__part3_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier3/part4 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__p_multiplier3__part4_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier3/part4 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__p_multiplier3__part4_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier3/part4 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__p_multiplier3__part4_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier3/part5 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__p_multiplier3__part5_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier3/part5 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__p_multiplier3__part5_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/p_multiplier3/part5 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__p_multiplier3__part5_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry0/part0 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__carry0__part0_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry0/part0 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__carry0__part0_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry0/part0 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__carry0__part0_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry0/part1 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__carry0__part1_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry0/part1 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__carry0__part1_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry0/part1 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__carry0__part1_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry0/part2 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__carry0__part2_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry0/part2 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__carry0__part2_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry0/part2 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__carry0__part2_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry0/part3 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__carry0__part3_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry0/part3 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__carry0__part3_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry0/part3 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__carry0__part3_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry0/part4 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__carry0__part4_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry0/part4 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__carry0__part4_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry0/part4 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__carry0__part4_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry0/part5 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__carry0__part5_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry0/part5 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__carry0__part5_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry0/part5 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__carry0__part5_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry0/part6 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__carry0__part6_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry0/part6 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__carry0__part6_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry0/part6 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__carry0__part6_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry1/part0 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__carry1__part0_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry1/part0 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__carry1__part0_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry1/part0 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__carry1__part0_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry1/part1 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__carry1__part1_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry1/part1 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__carry1__part1_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry1/part1 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__carry1__part1_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry1/part2 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__carry1__part2_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry1/part2 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__carry1__part2_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry1/part2 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__carry1__part2_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry1/part3 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__carry1__part3_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry1/part3 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__carry1__part3_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry1/part3 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__carry1__part3_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry1/part4 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__carry1__part4_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry1/part4 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__carry1__part4_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry1/part4 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__carry1__part4_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry1/part5 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__carry1__part5_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry1/part5 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__carry1__part5_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry1/part5 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__carry1__part5_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry1/part6 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__carry1__part6_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry1/part6 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__carry1__part6_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry1/part6 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__carry1__part6_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry2/part0 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__carry2__part0_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry2/part0 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__carry2__part0_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry2/part0 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__carry2__part0_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry2/part1 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__carry2__part1_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry2/part1 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__carry2__part1_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry2/part1 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__carry2__part1_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry2/part2 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__carry2__part2_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry2/part2 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__carry2__part2_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry2/part2 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__carry2__part2_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry2/part3 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__carry2__part3_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry2/part3 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__carry2__part3_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry2/part3 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__carry2__part3_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry2/part4 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__carry2__part4_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry2/part4 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__carry2__part4_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry2/part4 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__carry2__part4_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry2/part5 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__carry2__part5_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry2/part5 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__carry2__part5_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry2/part5 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__carry2__part5_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry2/part6 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__carry2__part6_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry2/part6 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__carry2__part6_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry2/part6 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__carry2__part6_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry3/part0 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__carry3__part0_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry3/part0 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__carry3__part0_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry3/part0 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__carry3__part0_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry3/part1 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__carry3__part1_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry3/part1 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__carry3__part1_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry3/part1 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__carry3__part1_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry3/part2 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__carry3__part2_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry3/part2 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__carry3__part2_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry3/part2 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__carry3__part2_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry3/part3 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__carry3__part3_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry3/part3 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__carry3__part3_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry3/part3 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__carry3__part3_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry3/part4 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__carry3__part4_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry3/part4 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__carry3__part4_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry3/part4 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__carry3__part4_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry3/part5 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__carry3__part5_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry3/part5 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__carry3__part5_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry3/part5 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__carry3__part5_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry3/part6 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__carry3__part6_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry3/part6 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__carry3__part6_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry3/part6 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__carry3__part6_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry4/part0 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__carry4__part0_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry4/part0 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__carry4__part0_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry4/part0 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__carry4__part0_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry4/part1 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__carry4__part1_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry4/part1 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__carry4__part1_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry4/part1 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__carry4__part1_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry4/part2 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__carry4__part2_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry4/part2 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__carry4__part2_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry4/part2 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__carry4__part2_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry4/part3 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__carry4__part3_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry4/part3 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__carry4__part3_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry4/part3 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__carry4__part3_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry4/part4 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__carry4__part4_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry4/part4 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__carry4__part4_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry4/part4 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__carry4__part4_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry4/part5 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__carry4__part5_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry4/part5 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__carry4__part5_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry4/part5 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__carry4__part5_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry4/part6 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__carry4__part6_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry4/part6 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__carry4__part6_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry4/part6 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__carry4__part6_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry5/part0 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__carry5__part0_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry5/part0 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__carry5__part0_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry5/part0 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__carry5__part0_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry5/part1 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__carry5__part1_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry5/part1 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__carry5__part1_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry5/part1 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__carry5__part1_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry5/part2 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__carry5__part2_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry5/part2 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__carry5__part2_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry5/part2 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__carry5__part2_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry5/part3 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__carry5__part3_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry5/part3 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__carry5__part3_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry5/part3 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__carry5__part3_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry5/part4 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__carry5__part4_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry5/part4 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__carry5__part4_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry5/part4 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__carry5__part4_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry5/part5 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__carry5__part5_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry5/part5 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__carry5__part5_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry5/part5 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__carry5__part5_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry5/part6 must be nonnegative.
        tempvar x = dynamic_params.mul_mod__carry5__part6_suboffset;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry5/part6 is too big.
        tempvar x = trace_length - dynamic_params.mul_mod__carry5__part6_suboffset - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;
        // Offset of mul_mod/carry5/part6 is too big.
        tempvar x = dynamic_params.mul_mod__row_ratio - (
            safe_mult(
                dynamic_params.mul_mod__carry5__part6_suboffset,
                dynamic_params.range_check_units_row_ratio,
            )
        ) - 1;
        assert [range_check_ptr] = x;
        let range_check_ptr = range_check_ptr + 1;

        tempvar range_check_ptr = range_check_ptr;
    } else {
        tempvar range_check_ptr = range_check_ptr;
    }
}
