use cairo_verifier::{
    abstract_air::public_memory::{Page, ContinuousPageHeader}, domains::StarkDomains
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

trait PublicInputTrait {
    fn get_public_input_hash(self: @PublicInput) -> u256;
    fn get_public_memory_product_ratio(
        self: @PublicInput, z: felt252, alpha: felt252, public_memory_column_size: felt252
    ) -> felt252;
    fn get_public_memory_product(
        self: @PublicInput, z: felt252, alpha: felt252
    ) -> (felt252, felt252);
    fn verify(self: @PublicInput) -> (felt252, felt252);
    fn validate(self: @PublicInput, domains: @StarkDomains);
}
