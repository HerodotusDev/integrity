// `horner_eval` is a function that evaluates a polynomial at a given point using Horner's method.
// `coefs` is an array of coefficients representing the polynomial in the format a0, a1, a2, ... an.
// `point` is the value at which the polynomial will be evaluated.
// The function returns the polynomial evaluation as `felt252`.

fn horner_eval(mut coefs: Span<felt252>, point: felt252) -> felt252 {
    let mut res = 0;
    loop {
        match coefs.pop_back() {
            Option::Some(coef) => { res = *coef + point * res; },
            Option::None => { break; }
        }
    };
    res
}
