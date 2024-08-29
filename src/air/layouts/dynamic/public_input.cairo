use core::array::ArrayTrait;
use core::clone::Clone;
use cairo_verifier::{
    common::{
        math::{pow, Felt252PartialOrd, Felt252Div},
        asserts::{assert_range_u128_le, assert_range_u128},
    },
    air::{
        public_memory::{Page, PageTrait},
        constants::{MAX_ADDRESS, INITIAL_PC, MAX_LOG_N_STEPS, MAX_RANGE_CHECK},
        layouts::dynamic::{
            autogenerated::{check_asserts},
            constants::{
                segments, get_builtins, CPU_COMPONENT_HEIGHT, LAYOUT_CODE, DynamicParams,
                PUBLIC_MEMORY_FRACTION
            }
        },
        public_input::{
            PublicInput, PublicInputTrait, verify_cairo1_public_input,
            get_builtins as get_program_builtins
        }
    },
    domains::StarkDomains
};

use core::{pedersen::PedersenTrait, hash::{HashStateTrait, HashStateExTrait, Hash}};
use poseidon::poseidon_hash_span;

impl DynamicPublicInputImpl of PublicInputTrait {
    fn verify_cairo0(self: @PublicInput) -> (felt252, felt252) {
        let public_segments = self.segments;

        let initial_pc = *public_segments.at(segments::PROGRAM).begin_addr;
        let final_pc = *public_segments.at(segments::PROGRAM).stop_ptr;
        let initial_ap = *public_segments.at(segments::EXECUTION).begin_addr;
        let initial_fp = initial_ap;
        let final_ap = *public_segments.at(segments::EXECUTION).stop_ptr;
        let output_start = *public_segments.at(segments::OUTPUT).begin_addr;
        let output_stop = *public_segments.at(segments::OUTPUT).stop_ptr;

        assert(initial_ap < MAX_ADDRESS, 'Invalid initial_ap');
        assert(final_ap < MAX_ADDRESS, 'Invalid final_ap');

        // TODO support more pages?
        assert(self.continuous_page_headers.len() == 0, 'Invalid continuous_page_headers');

        let layout_builtins = get_builtins();
        let program_builtins = get_program_builtins();
        let memory = self.main_page;

        // 1. Program segment
        assert(initial_pc == INITIAL_PC, 'Invalid initial_pc');
        assert(final_pc == INITIAL_PC + 4, 'Invalid final_pc');

        let mut memory_index: usize = 0;

        let program_end_pc = initial_fp - 2;
        let program_len = program_end_pc - initial_pc;
        let program = memory
            .extract_range(
                initial_pc.try_into().unwrap(), program_len.try_into().unwrap(), ref memory_index
            );

        assert(
            *program[0] == 0x40780017fff7fff, 'Invalid program'
        ); // Instruction: ap += N_BUILTINS.
        assert(*program[1] == program_builtins.len().into(), 'Invalid program');
        assert(*program[2] == 0x1104800180018000, 'Invalid program'); // Instruction: call rel ?.
        assert(*program[4] == 0x10780017fff7fff, 'Invalid program'); // Instruction: jmp rel 0.
        assert(*program[5] == 0x0, 'Invalid program');

        let program_hash = poseidon_hash_span(program);

        // 2. Execution segment
        // 2.1 Initial_fp, initial_pc
        let fp2 = *memory.at(memory_index);
        assert(fp2.address == initial_fp - 2, 'Invalid fp2 addr');
        assert(fp2.value == initial_fp, 'Invalid fp2 val');

        let fp1 = *memory.at(memory_index + 1);
        assert(fp1.address == initial_fp - 1, 'Invalid fp1 addr');
        assert(fp1.value == 0, 'Invalid fp1 val');
        memory_index += 2;

        // 2.2 Main arguments and return values
        let mut begin_addresses = ArrayTrait::new();
        let mut stop_addresses = ArrayTrait::new();
        let layout_builtins_len = layout_builtins.len();
        let mut i = 0;
        loop {
            if i == layout_builtins_len {
                break;
            }

            begin_addresses.append(*public_segments.at(2 + i).begin_addr);
            stop_addresses.append(*public_segments.at(2 + i).stop_ptr);

            i += 1;
        };
        memory
            .verify_stack(
                initial_ap,
                begin_addresses.span(),
                program_builtins.span(),
                layout_builtins.span(),
                ref memory_index
            );
        memory
            .verify_stack(
                final_ap - program_builtins.len().into(),
                stop_addresses.span(),
                program_builtins.span(),
                layout_builtins.span(),
                ref memory_index
            );

        // 3. Output segment
        let output_len = output_stop - output_start;
        let output = memory
            .extract_range(
                output_start.try_into().unwrap(), output_len.try_into().unwrap(), ref memory_index
            );
        let output_hash = poseidon_hash_span(output);

        // Check main page len
        assert(
            *memory.at(memory_index - 1) == *self.main_page.at(self.main_page.len() - 1),
            'Invalid main page len'
        );

        (program_hash, output_hash)
    }

