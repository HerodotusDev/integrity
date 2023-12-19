use core::option::OptionTrait;
use core::traits::TryInto;

use cairo_verifier::common::horner_eval;
use cairo_verifier::common::math;
use cairo_verifier::fri::fri_layer::FriLayerQuery;
// Verifies FRI last layer by evaluating the given polynomial on the given points (=inverses of
// x_inv_values), and comparing the results to the given values.
fn verify_last_layer(
    n_queries: felt252,
    queries: Span<FriLayerQuery>,
    coefficients: Span<felt252>
) {
    let mut i: u32 = 0;
    let len: u32 = n_queries.try_into().unwrap();
    loop {
        if i == len {
            break;
        }
        let value = horner_eval::horner_eval(
            coefficients, math::mul_inverse(*(queries.at(i)).x_inv_value)
        );
        assert(value == *(queries.at(i)).y_value, '');
        i += 1;
    }
}
