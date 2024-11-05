use integrity::{
    common::{
        math::{pow, Felt252PartialOrd, Felt252Div},
        asserts::{assert_range_u128_le, assert_range_u128},
    },
    air::{
        public_memory::{Page, PageTrait},
        constants::{MAX_ADDRESS, INITIAL_PC, MAX_LOG_N_STEPS, MAX_RANGE_CHECK},
        layouts::starknet::constants::{
            segments, get_builtins, CPU_COMPONENT_HEIGHT, CPU_COMPONENT_STEP, LAYOUT_CODE,
            PEDERSEN_BUILTIN_ROW_RATIO, RANGE_CHECK_BUILTIN_ROW_RATIO, BITWISE_ROW_RATIO,
            ECDSA_BUILTIN_ROW_RATIO, EC_OP_BUILTIN_ROW_RATIO, POSEIDON_ROW_RATIO
        },
        public_input::{PublicInput, PublicInputTrait, verify_cairo1_public_input}
    },
    domains::StarkDomains
};

use core::{pedersen::PedersenTrait, hash::{HashStateTrait, HashStateExTrait, Hash}};
use poseidon::poseidon_hash_span;

impl StarknetPublicInputImpl of PublicInputTrait {
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

        let builtins = get_builtins();
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
        assert(*program[1] == builtins.len().into(), 'Invalid program');
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
        let mut i = 0;
        let builtins_len = builtins.len();
        loop {
            if i == builtins_len {
                break;
            }

            begin_addresses.append(*public_segments.at(2 + i).begin_addr);
            stop_addresses.append(*public_segments.at(2 + i).stop_ptr);

            i += 1;
        };
        memory.verify_stack(initial_ap, begin_addresses.span(), builtins_len, ref memory_index);
        memory
            .verify_stack(
                final_ap - builtins_len.into(),
                stop_addresses.span(),
                builtins_len,
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
        assert_range_u128_le(*self.log_n_steps, MAX_LOG_N_STEPS);
        let n_steps = pow(2, *self.log_n_steps);
        let trace_length = *stark_domains.trace_domain_size;
        assert(
            n_steps * CPU_COMPONENT_HEIGHT * CPU_COMPONENT_STEP == trace_length, 'Wrong trace size'
        );

        assert(0 <= *self.range_check_min, 'wrong rc_min');
        assert(*self.range_check_min < *self.range_check_max, 'wrong rc range');
        assert(*self.range_check_max <= MAX_RANGE_CHECK, 'wrong rc_max');

        assert(*self.layout == LAYOUT_CODE, 'wrong layout code');

        let output_uses = (*self.segments.at(segments::OUTPUT).stop_ptr
            - *self.segments.at(segments::OUTPUT).begin_addr);
        assert_range_u128(output_uses);

        let pedersen_copies = trace_length / PEDERSEN_BUILTIN_ROW_RATIO;
        let pedersen_uses = (*self.segments.at(segments::PEDERSEN).stop_ptr
            - *self.segments.at(segments::PEDERSEN).begin_addr)
            / 3;
        assert_range_u128_le(pedersen_uses, pedersen_copies);

        let range_check_copies = trace_length / RANGE_CHECK_BUILTIN_ROW_RATIO;
        let range_check_uses = *self.segments.at(segments::RANGE_CHECK).stop_ptr
            - *self.segments.at(segments::RANGE_CHECK).begin_addr;
        assert_range_u128_le(range_check_uses, range_check_copies);

        let ecdsa_copies = trace_length / ECDSA_BUILTIN_ROW_RATIO;
        let ecdsa_uses = (*self.segments.at(segments::ECDSA).stop_ptr
            - *self.segments.at(segments::ECDSA).begin_addr)
            / 2;
        assert_range_u128_le(ecdsa_uses, ecdsa_copies);

        let bitwise_copies = trace_length / BITWISE_ROW_RATIO;
        let bitwise_uses = (*self.segments.at(segments::BITWISE).stop_ptr
            - *self.segments.at(segments::BITWISE).begin_addr)
            / 5;
        assert_range_u128_le(bitwise_uses, bitwise_copies);

        let ec_op_copies = trace_length / EC_OP_BUILTIN_ROW_RATIO;
        let ec_op_uses = (*self.segments.at(segments::EC_OP).stop_ptr
            - *self.segments.at(segments::EC_OP).begin_addr)
            / 7;
        assert_range_u128_le(ec_op_uses, ec_op_copies);

        let poseidon_copies = trace_length / POSEIDON_ROW_RATIO;
        let poseidon_uses = (*self.segments.at(segments::POSEIDON).stop_ptr
            - *self.segments.at(segments::POSEIDON).begin_addr)
            / 6;
        assert_range_u128_le(poseidon_uses, poseidon_copies);
    }
}

