use cairo_verifier::common::consts::STARK_PRIME_MINUS_TWO;

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

impl Felt252Div of Div<felt252> {
    fn div(lhs: felt252, rhs: felt252) -> felt252 {
        let lhs_u256: u256 = lhs.into();
        let rhs_u256: u256 = rhs.into();
        (lhs_u256 / rhs_u256).try_into().unwrap()
    }
}

impl Felt252PartialOrd of PartialOrd<felt252> {
    fn le(lhs: felt252, rhs: felt252) -> bool {
        let lhs_u256: u256 = lhs.into();
        let rhs_u256: u256 = rhs.into();
        lhs <= rhs
    }

    fn ge(lhs: felt252, rhs: felt252) -> bool {
        let lhs_u256: u256 = lhs.into();
        let rhs_u256: u256 = rhs.into();
        lhs >= rhs
    }

    fn lt(lhs: felt252, rhs: felt252) -> bool {
        let lhs_u256: u256 = lhs.into();
        let rhs_u256: u256 = rhs.into();
        lhs < rhs
    }

    fn gt(lhs: felt252, rhs: felt252) -> bool {
        let lhs_u256: u256 = lhs.into();
        let rhs_u256: u256 = rhs.into();
        lhs > rhs
    }
}
