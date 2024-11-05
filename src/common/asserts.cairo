use integrity::common::math::Felt252PartialOrd;

fn assert_in_range(x: felt252, min: felt252, max: felt252) {
    assert(min <= x, 'Value too small');
    assert(x < max, 'Value too large');
}

// Verifies that 0 <= x < RANGE_CHECK_BOUND
fn assert_range_u128(x: felt252) {
    assert(TryInto::<felt252, u128>::try_into(x).is_some(), 'range check failed');
}

fn assert_range_u128_le(x: felt252, max: felt252) {
    assert_range_u128(x);
    assert(x <= max, 'range check failed');
}
