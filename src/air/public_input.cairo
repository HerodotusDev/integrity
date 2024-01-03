use cairo_verifier::{
    common::{
        flip_endianness::FlipEndiannessTrait, array_append::ArrayAppendTrait, blake2s::blake2s,
        math::{pow, Felt252PartialOrd, Felt252Div}
    },
    air::public_memory::{Page, PageTrait, ContinuousPageHeader, get_continuous_pages_product}
};
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
        let mut hash_state = PedersenTrait::new(0);
        let mut i: u32 = 0;
        loop {
            if i == self.main_page.len() {
                break;
            }
            let page = *self.main_page.at(i);
            hash_state = hash_state.update_with((page.address, page.value));
            i += 1;
        };

        let main_page_hash = hash_state.finalize();

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
        };

        ArrayAppendTrait::<_, u256>::append_big_endian(ref hash_data, (*self.padding_addr).into());
        ArrayAppendTrait::<_, u256>::append_big_endian(ref hash_data, (*self.padding_value).into());
        hash_data.append((1 + self.continuous_page_headers.len()).flip_endianness());

        // Main page.
        hash_data.append(self.main_page.len().flip_endianness());
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
}
