use integrity::common::merge_sort::merge_sort;


#[test]
#[available_gas(9999999999)]
fn test_merge_sort_0() {
    assert(merge_sort(ArrayTrait::<u32>::new().span()) == ArrayTrait::<u32>::new(), 'merge_sort_0');
}

#[test]
#[available_gas(9999999999)]
fn test_merge_sort_1() {
    let input: Array<u32> = array![1237];
    assert(merge_sort(input.span()) == array![1237], 'merge_sort_1');
}

#[test]
#[available_gas(9999999999)]
fn test_merge_sort_2_sorted() {
    let input: Array<u32> = array![1237, 82139];
    assert(merge_sort(input.span()) == array![1237, 82139], 'merge_sort_2_sorted');
}

#[test]
#[available_gas(9999999999)]
fn test_merge_sort_2_unsorted() {
    let input: Array<u32> = array![82139, 1237];
    assert(merge_sort(input.span()) == array![1237, 82139], 'merge_sort_2_unsorted');
}

#[test]
#[available_gas(9999999999)]
fn test_merge_sort_3_reversed() {
    let input: Array<u32> = array![3, 2, 1];
    let output: Array<u32> = array![1, 2, 3];
    assert(merge_sort(input.span()) == output, 'merge_sort_3_reversed');
}

#[test]
#[available_gas(9999999999)]
fn test_merge_sort_4_reversed() {
    let input: Array<u32> = array![4, 3, 2, 1];
    let output: Array<u32> = array![1, 2, 3, 4];
    assert(merge_sort(input.span()) == output, 'merge_sort_4_reversed');
}

#[test]
#[available_gas(9999999999)]
fn test_merge_sort_5_reversed() {
    let input: Array<u32> = array![5, 4, 3, 2, 1];
    let output: Array<u32> = array![1, 2, 3, 4, 5];
    assert(merge_sort(input.span()) == output, 'merge_sort_5_reversed');
}

#[test]
#[available_gas(9999999999)]
fn test_merge_sort_6_reversed() {
    let input: Array<u32> = array![6, 5, 4, 3, 2, 1];
    let output: Array<u32> = array![1, 2, 3, 4, 5, 6];
    assert(merge_sort(input.span()) == output, 'merge_sort_6_reversed');
}

#[test]
#[available_gas(9999999999)]
fn test_merge_sort_7_reversed() {
    let input: Array<u32> = array![7, 6, 5, 4, 3, 2, 1];
    let output: Array<u32> = array![1, 2, 3, 4, 5, 6, 7];
    assert(merge_sort(input.span()) == output, 'merge_sort_7_reversed');
}

#[test]
#[available_gas(9999999999)]
fn test_merge_sort_8_reversed() {
    let input: Array<u32> = array![8, 7, 6, 5, 4, 3, 2, 1];
    let output: Array<u32> = array![1, 2, 3, 4, 5, 6, 7, 8];
    assert(merge_sort(input.span()) == output, 'merge_sort_8_reversed');
}

#[test]
#[available_gas(9999999999)]
fn test_merge_sort_9_reversed() {
    let input: Array<u32> = array![9, 8, 7, 6, 5, 4, 3, 2, 1];
    let output: Array<u32> = array![1, 2, 3, 4, 5, 6, 7, 8, 9];
    assert(merge_sort(input.span()) == output, 'merge_sort_9_reversed');
}

#[test]
#[available_gas(9999999999)]
fn test_merge_sort_10_reversed() {
    let input: Array<u32> = array![10, 9, 8, 7, 6, 5, 4, 3, 2, 1];
    let output: Array<u32> = array![1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    assert(merge_sort(input.span()) == output, 'merge_sort_10_reversed');
}

#[test]
#[available_gas(9999999999)]
fn test_merge_sort_10_random() {
    let input: Array<u32> = array![4, 2, 1, 5, 9, 10, 3, 6, 7, 8];
    let output: Array<u32> = array![1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    assert(merge_sort(input.span()) == output, 'merge_sort_10_random');
}

#[test]
#[available_gas(9999999999)]
fn test_merge_sort_27_random() {
    let input: Array<u32> = array![
        621290948,
        2994746375,
        4267084068,
        2172276725,
        1768815408,
        1620432111,
        3166011562,
        2001001936,
        1175674986,
        1562533906,
        621290948,
        4228656862,
        3821919331,
        464203079,
        3255422109,
        2843280039,
        1999048941,
        2994746375,
        1441727094,
        2865010309,
        2128601099,
        3064403147,
        3847279920,
        3901384727,
        1315473168,
        397120964,
        4155302219,
        598760305,
        3087811260
    ];
    let output: Array<u32> = array![
        397120964,
        464203079,
        598760305,
        621290948,
        621290948,
        1175674986,
        1315473168,
        1441727094,
        1562533906,
        1620432111,
        1768815408,
        1999048941,
        2001001936,
        2128601099,
        2172276725,
        2843280039,
        2865010309,
        2994746375,
        2994746375,
        3064403147,
        3087811260,
        3166011562,
        3255422109,
        3821919331,
        3847279920,
        3901384727,
        4155302219,
        4228656862,
        4267084068
    ];
    assert(merge_sort(input.span()) == output, 'merge_sort_27_random');
}
