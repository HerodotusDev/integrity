use cairo_verifier::common::merge_sort::merge_sort;


#[test]
#[available_gas(9999999999)]
fn test_merge_sort_0() {
    assert(merge_sort(ArrayTrait::<u32>::new()) == ArrayTrait::<u32>::new(), 'merge_sort_0');
}

#[test]
#[available_gas(9999999999)]
fn test_merge_sort_1() {
    let input: Array<u32> = array![1237];
    assert(merge_sort(input) == array![1237], 'merge_sort_1');
}

#[test]
#[available_gas(9999999999)]
fn test_merge_sort_2_sorted() {
    let input: Array<u32> = array![1237, 82139];
    assert(merge_sort(input) == array![1237, 82139], 'merge_sort_2_sorted');
}

#[test]
#[available_gas(9999999999)]
fn test_merge_sort_2_unsorted() {
    let input: Array<u32> = array![82139, 1237];
    assert(merge_sort(input) == array![1237, 82139], 'merge_sort_2_unsorted');
}

#[test]
#[available_gas(9999999999)]
fn test_merge_sort_3_reversed() {
    let input: Array<u32> = array![3, 2, 1];
    let output: Array<u32> = array![1, 2, 3];
    assert(merge_sort(input) == output, 'merge_sort_3_reversed');
}

#[test]
#[available_gas(9999999999)]
fn test_merge_sort_4_reversed() {
    let input: Array<u32> = array![4, 3, 2, 1];
    let output: Array<u32> = array![1, 2, 3, 4];
    assert(merge_sort(input) == output, 'merge_sort_4_reversed');
}

#[test]
#[available_gas(9999999999)]
fn test_merge_sort_5_reversed() {
    let input: Array<u32> = array![5, 4, 3, 2, 1];
    let output: Array<u32> = array![1, 2, 3, 4, 5];
    assert(merge_sort(input) == output, 'merge_sort_5_reversed');
}

#[test]
#[available_gas(9999999999)]
fn test_merge_sort_6_reversed() {
    let input: Array<u32> = array![6, 5, 4, 3, 2, 1];
    let output: Array<u32> = array![1, 2, 3, 4, 5, 6];
    assert(merge_sort(input) == output, 'merge_sort_6_reversed');
}

#[test]
#[available_gas(9999999999)]
fn test_merge_sort_7_reversed() {
    let input: Array<u32> = array![7, 6, 5, 4, 3, 2, 1];
    let output: Array<u32> = array![1, 2, 3, 4, 5, 6, 7];
    assert(merge_sort(input) == output, 'merge_sort_7_reversed');
}

#[test]
#[available_gas(9999999999)]
fn test_merge_sort_8_reversed() {
    let input: Array<u32> = array![8, 7, 6, 5, 4, 3, 2, 1];
    let output: Array<u32> = array![1, 2, 3, 4, 5, 6, 7, 8];
    assert(merge_sort(input) == output, 'merge_sort_8_reversed');
}

#[test]
#[available_gas(9999999999)]
fn test_merge_sort_9_reversed() {
    let input: Array<u32> = array![9, 8, 7, 6, 5, 4, 3, 2, 1];
    let output: Array<u32> = array![1, 2, 3, 4, 5, 6, 7, 8, 9];
    assert(merge_sort(input) == output, 'merge_sort_9_reversed');
}

#[test]
#[available_gas(9999999999)]
fn test_merge_sort_10_reversed() {
    let input: Array<u32> = array![10, 9, 8, 7, 6, 5, 4, 3, 2, 1];
    let output: Array<u32> = array![1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    assert(merge_sort(input) == output, 'merge_sort_10_reversed');
}

#[test]
#[available_gas(9999999999)]
fn test_merge_sort_10_random() {
    let input: Array<u32> = array![4, 2, 1, 5, 9, 10, 3, 6, 7, 8];
    let output: Array<u32> = array![1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    assert(merge_sort(input) == output, 'merge_sort_10_random');
}
