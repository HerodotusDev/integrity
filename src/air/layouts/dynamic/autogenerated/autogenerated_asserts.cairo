use core::integer::U256BitAnd;
use cairo_verifier::{
    domains::StarkDomains, air::layouts::dynamic::constants::DynamicParams,
    common::{math::{Felt252Div, pow}, asserts::assert_is_power_of_2},
};

fn check_asserts(dynamic_params: DynamicParams, stark_domains: @StarkDomains) {
    let trace_length: u256 = (*stark_domains.trace_domain_size).into();

    // Coset step (dynamicparam(diluted_units_row_ratio)) must be a power of two.
    let mut x: u256 = (dynamic_params.diluted_units_row_ratio.into());
    assert(x != 0 && U256BitAnd::bitand(x, x - 1) == 0, 'Value is not pow of 2');
    // Dimension should be a power of 2_u256.
    x = trace_length / (dynamic_params.diluted_units_row_ratio.into());
    assert(x != 0 && U256BitAnd::bitand(x, x - 1) == 0, 'Value is not pow of 2');
    // Index out of range.
    x = (trace_length / (dynamic_params.diluted_units_row_ratio.into())) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Coset step (memberexpression(trace_length)) must be a power of two.
    x = trace_length;
    assert(x != 0 && U256BitAnd::bitand(x, x - 1) == 0, 'Value is not pow of 2');
    // Index should be non negative.
    x = trace_length / (dynamic_params.diluted_units_row_ratio.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Coset step (dynamicparam(range_check_units_row_ratio)) must be a power of two.
    x = (dynamic_params.range_check_units_row_ratio.into());
    assert(x != 0 && U256BitAnd::bitand(x, x - 1) == 0, 'Value is not pow of 2');
    // Dimension should be a power of 2_u256.
    x = trace_length / (dynamic_params.range_check_units_row_ratio.into());
    assert(x != 0 && U256BitAnd::bitand(x, x - 1) == 0, 'Value is not pow of 2');
    // Index out of range.
    x = (trace_length / (dynamic_params.range_check_units_row_ratio.into())) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Index should be non negative.
    x = trace_length / (dynamic_params.range_check_units_row_ratio.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Coset step ((8_u256) * (dynamicparam(memory_units_row_ratio))) must be a power of two.
    x = (8_u256 * (dynamic_params.memory_units_row_ratio.into()));
    assert(x != 0 && U256BitAnd::bitand(x, x - 1) == 0, 'Value is not pow of 2');
    // Dimension should be a power of 2_u256.
    x = trace_length / (8_u256 * (dynamic_params.memory_units_row_ratio.into()));
    assert(x != 0 && U256BitAnd::bitand(x, x - 1) == 0, 'Value is not pow of 2');
    // Coset step (dynamicparam(memory_units_row_ratio)) must be a power of two.
    x = (dynamic_params.memory_units_row_ratio.into());
    assert(x != 0 && U256BitAnd::bitand(x, x - 1) == 0, 'Value is not pow of 2');
    // Dimension should be a power of 2_u256.
    x = trace_length / (dynamic_params.memory_units_row_ratio.into());
    assert(x != 0 && U256BitAnd::bitand(x, x - 1) == 0, 'Value is not pow of 2');
    // Index out of range.
    x = (trace_length / (dynamic_params.memory_units_row_ratio.into())) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Index should be non negative.
    x = trace_length / (dynamic_params.memory_units_row_ratio.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Coset step ((16_u256) * (dynamicparam(cpu_component_step))) must be a power of two.
    x = (16_u256 * (dynamic_params.cpu_component_step.into()));
    assert(x != 0 && U256BitAnd::bitand(x, x - 1) == 0, 'Value is not pow of 2');
    // Dimension should be a power of 2_u256.
    x = trace_length / (16_u256 * (dynamic_params.cpu_component_step.into()));
    assert(x != 0 && U256BitAnd::bitand(x, x - 1) == 0, 'Value is not pow of 2');
    // Step must not exceed dimension.
    x = (trace_length / (16_u256 * (dynamic_params.cpu_component_step.into()))) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Coset step (dynamicparam(cpu_component_step)) must be a power of two.
    x = (dynamic_params.cpu_component_step.into());
    assert(x != 0 && U256BitAnd::bitand(x, x - 1) == 0, 'Value is not pow of 2');
    // Index out of range.
    x = trace_length / (16_u256 * (dynamic_params.cpu_component_step.into()));
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Cpu_component_step is out of range.
    x = 256_u256 - (dynamic_params.cpu_component_step.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Memory_units_row_ratio is out of range.
    x = ((16_u256 * (dynamic_params.cpu_component_step.into())))
        - ((4_u256 * (dynamic_params.memory_units_row_ratio.into())));
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset of cpu/decode/mem_inst must be nonnegative.
    x = (dynamic_params.cpu_decode_mem_inst_suboffset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset of cpu/decode/mem_inst is too big.
    x = trace_length - (dynamic_params.cpu_decode_mem_inst_suboffset.into()) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset of cpu/decode/mem_inst is too big.
    x = ((16_u256 * (dynamic_params.cpu_component_step.into())))
        - (((dynamic_params.cpu_decode_mem_inst_suboffset.into())
            * (dynamic_params.memory_units_row_ratio.into())))
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset of cpu/decode/off0 must be nonnegative.
    x = (dynamic_params.cpu_decode_off0_suboffset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset of cpu/decode/off0 is too big.
    x = trace_length - (dynamic_params.cpu_decode_off0_suboffset.into()) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset of cpu/decode/off0 is too big.
    x = ((16_u256 * (dynamic_params.cpu_component_step.into())))
        - (((dynamic_params.cpu_decode_off0_suboffset.into())
            * (dynamic_params.range_check_units_row_ratio.into())))
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset of cpu/decode/off1 must be nonnegative.
    x = (dynamic_params.cpu_decode_off1_suboffset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset of cpu/decode/off1 is too big.
    x = trace_length - (dynamic_params.cpu_decode_off1_suboffset.into()) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset of cpu/decode/off1 is too big.
    x = ((16_u256 * (dynamic_params.cpu_component_step.into())))
        - (((dynamic_params.cpu_decode_off1_suboffset.into())
            * (dynamic_params.range_check_units_row_ratio.into())))
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset of cpu/decode/off2 must be nonnegative.
    x = (dynamic_params.cpu_decode_off2_suboffset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset of cpu/decode/off2 is too big.
    x = trace_length - (dynamic_params.cpu_decode_off2_suboffset.into()) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset of cpu/decode/off2 is too big.
    x = ((16_u256 * (dynamic_params.cpu_component_step.into())))
        - (((dynamic_params.cpu_decode_off2_suboffset.into())
            * (dynamic_params.range_check_units_row_ratio.into())))
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset of cpu/operands/mem_dst must be nonnegative.
    x = (dynamic_params.cpu_operands_mem_dst_suboffset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset of cpu/operands/mem_dst is too big.
    x = trace_length - (dynamic_params.cpu_operands_mem_dst_suboffset.into()) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset of cpu/operands/mem_dst is too big.
    x = ((16_u256 * (dynamic_params.cpu_component_step.into())))
        - (((dynamic_params.cpu_operands_mem_dst_suboffset.into())
            * (dynamic_params.memory_units_row_ratio.into())))
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset of cpu/operands/mem_op0 must be nonnegative.
    x = (dynamic_params.cpu_operands_mem_op0_suboffset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset of cpu/operands/mem_op0 is too big.
    x = trace_length - (dynamic_params.cpu_operands_mem_op0_suboffset.into()) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset of cpu/operands/mem_op0 is too big.
    x = ((16_u256 * (dynamic_params.cpu_component_step.into())))
        - (((dynamic_params.cpu_operands_mem_op0_suboffset.into())
            * (dynamic_params.memory_units_row_ratio.into())))
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset of cpu/operands/mem_op1 must be nonnegative.
    x = (dynamic_params.cpu_operands_mem_op1_suboffset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset of cpu/operands/mem_op1 is too big.
    x = trace_length - (dynamic_params.cpu_operands_mem_op1_suboffset.into()) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset of cpu/operands/mem_op1 is too big.
    x = ((16_u256 * (dynamic_params.cpu_component_step.into())))
        - (((dynamic_params.cpu_operands_mem_op1_suboffset.into())
            * (dynamic_params.memory_units_row_ratio.into())))
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset of orig/public_memory must be nonnegative.
    x = (dynamic_params.orig_public_memory_suboffset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset of orig/public_memory is too big.
    x = trace_length - (dynamic_params.orig_public_memory_suboffset.into()) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset of orig/public_memory is too big.
    x = ((8_u256 * (dynamic_params.memory_units_row_ratio.into())))
        - (((dynamic_params.orig_public_memory_suboffset.into())
            * (dynamic_params.memory_units_row_ratio.into())))
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Uses_pedersen_builtin should be a boolean.
    assert(
        (((dynamic_params.uses_pedersen_builtin.into())
            * (dynamic_params.uses_pedersen_builtin.into())
                - dynamic_params.uses_pedersen_builtin.into())) == 0,
        'NotBoolean'
    );
    // Uses_range_check_builtin should be a boolean.
    assert(
        (((dynamic_params.uses_range_check_builtin.into())
            * (dynamic_params.uses_range_check_builtin.into())
                - dynamic_params.uses_range_check_builtin.into())) == 0,
        'NotBoolean'
    );
    // Uses_ecdsa_builtin should be a boolean.
    assert(
        (((dynamic_params.uses_ecdsa_builtin.into())
            * (dynamic_params.uses_ecdsa_builtin.into())
                - dynamic_params.uses_ecdsa_builtin.into())) == 0,
        'NotBoolean'
    );
    // Uses_bitwise_builtin should be a boolean.
    assert(
        (((dynamic_params.uses_bitwise_builtin.into())
            * (dynamic_params.uses_bitwise_builtin.into())
                - dynamic_params.uses_bitwise_builtin.into())) == 0,
        'NotBoolean'
    );
    // Uses_ec_op_builtin should be a boolean.
    assert(
        (((dynamic_params.uses_ec_op_builtin.into())
            * (dynamic_params.uses_ec_op_builtin.into())
                - dynamic_params.uses_ec_op_builtin.into())) == 0,
        'NotBoolean'
    );
    // Uses_keccak_builtin should be a boolean.
    assert(
        (((dynamic_params.uses_keccak_builtin.into())
            * (dynamic_params.uses_keccak_builtin.into())
                - dynamic_params.uses_keccak_builtin.into())) == 0,
        'NotBoolean'
    );
    // Uses_poseidon_builtin should be a boolean.
    assert(
        (((dynamic_params.uses_poseidon_builtin.into())
            * (dynamic_params.uses_poseidon_builtin.into())
                - dynamic_params.uses_poseidon_builtin.into())) == 0,
        'NotBoolean'
    );
    // Uses_range_check96_builtin should be a boolean.
    assert(
        (((dynamic_params.uses_range_check96_builtin.into())
            * (dynamic_params.uses_range_check96_builtin.into()
                - dynamic_params.uses_range_check96_builtin.into()))) == 0,
        'NotBoolean'
    );
    // Uses_add_mod_builtin should be a boolean.
    assert(
        (((dynamic_params.uses_add_mod_builtin.into())
            * (dynamic_params.uses_add_mod_builtin.into())
                - dynamic_params.uses_add_mod_builtin.into())) == 0,
        'NotBoolean'
    );
    // Uses_mul_mod_builtin should be a boolean.
    assert(
        (((dynamic_params.uses_mul_mod_builtin.into())
            * (dynamic_params.uses_mul_mod_builtin.into())
                - dynamic_params.uses_mul_mod_builtin.into())) == 0,
        'NotBoolean'
    );
    // Num_columns_first is out of range.
    x = 65536_u256 - (dynamic_params.num_columns_first.into()) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Num_columns_second is out of range.
    x = 65536_u256 - (dynamic_params.num_columns_second.into()) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.mem_pool_addr_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.mem_pool_addr_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.mem_pool_addr_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length - (dynamic_params.mem_pool_addr_offset.into()) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.mem_pool_value_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.mem_pool_value_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.mem_pool_value_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length - (dynamic_params.mem_pool_value_offset.into()) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.range_check16_pool_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.range_check16_pool_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.range_check16_pool_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length - (dynamic_params.range_check16_pool_offset.into()) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.cpu_decode_opcode_range_check_column_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.cpu_decode_opcode_range_check_column_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.cpu_decode_opcode_range_check_column_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length - (dynamic_params.cpu_decode_opcode_range_check_column_offset.into()) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.cpu_registers_ap_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.cpu_registers_ap_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.cpu_registers_ap_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length - (dynamic_params.cpu_registers_ap_offset.into()) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.cpu_registers_fp_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.cpu_registers_fp_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.cpu_registers_fp_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length - (dynamic_params.cpu_registers_fp_offset.into()) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.cpu_operands_ops_mul_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.cpu_operands_ops_mul_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.cpu_operands_ops_mul_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length - (dynamic_params.cpu_operands_ops_mul_offset.into()) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.cpu_operands_res_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.cpu_operands_res_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.cpu_operands_res_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length - (dynamic_params.cpu_operands_res_offset.into()) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.cpu_update_registers_update_pc_tmp0_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.cpu_update_registers_update_pc_tmp0_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.cpu_update_registers_update_pc_tmp0_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length - (dynamic_params.cpu_update_registers_update_pc_tmp0_offset.into()) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.cpu_update_registers_update_pc_tmp1_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.cpu_update_registers_update_pc_tmp1_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.cpu_update_registers_update_pc_tmp1_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length - (dynamic_params.cpu_update_registers_update_pc_tmp1_offset.into()) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.memory_sorted_addr_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.memory_sorted_addr_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.memory_sorted_addr_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length - (dynamic_params.memory_sorted_addr_offset.into()) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.memory_sorted_value_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.memory_sorted_value_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.memory_sorted_value_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length - (dynamic_params.memory_sorted_value_offset.into()) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.range_check16_sorted_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.range_check16_sorted_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.range_check16_sorted_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length - (dynamic_params.range_check16_sorted_offset.into()) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.diluted_pool_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.diluted_pool_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.diluted_pool_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length - (dynamic_params.diluted_pool_offset.into()) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.diluted_check_permuted_values_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.diluted_check_permuted_values_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.diluted_check_permuted_values_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length - (dynamic_params.diluted_check_permuted_values_offset.into()) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.pedersen_hash0_ec_subset_sum_partial_sum_x_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.pedersen_hash0_ec_subset_sum_partial_sum_x_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.pedersen_hash0_ec_subset_sum_partial_sum_x_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length
        - (dynamic_params.pedersen_hash0_ec_subset_sum_partial_sum_x_offset.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.pedersen_hash0_ec_subset_sum_partial_sum_y_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.pedersen_hash0_ec_subset_sum_partial_sum_y_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.pedersen_hash0_ec_subset_sum_partial_sum_y_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length
        - (dynamic_params.pedersen_hash0_ec_subset_sum_partial_sum_y_offset.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.pedersen_hash0_ec_subset_sum_slope_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.pedersen_hash0_ec_subset_sum_slope_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.pedersen_hash0_ec_subset_sum_slope_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length - (dynamic_params.pedersen_hash0_ec_subset_sum_slope_offset.into()) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.pedersen_hash0_ec_subset_sum_selector_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.pedersen_hash0_ec_subset_sum_selector_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.pedersen_hash0_ec_subset_sum_selector_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length
        - (dynamic_params.pedersen_hash0_ec_subset_sum_selector_offset.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.pedersen_hash0_ec_subset_sum_bit_unpacking_prod_ones196_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.pedersen_hash0_ec_subset_sum_bit_unpacking_prod_ones196_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.pedersen_hash0_ec_subset_sum_bit_unpacking_prod_ones196_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length
        - (dynamic_params.pedersen_hash0_ec_subset_sum_bit_unpacking_prod_ones196_offset.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.pedersen_hash0_ec_subset_sum_bit_unpacking_prod_ones192_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.pedersen_hash0_ec_subset_sum_bit_unpacking_prod_ones192_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.pedersen_hash0_ec_subset_sum_bit_unpacking_prod_ones192_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length
        - (dynamic_params.pedersen_hash0_ec_subset_sum_bit_unpacking_prod_ones192_offset.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.ecdsa_signature0_key_points_x_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.ecdsa_signature0_key_points_x_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.ecdsa_signature0_key_points_x_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length - (dynamic_params.ecdsa_signature0_key_points_x_offset.into()) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.ecdsa_signature0_key_points_y_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.ecdsa_signature0_key_points_y_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.ecdsa_signature0_key_points_y_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length - (dynamic_params.ecdsa_signature0_key_points_y_offset.into()) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.ecdsa_signature0_doubling_slope_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.ecdsa_signature0_doubling_slope_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.ecdsa_signature0_doubling_slope_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length - (dynamic_params.ecdsa_signature0_doubling_slope_offset.into()) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.ecdsa_signature0_exponentiate_generator_partial_sum_x_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.ecdsa_signature0_exponentiate_generator_partial_sum_x_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.ecdsa_signature0_exponentiate_generator_partial_sum_x_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length
        - (dynamic_params.ecdsa_signature0_exponentiate_generator_partial_sum_x_offset.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.ecdsa_signature0_exponentiate_generator_partial_sum_y_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.ecdsa_signature0_exponentiate_generator_partial_sum_y_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.ecdsa_signature0_exponentiate_generator_partial_sum_y_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length
        - (dynamic_params.ecdsa_signature0_exponentiate_generator_partial_sum_y_offset.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.ecdsa_signature0_exponentiate_generator_slope_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.ecdsa_signature0_exponentiate_generator_slope_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.ecdsa_signature0_exponentiate_generator_slope_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length
        - (dynamic_params.ecdsa_signature0_exponentiate_generator_slope_offset.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.ecdsa_signature0_exponentiate_generator_selector_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.ecdsa_signature0_exponentiate_generator_selector_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.ecdsa_signature0_exponentiate_generator_selector_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length
        - (dynamic_params.ecdsa_signature0_exponentiate_generator_selector_offset.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.ecdsa_signature0_exponentiate_generator_x_diff_inv_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.ecdsa_signature0_exponentiate_generator_x_diff_inv_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.ecdsa_signature0_exponentiate_generator_x_diff_inv_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length
        - (dynamic_params.ecdsa_signature0_exponentiate_generator_x_diff_inv_offset.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.ecdsa_signature0_exponentiate_key_partial_sum_x_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.ecdsa_signature0_exponentiate_key_partial_sum_x_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.ecdsa_signature0_exponentiate_key_partial_sum_x_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length
        - (dynamic_params.ecdsa_signature0_exponentiate_key_partial_sum_x_offset.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.ecdsa_signature0_exponentiate_key_partial_sum_y_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.ecdsa_signature0_exponentiate_key_partial_sum_y_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.ecdsa_signature0_exponentiate_key_partial_sum_y_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length
        - (dynamic_params.ecdsa_signature0_exponentiate_key_partial_sum_y_offset.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.ecdsa_signature0_exponentiate_key_slope_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.ecdsa_signature0_exponentiate_key_slope_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.ecdsa_signature0_exponentiate_key_slope_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length
        - (dynamic_params.ecdsa_signature0_exponentiate_key_slope_offset.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.ecdsa_signature0_exponentiate_key_selector_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.ecdsa_signature0_exponentiate_key_selector_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.ecdsa_signature0_exponentiate_key_selector_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length
        - (dynamic_params.ecdsa_signature0_exponentiate_key_selector_offset.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.ecdsa_signature0_exponentiate_key_x_diff_inv_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.ecdsa_signature0_exponentiate_key_x_diff_inv_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.ecdsa_signature0_exponentiate_key_x_diff_inv_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length
        - (dynamic_params.ecdsa_signature0_exponentiate_key_x_diff_inv_offset.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.ecdsa_signature0_add_results_slope_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.ecdsa_signature0_add_results_slope_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.ecdsa_signature0_add_results_slope_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length - (dynamic_params.ecdsa_signature0_add_results_slope_offset.into()) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.ecdsa_signature0_add_results_inv_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.ecdsa_signature0_add_results_inv_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.ecdsa_signature0_add_results_inv_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length - (dynamic_params.ecdsa_signature0_add_results_inv_offset.into()) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.ecdsa_signature0_extract_r_slope_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.ecdsa_signature0_extract_r_slope_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.ecdsa_signature0_extract_r_slope_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length - (dynamic_params.ecdsa_signature0_extract_r_slope_offset.into()) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.ecdsa_signature0_extract_r_inv_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.ecdsa_signature0_extract_r_inv_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.ecdsa_signature0_extract_r_inv_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length - (dynamic_params.ecdsa_signature0_extract_r_inv_offset.into()) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.ecdsa_signature0_z_inv_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.ecdsa_signature0_z_inv_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.ecdsa_signature0_z_inv_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length - (dynamic_params.ecdsa_signature0_z_inv_offset.into()) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.ecdsa_signature0_r_w_inv_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.ecdsa_signature0_r_w_inv_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.ecdsa_signature0_r_w_inv_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length - (dynamic_params.ecdsa_signature0_r_w_inv_offset.into()) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.ecdsa_signature0_q_x_squared_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.ecdsa_signature0_q_x_squared_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.ecdsa_signature0_q_x_squared_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length - (dynamic_params.ecdsa_signature0_q_x_squared_offset.into()) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.ec_op_doubled_points_x_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.ec_op_doubled_points_x_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.ec_op_doubled_points_x_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length - (dynamic_params.ec_op_doubled_points_x_offset.into()) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.ec_op_doubled_points_y_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.ec_op_doubled_points_y_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.ec_op_doubled_points_y_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length - (dynamic_params.ec_op_doubled_points_y_offset.into()) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.ec_op_doubling_slope_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.ec_op_doubling_slope_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.ec_op_doubling_slope_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length - (dynamic_params.ec_op_doubling_slope_offset.into()) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.ec_op_ec_subset_sum_partial_sum_x_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.ec_op_ec_subset_sum_partial_sum_x_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.ec_op_ec_subset_sum_partial_sum_x_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length - (dynamic_params.ec_op_ec_subset_sum_partial_sum_x_offset.into()) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.ec_op_ec_subset_sum_partial_sum_y_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.ec_op_ec_subset_sum_partial_sum_y_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.ec_op_ec_subset_sum_partial_sum_y_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length - (dynamic_params.ec_op_ec_subset_sum_partial_sum_y_offset.into()) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.ec_op_ec_subset_sum_slope_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.ec_op_ec_subset_sum_slope_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.ec_op_ec_subset_sum_slope_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length - (dynamic_params.ec_op_ec_subset_sum_slope_offset.into()) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.ec_op_ec_subset_sum_selector_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.ec_op_ec_subset_sum_selector_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.ec_op_ec_subset_sum_selector_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length - (dynamic_params.ec_op_ec_subset_sum_selector_offset.into()) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.ec_op_ec_subset_sum_x_diff_inv_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.ec_op_ec_subset_sum_x_diff_inv_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.ec_op_ec_subset_sum_x_diff_inv_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length - (dynamic_params.ec_op_ec_subset_sum_x_diff_inv_offset.into()) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.ec_op_ec_subset_sum_bit_unpacking_prod_ones196_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.ec_op_ec_subset_sum_bit_unpacking_prod_ones196_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.ec_op_ec_subset_sum_bit_unpacking_prod_ones196_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length
        - (dynamic_params.ec_op_ec_subset_sum_bit_unpacking_prod_ones196_offset.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.ec_op_ec_subset_sum_bit_unpacking_prod_ones192_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.ec_op_ec_subset_sum_bit_unpacking_prod_ones192_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.ec_op_ec_subset_sum_bit_unpacking_prod_ones192_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length
        - (dynamic_params.ec_op_ec_subset_sum_bit_unpacking_prod_ones192_offset.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.keccak_keccak_parse_to_diluted_reshaped_intermediate_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.keccak_keccak_parse_to_diluted_reshaped_intermediate_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.keccak_keccak_parse_to_diluted_reshaped_intermediate_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length
        - (dynamic_params.keccak_keccak_parse_to_diluted_reshaped_intermediate_offset.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.keccak_keccak_parse_to_diluted_final_reshaped_input_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.keccak_keccak_parse_to_diluted_final_reshaped_input_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.keccak_keccak_parse_to_diluted_final_reshaped_input_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length
        - (dynamic_params.keccak_keccak_parse_to_diluted_final_reshaped_input_offset.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.keccak_keccak_parse_to_diluted_cumulative_sum_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.keccak_keccak_parse_to_diluted_cumulative_sum_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.keccak_keccak_parse_to_diluted_cumulative_sum_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length
        - (dynamic_params.keccak_keccak_parse_to_diluted_cumulative_sum_offset.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.keccak_keccak_rotated_parity0_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.keccak_keccak_rotated_parity0_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.keccak_keccak_rotated_parity0_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length - (dynamic_params.keccak_keccak_rotated_parity0_offset.into()) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.keccak_keccak_rotated_parity1_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.keccak_keccak_rotated_parity1_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.keccak_keccak_rotated_parity1_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length - (dynamic_params.keccak_keccak_rotated_parity1_offset.into()) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.keccak_keccak_rotated_parity2_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.keccak_keccak_rotated_parity2_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.keccak_keccak_rotated_parity2_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length - (dynamic_params.keccak_keccak_rotated_parity2_offset.into()) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.keccak_keccak_rotated_parity3_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.keccak_keccak_rotated_parity3_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.keccak_keccak_rotated_parity3_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length - (dynamic_params.keccak_keccak_rotated_parity3_offset.into()) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.keccak_keccak_rotated_parity4_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.keccak_keccak_rotated_parity4_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.keccak_keccak_rotated_parity4_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length - (dynamic_params.keccak_keccak_rotated_parity4_offset.into()) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.poseidon_poseidon_full_rounds_state0_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.poseidon_poseidon_full_rounds_state0_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.poseidon_poseidon_full_rounds_state0_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length - (dynamic_params.poseidon_poseidon_full_rounds_state0_offset.into()) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.poseidon_poseidon_full_rounds_state1_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.poseidon_poseidon_full_rounds_state1_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.poseidon_poseidon_full_rounds_state1_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length - (dynamic_params.poseidon_poseidon_full_rounds_state1_offset.into()) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.poseidon_poseidon_full_rounds_state2_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.poseidon_poseidon_full_rounds_state2_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.poseidon_poseidon_full_rounds_state2_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length - (dynamic_params.poseidon_poseidon_full_rounds_state2_offset.into()) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.poseidon_poseidon_full_rounds_state0_squared_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.poseidon_poseidon_full_rounds_state0_squared_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.poseidon_poseidon_full_rounds_state0_squared_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length
        - (dynamic_params.poseidon_poseidon_full_rounds_state0_squared_offset.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.poseidon_poseidon_full_rounds_state1_squared_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.poseidon_poseidon_full_rounds_state1_squared_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.poseidon_poseidon_full_rounds_state1_squared_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length
        - (dynamic_params.poseidon_poseidon_full_rounds_state1_squared_offset.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.poseidon_poseidon_full_rounds_state2_squared_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.poseidon_poseidon_full_rounds_state2_squared_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.poseidon_poseidon_full_rounds_state2_squared_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length
        - (dynamic_params.poseidon_poseidon_full_rounds_state2_squared_offset.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.poseidon_poseidon_partial_rounds_state0_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.poseidon_poseidon_partial_rounds_state0_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.poseidon_poseidon_partial_rounds_state0_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length
        - (dynamic_params.poseidon_poseidon_partial_rounds_state0_offset.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.poseidon_poseidon_partial_rounds_state1_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.poseidon_poseidon_partial_rounds_state1_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.poseidon_poseidon_partial_rounds_state1_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length
        - (dynamic_params.poseidon_poseidon_partial_rounds_state1_offset.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.poseidon_poseidon_partial_rounds_state0_squared_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.poseidon_poseidon_partial_rounds_state0_squared_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.poseidon_poseidon_partial_rounds_state0_squared_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length
        - (dynamic_params.poseidon_poseidon_partial_rounds_state0_squared_offset.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.poseidon_poseidon_partial_rounds_state1_squared_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.poseidon_poseidon_partial_rounds_state1_squared_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.poseidon_poseidon_partial_rounds_state1_squared_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length
        - (dynamic_params.poseidon_poseidon_partial_rounds_state1_squared_offset.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.add_mod_sub_p_bit_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.add_mod_sub_p_bit_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.add_mod_sub_p_bit_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length - (dynamic_params.add_mod_sub_p_bit_offset.into()) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.add_mod_carry1_bit_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.add_mod_carry1_bit_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.add_mod_carry1_bit_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length - (dynamic_params.add_mod_carry1_bit_offset.into()) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.add_mod_carry2_bit_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.add_mod_carry2_bit_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.add_mod_carry2_bit_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length - (dynamic_params.add_mod_carry2_bit_offset.into()) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.add_mod_carry3_bit_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.add_mod_carry3_bit_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.add_mod_carry3_bit_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length - (dynamic_params.add_mod_carry3_bit_offset.into()) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.add_mod_carry1_sign_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.add_mod_carry1_sign_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.add_mod_carry1_sign_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length - (dynamic_params.add_mod_carry1_sign_offset.into()) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.add_mod_carry2_sign_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.add_mod_carry2_sign_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.add_mod_carry2_sign_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length - (dynamic_params.add_mod_carry2_sign_offset.into()) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.add_mod_carry3_sign_column.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        - (dynamic_params.add_mod_carry3_sign_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.add_mod_carry3_sign_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length - (dynamic_params.add_mod_carry3_sign_offset.into()) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.memory_multi_column_perm_perm_cum_prod0_column.into())
        - (dynamic_params.num_columns_first.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        + (dynamic_params.num_columns_second.into())
        - (dynamic_params.memory_multi_column_perm_perm_cum_prod0_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.memory_multi_column_perm_perm_cum_prod0_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length
        - (dynamic_params.memory_multi_column_perm_perm_cum_prod0_offset.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.range_check16_perm_cum_prod0_column.into())
        - (dynamic_params.num_columns_first.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        + (dynamic_params.num_columns_second.into())
        - (dynamic_params.range_check16_perm_cum_prod0_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.range_check16_perm_cum_prod0_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length - (dynamic_params.range_check16_perm_cum_prod0_offset.into()) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.diluted_check_cumulative_value_column.into())
        - (dynamic_params.num_columns_first.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        + (dynamic_params.num_columns_second.into())
        - (dynamic_params.diluted_check_cumulative_value_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.diluted_check_cumulative_value_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length - (dynamic_params.diluted_check_cumulative_value_offset.into()) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.diluted_check_permutation_cum_prod0_column.into())
        - (dynamic_params.num_columns_first.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Column index out of range.
    x = (dynamic_params.num_columns_first.into())
        + (dynamic_params.num_columns_second.into())
        - (dynamic_params.diluted_check_permutation_cum_prod0_column.into())
        - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be nonnegative.
    x = (dynamic_params.diluted_check_permutation_cum_prod0_offset.into());
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    // Offset must be smaller than trace length.
    x = trace_length - (dynamic_params.diluted_check_permutation_cum_prod0_offset.into()) - 1_u256;
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');

    if (dynamic_params.uses_pedersen_builtin.into()) != 0 {
        // Row ratio should be a power of 2_u256, smaller than trace length.
        x = (dynamic_params.pedersen_builtin_row_ratio.into());
        assert(x != 0 && U256BitAnd::bitand(x, x - 1) == 0, 'Value is not pow of 2');
        // Dimension should be a power of 2_u256.
        x = trace_length / (dynamic_params.pedersen_builtin_row_ratio.into());
        assert(x != 0 && U256BitAnd::bitand(x, x - 1) == 0, 'Value is not pow of 2');
        // Coset step ((dynamicparam(pedersen_builtin_row_ratio)) / (512_u256)) must be a power of two.
        x = dynamic_params.pedersen_builtin_row_ratio.into() / 512_u256;
        assert(x != 0 && U256BitAnd::bitand(x, x - 1) == 0, 'Value is not pow of 2');
        // Coset step ((dynamicparam(pedersen_builtin_row_ratio)) / (2_u256)) must be a power of two.
        x = dynamic_params.pedersen_builtin_row_ratio.into() / 2_u256;
        assert(x != 0 && U256BitAnd::bitand(x, x - 1) == 0, 'Value is not pow of 2');
        // Step must not exceed dimension.
        x = (trace_length / (dynamic_params.pedersen_builtin_row_ratio.into())) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Index should be non negative.
        x = trace_length / (dynamic_params.pedersen_builtin_row_ratio.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Coset step (memberexpression(trace_length)) must be a power of two.
        x = trace_length;
        assert(x != 0 && U256BitAnd::bitand(x, x - 1) == 0, 'Value is not pow of 2');
        // Offset of pedersen/input0 must be nonnegative.
        x = (dynamic_params.pedersen_input0_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of pedersen/input0 is too big.
        x = trace_length - (dynamic_params.pedersen_input0_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of pedersen/input0 is too big.
        x = (dynamic_params.pedersen_builtin_row_ratio.into())
            - (((dynamic_params.pedersen_input0_suboffset.into())
                * (dynamic_params.memory_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of pedersen/input1 must be nonnegative.
        x = (dynamic_params.pedersen_input1_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of pedersen/input1 is too big.
        x = trace_length - (dynamic_params.pedersen_input1_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of pedersen/input1 is too big.
        x = (dynamic_params.pedersen_builtin_row_ratio.into())
            - (((dynamic_params.pedersen_input1_suboffset.into())
                * (dynamic_params.memory_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of pedersen/output must be nonnegative.
        x = (dynamic_params.pedersen_output_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of pedersen/output is too big.
        x = trace_length - (dynamic_params.pedersen_output_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of pedersen/output is too big.
        x = (dynamic_params.pedersen_builtin_row_ratio.into())
            - (((dynamic_params.pedersen_output_suboffset.into())
                * (dynamic_params.memory_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    }
    if (dynamic_params.uses_range_check_builtin.into()) != 0 {
        // Coset step (memberexpression(trace_length)) must be a power of two.
        x = trace_length;
        assert(x != 0 && U256BitAnd::bitand(x, x - 1) == 0, 'Value is not pow of 2');
        // Row ratio should be a power of 2_u256, smaller than trace length.
        x = (dynamic_params.range_check_builtin_row_ratio.into());
        assert(x != 0 && U256BitAnd::bitand(x, x - 1) == 0, 'Value is not pow of 2');
        // Dimension should be a power of 2_u256.
        x = trace_length / (dynamic_params.range_check_builtin_row_ratio.into());
        assert(x != 0 && U256BitAnd::bitand(x, x - 1) == 0, 'Value is not pow of 2');
        // Step must not exceed dimension.
        x = (trace_length / (dynamic_params.range_check_builtin_row_ratio.into())) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Index should be non negative.
        x = trace_length / (dynamic_params.range_check_builtin_row_ratio.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Coset step ((dynamicparam(range_check_builtin_row_ratio)) / (8_u256)) must be a power of two.
        x = dynamic_params.range_check_builtin_row_ratio.into() / 8_u256;
        assert(x != 0 && U256BitAnd::bitand(x, x - 1) == 0, 'Value is not pow of 2');
        // Offset of range_check_builtin/mem must be nonnegative.
        x = (dynamic_params.range_check_builtin_mem_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of range_check_builtin/mem is too big.
        x = trace_length - (dynamic_params.range_check_builtin_mem_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of range_check_builtin/mem is too big.
        x = (dynamic_params.range_check_builtin_row_ratio.into())
            - (((dynamic_params.range_check_builtin_mem_suboffset.into())
                * (dynamic_params.memory_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of range_check_builtin/inner_range_check must be nonnegative.
        x = (dynamic_params.range_check_builtin_inner_range_check_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of range_check_builtin/inner_range_check is too big.
        x = trace_length
            - (dynamic_params.range_check_builtin_inner_range_check_suboffset.into())
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of range_check_builtin/inner_range_check is too big.
        x = (dynamic_params.range_check_builtin_row_ratio.into() / 8_u256)
            - (((dynamic_params.range_check_builtin_inner_range_check_suboffset.into())
                * (dynamic_params.range_check_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    }
    if (dynamic_params.uses_ecdsa_builtin.into()) != 0 {
        // Row ratio should be a power of 2_u256, smaller than trace length.
        x = (dynamic_params.ecdsa_builtin_row_ratio.into());
        assert(x != 0 && U256BitAnd::bitand(x, x - 1) == 0, 'Value is not pow of 2');
        // Dimension should be a power of 2_u256.
        x = trace_length / (dynamic_params.ecdsa_builtin_row_ratio.into());
        assert(x != 0 && U256BitAnd::bitand(x, x - 1) == 0, 'Value is not pow of 2');
        // Coset step ((dynamicparam(ecdsa_builtin_row_ratio)) / (512_u256)) must be a power of two.
        x = dynamic_params.ecdsa_builtin_row_ratio.into() / 512_u256;
        assert(x != 0 && U256BitAnd::bitand(x, x - 1) == 0, 'Value is not pow of 2');
        // Step must not exceed dimension.
        x = (trace_length / (dynamic_params.ecdsa_builtin_row_ratio.into())) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Index should be non negative.
        x = trace_length / (dynamic_params.ecdsa_builtin_row_ratio.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Coset step ((dynamicparam(ecdsa_builtin_row_ratio)) / (256_u256)) must be a power of two.
        x = dynamic_params.ecdsa_builtin_row_ratio.into() / 256_u256;
        assert(x != 0 && U256BitAnd::bitand(x, x - 1) == 0, 'Value is not pow of 2');
        // Coset step (memberexpression(trace_length)) must be a power of two.
        x = trace_length;
        assert(x != 0 && U256BitAnd::bitand(x, x - 1) == 0, 'Value is not pow of 2');
        // Coset step ((dynamicparam(ecdsa_builtin_row_ratio)) / (2_u256)) must be a power of two.
        x = dynamic_params.ecdsa_builtin_row_ratio.into() / 2_u256;
        assert(x != 0 && U256BitAnd::bitand(x, x - 1) == 0, 'Value is not pow of 2');
        // Offset of ecdsa/pubkey must be nonnegative.
        x = (dynamic_params.ecdsa_pubkey_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of ecdsa/pubkey is too big.
        x = trace_length - (dynamic_params.ecdsa_pubkey_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of ecdsa/pubkey is too big.
        x = (dynamic_params.ecdsa_builtin_row_ratio.into())
            - (((dynamic_params.ecdsa_pubkey_suboffset.into())
                * (dynamic_params.memory_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of ecdsa/message must be nonnegative.
        x = (dynamic_params.ecdsa_message_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of ecdsa/message is too big.
        x = trace_length - (dynamic_params.ecdsa_message_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of ecdsa/message is too big.
        x = (dynamic_params.ecdsa_builtin_row_ratio.into())
            - (((dynamic_params.ecdsa_message_suboffset.into())
                * (dynamic_params.memory_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    }
    if (dynamic_params.uses_bitwise_builtin.into()) != 0 {
        // Row ratio should be a power of 2_u256, smaller than trace length.
        x = (dynamic_params.bitwise_row_ratio.into());
        assert(x != 0 && U256BitAnd::bitand(x, x - 1) == 0, 'Value is not pow of 2');
        // Dimension should be a power of 2_u256.
        x = trace_length / (dynamic_params.bitwise_row_ratio.into());
        assert(x != 0 && U256BitAnd::bitand(x, x - 1) == 0, 'Value is not pow of 2');
        // Coset step ((dynamicparam(bitwise_row_ratio)) / (64_u256)) must be a power of two.
        x = dynamic_params.bitwise_row_ratio.into() / 64_u256;
        assert(x != 0 && U256BitAnd::bitand(x, x - 1) == 0, 'Value is not pow of 2');
        // Coset step ((dynamicparam(bitwise_row_ratio)) / (4_u256)) must be a power of two.
        x = dynamic_params.bitwise_row_ratio.into() / 4_u256;
        assert(x != 0 && U256BitAnd::bitand(x, x - 1) == 0, 'Value is not pow of 2');
        // Index out of range.
        x = (trace_length / (dynamic_params.bitwise_row_ratio.into())) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Index should be non negative.
        x = trace_length / (dynamic_params.bitwise_row_ratio.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Coset step (memberexpression(trace_length)) must be a power of two.
        x = trace_length;
        assert(x != 0 && U256BitAnd::bitand(x, x - 1) == 0, 'Value is not pow of 2');
        // Offset of bitwise/var_pool must be nonnegative.
        x = (dynamic_params.bitwise_var_pool_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of bitwise/var_pool is too big.
        x = trace_length - (dynamic_params.bitwise_var_pool_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of bitwise/var_pool is too big.
        x = (dynamic_params.bitwise_row_ratio.into() / 4_u256)
            - (((dynamic_params.bitwise_var_pool_suboffset.into())
                * (dynamic_params.memory_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of bitwise/x_or_y must be nonnegative.
        x = (dynamic_params.bitwise_x_or_y_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of bitwise/x_or_y is too big.
        x = trace_length - (dynamic_params.bitwise_x_or_y_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of bitwise/x_or_y is too big.
        x = (dynamic_params.bitwise_row_ratio.into())
            - (((dynamic_params.bitwise_x_or_y_suboffset.into())
                * (dynamic_params.memory_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of bitwise/diluted_var_pool must be nonnegative.
        x = (dynamic_params.bitwise_diluted_var_pool_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of bitwise/diluted_var_pool is too big.
        x = trace_length - (dynamic_params.bitwise_diluted_var_pool_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of bitwise/diluted_var_pool is too big.
        x = (dynamic_params.bitwise_row_ratio.into() / 64_u256)
            - (((dynamic_params.bitwise_diluted_var_pool_suboffset.into())
                * (dynamic_params.diluted_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of bitwise/trim_unpacking192 must be nonnegative.
        x = (dynamic_params.bitwise_trim_unpacking192_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of bitwise/trim_unpacking192 is too big.
        x = trace_length - (dynamic_params.bitwise_trim_unpacking192_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of bitwise/trim_unpacking192 is too big.
        x = (dynamic_params.bitwise_row_ratio.into())
            - (((dynamic_params.bitwise_trim_unpacking192_suboffset.into())
                * (dynamic_params.diluted_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of bitwise/trim_unpacking193 must be nonnegative.
        x = (dynamic_params.bitwise_trim_unpacking193_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of bitwise/trim_unpacking193 is too big.
        x = trace_length - (dynamic_params.bitwise_trim_unpacking193_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of bitwise/trim_unpacking193 is too big.
        x = (dynamic_params.bitwise_row_ratio.into())
            - (((dynamic_params.bitwise_trim_unpacking193_suboffset.into())
                * (dynamic_params.diluted_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of bitwise/trim_unpacking194 must be nonnegative.
        x = (dynamic_params.bitwise_trim_unpacking194_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of bitwise/trim_unpacking194 is too big.
        x = trace_length - (dynamic_params.bitwise_trim_unpacking194_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of bitwise/trim_unpacking194 is too big.
        x = (dynamic_params.bitwise_row_ratio.into())
            - (((dynamic_params.bitwise_trim_unpacking194_suboffset.into())
                * (dynamic_params.diluted_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of bitwise/trim_unpacking195 must be nonnegative.
        x = (dynamic_params.bitwise_trim_unpacking195_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of bitwise/trim_unpacking195 is too big.
        x = trace_length - (dynamic_params.bitwise_trim_unpacking195_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of bitwise/trim_unpacking195 is too big.
        x = (dynamic_params.bitwise_row_ratio.into())
            - (((dynamic_params.bitwise_trim_unpacking195_suboffset.into())
                * (dynamic_params.diluted_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    }
    if (dynamic_params.uses_ec_op_builtin.into()) != 0 {
        // Row ratio should be a power of 2_u256, smaller than trace length.
        x = (dynamic_params.ec_op_builtin_row_ratio.into());
        assert(x != 0 && U256BitAnd::bitand(x, x - 1) == 0, 'Value is not pow of 2');
        // Dimension should be a power of 2_u256.
        x = trace_length / (dynamic_params.ec_op_builtin_row_ratio.into());
        assert(x != 0 && U256BitAnd::bitand(x, x - 1) == 0, 'Value is not pow of 2');
        // Coset step ((dynamicparam(ec_op_builtin_row_ratio)) / (256_u256)) must be a power of two.
        x = dynamic_params.ec_op_builtin_row_ratio.into() / 256_u256;
        assert(x != 0 && U256BitAnd::bitand(x, x - 1) == 0, 'Value is not pow of 2');
        // Index out of range.
        x = (trace_length / (dynamic_params.ec_op_builtin_row_ratio.into())) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Index should be non negative.
        x = trace_length / (dynamic_params.ec_op_builtin_row_ratio.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Coset step (memberexpression(trace_length)) must be a power of two.
        x = trace_length;
        assert(x != 0 && U256BitAnd::bitand(x, x - 1) == 0, 'Value is not pow of 2');
        // Offset of ec_op/p_x must be nonnegative.
        x = (dynamic_params.ec_op_p_x_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of ec_op/p_x is too big.
        x = trace_length - (dynamic_params.ec_op_p_x_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of ec_op/p_x is too big.
        x = (dynamic_params.ec_op_builtin_row_ratio.into())
            - (((dynamic_params.ec_op_p_x_suboffset.into())
                * (dynamic_params.memory_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of ec_op/p_y must be nonnegative.
        x = (dynamic_params.ec_op_p_y_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of ec_op/p_y is too big.
        x = trace_length - (dynamic_params.ec_op_p_y_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of ec_op/p_y is too big.
        x = (dynamic_params.ec_op_builtin_row_ratio.into())
            - (((dynamic_params.ec_op_p_y_suboffset.into())
                * (dynamic_params.memory_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of ec_op/q_x must be nonnegative.
        x = (dynamic_params.ec_op_q_x_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of ec_op/q_x is too big.
        x = trace_length - (dynamic_params.ec_op_q_x_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of ec_op/q_x is too big.
        x = (dynamic_params.ec_op_builtin_row_ratio.into())
            - (((dynamic_params.ec_op_q_x_suboffset.into())
                * (dynamic_params.memory_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of ec_op/q_y must be nonnegative.
        x = (dynamic_params.ec_op_q_y_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of ec_op/q_y is too big.
        x = trace_length - (dynamic_params.ec_op_q_y_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of ec_op/q_y is too big.
        x = (dynamic_params.ec_op_builtin_row_ratio.into())
            - (((dynamic_params.ec_op_q_y_suboffset.into())
                * (dynamic_params.memory_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of ec_op/m must be nonnegative.
        x = (dynamic_params.ec_op_m_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of ec_op/m is too big.
        x = trace_length - (dynamic_params.ec_op_m_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of ec_op/m is too big.
        x = (dynamic_params.ec_op_builtin_row_ratio.into())
            - (((dynamic_params.ec_op_m_suboffset.into())
                * (dynamic_params.memory_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of ec_op/r_x must be nonnegative.
        x = (dynamic_params.ec_op_r_x_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of ec_op/r_x is too big.
        x = trace_length - (dynamic_params.ec_op_r_x_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of ec_op/r_x is too big.
        x = (dynamic_params.ec_op_builtin_row_ratio.into())
            - (((dynamic_params.ec_op_r_x_suboffset.into())
                * (dynamic_params.memory_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of ec_op/r_y must be nonnegative.
        x = (dynamic_params.ec_op_r_y_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of ec_op/r_y is too big.
        x = trace_length - (dynamic_params.ec_op_r_y_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of ec_op/r_y is too big.
        x = (dynamic_params.ec_op_builtin_row_ratio.into())
            - (((dynamic_params.ec_op_r_y_suboffset.into())
                * (dynamic_params.memory_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    }
    if (dynamic_params.uses_keccak_builtin.into()) != 0 {
        // Coset step ((dynamicparam(keccak_row_ratio)) / (4096_u256)) must be a power of two.
        x = dynamic_params.keccak_row_ratio.into() / 4096_u256;
        assert(x != 0 && U256BitAnd::bitand(x, x - 1) == 0, 'Value is not pow of 2');
        // Dimension should be a power of 2_u256.
        x = trace_length / (16_u256 * (dynamic_params.keccak_row_ratio.into()));
        assert(x != 0 && U256BitAnd::bitand(x, x - 1) == 0, 'Value is not pow of 2');
        // Coset step ((dynamicparam(keccak_row_ratio)) / (128_u256)) must be a power of two.
        x = dynamic_params.keccak_row_ratio.into() / 128_u256;
        assert(x != 0 && U256BitAnd::bitand(x, x - 1) == 0, 'Value is not pow of 2');
        // Coset step ((dynamicparam(keccak_row_ratio)) / (32768_u256)) must be a power of two.
        x = dynamic_params.keccak_row_ratio.into() / 32768_u256;
        assert(x != 0 && U256BitAnd::bitand(x, x - 1) == 0, 'Value is not pow of 2');
        // Row ratio should be a power of 2_u256, smaller than trace length.
        x = (dynamic_params.keccak_row_ratio.into());
        assert(x != 0 && U256BitAnd::bitand(x, x - 1) == 0, 'Value is not pow of 2');
        // Coset step ((dynamicparam(keccak_row_ratio)) / (16_u256)) must be a power of two.
        x = dynamic_params.keccak_row_ratio.into() / 16_u256;
        assert(x != 0 && U256BitAnd::bitand(x, x - 1) == 0, 'Value is not pow of 2');
        // Dimension should be a power of 2_u256.
        x = (16_u256 * trace_length) / (dynamic_params.keccak_row_ratio.into());
        assert(x != 0 && U256BitAnd::bitand(x, x - 1) == 0, 'Value is not pow of 2');
        // Index out of range.
        x = (16_u256 * trace_length) / (dynamic_params.keccak_row_ratio.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Index should be non negative.
        x = (16_u256 * trace_length) / (dynamic_params.keccak_row_ratio.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Coset step (memberexpression(trace_length)) must be a power of two.
        x = trace_length;
        assert(x != 0 && U256BitAnd::bitand(x, x - 1) == 0, 'Value is not pow of 2');
        // Offset of keccak/input_output must be nonnegative.
        x = (dynamic_params.keccak_input_output_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of keccak/input_output is too big.
        x = trace_length - (dynamic_params.keccak_input_output_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of keccak/input_output is too big.
        x = (dynamic_params.keccak_row_ratio.into() / 16_u256)
            - (((dynamic_params.keccak_input_output_suboffset.into())
                * (dynamic_params.memory_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of keccak/keccak/diluted_column0 must be nonnegative.
        x = (dynamic_params.keccak_keccak_diluted_column0_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of keccak/keccak/diluted_column0 is too big.
        x = trace_length - (dynamic_params.keccak_keccak_diluted_column0_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of keccak/keccak/diluted_column0 is too big.
        x = (dynamic_params.keccak_row_ratio.into() / 4096_u256)
            - (((dynamic_params.keccak_keccak_diluted_column0_suboffset.into())
                * (dynamic_params.diluted_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of keccak/keccak/diluted_column1 must be nonnegative.
        x = (dynamic_params.keccak_keccak_diluted_column1_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of keccak/keccak/diluted_column1 is too big.
        x = trace_length - (dynamic_params.keccak_keccak_diluted_column1_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of keccak/keccak/diluted_column1 is too big.
        x = (dynamic_params.keccak_row_ratio.into() / 4096_u256)
            - (((dynamic_params.keccak_keccak_diluted_column1_suboffset.into())
                * (dynamic_params.diluted_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of keccak/keccak/diluted_column2 must be nonnegative.
        x = (dynamic_params.keccak_keccak_diluted_column2_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of keccak/keccak/diluted_column2 is too big.
        x = trace_length - (dynamic_params.keccak_keccak_diluted_column2_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of keccak/keccak/diluted_column2 is too big.
        x = (dynamic_params.keccak_row_ratio.into() / 4096_u256)
            - (((dynamic_params.keccak_keccak_diluted_column2_suboffset.into())
                * (dynamic_params.diluted_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of keccak/keccak/diluted_column3 must be nonnegative.
        x = (dynamic_params.keccak_keccak_diluted_column3_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of keccak/keccak/diluted_column3 is too big.
        x = trace_length - (dynamic_params.keccak_keccak_diluted_column3_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of keccak/keccak/diluted_column3 is too big.
        x = (dynamic_params.keccak_row_ratio.into() / 4096_u256)
            - (((dynamic_params.keccak_keccak_diluted_column3_suboffset.into())
                * (dynamic_params.diluted_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    }
    if (dynamic_params.uses_poseidon_builtin.into()) != 0 {
        // Row ratio should be a power of 2_u256, smaller than trace length.
        x = (dynamic_params.poseidon_row_ratio.into());
        assert(x != 0 && U256BitAnd::bitand(x, x - 1) == 0, 'Value is not pow of 2');
        // Dimension should be a power of 2_u256.
        x = trace_length / (dynamic_params.poseidon_row_ratio.into());
        assert(x != 0 && U256BitAnd::bitand(x, x - 1) == 0, 'Value is not pow of 2');
        // Coset step ((dynamicparam(poseidon_row_ratio)) / (32_u256)) must be a power of two.
        x = dynamic_params.poseidon_row_ratio.into() / 32_u256;
        assert(x != 0 && U256BitAnd::bitand(x, x - 1) == 0, 'Value is not pow of 2');
        // Coset step ((dynamicparam(poseidon_row_ratio)) / (8_u256)) must be a power of two.
        x = dynamic_params.poseidon_row_ratio.into() / 8_u256;
        assert(x != 0 && U256BitAnd::bitand(x, x - 1) == 0, 'Value is not pow of 2');
        // Coset step ((dynamicparam(poseidon_row_ratio)) / (64_u256)) must be a power of two.
        x = dynamic_params.poseidon_row_ratio.into() / 64_u256;
        assert(x != 0 && U256BitAnd::bitand(x, x - 1) == 0, 'Value is not pow of 2');
        // Coset step ((dynamicparam(poseidon_row_ratio)) / (2_u256)) must be a power of two.
        x = dynamic_params.poseidon_row_ratio.into() / 2_u256;
        assert(x != 0 && U256BitAnd::bitand(x, x - 1) == 0, 'Value is not pow of 2');
        // Dimension should be a power of 2_u256.
        x = (2_u256 * trace_length) / (dynamic_params.poseidon_row_ratio.into());
        assert(x != 0 && U256BitAnd::bitand(x, x - 1) == 0, 'Value is not pow of 2');
        // Index out of range.
        x = (2_u256 * trace_length) / (dynamic_params.poseidon_row_ratio.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Index should be non negative.
        x = (2_u256 * trace_length) / (dynamic_params.poseidon_row_ratio.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Coset step (memberexpression(trace_length)) must be a power of two.
        x = trace_length;
        assert(x != 0 && U256BitAnd::bitand(x, x - 1) == 0, 'Value is not pow of 2');
        // Offset of poseidon/param_0/input_output must be nonnegative.
        x = (dynamic_params.poseidon_param_0_input_output_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of poseidon/param_0/input_output is too big.
        x = trace_length - (dynamic_params.poseidon_param_0_input_output_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of poseidon/param_0/input_output is too big.
        x = (dynamic_params.poseidon_row_ratio.into() / 2_u256)
            - (((dynamic_params.poseidon_param_0_input_output_suboffset.into())
                * (dynamic_params.memory_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of poseidon/param_1/input_output must be nonnegative.
        x = (dynamic_params.poseidon_param_1_input_output_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of poseidon/param_1/input_output is too big.
        x = trace_length - (dynamic_params.poseidon_param_1_input_output_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of poseidon/param_1/input_output is too big.
        x = (dynamic_params.poseidon_row_ratio.into() / 2_u256)
            - (((dynamic_params.poseidon_param_1_input_output_suboffset.into())
                * (dynamic_params.memory_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of poseidon/param_2/input_output must be nonnegative.
        x = (dynamic_params.poseidon_param_2_input_output_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of poseidon/param_2/input_output is too big.
        x = trace_length - (dynamic_params.poseidon_param_2_input_output_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of poseidon/param_2/input_output is too big.
        x = (dynamic_params.poseidon_row_ratio.into() / 2_u256)
            - (((dynamic_params.poseidon_param_2_input_output_suboffset.into())
                * (dynamic_params.memory_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    }
    if (dynamic_params.uses_range_check96_builtin.into()) != 0 {
        // Coset step (memberexpression(trace_length)) must be a power of two.
        x = trace_length;
        assert(x != 0 && U256BitAnd::bitand(x, x - 1) == 0, 'Value is not pow of 2');
        // Row ratio should be a power of 2_u256, smaller than trace length.
        x = (dynamic_params.range_check96_builtin_row_ratio.into());
        assert(x != 0 && U256BitAnd::bitand(x, x - 1) == 0, 'Value is not pow of 2');
        // Dimension should be a power of 2_u256.
        x = trace_length / (dynamic_params.range_check96_builtin_row_ratio.into());
        assert(x != 0 && U256BitAnd::bitand(x, x - 1) == 0, 'Value is not pow of 2');
        // Step must not exceed dimension.
        x = (trace_length / (dynamic_params.range_check96_builtin_row_ratio.into())) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Index should be non negative.
        x = trace_length / (dynamic_params.range_check96_builtin_row_ratio.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of range_check96_builtin/mem must be nonnegative.
        x = (dynamic_params.range_check96_builtin_mem_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of range_check96_builtin/mem is too big.
        x = trace_length - (dynamic_params.range_check96_builtin_mem_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of range_check96_builtin/mem is too big.
        x = (dynamic_params.range_check96_builtin_row_ratio.into())
            - (((dynamic_params.range_check96_builtin_mem_suboffset.into())
                * (dynamic_params.memory_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of range_check96_builtin/inner_range_check0 must be nonnegative.
        x = (dynamic_params.range_check96_builtin_inner_range_check0_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of range_check96_builtin/inner_range_check0 is too big.
        x = trace_length
            - (dynamic_params.range_check96_builtin_inner_range_check0_suboffset.into())
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of range_check96_builtin/inner_range_check0 is too big.
        x = (dynamic_params.range_check96_builtin_row_ratio.into())
            - (((dynamic_params.range_check96_builtin_inner_range_check0_suboffset.into())
                * (dynamic_params.range_check_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of range_check96_builtin/inner_range_check1 must be nonnegative.
        x = (dynamic_params.range_check96_builtin_inner_range_check1_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of range_check96_builtin/inner_range_check1 is too big.
        x = trace_length
            - (dynamic_params.range_check96_builtin_inner_range_check1_suboffset.into())
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of range_check96_builtin/inner_range_check1 is too big.
        x = (dynamic_params.range_check96_builtin_row_ratio.into())
            - (((dynamic_params.range_check96_builtin_inner_range_check1_suboffset.into())
                * (dynamic_params.range_check_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of range_check96_builtin/inner_range_check2 must be nonnegative.
        x = (dynamic_params.range_check96_builtin_inner_range_check2_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of range_check96_builtin/inner_range_check2 is too big.
        x = trace_length
            - (dynamic_params.range_check96_builtin_inner_range_check2_suboffset.into())
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of range_check96_builtin/inner_range_check2 is too big.
        x = (dynamic_params.range_check96_builtin_row_ratio.into())
            - (((dynamic_params.range_check96_builtin_inner_range_check2_suboffset.into())
                * (dynamic_params.range_check_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of range_check96_builtin/inner_range_check3 must be nonnegative.
        x = (dynamic_params.range_check96_builtin_inner_range_check3_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of range_check96_builtin/inner_range_check3 is too big.
        x = trace_length
            - (dynamic_params.range_check96_builtin_inner_range_check3_suboffset.into())
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of range_check96_builtin/inner_range_check3 is too big.
        x = (dynamic_params.range_check96_builtin_row_ratio.into())
            - (((dynamic_params.range_check96_builtin_inner_range_check3_suboffset.into())
                * (dynamic_params.range_check_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of range_check96_builtin/inner_range_check4 must be nonnegative.
        x = (dynamic_params.range_check96_builtin_inner_range_check4_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of range_check96_builtin/inner_range_check4 is too big.
        x = trace_length
            - (dynamic_params.range_check96_builtin_inner_range_check4_suboffset.into())
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of range_check96_builtin/inner_range_check4 is too big.
        x = (dynamic_params.range_check96_builtin_row_ratio.into())
            - (((dynamic_params.range_check96_builtin_inner_range_check4_suboffset.into())
                * (dynamic_params.range_check_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of range_check96_builtin/inner_range_check5 must be nonnegative.
        x = (dynamic_params.range_check96_builtin_inner_range_check5_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of range_check96_builtin/inner_range_check5 is too big.
        x = trace_length
            - (dynamic_params.range_check96_builtin_inner_range_check5_suboffset.into())
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of range_check96_builtin/inner_range_check5 is too big.
        x = (dynamic_params.range_check96_builtin_row_ratio.into())
            - (((dynamic_params.range_check96_builtin_inner_range_check5_suboffset.into())
                * (dynamic_params.range_check_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    }
    if (dynamic_params.uses_add_mod_builtin.into()) != 0 {
        // Row ratio should be a power of 2_u256, smaller than trace length.
        x = (dynamic_params.add_mod_row_ratio.into());
        assert(x != 0 && U256BitAnd::bitand(x, x - 1) == 0, 'Value is not pow of 2');
        // Dimension should be a power of 2_u256.
        x = trace_length / (dynamic_params.add_mod_row_ratio.into());
        assert(x != 0 && U256BitAnd::bitand(x, x - 1) == 0, 'Value is not pow of 2');
        // Index out of range.
        x = (trace_length / (dynamic_params.add_mod_row_ratio.into())) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Index should be non negative.
        x = trace_length / (dynamic_params.add_mod_row_ratio.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Coset step (memberexpression(trace_length)) must be a power of two.
        x = trace_length;
        assert(x != 0 && U256BitAnd::bitand(x, x - 1) == 0, 'Value is not pow of 2');
        // Offset of add_mod/p0 must be nonnegative.
        x = (dynamic_params.add_mod_p0_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/p0 is too big.
        x = trace_length - (dynamic_params.add_mod_p0_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/p0 is too big.
        x = (dynamic_params.add_mod_row_ratio.into())
            - (((dynamic_params.add_mod_p0_suboffset.into())
                * (dynamic_params.memory_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/p1 must be nonnegative.
        x = (dynamic_params.add_mod_p1_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/p1 is too big.
        x = trace_length - (dynamic_params.add_mod_p1_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/p1 is too big.
        x = (dynamic_params.add_mod_row_ratio.into())
            - (((dynamic_params.add_mod_p1_suboffset.into())
                * (dynamic_params.memory_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/p2 must be nonnegative.
        x = (dynamic_params.add_mod_p2_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/p2 is too big.
        x = trace_length - (dynamic_params.add_mod_p2_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/p2 is too big.
        x = (dynamic_params.add_mod_row_ratio.into())
            - (((dynamic_params.add_mod_p2_suboffset.into())
                * (dynamic_params.memory_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/p3 must be nonnegative.
        x = (dynamic_params.add_mod_p3_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/p3 is too big.
        x = trace_length - (dynamic_params.add_mod_p3_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/p3 is too big.
        x = (dynamic_params.add_mod_row_ratio.into())
            - (((dynamic_params.add_mod_p3_suboffset.into())
                * (dynamic_params.memory_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/values_ptr must be nonnegative.
        x = (dynamic_params.add_mod_values_ptr_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/values_ptr is too big.
        x = trace_length - (dynamic_params.add_mod_values_ptr_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/values_ptr is too big.
        x = (dynamic_params.add_mod_row_ratio.into())
            - (((dynamic_params.add_mod_values_ptr_suboffset.into())
                * (dynamic_params.memory_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/offsets_ptr must be nonnegative.
        x = (dynamic_params.add_mod_offsets_ptr_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/offsets_ptr is too big.
        x = trace_length - (dynamic_params.add_mod_offsets_ptr_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/offsets_ptr is too big.
        x = (dynamic_params.add_mod_row_ratio.into())
            - (((dynamic_params.add_mod_offsets_ptr_suboffset.into())
                * (dynamic_params.memory_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/n must be nonnegative.
        x = (dynamic_params.add_mod_n_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/n is too big.
        x = trace_length - (dynamic_params.add_mod_n_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/n is too big.
        x = (dynamic_params.add_mod_row_ratio.into())
            - (((dynamic_params.add_mod_n_suboffset.into())
                * (dynamic_params.memory_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/a_offset must be nonnegative.
        x = (dynamic_params.add_mod_a_offset_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/a_offset is too big.
        x = trace_length - (dynamic_params.add_mod_a_offset_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/a_offset is too big.
        x = (dynamic_params.add_mod_row_ratio.into())
            - (((dynamic_params.add_mod_a_offset_suboffset.into())
                * (dynamic_params.memory_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/b_offset must be nonnegative.
        x = (dynamic_params.add_mod_b_offset_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/b_offset is too big.
        x = trace_length - (dynamic_params.add_mod_b_offset_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/b_offset is too big.
        x = (dynamic_params.add_mod_row_ratio.into())
            - (((dynamic_params.add_mod_b_offset_suboffset.into())
                * (dynamic_params.memory_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/c_offset must be nonnegative.
        x = (dynamic_params.add_mod_c_offset_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/c_offset is too big.
        x = trace_length - (dynamic_params.add_mod_c_offset_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/c_offset is too big.
        x = (dynamic_params.add_mod_row_ratio.into())
            - (((dynamic_params.add_mod_c_offset_suboffset.into())
                * (dynamic_params.memory_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/a0 must be nonnegative.
        x = (dynamic_params.add_mod_a0_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/a0 is too big.
        x = trace_length - (dynamic_params.add_mod_a0_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/a0 is too big.
        x = (dynamic_params.add_mod_row_ratio.into())
            - (((dynamic_params.add_mod_a0_suboffset.into())
                * (dynamic_params.memory_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/a1 must be nonnegative.
        x = (dynamic_params.add_mod_a1_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/a1 is too big.
        x = trace_length - (dynamic_params.add_mod_a1_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/a1 is too big.
        x = (dynamic_params.add_mod_row_ratio.into())
            - (((dynamic_params.add_mod_a1_suboffset.into())
                * (dynamic_params.memory_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/a2 must be nonnegative.
        x = (dynamic_params.add_mod_a2_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/a2 is too big.
        x = trace_length - (dynamic_params.add_mod_a2_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/a2 is too big.
        x = (dynamic_params.add_mod_row_ratio.into())
            - (((dynamic_params.add_mod_a2_suboffset.into())
                * (dynamic_params.memory_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/a3 must be nonnegative.
        x = (dynamic_params.add_mod_a3_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/a3 is too big.
        x = trace_length - (dynamic_params.add_mod_a3_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/a3 is too big.
        x = (dynamic_params.add_mod_row_ratio.into())
            - (((dynamic_params.add_mod_a3_suboffset.into())
                * (dynamic_params.memory_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/b0 must be nonnegative.
        x = (dynamic_params.add_mod_b0_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/b0 is too big.
        x = trace_length - (dynamic_params.add_mod_b0_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/b0 is too big.
        x = (dynamic_params.add_mod_row_ratio.into())
            - (((dynamic_params.add_mod_b0_suboffset.into())
                * (dynamic_params.memory_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/b1 must be nonnegative.
        x = (dynamic_params.add_mod_b1_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/b1 is too big.
        x = trace_length - (dynamic_params.add_mod_b1_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/b1 is too big.
        x = (dynamic_params.add_mod_row_ratio.into())
            - (((dynamic_params.add_mod_b1_suboffset.into())
                * (dynamic_params.memory_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/b2 must be nonnegative.
        x = (dynamic_params.add_mod_b2_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/b2 is too big.
        x = trace_length - (dynamic_params.add_mod_b2_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/b2 is too big.
        x = (dynamic_params.add_mod_row_ratio.into())
            - (((dynamic_params.add_mod_b2_suboffset.into())
                * (dynamic_params.memory_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/b3 must be nonnegative.
        x = (dynamic_params.add_mod_b3_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/b3 is too big.
        x = trace_length - (dynamic_params.add_mod_b3_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/b3 is too big.
        x = (dynamic_params.add_mod_row_ratio.into())
            - (((dynamic_params.add_mod_b3_suboffset.into())
                * (dynamic_params.memory_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/c0 must be nonnegative.
        x = (dynamic_params.add_mod_c0_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/c0 is too big.
        x = trace_length - (dynamic_params.add_mod_c0_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/c0 is too big.
        x = (dynamic_params.add_mod_row_ratio.into())
            - (((dynamic_params.add_mod_c0_suboffset.into())
                * (dynamic_params.memory_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/c1 must be nonnegative.
        x = (dynamic_params.add_mod_c1_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/c1 is too big.
        x = trace_length - (dynamic_params.add_mod_c1_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/c1 is too big.
        x = (dynamic_params.add_mod_row_ratio.into())
            - (((dynamic_params.add_mod_c1_suboffset.into())
                * (dynamic_params.memory_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/c2 must be nonnegative.
        x = (dynamic_params.add_mod_c2_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/c2 is too big.
        x = trace_length - (dynamic_params.add_mod_c2_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/c2 is too big.
        x = (dynamic_params.add_mod_row_ratio.into())
            - (((dynamic_params.add_mod_c2_suboffset.into())
                * (dynamic_params.memory_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/c3 must be nonnegative.
        x = (dynamic_params.add_mod_c3_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/c3 is too big.
        x = trace_length - (dynamic_params.add_mod_c3_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of add_mod/c3 is too big.
        x = (dynamic_params.add_mod_row_ratio.into())
            - (((dynamic_params.add_mod_c3_suboffset.into())
                * (dynamic_params.memory_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    }
    if (dynamic_params.uses_mul_mod_builtin.into()) != 0 {
        // Row ratio should be a power of 2_u256, smaller than trace length.
        x = (dynamic_params.mul_mod_row_ratio.into());
        assert(x != 0 && U256BitAnd::bitand(x, x - 1) == 0, 'Value is not pow of 2');
        // Dimension should be a power of 2_u256.
        x = trace_length / (dynamic_params.mul_mod_row_ratio.into());
        assert(x != 0 && U256BitAnd::bitand(x, x - 1) == 0, 'Value is not pow of 2');
        // Index out of range.
        x = (trace_length / (dynamic_params.mul_mod_row_ratio.into())) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Index should be non negative.
        x = trace_length / (dynamic_params.mul_mod_row_ratio.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Coset step (memberexpression(trace_length)) must be a power of two.
        x = trace_length;
        assert(x != 0 && U256BitAnd::bitand(x, x - 1) == 0, 'Value is not pow of 2');
        // Offset of mul_mod/p0 must be nonnegative.
        x = (dynamic_params.mul_mod_p0_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/p0 is too big.
        x = trace_length - (dynamic_params.mul_mod_p0_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/p0 is too big.
        x = (dynamic_params.mul_mod_row_ratio.into())
            - (((dynamic_params.mul_mod_p0_suboffset.into())
                * (dynamic_params.memory_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/p1 must be nonnegative.
        x = (dynamic_params.mul_mod_p1_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/p1 is too big.
        x = trace_length - (dynamic_params.mul_mod_p1_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/p1 is too big.
        x = (dynamic_params.mul_mod_row_ratio.into())
            - (((dynamic_params.mul_mod_p1_suboffset.into())
                * (dynamic_params.memory_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/p2 must be nonnegative.
        x = (dynamic_params.mul_mod_p2_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/p2 is too big.
        x = trace_length - (dynamic_params.mul_mod_p2_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/p2 is too big.
        x = (dynamic_params.mul_mod_row_ratio.into())
            - (((dynamic_params.mul_mod_p2_suboffset.into())
                * (dynamic_params.memory_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/p3 must be nonnegative.
        x = (dynamic_params.mul_mod_p3_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/p3 is too big.
        x = trace_length - (dynamic_params.mul_mod_p3_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/p3 is too big.
        x = (dynamic_params.mul_mod_row_ratio.into())
            - (((dynamic_params.mul_mod_p3_suboffset.into())
                * (dynamic_params.memory_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/values_ptr must be nonnegative.
        x = (dynamic_params.mul_mod_values_ptr_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/values_ptr is too big.
        x = trace_length - (dynamic_params.mul_mod_values_ptr_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/values_ptr is too big.
        x = (dynamic_params.mul_mod_row_ratio.into())
            - (((dynamic_params.mul_mod_values_ptr_suboffset.into())
                * (dynamic_params.memory_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/offsets_ptr must be nonnegative.
        x = (dynamic_params.mul_mod_offsets_ptr_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/offsets_ptr is too big.
        x = trace_length - (dynamic_params.mul_mod_offsets_ptr_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/offsets_ptr is too big.
        x = (dynamic_params.mul_mod_row_ratio.into())
            - (((dynamic_params.mul_mod_offsets_ptr_suboffset.into())
                * (dynamic_params.memory_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/n must be nonnegative.
        x = (dynamic_params.mul_mod_n_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/n is too big.
        x = trace_length - (dynamic_params.mul_mod_n_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/n is too big.
        x = (dynamic_params.mul_mod_row_ratio.into())
            - (((dynamic_params.mul_mod_n_suboffset.into())
                * (dynamic_params.memory_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/a_offset must be nonnegative.
        x = (dynamic_params.mul_mod_a_offset_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/a_offset is too big.
        x = trace_length - (dynamic_params.mul_mod_a_offset_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/a_offset is too big.
        x = (dynamic_params.mul_mod_row_ratio.into())
            - (((dynamic_params.mul_mod_a_offset_suboffset.into())
                * (dynamic_params.memory_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/b_offset must be nonnegative.
        x = (dynamic_params.mul_mod_b_offset_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/b_offset is too big.
        x = trace_length - (dynamic_params.mul_mod_b_offset_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/b_offset is too big.
        x = (dynamic_params.mul_mod_row_ratio.into())
            - (((dynamic_params.mul_mod_b_offset_suboffset.into())
                * (dynamic_params.memory_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/c_offset must be nonnegative.
        x = (dynamic_params.mul_mod_c_offset_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/c_offset is too big.
        x = trace_length - (dynamic_params.mul_mod_c_offset_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/c_offset is too big.
        x = (dynamic_params.mul_mod_row_ratio.into())
            - (((dynamic_params.mul_mod_c_offset_suboffset.into())
                * (dynamic_params.memory_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/a0 must be nonnegative.
        x = (dynamic_params.mul_mod_a0_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/a0 is too big.
        x = trace_length - (dynamic_params.mul_mod_a0_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/a0 is too big.
        x = (dynamic_params.mul_mod_row_ratio.into())
            - (((dynamic_params.mul_mod_a0_suboffset.into())
                * (dynamic_params.memory_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/a1 must be nonnegative.
        x = (dynamic_params.mul_mod_a1_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/a1 is too big.
        x = trace_length - (dynamic_params.mul_mod_a1_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/a1 is too big.
        x = (dynamic_params.mul_mod_row_ratio.into())
            - (((dynamic_params.mul_mod_a1_suboffset.into())
                * (dynamic_params.memory_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/a2 must be nonnegative.
        x = (dynamic_params.mul_mod_a2_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/a2 is too big.
        x = trace_length - (dynamic_params.mul_mod_a2_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/a2 is too big.
        x = (dynamic_params.mul_mod_row_ratio.into())
            - (((dynamic_params.mul_mod_a2_suboffset.into())
                * (dynamic_params.memory_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/a3 must be nonnegative.
        x = (dynamic_params.mul_mod_a3_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/a3 is too big.
        x = trace_length - (dynamic_params.mul_mod_a3_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/a3 is too big.
        x = (dynamic_params.mul_mod_row_ratio.into())
            - (((dynamic_params.mul_mod_a3_suboffset.into())
                * (dynamic_params.memory_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/b0 must be nonnegative.
        x = (dynamic_params.mul_mod_b0_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/b0 is too big.
        x = trace_length - (dynamic_params.mul_mod_b0_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/b0 is too big.
        x = (dynamic_params.mul_mod_row_ratio.into())
            - (((dynamic_params.mul_mod_b0_suboffset.into())
                * (dynamic_params.memory_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/b1 must be nonnegative.
        x = (dynamic_params.mul_mod_b1_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/b1 is too big.
        x = trace_length - (dynamic_params.mul_mod_b1_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/b1 is too big.
        x = (dynamic_params.mul_mod_row_ratio.into())
            - (((dynamic_params.mul_mod_b1_suboffset.into())
                * (dynamic_params.memory_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/b2 must be nonnegative.
        x = (dynamic_params.mul_mod_b2_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/b2 is too big.
        x = trace_length - (dynamic_params.mul_mod_b2_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/b2 is too big.
        x = (dynamic_params.mul_mod_row_ratio.into())
            - (((dynamic_params.mul_mod_b2_suboffset.into())
                * (dynamic_params.memory_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/b3 must be nonnegative.
        x = (dynamic_params.mul_mod_b3_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/b3 is too big.
        x = trace_length - (dynamic_params.mul_mod_b3_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/b3 is too big.
        x = (dynamic_params.mul_mod_row_ratio.into())
            - (((dynamic_params.mul_mod_b3_suboffset.into())
                * (dynamic_params.memory_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/c0 must be nonnegative.
        x = (dynamic_params.mul_mod_c0_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/c0 is too big.
        x = trace_length - (dynamic_params.mul_mod_c0_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/c0 is too big.
        x = (dynamic_params.mul_mod_row_ratio.into())
            - (((dynamic_params.mul_mod_c0_suboffset.into())
                * (dynamic_params.memory_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/c1 must be nonnegative.
        x = (dynamic_params.mul_mod_c1_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/c1 is too big.
        x = trace_length - (dynamic_params.mul_mod_c1_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/c1 is too big.
        x = (dynamic_params.mul_mod_row_ratio.into())
            - (((dynamic_params.mul_mod_c1_suboffset.into())
                * (dynamic_params.memory_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/c2 must be nonnegative.
        x = (dynamic_params.mul_mod_c2_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/c2 is too big.
        x = trace_length - (dynamic_params.mul_mod_c2_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/c2 is too big.
        x = (dynamic_params.mul_mod_row_ratio.into())
            - (((dynamic_params.mul_mod_c2_suboffset.into())
                * (dynamic_params.memory_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/c3 must be nonnegative.
        x = (dynamic_params.mul_mod_c3_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/c3 is too big.
        x = trace_length - (dynamic_params.mul_mod_c3_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/c3 is too big.
        x = (dynamic_params.mul_mod_row_ratio.into())
            - (((dynamic_params.mul_mod_c3_suboffset.into())
                * (dynamic_params.memory_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/p_multiplier0/part0 must be nonnegative.
        x = (dynamic_params.mul_mod_p_multiplier0_part0_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/p_multiplier0/part0 is too big.
        x = trace_length - (dynamic_params.mul_mod_p_multiplier0_part0_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/p_multiplier0/part0 is too big.
        x = (dynamic_params.mul_mod_row_ratio.into())
            - (((dynamic_params.mul_mod_p_multiplier0_part0_suboffset.into())
                * (dynamic_params.range_check_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/p_multiplier0/part1 must be nonnegative.
        x = (dynamic_params.mul_mod_p_multiplier0_part1_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/p_multiplier0/part1 is too big.
        x = trace_length - (dynamic_params.mul_mod_p_multiplier0_part1_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/p_multiplier0/part1 is too big.
        x = (dynamic_params.mul_mod_row_ratio.into())
            - (((dynamic_params.mul_mod_p_multiplier0_part1_suboffset.into())
                * (dynamic_params.range_check_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/p_multiplier0/part2 must be nonnegative.
        x = (dynamic_params.mul_mod_p_multiplier0_part2_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/p_multiplier0/part2 is too big.
        x = trace_length - (dynamic_params.mul_mod_p_multiplier0_part2_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/p_multiplier0/part2 is too big.
        x = (dynamic_params.mul_mod_row_ratio.into())
            - (((dynamic_params.mul_mod_p_multiplier0_part2_suboffset.into())
                * (dynamic_params.range_check_units_row_ratio.into())))
            - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/p_multiplier0/part3 must be nonnegative.
        x = (dynamic_params.mul_mod_p_multiplier0_part3_suboffset.into());
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // Offset of mul_mod/p_multiplier0/part3 is too big.
        x = trace_length - (dynamic_params.mul_mod_p_multiplier0_part3_suboffset.into()) - 1_u256;
        assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/p_multiplier0/part3 is too big.
        // x = (dynamic_params.mul_mod_row_ratio.into())
        //     - (((dynamic_params.mul_mod_p_multiplier0_part3_suboffset.into())
        //         * (dynamic_params.range_check_units_row_ratio.into())))
        //     - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/p_multiplier0/part4 must be nonnegative.
        // x = (dynamic_params.mul_mod_p_multiplier0_part4_suboffset.into());
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/p_multiplier0/part4 is too big.
        // x = trace_length - (dynamic_params.mul_mod_p_multiplier0_part4_suboffset.into()) - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/p_multiplier0/part4 is too big.
        // x = (dynamic_params.mul_mod_row_ratio.into())
        //     - (((dynamic_params.mul_mod_p_multiplier0_part4_suboffset.into())
        //         * (dynamic_params.range_check_units_row_ratio.into())))
        //     - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/p_multiplier0/part5 must be nonnegative.
        // x = (dynamic_params.mul_mod_p_multiplier0_part5_suboffset.into());
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/p_multiplier0/part5 is too big.
        // x = trace_length - (dynamic_params.mul_mod_p_multiplier0_part5_suboffset.into()) - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/p_multiplier0/part5 is too big.
        // x = (dynamic_params.mul_mod_row_ratio.into())
        //     - (((dynamic_params.mul_mod_p_multiplier0_part5_suboffset.into())
        //         * (dynamic_params.range_check_units_row_ratio.into())))
        //     - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/p_multiplier1/part0 must be nonnegative.
        // x = (dynamic_params.mul_mod_p_multiplier1_part0_suboffset.into());
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/p_multiplier1/part0 is too big.
        // x = trace_length - (dynamic_params.mul_mod_p_multiplier1_part0_suboffset.into()) - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/p_multiplier1/part0 is too big.
        // x = (dynamic_params.mul_mod_row_ratio.into())
        //     - (((dynamic_params.mul_mod_p_multiplier1_part0_suboffset.into())
        //         * (dynamic_params.range_check_units_row_ratio.into())))
        //     - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/p_multiplier1/part1 must be nonnegative.
        // x = (dynamic_params.mul_mod_p_multiplier1_part1_suboffset.into());
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/p_multiplier1/part1 is too big.
        // x = trace_length - (dynamic_params.mul_mod_p_multiplier1_part1_suboffset.into()) - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/p_multiplier1/part1 is too big.
        // x = (dynamic_params.mul_mod_row_ratio.into())
        //     - (((dynamic_params.mul_mod_p_multiplier1_part1_suboffset.into())
        //         * (dynamic_params.range_check_units_row_ratio.into())))
        //     - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/p_multiplier1/part2 must be nonnegative.
        // x = (dynamic_params.mul_mod_p_multiplier1_part2_suboffset.into());
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/p_multiplier1/part2 is too big.
        // x = trace_length - (dynamic_params.mul_mod_p_multiplier1_part2_suboffset.into()) - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/p_multiplier1/part2 is too big.
        // x = (dynamic_params.mul_mod_row_ratio.into())
        //     - (((dynamic_params.mul_mod_p_multiplier1_part2_suboffset.into())
        //         * (dynamic_params.range_check_units_row_ratio.into())))
        //     - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/p_multiplier1/part3 must be nonnegative.
        // x = (dynamic_params.mul_mod_p_multiplier1_part3_suboffset.into());
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/p_multiplier1/part3 is too big.
        // x = trace_length - (dynamic_params.mul_mod_p_multiplier1_part3_suboffset.into()) - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/p_multiplier1/part3 is too big.
        // x = (dynamic_params.mul_mod_row_ratio.into())
        //     - (((dynamic_params.mul_mod_p_multiplier1_part3_suboffset.into())
        //         * (dynamic_params.range_check_units_row_ratio.into())))
        //     - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/p_multiplier1/part4 must be nonnegative.
        // x = (dynamic_params.mul_mod_p_multiplier1_part4_suboffset.into());
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/p_multiplier1/part4 is too big.
        // x = trace_length - (dynamic_params.mul_mod_p_multiplier1_part4_suboffset.into()) - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/p_multiplier1/part4 is too big.
        // x = (dynamic_params.mul_mod_row_ratio.into())
        //     - (((dynamic_params.mul_mod_p_multiplier1_part4_suboffset.into())
        //         * (dynamic_params.range_check_units_row_ratio.into())))
        //     - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/p_multiplier1/part5 must be nonnegative.
        // x = (dynamic_params.mul_mod_p_multiplier1_part5_suboffset.into());
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/p_multiplier1/part5 is too big.
        // x = trace_length - (dynamic_params.mul_mod_p_multiplier1_part5_suboffset.into()) - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/p_multiplier1/part5 is too big.
        // x = (dynamic_params.mul_mod_row_ratio.into())
        //     - (((dynamic_params.mul_mod_p_multiplier1_part5_suboffset.into())
        //         * (dynamic_params.range_check_units_row_ratio.into())))
        //     - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/p_multiplier2/part0 must be nonnegative.
        // x = (dynamic_params.mul_mod_p_multiplier2_part0_suboffset.into());
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/p_multiplier2/part0 is too big.
        // x = trace_length - (dynamic_params.mul_mod_p_multiplier2_part0_suboffset.into()) - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/p_multiplier2/part0 is too big.
        // x = (dynamic_params.mul_mod_row_ratio.into())
        //     - (((dynamic_params.mul_mod_p_multiplier2_part0_suboffset.into())
        //         * (dynamic_params.range_check_units_row_ratio.into())))
        //     - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/p_multiplier2/part1 must be nonnegative.
        // x = (dynamic_params.mul_mod_p_multiplier2_part1_suboffset.into());
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');

        // // Offset of mul_mod/p_multiplier2/part1 is too big.
        // x = trace_length - (dynamic_params.mul_mod_p_multiplier2_part1_suboffset.into()) - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/p_multiplier2/part1 is too big.
        // x = (dynamic_params.mul_mod_row_ratio.into())
        //     - (((dynamic_params.mul_mod_p_multiplier2_part1_suboffset.into())
        //         * (dynamic_params.range_check_units_row_ratio.into())))
        //     - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/p_multiplier2/part2 must be nonnegative.
        // x = (dynamic_params.mul_mod_p_multiplier2_part2_suboffset.into());
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/p_multiplier2/part2 is too big.
        // x = trace_length - (dynamic_params.mul_mod_p_multiplier2_part2_suboffset.into()) - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/p_multiplier2/part2 is too big.
        // x = (dynamic_params.mul_mod_row_ratio.into())
        //     - (((dynamic_params.mul_mod_p_multiplier2_part2_suboffset.into())
        //         * (dynamic_params.range_check_units_row_ratio.into())))
        //     - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/p_multiplier2/part3 must be nonnegative.
        // x = (dynamic_params.mul_mod_p_multiplier2_part3_suboffset.into());
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/p_multiplier2/part3 is too big.
        // x = trace_length - (dynamic_params.mul_mod_p_multiplier2_part3_suboffset.into()) - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/p_multiplier2/part3 is too big.
        // x = (dynamic_params.mul_mod_row_ratio.into())
        //     - (((dynamic_params.mul_mod_p_multiplier2_part3_suboffset.into())
        //         * (dynamic_params.range_check_units_row_ratio.into())))
        //     - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/p_multiplier2/part4 must be nonnegative.
        // x = (dynamic_params.mul_mod_p_multiplier2_part4_suboffset.into());
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/p_multiplier2/part4 is too big.
        // x = trace_length - (dynamic_params.mul_mod_p_multiplier2_part4_suboffset.into()) - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/p_multiplier2/part4 is too big.
        // x = (dynamic_params.mul_mod_row_ratio.into())
        //     - (((dynamic_params.mul_mod_p_multiplier2_part4_suboffset.into())
        //         * (dynamic_params.range_check_units_row_ratio.into())))
        //     - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/p_multiplier2/part5 must be nonnegative.
        // x = (dynamic_params.mul_mod_p_multiplier2_part5_suboffset.into());
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/p_multiplier2/part5 is too big.
        // x = trace_length - (dynamic_params.mul_mod_p_multiplier2_part5_suboffset.into()) - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/p_multiplier2/part5 is too big.
        // x = (dynamic_params.mul_mod_row_ratio.into())
        //     - (((dynamic_params.mul_mod_p_multiplier2_part5_suboffset.into())
        //         * (dynamic_params.range_check_units_row_ratio.into())))
        //     - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/p_multiplier3/part0 must be nonnegative.
        // x = (dynamic_params.mul_mod_p_multiplier3_part0_suboffset.into());
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/p_multiplier3/part0 is too big.
        // x = trace_length - (dynamic_params.mul_mod_p_multiplier3_part0_suboffset.into()) - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/p_multiplier3/part0 is too big.
        // x = (dynamic_params.mul_mod_row_ratio.into())
        //     - (((dynamic_params.mul_mod_p_multiplier3_part0_suboffset.into())
        //         * (dynamic_params.range_check_units_row_ratio.into())))
        //     - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/p_multiplier3/part1 must be nonnegative.
        // x = (dynamic_params.mul_mod_p_multiplier3_part1_suboffset.into());
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/p_multiplier3/part1 is too big.
        // x = trace_length - (dynamic_params.mul_mod_p_multiplier3_part1_suboffset.into()) - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/p_multiplier3/part1 is too big.
        // x = (dynamic_params.mul_mod_row_ratio.into())
        //     - (((dynamic_params.mul_mod_p_multiplier3_part1_suboffset.into())
        //         * (dynamic_params.range_check_units_row_ratio.into())))
        //     - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/p_multiplier3/part2 must be nonnegative.
        // x = (dynamic_params.mul_mod_p_multiplier3_part2_suboffset.into());
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/p_multiplier3/part2 is too big.
        // x = trace_length - (dynamic_params.mul_mod_p_multiplier3_part2_suboffset.into()) - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/p_multiplier3/part2 is too big.
        // x = (dynamic_params.mul_mod_row_ratio.into())
        //     - (((dynamic_params.mul_mod_p_multiplier3_part2_suboffset.into())
        //         * (dynamic_params.range_check_units_row_ratio.into())))
        //     - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/p_multiplier3/part3 must be nonnegative.
        // x = (dynamic_params.mul_mod_p_multiplier3_part3_suboffset.into());
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/p_multiplier3/part3 is too big.
        // x = trace_length - (dynamic_params.mul_mod_p_multiplier3_part3_suboffset.into()) - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/p_multiplier3/part3 is too big.
        // x = (dynamic_params.mul_mod_row_ratio.into())
        //     - (((dynamic_params.mul_mod_p_multiplier3_part3_suboffset.into())
        //         * (dynamic_params.range_check_units_row_ratio.into())))
        //     - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/p_multiplier3/part4 must be nonnegative.
        // x = (dynamic_params.mul_mod_p_multiplier3_part4_suboffset.into());
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/p_multiplier3/part4 is too big.
        // x = trace_length - (dynamic_params.mul_mod_p_multiplier3_part4_suboffset.into()) - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/p_multiplier3/part4 is too big.
        // x = (dynamic_params.mul_mod_row_ratio.into())
        //     - (((dynamic_params.mul_mod_p_multiplier3_part4_suboffset.into())
        //         * (dynamic_params.range_check_units_row_ratio.into())))
        //     - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/p_multiplier3/part5 must be nonnegative.
        // x = (dynamic_params.mul_mod_p_multiplier3_part5_suboffset.into());
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/p_multiplier3/part5 is too big.
        // x = trace_length - (dynamic_params.mul_mod_p_multiplier3_part5_suboffset.into()) - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/p_multiplier3/part5 is too big.
        // x = (dynamic_params.mul_mod_row_ratio.into())
        //     - (((dynamic_params.mul_mod_p_multiplier3_part5_suboffset.into())
        //         * (dynamic_params.range_check_units_row_ratio.into())))
        //     - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry0/part0 must be nonnegative.
        // x = (dynamic_params.mul_mod_carry0_part0_suboffset.into());
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry0/part0 is too big.
        // x = trace_length - (dynamic_params.mul_mod_carry0_part0_suboffset.into()) - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry0/part0 is too big.
        // x = (dynamic_params.mul_mod_row_ratio.into())
        //     - (((dynamic_params.mul_mod_carry0_part0_suboffset.into())
        //         * (dynamic_params.range_check_units_row_ratio.into())))
        //     - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry0/part1 must be nonnegative.
        // x = (dynamic_params.mul_mod_carry0_part1_suboffset.into());
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry0/part1 is too big.
        // x = trace_length - (dynamic_params.mul_mod_carry0_part1_suboffset.into()) - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry0/part1 is too big.
        // x = (dynamic_params.mul_mod_row_ratio.into())
        //     - (((dynamic_params.mul_mod_carry0_part1_suboffset.into())
        //         * (dynamic_params.range_check_units_row_ratio.into())))
        //     - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry0/part2 must be nonnegative.
        // x = (dynamic_params.mul_mod_carry0_part2_suboffset.into());
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry0/part2 is too big.
        // x = trace_length - (dynamic_params.mul_mod_carry0_part2_suboffset.into()) - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry0/part2 is too big.
        // x = (dynamic_params.mul_mod_row_ratio.into())
        //     - (((dynamic_params.mul_mod_carry0_part2_suboffset.into())
        //         * (dynamic_params.range_check_units_row_ratio.into())))
        //     - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry0/part3 must be nonnegative.
        // x = (dynamic_params.mul_mod_carry0_part3_suboffset.into());
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry0/part3 is too big.
        // x = trace_length - (dynamic_params.mul_mod_carry0_part3_suboffset.into()) - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry0/part3 is too big.
        // x = (dynamic_params.mul_mod_row_ratio.into())
        //     - (((dynamic_params.mul_mod_carry0_part3_suboffset.into())
        //         * (dynamic_params.range_check_units_row_ratio.into())))
        //     - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry0/part4 must be nonnegative.
        // x = (dynamic_params.mul_mod_carry0_part4_suboffset.into());
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry0/part4 is too big.
        // x = trace_length - (dynamic_params.mul_mod_carry0_part4_suboffset.into()) - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry0/part4 is too big.
        // x = (dynamic_params.mul_mod_row_ratio.into())
        //     - (((dynamic_params.mul_mod_carry0_part4_suboffset.into())
        //         * (dynamic_params.range_check_units_row_ratio.into())))
        //     - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry0/part5 must be nonnegative.
        // x = (dynamic_params.mul_mod_carry0_part5_suboffset.into());
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry0/part5 is too big.
        // x = trace_length - (dynamic_params.mul_mod_carry0_part5_suboffset.into()) - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry0/part5 is too big.
        // x = (dynamic_params.mul_mod_row_ratio.into())
        //     - (((dynamic_params.mul_mod_carry0_part5_suboffset.into())
        //         * (dynamic_params.range_check_units_row_ratio.into())))
        //     - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry0/part6 must be nonnegative.
        // x = (dynamic_params.mul_mod_carry0_part6_suboffset.into());
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry0/part6 is too big.
        // x = trace_length - (dynamic_params.mul_mod_carry0_part6_suboffset.into()) - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry0/part6 is too big.
        // x = (dynamic_params.mul_mod_row_ratio.into())
        //     - (((dynamic_params.mul_mod_carry0_part6_suboffset.into())
        //         * (dynamic_params.range_check_units_row_ratio.into())))
        //     - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry1/part0 must be nonnegative.
        // x = (dynamic_params.mul_mod_carry1_part0_suboffset.into());
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry1/part0 is too big.
        // x = trace_length - (dynamic_params.mul_mod_carry1_part0_suboffset.into()) - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry1/part0 is too big.
        // x = (dynamic_params.mul_mod_row_ratio.into())
        //     - (((dynamic_params.mul_mod_carry1_part0_suboffset.into())
        //         * (dynamic_params.range_check_units_row_ratio.into())))
        //     - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry1/part1 must be nonnegative.
        // x = (dynamic_params.mul_mod_carry1_part1_suboffset.into());
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry1/part1 is too big.
        // x = trace_length - (dynamic_params.mul_mod_carry1_part1_suboffset.into()) - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry1/part1 is too big.
        // x = (dynamic_params.mul_mod_row_ratio.into())
        //     - (((dynamic_params.mul_mod_carry1_part1_suboffset.into())
        //         * (dynamic_params.range_check_units_row_ratio.into())))
        //     - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry1/part2 must be nonnegative.
        // x = (dynamic_params.mul_mod_carry1_part2_suboffset.into());
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry1/part2 is too big.
        // x = trace_length - (dynamic_params.mul_mod_carry1_part2_suboffset.into()) - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry1/part2 is too big.
        // x = (dynamic_params.mul_mod_row_ratio.into())
        //     - (((dynamic_params.mul_mod_carry1_part2_suboffset.into())
        //         * (dynamic_params.range_check_units_row_ratio.into())))
        //     - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry1/part3 must be nonnegative.
        // x = (dynamic_params.mul_mod_carry1_part3_suboffset.into());
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry1/part3 is too big.
        // x = trace_length - (dynamic_params.mul_mod_carry1_part3_suboffset.into()) - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry1/part3 is too big.
        // x = (dynamic_params.mul_mod_row_ratio.into())
        //     - (((dynamic_params.mul_mod_carry1_part3_suboffset.into())
        //         * (dynamic_params.range_check_units_row_ratio.into())))
        //     - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry1/part4 must be nonnegative.
        // x = (dynamic_params.mul_mod_carry1_part4_suboffset.into());
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry1/part4 is too big.
        // x = trace_length - (dynamic_params.mul_mod_carry1_part4_suboffset.into()) - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry1/part4 is too big.
        // x = (dynamic_params.mul_mod_row_ratio.into())
        //     - (((dynamic_params.mul_mod_carry1_part4_suboffset.into())
        //         * (dynamic_params.range_check_units_row_ratio.into())))
        //     - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry1/part5 must be nonnegative.
        // x = (dynamic_params.mul_mod_carry1_part5_suboffset.into());
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry1/part5 is too big.
        // x = trace_length - (dynamic_params.mul_mod_carry1_part5_suboffset.into()) - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry1/part5 is too big.
        // x = (dynamic_params.mul_mod_row_ratio.into())
        //     - (((dynamic_params.mul_mod_carry1_part5_suboffset.into())
        //         * (dynamic_params.range_check_units_row_ratio.into())))
        //     - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry1/part6 must be nonnegative.
        // x = (dynamic_params.mul_mod_carry1_part6_suboffset.into());
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry1/part6 is too big.
        // x = trace_length - (dynamic_params.mul_mod_carry1_part6_suboffset.into()) - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry1/part6 is too big.
        // x = (dynamic_params.mul_mod_row_ratio.into())
        //     - (((dynamic_params.mul_mod_carry1_part6_suboffset.into())
        //         * (dynamic_params.range_check_units_row_ratio.into())))
        //     - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry2/part0 must be nonnegative.
        // x = (dynamic_params.mul_mod_carry2_part0_suboffset.into());
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry2/part0 is too big.
        // x = trace_length - (dynamic_params.mul_mod_carry2_part0_suboffset.into()) - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry2/part0 is too big.
        // x = (dynamic_params.mul_mod_row_ratio.into())
        //     - (((dynamic_params.mul_mod_carry2_part0_suboffset.into())
        //         * (dynamic_params.range_check_units_row_ratio.into())))
        //     - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry2/part1 must be nonnegative.
        // x = (dynamic_params.mul_mod_carry2_part1_suboffset.into());
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry2/part1 is too big.
        // x = trace_length - (dynamic_params.mul_mod_carry2_part1_suboffset.into()) - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry2/part1 is too big.
        // x = (dynamic_params.mul_mod_row_ratio.into())
        //     - (((dynamic_params.mul_mod_carry2_part1_suboffset.into())
        //         * (dynamic_params.range_check_units_row_ratio.into())))
        //     - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry2/part2 must be nonnegative.
        // x = (dynamic_params.mul_mod_carry2_part2_suboffset.into());
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry2/part2 is too big.
        // x = trace_length - (dynamic_params.mul_mod_carry2_part2_suboffset.into()) - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry2/part2 is too big.
        // x = (dynamic_params.mul_mod_row_ratio.into())
        //     - (((dynamic_params.mul_mod_carry2_part2_suboffset.into())
        //         * (dynamic_params.range_check_units_row_ratio.into())))
        //     - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry2/part3 must be nonnegative.
        // x = (dynamic_params.mul_mod_carry2_part3_suboffset.into());
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry2/part3 is too big.
        // x = trace_length - (dynamic_params.mul_mod_carry2_part3_suboffset.into()) - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry2/part3 is too big.
        // x = (dynamic_params.mul_mod_row_ratio.into())
        //     - (((dynamic_params.mul_mod_carry2_part3_suboffset.into())
        //         * (dynamic_params.range_check_units_row_ratio.into())))
        //     - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry2/part4 must be nonnegative.
        // x = (dynamic_params.mul_mod_carry2_part4_suboffset.into());
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry2/part4 is too big.
        // x = trace_length - (dynamic_params.mul_mod_carry2_part4_suboffset.into()) - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry2/part4 is too big.
        // x = (dynamic_params.mul_mod_row_ratio.into())
        //     - (((dynamic_params.mul_mod_carry2_part4_suboffset.into())
        //         * (dynamic_params.range_check_units_row_ratio.into())))
        //     - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry2/part5 must be nonnegative.
        // x = (dynamic_params.mul_mod_carry2_part5_suboffset.into());
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry2/part5 is too big.
        // x = trace_length - (dynamic_params.mul_mod_carry2_part5_suboffset.into()) - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry2/part5 is too big.
        // x = (dynamic_params.mul_mod_row_ratio.into())
        //     - (((dynamic_params.mul_mod_carry2_part5_suboffset.into())
        //         * (dynamic_params.range_check_units_row_ratio.into())))
        //     - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry2/part6 must be nonnegative.
        // x = (dynamic_params.mul_mod_carry2_part6_suboffset.into());
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry2/part6 is too big.
        // x = trace_length - (dynamic_params.mul_mod_carry2_part6_suboffset.into()) - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry2/part6 is too big.
        // x = (dynamic_params.mul_mod_row_ratio.into())
        //     - (((dynamic_params.mul_mod_carry2_part6_suboffset.into())
        //         * (dynamic_params.range_check_units_row_ratio.into())))
        //     - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry3/part0 must be nonnegative.
        // x = (dynamic_params.mul_mod_carry3_part0_suboffset.into());
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry3/part0 is too big.
        // x = trace_length - (dynamic_params.mul_mod_carry3_part0_suboffset.into()) - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry3/part0 is too big.
        // x = (dynamic_params.mul_mod_row_ratio.into())
        //     - (((dynamic_params.mul_mod_carry3_part0_suboffset.into())
        //         * (dynamic_params.range_check_units_row_ratio.into())))
        //     - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry3/part1 must be nonnegative.
        // x = (dynamic_params.mul_mod_carry3_part1_suboffset.into());
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry3/part1 is too big.
        // x = trace_length - (dynamic_params.mul_mod_carry3_part1_suboffset.into()) - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry3/part1 is too big.
        // x = (dynamic_params.mul_mod_row_ratio.into())
        //     - (((dynamic_params.mul_mod_carry3_part1_suboffset.into())
        //         * (dynamic_params.range_check_units_row_ratio.into())))
        //     - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry3/part2 must be nonnegative.
        // x = (dynamic_params.mul_mod_carry3_part2_suboffset.into());
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry3/part2 is too big.
        // x = trace_length - (dynamic_params.mul_mod_carry3_part2_suboffset.into()) - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry3/part2 is too big.
        // x = (dynamic_params.mul_mod_row_ratio.into())
        //     - (((dynamic_params.mul_mod_carry3_part2_suboffset.into())
        //         * (dynamic_params.range_check_units_row_ratio.into())))
        //     - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry3/part3 must be nonnegative.
        // x = (dynamic_params.mul_mod_carry3_part3_suboffset.into());
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry3/part3 is too big.
        // x = trace_length - (dynamic_params.mul_mod_carry3_part3_suboffset.into()) - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry3/part3 is too big.
        // x = (dynamic_params.mul_mod_row_ratio.into())
        //     - (((dynamic_params.mul_mod_carry3_part3_suboffset.into())
        //         * (dynamic_params.range_check_units_row_ratio.into())))
        //     - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry3/part4 must be nonnegative.
        // x = (dynamic_params.mul_mod_carry3_part4_suboffset.into());
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry3/part4 is too big.
        // x = trace_length - (dynamic_params.mul_mod_carry3_part4_suboffset.into()) - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry3/part4 is too big.
        // x = (dynamic_params.mul_mod_row_ratio.into())
        //     - (((dynamic_params.mul_mod_carry3_part4_suboffset.into())
        //         * (dynamic_params.range_check_units_row_ratio.into())))
        //     - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry3/part5 must be nonnegative.
        // x = (dynamic_params.mul_mod_carry3_part5_suboffset.into());
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry3/part5 is too big.
        // x = trace_length - (dynamic_params.mul_mod_carry3_part5_suboffset.into()) - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry3/part5 is too big.
        // x = (dynamic_params.mul_mod_row_ratio.into())
        //     - (((dynamic_params.mul_mod_carry3_part5_suboffset.into())
        //         * (dynamic_params.range_check_units_row_ratio.into())))
        //     - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry3/part6 must be nonnegative.
        // x = (dynamic_params.mul_mod_carry3_part6_suboffset.into());
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry3/part6 is too big.
        // x = trace_length - (dynamic_params.mul_mod_carry3_part6_suboffset.into()) - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry3/part6 is too big.
        // x = (dynamic_params.mul_mod_row_ratio.into())
        //     - (((dynamic_params.mul_mod_carry3_part6_suboffset.into())
        //         * (dynamic_params.range_check_units_row_ratio.into())))
        //     - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry4/part0 must be nonnegative.
        // x = (dynamic_params.mul_mod_carry4_part0_suboffset.into());
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry4/part0 is too big.
        // x = trace_length - (dynamic_params.mul_mod_carry4_part0_suboffset.into()) - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry4/part0 is too big.
        // x = (dynamic_params.mul_mod_row_ratio.into())
        //     - (((dynamic_params.mul_mod_carry4_part0_suboffset.into())
        //         * (dynamic_params.range_check_units_row_ratio.into())))
        //     - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry4/part1 must be nonnegative.
        // x = (dynamic_params.mul_mod_carry4_part1_suboffset.into());
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry4/part1 is too big.
        // x = trace_length - (dynamic_params.mul_mod_carry4_part1_suboffset.into()) - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry4/part1 is too big.
        // x = (dynamic_params.mul_mod_row_ratio.into())
        //     - (((dynamic_params.mul_mod_carry4_part1_suboffset.into())
        //         * (dynamic_params.range_check_units_row_ratio.into())))
        //     - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry4/part2 must be nonnegative.
        // x = (dynamic_params.mul_mod_carry4_part2_suboffset.into());
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry4/part2 is too big.
        // x = trace_length - (dynamic_params.mul_mod_carry4_part2_suboffset.into()) - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry4/part2 is too big.
        // x = (dynamic_params.mul_mod_row_ratio.into())
        //     - (((dynamic_params.mul_mod_carry4_part2_suboffset.into())
        //         * (dynamic_params.range_check_units_row_ratio.into())))
        //     - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry4/part3 must be nonnegative.
        // x = (dynamic_params.mul_mod_carry4_part3_suboffset.into());
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry4/part3 is too big.
        // x = trace_length - (dynamic_params.mul_mod_carry4_part3_suboffset.into()) - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry4/part3 is too big.
        // x = (dynamic_params.mul_mod_row_ratio.into())
        //     - (((dynamic_params.mul_mod_carry4_part3_suboffset.into())
        //         * (dynamic_params.range_check_units_row_ratio.into())))
        //     - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry4/part4 must be nonnegative.
        // x = (dynamic_params.mul_mod_carry4_part4_suboffset.into());
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry4/part4 is too big.
        // x = trace_length - (dynamic_params.mul_mod_carry4_part4_suboffset.into()) - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry4/part4 is too big.
        // x = (dynamic_params.mul_mod_row_ratio.into())
        //     - (((dynamic_params.mul_mod_carry4_part4_suboffset.into())
        //         * (dynamic_params.range_check_units_row_ratio.into())))
        //     - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry4/part5 must be nonnegative.
        // x = (dynamic_params.mul_mod_carry4_part5_suboffset.into());
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry4/part5 is too big.
        // x = trace_length - (dynamic_params.mul_mod_carry4_part5_suboffset.into()) - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry4/part5 is too big.
        // x = (dynamic_params.mul_mod_row_ratio.into())
        //     - (((dynamic_params.mul_mod_carry4_part5_suboffset.into())
        //         * (dynamic_params.range_check_units_row_ratio.into())))
        //     - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry4/part6 must be nonnegative.
        // x = (dynamic_params.mul_mod_carry4_part6_suboffset.into());
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry4/part6 is too big.
        // x = trace_length - (dynamic_params.mul_mod_carry4_part6_suboffset.into()) - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry4/part6 is too big.
        // x = (dynamic_params.mul_mod_row_ratio.into())
        //     - (((dynamic_params.mul_mod_carry4_part6_suboffset.into())
        //         * (dynamic_params.range_check_units_row_ratio.into())))
        //     - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // //Offset of mul_mod/carry5/part0 must be nonnegative.
        // x = (dynamic_params.mul_mod_carry5_part0_suboffset.into());
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry5/part0 is too big.
        // x = trace_length - (dynamic_params.mul_mod_carry5_part0_suboffset.into()) - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry5/part0 is too big.
        // x = (dynamic_params.mul_mod_row_ratio.into())
        //     - (((dynamic_params.mul_mod_carry5_part0_suboffset.into())
        //         * (dynamic_params.range_check_units_row_ratio.into())))
        //     - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry5/part1 must be nonnegative.
        // x = (dynamic_params.mul_mod_carry5_part1_suboffset.into());
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry5/part1 is too big.
        // x = trace_length - (dynamic_params.mul_mod_carry5_part1_suboffset.into()) - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry5/part1 is too big.
        // x = (dynamic_params.mul_mod_row_ratio.into())
        //     - (((dynamic_params.mul_mod_carry5_part1_suboffset.into())
        //         * (dynamic_params.range_check_units_row_ratio.into())))
        //     - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry5/part2 must be nonnegative.
        // x = (dynamic_params.mul_mod_carry5_part2_suboffset.into());
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry5/part2 is too big.
        // x = trace_length - (dynamic_params.mul_mod_carry5_part2_suboffset.into()) - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry5/part2 is too big.
        // x = (dynamic_params.mul_mod_row_ratio.into())
        //     - (((dynamic_params.mul_mod_carry5_part2_suboffset.into())
        //         * (dynamic_params.range_check_units_row_ratio.into())))
        //     - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry5/part3 must be nonnegative.
        // x = (dynamic_params.mul_mod_carry5_part3_suboffset.into());
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry5/part3 is too big.
        // x = trace_length - (dynamic_params.mul_mod_carry5_part3_suboffset.into()) - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry5/part3 is too big.
        // x = (dynamic_params.mul_mod_row_ratio.into())
        //     - (((dynamic_params.mul_mod_carry5_part3_suboffset.into())
        //         * (dynamic_params.range_check_units_row_ratio.into())))
        //     - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry5/part4 must be nonnegative.
        // x = (dynamic_params.mul_mod_carry5_part4_suboffset.into());
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry5/part4 is too big.
        // x = trace_length - (dynamic_params.mul_mod_carry5_part4_suboffset.into()) - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry5/part4 is too big.
        // x = (dynamic_params.mul_mod_row_ratio.into())
        //     - (((dynamic_params.mul_mod_carry5_part4_suboffset.into())
        //         * (dynamic_params.range_check_units_row_ratio.into())))
        //     - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry5/part5 must be nonnegative.
        // x = (dynamic_params.mul_mod_carry5_part5_suboffset.into());
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry5/part5 is too big.
        // x = trace_length - (dynamic_params.mul_mod_carry5_part5_suboffset.into()) - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry5/part5 is too big.
        // x = (dynamic_params.mul_mod_row_ratio.into())
        //     - (((dynamic_params.mul_mod_carry5_part5_suboffset.into())
        //         * (dynamic_params.range_check_units_row_ratio.into())))
        //     - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry5/part6 must be nonnegative.
        // x = (dynamic_params.mul_mod_carry5_part6_suboffset.into());
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry5/part6 is too big.
        // x = trace_length - (dynamic_params.mul_mod_carry5_part6_suboffset.into()) - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
        // // Offset of mul_mod/carry5/part6 is too big.
        // x = (dynamic_params.mul_mod_row_ratio.into())
        //     - (((dynamic_params.mul_mod_carry5_part6_suboffset.into())
        //         * (dynamic_params.range_check_units_row_ratio.into())))
        //     - 1_u256;
        // assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
    }
}
