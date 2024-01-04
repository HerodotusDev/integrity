use cairo_verifier::common::consts::STARK_PRIME_MINUS_TWO;
use core::traits::TryInto;

fn pow(base: felt252, exp: felt252) -> felt252 {
    if exp == 0 {
        return 1;
    }
    let mut exp: u256 = exp.into();
    let mut res = 1;
    let mut curr_base = base;

    loop {
        if exp == 0 {
            break;
        } else {
            if exp % 2 == 1 {
                res = res * curr_base;
            }
            curr_base = curr_base * curr_base;
            exp = exp / 2;
        }
    };
    res
}

fn mul_inverse(x: felt252) -> felt252 {
    // From Fermat's little theorem, a ^ (p - 1) = 1 when p is prime and a != 0. Since a ^ (p - 1) = a · a ^ (p - 2) we have that 
    // a ^ (p - 2) is the multiplicative inverse of a modulo p.
    pow(x, STARK_PRIME_MINUS_TWO)
}

// Verifies that 0 <= x < RANGE_CHECK_BOUND
fn assert_range_u128(x: felt252) {
    assert(TryInto::<felt252, u128>::try_into(x).is_some(), 'range check failed');
}

impl Felt252Div of Div<felt252> {
    fn div(lhs: felt252, rhs: felt252) -> felt252 {
        (Into::<felt252, u256>::into(lhs) / Into::<felt252, u256>::into(rhs)).try_into().unwrap()
    }
}

fn div_rem2(lhs: felt252,) -> (felt252, felt252) {
    let lhs: u256 = lhs.into();
    let quotient = lhs / 2;
    let remainder = lhs - (quotient * 2);
    (quotient.try_into().unwrap(), remainder.try_into().unwrap())
}

impl Felt252PartialOrd of PartialOrd<felt252> {
    fn le(lhs: felt252, rhs: felt252) -> bool {
        Into::<felt252, u256>::into(lhs) <= Into::<felt252, u256>::into(rhs)
    }

    fn ge(lhs: felt252, rhs: felt252) -> bool {
        Into::<felt252, u256>::into(lhs) >= Into::<felt252, u256>::into(rhs)
    }

    fn lt(lhs: felt252, rhs: felt252) -> bool {
        Into::<felt252, u256>::into(lhs) < Into::<felt252, u256>::into(rhs)
    }

    fn gt(lhs: felt252, rhs: felt252) -> bool {
        Into::<felt252, u256>::into(lhs) > Into::<felt252, u256>::into(rhs)
    }
}
