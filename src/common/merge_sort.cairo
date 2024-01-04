use cairo_verifier::common::array_split::ArraySplitTrait;
use core::debug::PrintTrait;
use cairo_verifier::common::array_print::{ArrayPrintTrait, SpanPrintTrait};

// Merge Sort
/// # Arguments
/// * `arr` - Array to sort
/// # Returns
/// * `Array<T>` - Sorted array
fn merge_sort<T, +Copy<T>, +Drop<T>, +PartialOrd<T>>(mut arr: Array<T>) -> Array<T> {
    let mut chunk = 1;
    loop {
        if chunk >= arr.len() {
            break;
        }
        let mut start = 0;
        let mut new_arr: Array<T> = ArrayTrait::new();
        let arr_span = arr.span();
        loop {
            let start2 = start + chunk;
            let size2 = if start + 2 * chunk >= arr_span.len() {
                arr_span.len() - start - chunk
            } else {
                chunk
            };

            merge_arrays(arr_span.slice(start, chunk), arr_span.slice(start2, size2), ref new_arr);

            start += 2 * chunk;
            if start + chunk >= arr_span.len() {
                break;
            };
        };
        loop {
            if start >= arr_span.len() {
                break;
            };
            new_arr.append(*arr_span.at(start));
            start += 1;
        };
        arr = new_arr;
        chunk *= 2;
    };
    arr
}

fn merge_arrays<T, +Copy<T>, +Drop<T>, +PartialOrd<T>>(
    left_arr: Span<T>, right_arr: Span<T>, ref result_arr: Array<T>,
) {
    let mut left_arr_ix = 0;
    let mut right_arr_ix = 0;

    loop {
        if left_arr_ix < left_arr.len() && right_arr_ix < right_arr.len() {
            if *left_arr.at(left_arr_ix) < *right_arr.at(right_arr_ix) {
                result_arr.append(*left_arr.at(left_arr_ix));
                left_arr_ix += 1;
            } else {
                result_arr.append(*right_arr.at(right_arr_ix));
                right_arr_ix += 1;
            }
        } else {
            break;
        }
    };

    // Append the remaining elements from left_arr, if any
    loop {
        if left_arr_ix < left_arr.len() {
            result_arr.append(*left_arr.at(left_arr_ix));
            left_arr_ix += 1;
        } else {
            break;
        }
    };

    // Append the remaining elements from right_arr, if any
    loop {
        if right_arr_ix < right_arr.len() {
            result_arr.append(*right_arr.at(right_arr_ix));
            right_arr_ix += 1;
        } else {
            break;
        }
    }
}
