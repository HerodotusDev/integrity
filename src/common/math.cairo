fn pow(base: felt252, exp: felt252) -> felt252 {
    if exp == 0 {
        return 1; // Return 1 for zero exponent
    }
    let mut exp: u256 = exp.into();
    let mut res = 1; // Initialize result as 1
    let mut curr_base = base; // Current base value

    loop {
        if exp == 0 {
            break;
        } else {
            if exp % 2 == 1 {
                res = res * curr_base; // Multiply result only when exp is odd
            }
            curr_base = curr_base * curr_base; // Square the base for next iteration
            exp = exp / 2; // Divide exponent by 2
        }
    };

    res
}
