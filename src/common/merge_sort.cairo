use integrity::common::array_extend::ArrayExtendTrait;

// Merge Sort
/// # Arguments
/// * `arr` - Span to sort
/// # Returns
/// * `Array<T>` - Sorted array
fn merge_sort<T, +Copy<T>, +Drop<T>, +PartialOrd<T>>(mut arr: Span<T>) -> Array<T> {
    let mut ret: Array<T> = ArrayTrait::new();
    ret.extend(arr);

    let mut chunk = 1;
    loop {
        if chunk >= arr.len() {
            break;
        }
        let mut start = 0;
        let mut new_arr: Array<T> = ArrayTrait::new();
        loop {
            let start2 = start + chunk;
            let size2 = if start + 2 * chunk >= arr.len() {
                arr.len() - start - chunk
            } else {
                chunk
            };

            merge_arrays(arr.slice(start, chunk), arr.slice(start2, size2), ref new_arr);

            start += 2 * chunk;
            if start + chunk >= arr.len() {
                break;
            };
        };
        loop {
            if start >= arr.len() {
                break;
            };
            new_arr.append(*arr.at(start));
            start += 1;
        };
        arr = new_arr.span();
        ret = new_arr;
        chunk *= 2;
    };
    ret
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
