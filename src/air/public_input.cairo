use integrity::{
    domains::StarkDomains, air::constants::{MAX_ADDRESS, INITIAL_PC},
    air::public_memory::{
        Page, PageTrait, ContinuousPageHeader, get_continuous_pages_product, AddrValueSize
    },
    common::{
        array_extend::ArrayExtend, array_append::ArrayAppendTrait,
        math::{pow, Felt252PartialOrd, Felt252Div},
    },
    settings::{StoneVersion, VerifierSettings},
};
use core::{pedersen::PedersenTrait, hash::{HashStateTrait, HashStateExTrait, Hash}};
use poseidon::poseidon_hash_span;
#[cfg(feature: 'dex')]
use integrity::air::layouts::dex::constants::segments;
#[cfg(feature: 'recursive')]
use integrity::air::layouts::recursive::constants::segments;
#[cfg(feature: 'recursive_with_poseidon')]
use integrity::air::layouts::recursive_with_poseidon::constants::segments;
#[cfg(feature: 'small')]
use integrity::air::layouts::small::constants::segments;
#[cfg(feature: 'starknet')]
use integrity::air::layouts::starknet::constants::segments;
#[cfg(feature: 'starknet_with_keccak')]
use integrity::air::layouts::starknet_with_keccak::constants::segments;


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
    fn verify_cairo0(self: @PublicInput) -> (felt252, felt252);
    fn verify_cairo1(self: @PublicInput) -> (felt252, felt252);
    fn validate(self: @PublicInput, stark_domains: @StarkDomains);
}

// Computes the hash of the public input, which is used as the initial seed for the Fiat-Shamir
// heuristic.
fn get_public_input_hash(
    public_input: @PublicInput,
    n_verifier_friendly_commitment_layers: felt252,
    settings: @VerifierSettings,
) -> felt252 {
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

    if *settings.stone_version == StoneVersion::Stone6 {
        hash_data.append(n_verifier_friendly_commitment_layers);
    }
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

fn verify_cairo1_public_input(public_input: @PublicInput) -> (felt252, felt252) {
    let public_segments = public_input.segments;

    let initial_pc = *public_segments.at(segments::PROGRAM).begin_addr;
    let initial_ap = *public_segments.at(segments::EXECUTION).begin_addr;
    let final_ap = *public_segments.at(segments::EXECUTION).stop_ptr;
    let output_start = *public_segments.at(segments::OUTPUT).begin_addr;
    let output_stop = *public_segments.at(segments::OUTPUT).stop_ptr;
    let output_len: u32 = (output_stop - output_start).try_into().unwrap();

    assert(initial_ap < MAX_ADDRESS, 'Invalid initial_ap');
    assert(final_ap < MAX_ADDRESS, 'Invalid final_ap');

    // TODO support continuous memory pages
    assert(public_input.continuous_page_headers.len() == 0, 'Invalid continuous_page_headers');

    let memory = public_input.main_page;

    // 1. Program segment
    assert(initial_pc == INITIAL_PC, 'Invalid initial_pc');
    let program = memory.extract_range_unchecked(0, memory.len() - output_len);
    let program_hash = poseidon_hash_span(program);

    // 2. Output segment
    let output = memory.extract_range_unchecked(memory.len() - output_len, output_len);
    let output_hash = poseidon_hash_span(output);
    (program_hash, output_hash)
}


#[cfg(feature: 'recursive')]
#[cfg(test)]
mod tests {
    use super::get_public_input_hash;
    use integrity::tests::stone_proof_fibonacci_keccak::public_input::get;
    use integrity::settings::{VerifierSettings, CairoVersion, HasherBitLength, StoneVersion};
    #[test]
    #[available_gas(9999999999)]
    fn test_get_public_input_hash() {
        let settings = VerifierSettings {
            cairo_version: CairoVersion::Cairo1,
            hasher_bit_length: HasherBitLength::Lsb160,
            stone_version: StoneVersion::Stone5,
        };
        let public_input = get();
        let hash = get_public_input_hash(@public_input, 0, @settings);
        assert(
            hash == 0xaf91f2c71f4a594b1575d258ce82464475c82d8fb244142d0db450491c1b52, 'Hash invalid'
        )
    }
}
