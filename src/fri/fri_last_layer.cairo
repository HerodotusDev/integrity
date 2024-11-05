use integrity::{common::{horner_eval, math::Felt252Div}, fri::fri_layer::FriLayerQuery};

// Verifies FRI last layer by evaluating the given polynomial on the given points
// (=inverses of x_inv_values), and comparing the results to the given values.
fn verify_last_layer(mut queries: Span<FriLayerQuery>, coefficients: Span<felt252>) {
    loop {
        match queries.pop_front() {
            Option::Some(query) => {
                assert(
                    horner_eval::horner_eval(coefficients, 1 / *query.x_inv_value) == *query
                        .y_value,
                    'Invalid value'
                );
            },
            Option::None => { break; }
        }
    }
}
