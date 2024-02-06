use core::{pedersen::PedersenTrait, hash::{HashStateTrait, HashStateExTrait, Hash}};
use cairo_verifier::{
    common::{
        flip_endianness::FlipEndiannessTrait, array_append::ArrayAppendTrait,
        math::{pow, Felt252PartialOrd, Felt252Div}, asserts::assert_range_u128_le,
        array_print::SpanPrintTrait, hash::hash_felts,
    },
    air::{
        public_memory::{
            Page, PageTrait, ContinuousPageHeader, get_continuous_pages_product, AddrValueSize
        },
        constants::{
            segments, MAX_ADDRESS, get_builtins, INITIAL_PC, MAX_LOG_N_STEPS, CPU_COMPONENT_HEIGHT,
            MAX_RANGE_CHECK, LAYOUT_CODE, PEDERSEN_BUILTIN_RATIO, RC_BUILTIN_RATIO, BITWISE_RATIO
        }
    },
    domains::StarkDomains
};


#[derive(Drop, Copy, PartialEq)]
struct SegmentInfo {
    // Start address of the memory segment.
    begin_addr: felt252,
    // Stop pointer of the segment - not necessarily the end of the segment.
    stop_ptr: felt252,
}

#[derive(Drop, PartialEq)]
struct PublicInput {
    log_n_steps: felt252,
    rc_min: felt252,
    rc_max: felt252,
    layout: felt252,
    dynamic_params: Array<felt252>,
    segments: Array<SegmentInfo>,
    padding_addr: felt252,
    padding_value: felt252,
    main_page: Page,
    continuous_page_headers: Array<ContinuousPageHeader>
}

#[generate_trait]
impl PublicInputImpl of PublicInputTrait {
    // Computes the hash of the public input, which is used as the initial seed for the Fiat-Shamir heuristic.
    fn get_public_input_hash(self: @PublicInput) -> u256 {
        // Main page hash.
        let mut main_page_hash_state = PedersenTrait::new(0);
        let mut i: u32 = 0;
        loop {
            if i == self.main_page.len() {
                break;
            }
            main_page_hash_state = main_page_hash_state.update_with(*self.main_page.at(i));
            i += 1;
        };
        main_page_hash_state = main_page_hash_state
            .update_with(AddrValueSize * self.main_page.len());
        let main_page_hash = main_page_hash_state.finalize();

        let mut hash_data = ArrayTrait::<u64>::new();
        ArrayAppendTrait::<_, u256>::append_big_endian(ref hash_data, (*self.log_n_steps).into());
        ArrayAppendTrait::<_, u256>::append_big_endian(ref hash_data, (*self.rc_min).into());
        ArrayAppendTrait::<_, u256>::append_big_endian(ref hash_data, (*self.rc_max).into());
        ArrayAppendTrait::<_, u256>::append_big_endian(ref hash_data, (*self.layout).into());

        // Dynamic params.
        let mut i: u32 = 0;
        loop {
            if i == self.dynamic_params.len() {
                break;
            }

            ArrayAppendTrait::<
                _, u256
            >::append_big_endian(ref hash_data, (*self.dynamic_params.at(i)).into());

            i += 1;
        };

        // Segments.
        let mut i: u32 = 0;
        loop {
            if i == self.segments.len() {
                break;
            }

            let segment = *self.segments.at(i);
            ArrayAppendTrait::<
                _, u256
            >::append_big_endian(ref hash_data, segment.begin_addr.into());
            ArrayAppendTrait::<_, u256>::append_big_endian(ref hash_data, segment.stop_ptr.into());

            i += 1;
        };

        ArrayAppendTrait::<_, u256>::append_big_endian(ref hash_data, (*self.padding_addr).into());
        ArrayAppendTrait::<_, u256>::append_big_endian(ref hash_data, (*self.padding_value).into());
        ArrayAppendTrait::<
            _, u256
        >::append_big_endian(ref hash_data, 1 + self.continuous_page_headers.len().into());

        // Main page.
        ArrayAppendTrait::<_, u256>::append_big_endian(ref hash_data, self.main_page.len().into());
        ArrayAppendTrait::<_, u256>::append_big_endian(ref hash_data, main_page_hash.into());

        // Add the rest of the pages.
        let mut i: u32 = 0;
        loop {
            if i == self.continuous_page_headers.len() {
                break;
            }

            let continuous_page = *self.continuous_page_headers.at(i);
            ArrayAppendTrait::<
                _, u256
            >::append_big_endian(ref hash_data, continuous_page.start_address.into());
            ArrayAppendTrait::<
                _, u256
            >::append_big_endian(ref hash_data, continuous_page.size.into());
            ArrayAppendTrait::<_, u256>::append_big_endian(ref hash_data, continuous_page.hash);

            i += 1;
        };

        keccak::cairo_keccak(ref hash_data, 0, 0).flip_endianness()
    }

