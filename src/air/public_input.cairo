use cairo_verifier::{
    common::{
        flip_endianness::FlipEndiannessTrait, array_append::ArrayAppendTrait, blake2s::blake2s,
        math::{pow, Felt252PartialOrd, Felt252Div}
    },
    air::public_memory::{Page, PageTrait, ContinuousPageHeader, get_continuous_pages_product}
};
use cairo_verifier::common::math::{pow, Felt252PartialOrd, Felt252Div};
use cairo_verifier::common::hash::hash_felts;
use cairo_verifier::air::constants::{segments, MAX_ADDRESS, get_builtins, INITIAL_PC};
use core::{pedersen::PedersenTrait, hash::{HashStateTrait, HashStateExTrait, Hash}};

#[derive(Drop, Copy)]
struct SegmentInfo {
    // Start address of the memory segment.
    begin_addr: felt252,
    // Stop pointer of the segment - not necessarily the end of the segment.
    stop_ptr: felt252,
}

#[derive(Drop)]
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

            let page = *self.main_page.at(i);
            main_page_hash_state = main_page_hash_state.update_with((page.address, page.value));

            i += 1;
        };

        let mut hash_data = ArrayTrait::<u32>::new();
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
        hash_data.append(1 + self.continuous_page_headers.len());

        // Main page.
        hash_data.append(self.main_page.len());
        ArrayAppendTrait::<
            _, u256
        >::append_big_endian(ref hash_data, main_page_hash_state.finalize().into());

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

        blake2s(hash_data)
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
        assert((*self.continuous_page_headers).len() == 0, 'Invalid continuous_page_headers');

        let builtins = get_builtins();
        let memory = self.main_page;

        // 1. Program segment
        assert(initial_pc == INITIAL_PC, 'Invalid initial_pc');
        assert(final_pc == INITIAL_PC + 4, 'Invalid final_pc');

        let mut memory_index: usize = 0;

        let program_end_pc = initial_fp - 2;
        let program_len = program_end_pc - initial_pc;
        let program = memory.extract_range(initial_pc, program_len);
        memory_index += program_len.try_into().unwrap();

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
        let output = memory
            .extract_range(memory_index.into() + output_start, output_stop - output_start);
        memory_index += (output_stop - output_start).try_into().unwrap();
        let output_hash = hash_felts(output);

        // Check main page len
        assert(
            *memory.at(memory_index) == *self.main_page.at(self.main_page.len() - 1),
            'Invalid main page len'
        );

        (program_hash, output_hash)
    }
}

