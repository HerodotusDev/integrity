use integrity::queries::queries::usort;

#[test]
#[available_gas(9999999999)]
fn test_usort_0() {
    let unsorted: Array<u64> = array![3];
    assert(usort(unsorted.span()) == array![3], 'Invalid sorting');
}

#[test]
#[available_gas(9999999999)]
fn test_usort_1() {
    let unsorted: Array<u64> = array![];
    assert(usort(unsorted.span()) == array![], 'Invalid sorting');
}

#[test]
#[available_gas(9999999999)]
fn test_usort_2() {
    let unsorted: Array<u64> = array![742, 360, 952, 891, 634, 707, 582, 264, 806, 720];
    assert(
        usort(unsorted.span()) == array![264, 360, 582, 634, 707, 720, 742, 806, 891, 952],
        'Invalid sorting'
    );
}

#[test]
#[available_gas(9999999999)]
fn test_usort_3() {
    let unsorted: Array<u64> = array![6, 3, 4, 3, 9, 8, 0, 10, 5, 6];
    assert(usort(unsorted.span()) == array![0, 3, 4, 5, 6, 8, 9, 10], 'Invalid sorting');
}

#[test]
#[available_gas(9999999999)]
fn test_usort_4() {
    let unsorted: Array<u64> = array![3, 3, 3, 3, 3, 3, 3, 3, 3, 3];
    assert(usort(unsorted.span()) == array![3], 'Invalid sorting');
}

#[test]
#[available_gas(9999999999)]
fn test_usort_5() {
    let unsorted: Array<u64> = array![7, 3];
    assert(usort(unsorted.span()) == array![3, 7], 'Invalid sorting');
}
