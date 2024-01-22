use core::debug::PrintTrait;
use cairo_verifier::{
    common::{
        flip_endianness::FlipEndiannessTrait, array_append::ArrayAppendTrait, blake2s::blake2s,
        math::{pow, Felt252PartialOrd, Felt252Div}, asserts::assert_range_u128_le,
        array_print::SpanPrintTrait
    },
    air::{
        public_memory::{
            Page, PageTrait, ContinuousPageHeader, get_continuous_pages_product, AddrValueSize
        },
        constants
    },
    domains::StarkDomains
};
use core::{pedersen::PedersenTrait, hash::{HashStateTrait, HashStateExTrait, Hash}};

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
        hash_data
            .append_big_endian(Into::<u32, u256>::into(1 + self.continuous_page_headers.len()));

        // Main page.
        hash_data.append_big_endian(Into::<_, u256>::into(self.main_page.len()));
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

        blake2s(hash_data).flip_endianness()
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

    fn validate(self: @PublicInput, domains: @StarkDomains) {
        assert_range_u128_le(*self.log_n_steps, constants::MAX_LOG_N_STEPS);
        let n_steps = pow(2, *self.log_n_steps);
        assert(
            n_steps * constants::CPU_COMPONENT_HEIGHT == *domains.trace_domain_size,
            'Wrong trace size'
        );

        assert(0 <= *self.rc_min, 'wrong rc_min');
        assert(*self.rc_min < *self.rc_max, 'wrong rc range');
        assert(*self.rc_max <= constants::MAX_RANGE_CHECK, 'wrong rc_max');

        assert(*self.layout == constants::LAYOUT_CODE, 'wrong layout code');

        let pedersen_copies = n_steps / constants::PEDERSEN_BUILTIN_RATIO;
        let pedersen_uses = (*self.segments.at(constants::segments::PEDERSEN).stop_ptr
            - *self.segments.at(constants::segments::PEDERSEN).begin_addr)
            / 3;
        assert_range_u128_le(pedersen_uses, pedersen_copies);

        let range_check_copies = n_steps / constants::RC_BUILTIN_RATIO;
        let range_check_uses = *self.segments.at(constants::segments::RANGE_CHECK).stop_ptr
            - *self.segments.at(constants::segments::RANGE_CHECK).begin_addr;
        assert_range_u128_le(range_check_uses, range_check_copies);

        let bitwise_copies = n_steps / constants::BITWISE_RATIO;
        let bitwise_uses = (*self.segments.at(constants::segments::BITWISE).stop_ptr
            - *self.segments.at(constants::segments::BITWISE).begin_addr)
            / 5;
        assert_range_u128_le(bitwise_uses, bitwise_copies);
    }
}