    fn verify_cairo1(self: @PublicInput) -> (felt252, felt252) {
        verify_cairo1_public_input(self)
    }

    fn validate(self: @PublicInput, stark_domains: @StarkDomains) {
        let mut dynamic_params_span = self.dynamic_params.span();
        let dynamic_params = Serde::<DynamicParams>::deserialize(ref dynamic_params_span).unwrap();
        assert_range_u128_le(*self.log_n_steps, MAX_LOG_N_STEPS);

        let n_steps = pow(2, *self.log_n_steps);
        let trace_length = *stark_domains.trace_domain_size;
        assert(
            n_steps
                * CPU_COMPONENT_HEIGHT
                * dynamic_params.cpu_component_step.into() == trace_length,
            'Wrong trace size'
        );

        assert(0 <= *self.range_check_min, 'wrong rc_min');
        assert(*self.range_check_min < *self.range_check_max, 'wrong rc range');
        assert(*self.range_check_max <= MAX_RANGE_CHECK, 'wrong rc_max');

        assert(*self.layout == LAYOUT_CODE, 'wrong layout code');

        // Segments.
        let output_uses = (*self.segments.at(segments::OUTPUT).stop_ptr
            - *self.segments.at(segments::OUTPUT).begin_addr);
        assert_range_u128(output_uses);

        assert(self.segments.len() == segments::N_SEGMENTS, 'Segment number miss-match');

        let pedersen_copies = if (dynamic_params.uses_pedersen_builtin == 0) {
            0
        } else {
            trace_length / dynamic_params.pedersen_builtin_row_ratio.into()
        };
        let pedersen_uses = (*self.segments.at(segments::PEDERSEN).stop_ptr
            - *self.segments.at(segments::PEDERSEN).begin_addr)
            / 3;
        assert_range_u128_le(pedersen_uses, pedersen_copies);
        // Note that the following call implies that trace_length is divisible by
        // dynamic_params.pedersen_builtin_row_ratio
        // and that stop_ptr - begin_addr is divisible by 3.

        let range_check_copies = if (dynamic_params.uses_range_check_builtin == 0) {
            0
        } else {
            trace_length / dynamic_params.range_check_builtin_row_ratio.into()
        };
        let range_check_uses = *self.segments.at(segments::RANGE_CHECK).stop_ptr
            - *self.segments.at(segments::RANGE_CHECK).begin_addr;
        assert_range_u128_le(range_check_uses, range_check_copies);
        // Note that the following call implies that trace_length is divisible by
        // dynamic_params.range_check_builtin_row_ratio.

        let ecdsa_copies = if (dynamic_params.uses_ecdsa_builtin == 0) {
            0
        } else {
            trace_length / dynamic_params.ecdsa_builtin_row_ratio.into()
        };
        let ecdsa_uses = (*self.segments.at(segments::ECDSA).stop_ptr
            - *self.segments.at(segments::ECDSA).begin_addr)
            / 2;
        assert_range_u128_le(ecdsa_uses, ecdsa_copies);
        // Note that the following call implies that trace_length is divisible by
        // dynamic_params.ecdsa_builtin_row_ratio
        // and that stop_ptr - begin_addr is divisible by 2.

        let bitwise_copies = if (dynamic_params.uses_bitwise_builtin == 0) {
            0
        } else {
            trace_length / dynamic_params.bitwise_row_ratio.into()
        };
        let bitwise_uses = (*self.segments.at(segments::BITWISE).stop_ptr
            - *self.segments.at(segments::BITWISE).begin_addr)
            / 5;
        assert_range_u128_le(bitwise_uses, bitwise_copies);
        // Note that the following call implies that trace_length is divisible by
        // dynamic_params.bitwise_row_ratio
        // and that stop_ptr - begin_addr is divisible by 5.

        let ec_op_copies = if (dynamic_params.uses_ec_op_builtin == 0) {
            0
        } else {
            trace_length / dynamic_params.ec_op_builtin_row_ratio.into()
        };
        let ec_op_uses = (*self.segments.at(segments::EC_OP).stop_ptr
            - *self.segments.at(segments::EC_OP).begin_addr)
            / 7;
        assert_range_u128_le(ec_op_uses, ec_op_copies);
        // Note that the following call implies that trace_length is divisible by
        // dynamic_params.ec_op_builtin_row_ratio
        // and that stop_ptr - begin_addr is divisible by 7.

        let keccak_copies = if (dynamic_params.uses_keccak_builtin == 0) {
            0
        } else {
            trace_length / dynamic_params.keccak_row_ratio.into()
        };
        let keccak_uses = (*self.segments.at(segments::KECCAK).stop_ptr
            - *self.segments.at(segments::KECCAK).begin_addr)
            / 16;
        assert_range_u128_le(keccak_uses, keccak_copies);
        // Note that the following call implies that trace_length is divisible by
        // dynamic_params.keccak_row_ratio
        // and that stop_ptr - begin_addr is divisible by 16.

        let poseidon_copies = if (dynamic_params.uses_poseidon_builtin == 0) {
            0
        } else {
            trace_length / dynamic_params.poseidon_row_ratio.into()
        };
        let poseidon_uses = (*self.segments.at(segments::POSEIDON).stop_ptr
            - *self.segments.at(segments::POSEIDON).begin_addr)
            / 6;
        assert_range_u128_le(poseidon_uses, poseidon_copies);
        // Note that the following call implies that trace_length is divisible by
        // dynamic_params.poseidon_row_ratio
        // and that stop_ptr - begin_addr is divisible by 6.

        let range_check96_copies = if (dynamic_params.uses_range_check96_builtin == 0) {
            0
        } else {
            trace_length / dynamic_params.range_check96_builtin_row_ratio.into()
        };
        let range_check96_uses = *self.segments.at(segments::RANGE_CHECK96).stop_ptr
            - *self.segments.at(segments::RANGE_CHECK96).begin_addr;
        assert_range_u128_le(range_check96_uses, range_check96_copies);
        // Note that the following call implies that trace_length is divisible by
        // dynamic_params.range_check96_builtin_row_ratio.

        let add_mod_copies = if (dynamic_params.uses_add_mod_builtin == 0) {
            0
        } else {
            trace_length / dynamic_params.add_mod_row_ratio.into()
        };
        let add_mod_uses = (*self.segments.at(segments::ADD_MOD).stop_ptr
            - *self.segments.at(segments::ADD_MOD).begin_addr)
            / 7;
        assert_range_u128_le(add_mod_uses, add_mod_copies);
        // Note that the following call implies that trace_length is divisible by
        // dynamic_params.add_mod_row_ratio
        // and that stop_ptr - begin_addr is divisible by 7.

        let mul_mod_copies = if (dynamic_params.uses_mul_mod_builtin == 0) {
            0
        } else {
            trace_length / dynamic_params.mul_mod_row_ratio.into()
        };
        let mul_mod_uses = (*self.segments.at(segments::MUL_MOD).stop_ptr
            - *self.segments.at(segments::MUL_MOD).begin_addr)
            / 7;
        assert_range_u128_le(mul_mod_uses, mul_mod_copies);
        // Note that the following call implies that trace_length is divisible by
        // dynamic_params.mul_mod_row_ratio
        // and that stop_ptr - begin_addr is divisible by 7.

        let memory_units = trace_length / dynamic_params.memory_units_row_ratio.into();
        assert_range_u128_le(
            4 * n_steps
                + memory_units / PUBLIC_MEMORY_FRACTION
                + 3 * pedersen_copies
                + 1 * range_check_copies
                + 2 * ecdsa_copies
                + 5 * bitwise_copies
                + 7 * ec_op_copies
                + 16 * keccak_copies
                + 6 * poseidon_copies
                + 1 * range_check96_copies
                + 7 * add_mod_copies
                + 7 * mul_mod_copies,
            memory_units,
        );

        let n_rc_units = trace_length / dynamic_params.range_check_units_row_ratio.into();
        assert_range_u128_le(
            3 * n_steps + 8 * range_check_copies + 6 * range_check96_copies + 66 * mul_mod_copies,
            n_rc_units,
        );

        let n_diluted_units = trace_length / dynamic_params.diluted_units_row_ratio.into();
        assert_range_u128_le(68 * bitwise_copies + 16384 * keccak_copies, n_diluted_units);

        if (dynamic_params.uses_keccak_builtin != 0) {
            assert_range_u128_le(16, keccak_copies);
        }

        check_asserts(dynamic_params, stark_domains);
    }
}

