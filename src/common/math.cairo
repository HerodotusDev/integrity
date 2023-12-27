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
