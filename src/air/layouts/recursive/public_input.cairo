use core::array::SpanTrait;
use core::array::ArrayTrait;
use cairo_verifier::{
    common::{
        math::{pow, Felt252PartialOrd, Felt252Div},
        asserts::{assert_range_u128_le, assert_range_u128},
    },
    air::{
        public_memory::{Page, PageTrait},
        constants::{MAX_ADDRESS, INITIAL_PC, MAX_LOG_N_STEPS, MAX_RANGE_CHECK},
        layouts::recursive::constants::{
            segments, get_builtins, CPU_COMPONENT_HEIGHT, CPU_COMPONENT_STEP, LAYOUT_CODE,
            PEDERSEN_BUILTIN_ROW_RATIO, RANGE_CHECK_BUILTIN_ROW_RATIO, BITWISE_ROW_RATIO
        },
        public_input::{PublicInput, PublicInputTrait}
    },
    domains::StarkDomains
};

use core::{pedersen::PedersenTrait, hash::{HashStateTrait, HashStateExTrait, Hash}};
use poseidon::poseidon_hash_span;

impl RecursivePublicInputImpl of PublicInputTrait {
    fn verify(self: @PublicInput) -> (felt252, felt252) {
        let public_segments = self.segments;

        let initial_pc = *public_segments.at(segments::PROGRAM).begin_addr;
        let initial_ap = *public_segments.at(segments::EXECUTION).begin_addr;
        let final_ap = *public_segments.at(segments::EXECUTION).stop_ptr;
        let output_start = *public_segments.at(segments::OUTPUT).begin_addr;
        let output_stop = *public_segments.at(segments::OUTPUT).stop_ptr;

        let output_len: u32 = (output_stop - output_start).try_into().unwrap();

        assert(initial_ap < MAX_ADDRESS, 'Invalid initial_ap');
        assert(final_ap < MAX_ADDRESS, 'Invalid final_ap');

        assert(self.continuous_page_headers.len() == 0, 'Invalid continuous_page_headers');

        let public_memory = self.main_page;

        // 1. Program segment
        assert(initial_pc == INITIAL_PC, 'Invalid initial_pc');

        let program = public_memory
            .extract_range(initial_pc.try_into().unwrap(), public_memory.len() - output_len);

        let program_hash = poseidon_hash_span(program.span());

        // 3. Output segment 
        let output_len: u32 = (output_stop - output_start).try_into().unwrap();
        let output = public_memory.extract_range(public_memory.len() - output_len, output_len);
        let output_hash = poseidon_hash_span(output.span());

        (program_hash, output_hash)
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

        let bitwise_copies = trace_length / BITWISE_ROW_RATIO;
        let bitwise_uses = (*self.segments.at(segments::BITWISE).stop_ptr
            - *self.segments.at(segments::BITWISE).begin_addr)
            / 5;
        assert_range_u128_le(bitwise_uses, bitwise_copies);
    }
}

