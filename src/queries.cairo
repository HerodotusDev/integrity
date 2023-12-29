use core::option::OptionTrait;
use core::traits::TryInto;
use core::array::ArrayTrait;
use cairo_verifier::channel::channel::Channel;
use cairo_verifier::common::merge_sort::merge_sort;

fn generate_queries() {}

fn sample_random_queries(
    ref channel: Channel, n_samples: u32, query_upper_bound: felt252
) -> Array<felt252> {
    let result = ArrayTrait::<felt252>::new();

    result
}

// Sorts an array of field elements and removes duplicates.
// Returns the sorted array.
fn usort<T, +Copy<T>, +Drop<T>, +PartialOrd<T>, +PartialEq<T>>(input: Array<T>) -> Array<T> {
    if input.len() == 0 || input.len() == 1 {
        return input;
    }

    let mut result = ArrayTrait::<T>::new();

    let sorted = merge_sort(input);

    let mut prev = *sorted.at(0);
    result.append(prev);

    let mut i: u32 = 1;
    loop {
        if i == sorted.len() {
            break;
        }

        let curr = *sorted.at(i);
        if curr != prev {
            result.append(curr);
            prev = curr;
        }

        i += 1;
    };

    result
}


#[test]
#[available_gas(9999999999)]
fn test_usort_0() {
    let unsorted: Array<u128> = array![3];
    assert(usort(unsorted) == array![3], 'Invalid sorting');
}

#[test]
#[available_gas(9999999999)]
fn test_usort_1() {
    let unsorted: Array<u128> = array![];
    assert(usort(unsorted) == array![], 'Invalid sorting');
}

#[test]
#[available_gas(9999999999)]
fn test_usort_2() {
    let unsorted: Array<u128> = array![742, 360, 952, 891, 634, 707, 582, 264, 806, 720];
    assert(
        usort(unsorted) == array![264, 360, 582, 634, 707, 720, 742, 806, 891, 952],
        'Invalid sorting'
    );
}

#[test]
#[available_gas(9999999999)]
fn test_usort_3() {
    let unsorted: Array<u128> = array![6, 3, 4, 3, 9, 8, 0, 10, 5, 6];
    assert(usort(unsorted) == array![0, 3, 4, 5, 6, 8, 9, 10], 'Invalid sorting');
}

#[test]
#[available_gas(9999999999)]
fn test_usort_4() {
    let unsorted: Array<u128> = array![3, 3, 3, 3, 3, 3, 3, 3, 3, 3];
    assert(usort(unsorted) == array![3], 'Invalid sorting');
}

#[test]
#[available_gas(9999999999)]
fn test_usort_5() {
    let unsorted: Array<u128> = array![7, 3];
    assert(usort(unsorted) == array![3, 7], 'Invalid sorting');
}