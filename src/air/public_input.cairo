use cairo_verifier::{
    air::public_memory::{
        Page, PageTrait, ContinuousPageHeader, get_continuous_pages_product, AddrValueSize
    },
    domains::StarkDomains,
    common::{
        array_extend::ArrayExtend, array_append::ArrayAppendTrait,
        math::{pow, Felt252PartialOrd, Felt252Div},
    },
};

use core::{pedersen::PedersenTrait, hash::{HashStateTrait, HashStateExTrait, Hash}};
use poseidon::poseidon_hash_span;

#[derive(Drop, Copy, PartialEq, Serde)]
struct SegmentInfo {
    // Start address of the memory segment.
    begin_addr: felt252,
    // Stop pointer of the segment - not necessarily the end of the segment.
    stop_ptr: felt252,
}

#[derive(Drop, PartialEq, Serde)]
struct PublicInput {
    log_n_steps: felt252,
    range_check_min: felt252,
    range_check_max: felt252,
    layout: felt252,
    dynamic_params: Array<felt252>,
    segments: Array<SegmentInfo>,
    padding_addr: felt252,
    padding_value: felt252,
    main_page: Page,
    continuous_page_headers: Array<ContinuousPageHeader>
}

trait PublicInputTrait {
    fn verify(self: @PublicInput) -> (felt252, felt252);
    fn validate(self: @PublicInput, stark_domains: @StarkDomains);
}

// Computes the hash of the public input, which is used as the initial seed for the Fiat-Shamir heuristic.
fn get_public_input_hash(public_input: @PublicInput) -> felt252 {
    // Main page hash.
    let mut main_page_hash_state = PedersenTrait::new(0);
    let mut i: u32 = 0;
    loop {
        if i == public_input.main_page.len() {
            break;
        }
        main_page_hash_state = main_page_hash_state.update_with(*public_input.main_page.at(i));
        i += 1;
    };
    main_page_hash_state = main_page_hash_state
        .update_with(AddrValueSize * public_input.main_page.len());
    let main_page_hash = main_page_hash_state.finalize();

    let mut hash_data = ArrayTrait::<felt252>::new();
    hash_data.append(*public_input.log_n_steps);
    hash_data.append(*public_input.range_check_min);
    hash_data.append(*public_input.range_check_max);
    hash_data.append(*public_input.layout);
    hash_data.extend(public_input.dynamic_params.span());

    // Segments.
    let mut segments = public_input.segments.span();
    loop {
        match segments.pop_front() {
            Option::Some(seg) => {
                hash_data.append(*seg.begin_addr);
                hash_data.append(*seg.stop_ptr);
            },
            Option::None => { break; }
        }
    };

    hash_data.append(*public_input.padding_addr);
    hash_data.append(*public_input.padding_value);
    hash_data.append(1 + public_input.continuous_page_headers.len().into());

    // Main page.
    hash_data.append(public_input.main_page.len().into());
    hash_data.append(main_page_hash);

    // Add the rest of the pages.
    let mut continuous_page_headers = public_input.continuous_page_headers.span();
    loop {
        match continuous_page_headers.pop_front() {
            Option::Some(continuous_page) => {
                hash_data.append(*continuous_page.start_address);
                hash_data.append(*continuous_page.size);
                hash_data.append(*continuous_page.hash);
            },
            Option::None => { break; }
        }
    };

    poseidon_hash_span(hash_data.span())
}

// Returns the ratio between the product of all public memory cells and z^|public_memory|.
// This is the value that needs to be at the memory__multi_column_perm__perm__public_memory_prod
// member expression.
fn get_public_memory_product_ratio(
    public_input: @PublicInput, z: felt252, alpha: felt252, public_memory_column_size: felt252
) -> felt252 {
    let (pages_product, total_length) = get_public_memory_product(public_input, z, alpha);

    // Pad and divide
    let numerator = pow(z, public_memory_column_size);
    let padded = z - (*public_input.padding_addr + alpha * *public_input.padding_value);

    assert(total_length <= public_memory_column_size, 'Invalid length');
    let denominator_pad = pow(padded, public_memory_column_size - total_length);

    numerator / pages_product / denominator_pad
}

// Returns the product of all public memory cells.
fn get_public_memory_product(
    public_input: @PublicInput, z: felt252, alpha: felt252
) -> (felt252, felt252) {
    let main_page_prod = public_input.main_page.get_product(z, alpha);

    let (continuous_pages_prod, continuous_pages_total_length) = get_continuous_pages_product(
        public_input.continuous_page_headers.span(),
    );

    let prod = main_page_prod * continuous_pages_prod;
    let total_length = (public_input.main_page.len()).into() + continuous_pages_total_length;

    (prod, total_length)
}
