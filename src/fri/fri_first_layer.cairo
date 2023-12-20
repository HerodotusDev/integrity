use core::array::SpanTrait;
use core::option::OptionTrait;
use core::array::ArrayTrait;
use core::traits::TryInto;

use cairo_verifier::common::math;
use cairo_verifier::fri::fri_layer::FriLayerQuery;
use cairo_verifier::FIELD_GENERATOR_INV;

fn gather_first_layer_queries(
    n_queries: felt252, queries: Span<felt252>, evaluations: Span<felt252>, x_values: Span<felt252>
) {
    let mut fri_queries = ArrayTrait::<FriLayerQuery>::new();

    let len: u32 = n_queries.try_into().unwrap();
    let mut i: u32 = 0;
    loop {
        if i == len {
            break;
        }

        // Translate the coset to the homogenous group to have simple FRI equations.
        let shifted_x_value = *(x_values.at(i)) * FIELD_GENERATOR_INV;

        fri_queries
            .append(
                FriLayerQuery {
                    index: *(queries.at(i)),
                    y_value: *(evaluations.at(i)),
                    x_inv_value: math::mul_inverse(shifted_x_value),
                }
            );

        i += 1;
    }
}
