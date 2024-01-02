use cairo_verifier::{channel::channel::{Channel, ChannelTrait}, common::merge_sort::merge_sort};

// 2^64 = 18446744073709551616
const U128maxU64: u128 = 18446744073709551616;

fn generate_queries(
    ref channel: Channel, n_samples: u32, query_upper_bound: u64
) -> Array<felt252> {
    let samples = sample_random_queries(ref channel, n_samples, query_upper_bound);
    usort(samples)
}

fn sample_random_queries(
    ref channel: Channel, n_samples: u32, query_upper_bound: u64
) -> Array<u64> {
    let mut result = ArrayTrait::<u64>::new();

    // Samples are generated in quadruplets. We generate ceil(n_samples / 4) samples
    let (mut n_quad, rem) = DivRem::div_rem(n_samples, 4_u32.try_into().unwrap());
    if rem != 0 {
        n_quad += 1;
    }

    let u64_modulus_nonzero: NonZero<u128> = U128maxU64.try_into().unwrap();
    let query_upper_bound_nonzero: NonZero<u64> = query_upper_bound.try_into().unwrap();

    loop {
        if n_quad == 0 {
            break;
        }

        let res = channel.random_uint256_to_prover();

        let (hh, hl) = DivRem::div_rem(res.high, u64_modulus_nonzero);
        let (lh, ll) = DivRem::div_rem(res.low, u64_modulus_nonzero);
        let (_, r0) = DivRem::div_rem(hh.try_into().unwrap(), query_upper_bound_nonzero);
        let (_, r1) = DivRem::div_rem(hl.try_into().unwrap(), query_upper_bound_nonzero);
        let (_, r2) = DivRem::div_rem(lh.try_into().unwrap(), query_upper_bound_nonzero);
        let (_, r3) = DivRem::div_rem(ll.try_into().unwrap(), query_upper_bound_nonzero);

        result.append(r0);
        result.append(r1);
        result.append(r2);
        result.append(r3);

        n_quad -= 1;
    };

    result
}

// Sorts an array of field elements and removes duplicates.
// Returns the sorted array.
fn usort(input: Array<u64>) -> Array<felt252> {
    let mut result = ArrayTrait::<felt252>::new();

    if input.len() == 0 {
        return result;
    }

    let sorted = merge_sort(input);

    let mut prev = *sorted.at(0);
    result.append(prev.into());

    let mut i: u32 = 1;
    loop {
        if i == sorted.len() {
            break;
        }

        let curr = *sorted.at(i);
        if curr != prev {
            result.append(curr.into());
            prev = curr;
        }

        i += 1;
    };

    result
}


#[test]
#[available_gas(9999999999)]
fn test_usort_0() {
    let unsorted: Array<u64> = array![3];
    assert(usort(unsorted) == array![3], 'Invalid sorting');
}

#[test]
#[available_gas(9999999999)]
fn test_usort_1() {
    let unsorted: Array<u64> = array![];
    assert(usort(unsorted) == array![], 'Invalid sorting');
}

#[test]
#[available_gas(9999999999)]
fn test_usort_2() {
    let unsorted: Array<u64> = array![742, 360, 952, 891, 634, 707, 582, 264, 806, 720];
    assert(
        usort(unsorted) == array![264, 360, 582, 634, 707, 720, 742, 806, 891, 952],
        'Invalid sorting'
    );
}

#[test]
#[available_gas(9999999999)]
fn test_usort_3() {
    let unsorted: Array<u64> = array![6, 3, 4, 3, 9, 8, 0, 10, 5, 6];
    assert(usort(unsorted) == array![0, 3, 4, 5, 6, 8, 9, 10], 'Invalid sorting');
}

#[test]
#[available_gas(9999999999)]
fn test_usort_4() {
    let unsorted: Array<u64> = array![3, 3, 3, 3, 3, 3, 3, 3, 3, 3];
    assert(usort(unsorted) == array![3], 'Invalid sorting');
}

#[test]
#[available_gas(9999999999)]
fn test_usort_5() {
    let unsorted: Array<u64> = array![7, 3];
    assert(usort(unsorted) == array![3, 7], 'Invalid sorting');
}

