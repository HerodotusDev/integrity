fn horner_eval(coefs: Array<felt252>, point: felt252) -> felt252 {
    let mut res = 0;
    let mut i = coefs.len();
    loop {
        if i > 0 {
            i -= 1;
            res = *coefs.at(i) + point * res;
        } else { break; }
    };
    res
}