    // Returns the ratio between the product of all public memory cells and z^|public_memory|.
    // This is the value that needs to be at the memory__multi_column_perm__perm__public_memory_prod
    // member expression.
    fn get_public_memory_product_ratio(
        self: @PublicInput, z: felt252, alpha: felt252, public_memory_column_size: felt252
    ) -> felt252 {
        let (pages_product, total_length) = self.get_public_memory_product(z, alpha);

        // Pad and divide
        let numerator = pow(z, public_memory_column_size);
        let padded = z - (*self.padding_addr + alpha * *self.padding_value);

        assert(total_length <= public_memory_column_size, 'Invalid length');
        let denominator_pad = pow(padded, public_memory_column_size - total_length);

        numerator / pages_product / denominator_pad
    }

    // Returns the product of all public memory cells.
    fn get_public_memory_product(
        self: @PublicInput, z: felt252, alpha: felt252
    ) -> (felt252, felt252) {
        let main_page_prod = self.main_page.get_product(z, alpha);

        let (continuous_pages_prod, continuous_pages_total_length) = get_continuous_pages_product(
            self.continuous_page_headers.span(),
        );

        let prod = main_page_prod * continuous_pages_prod;
        let total_length = (self.main_page.len()).into() + continuous_pages_total_length;

        (prod, total_length)
    }

    fn verify(self: @PublicInput) -> (felt252, felt252) {
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
            .extract_range(initial_pc.try_into().unwrap(), program_len.try_into().unwrap());
        memory_index += program.len().into();

        assert(
            *program[0] == 0x40780017fff7fff, 'Invalid program'
        ); // Instruction: ap += N_BUILTINS.
        assert(*program[1] == builtins.len().into(), 'Invalid program');
        assert(*program[2] == 0x1104800180018000, 'Invalid program'); // Instruction: call rel ?.
        assert(*program[4] == 0x10780017fff7fff, 'Invalid program'); // Instruction: jmp rel 0.
        assert(*program[5] == 0x0, 'Invalid program');

        let program_hash = hash_felts(program);

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
        memory
            .verify_stack(
                initial_ap, *public_segments.at(2).begin_addr, builtins.span(), memory_index.into()
            );
        memory_index += builtins.len();

        memory
            .verify_stack(
                final_ap - builtins.len().into(),
                *public_segments.at(2).stop_ptr,
                builtins.span(),
                memory_index.into()
            );
        memory_index += builtins.len();

        // 3. Output segment 
        let output_len = output_stop - output_start;
        let output = memory
            .extract_range(
                memory_index + output_start.try_into().unwrap(), output_len.try_into().unwrap()
            );
        memory_index += output.len().into();
        let output_hash = hash_felts(output);

        // Check main page len
        assert(
            *memory.at(memory_index) == *self.main_page.at(self.main_page.len() - 1),
            'Invalid main page len'
        );

        (program_hash, output_hash)
    }

    fn validate(self: @PublicInput, domains: @StarkDomains) {
        assert_range_u128_le(*self.log_n_steps, MAX_LOG_N_STEPS);
        let n_steps = pow(2, *self.log_n_steps);
        assert(n_steps * CPU_COMPONENT_HEIGHT == *domains.trace_domain_size, 'Wrong trace size');

        assert(0 <= *self.rc_min, 'wrong rc_min');
        assert(*self.rc_min < *self.rc_max, 'wrong rc range');
        assert(*self.rc_max <= MAX_RANGE_CHECK, 'wrong rc_max');

        assert(*self.layout == LAYOUT_CODE, 'wrong layout code');

        let pedersen_copies = n_steps / PEDERSEN_BUILTIN_RATIO;
        let pedersen_uses = (*self.segments.at(segments::PEDERSEN).stop_ptr
            - *self.segments.at(segments::PEDERSEN).begin_addr)
            / 3;
        assert_range_u128_le(pedersen_uses, pedersen_copies);

        let range_check_copies = n_steps / RC_BUILTIN_RATIO;
        let range_check_uses = *self.segments.at(segments::RANGE_CHECK).stop_ptr
            - *self.segments.at(segments::RANGE_CHECK).begin_addr;
        assert_range_u128_le(range_check_uses, range_check_copies);

        let bitwise_copies = n_steps / BITWISE_RATIO;
        let bitwise_uses = (*self.segments.at(segments::BITWISE).stop_ptr
            - *self.segments.at(segments::BITWISE).begin_addr)
            / 5;
        assert_range_u128_le(bitwise_uses, bitwise_copies);
    }
}

