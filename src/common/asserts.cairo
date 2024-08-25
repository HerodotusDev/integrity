use core::integer::U128BitAnd;
use cairo_verifier::common::math::Felt252PartialOrd;

fn assert_in_range(x: felt252, min: felt252, max: felt252) {
    assert(min <= x, 'Value too small');
    assert(x < max, 'Value too large');
}

// Verifies that 0 <= x < RANGE_CHECK_BOUND
fn assert_range_u128(x: felt252) {
    assert(TryInto::<felt252, u128>::try_into(x).is_some(), 'range check failed');
}

// Verifies that 0 <= x < RANGE_CHECK_BOUND
fn assert_range_u128_from_u256(x: u256) {
    assert(TryInto::<u256, u128>::try_into(x).is_some(), 'range check failed');
}

fn assert_range_u128_le(x: felt252, max: felt252) {
    assert_range_u128(x);
    assert(x <= max, 'range check failed');
}

fn assert_is_power_of_2(x: u128) {
    assert(U128BitAnd::bitand(x, x-1) == 0, 'Value is not pow of 2');
}