#[test]
#[available_gas(9999999999)]
fn test_sample_random_queries_1() {
    let mut channel = ChannelTrait::new(
        u256 { low: 0xf7685ebd40e852b164633a4acbd3244c, high: 0xe8e77626586f73b955364c7b4bbf0bb7 }
    );
    let queries = sample_random_queries(ref channel, 1, 12389012333);
    assert(queries.len() == 4, 'Invalid value');
    assert(*queries.at(0) == 0xc53fdd1e, 'Invalid value');
    assert(*queries.at(1) == 0x166d56d3d, 'Invalid value');
    assert(*queries.at(2) == 0x1e563d10b, 'Invalid value');
    assert(*queries.at(3) == 0x2d9a2434f, 'Invalid value');
}

#[test]
#[available_gas(9999999999)]
fn test_sample_random_queries_2() {
    let mut channel = ChannelTrait::new(
        u256 { low: 0xf7685ebd40e852b164633a4acbd3244c, high: 0xe8e77626586f73b955364c7b4bbf0bb7 }
    );
    let queries = sample_random_queries(ref channel, 10, 99809818624);
    assert(queries.len() == 12, 'Invalid value');
    assert(*queries.at(0) == 0x1405a07e8c, 'Invalid value');
    assert(*queries.at(1) == 0x982d6fc79, 'Invalid value');
    assert(*queries.at(2) == 0x6188b67d1, 'Invalid value');
    assert(*queries.at(3) == 0xa733f8ed8, 'Invalid value');
    assert(*queries.at(4) == 0x557cce2e5, 'Invalid value');
    assert(*queries.at(5) == 0xbf23e4bf7, 'Invalid value');
    assert(*queries.at(6) == 0x3247d4098, 'Invalid value');
    assert(*queries.at(7) == 0xca83fb21d, 'Invalid value');
    assert(*queries.at(8) == 0xc2321969b, 'Invalid value');
    assert(*queries.at(9) == 0x52d896136, 'Invalid value');
    assert(*queries.at(10) == 0xe4da8dce0, 'Invalid value');
    assert(*queries.at(11) == 0x8cf7e0675, 'Invalid value');
}

#[test]
#[available_gas(9999999999)]
fn test_generate_queries_1() {
    let mut channel = ChannelTrait::new(
        u256 { low: 0xf7685ebd40e852b164633a4acbd3244c, high: 0xe8e77626586f73b955364c7b4bbf0bb7 }
    );
    let queries = generate_queries(ref channel, 1, 12389012333);
    assert(queries.len() == 4, 'Invalid value');
    assert(*queries.at(0) == 0xc53fdd1e, 'Invalid value');
    assert(*queries.at(1) == 0x166d56d3d, 'Invalid value');
    assert(*queries.at(2) == 0x1e563d10b, 'Invalid value');
    assert(*queries.at(3) == 0x2d9a2434f, 'Invalid value');
}

#[test]
#[available_gas(9999999999)]
fn test_generate_queries_2() {
    let mut channel = ChannelTrait::new(
        u256 { low: 0xf7685ebd40e852b164633a4acbd3244c, high: 0xe8e77626586f73b955364c7b4bbf0bb7 }
    );
    let queries = generate_queries(ref channel, 10, 99809818624);
    assert(queries.len() == 12, 'Invalid value');
    assert(*queries.at(0) == 0x3247d4098, 'Invalid value');
    assert(*queries.at(1) == 0x52d896136, 'Invalid value');
    assert(*queries.at(2) == 0x557cce2e5, 'Invalid value');
    assert(*queries.at(3) == 0x6188b67d1, 'Invalid value');
    assert(*queries.at(4) == 0x8cf7e0675, 'Invalid value');
    assert(*queries.at(5) == 0x982d6fc79, 'Invalid value');
    assert(*queries.at(6) == 0xa733f8ed8, 'Invalid value');
    assert(*queries.at(7) == 0xbf23e4bf7, 'Invalid value');
    assert(*queries.at(8) == 0xc2321969b, 'Invalid value');
    assert(*queries.at(9) == 0xca83fb21d, 'Invalid value');
    assert(*queries.at(10) == 0xe4da8dce0, 'Invalid value');
    assert(*queries.at(11) == 0x1405a07e8c, 'Invalid value');
}
