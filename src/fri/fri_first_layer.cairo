use integrity::{
    common::{consts::FIELD_GENERATOR_INVERSE, math::Felt252Div}, fri::fri_layer::FriLayerQuery,
};

fn gather_first_layer_queries(
    queries: Span<felt252>, evaluations: Span<felt252>, x_values: Span<felt252>
) -> Array<FriLayerQuery> {
    let mut fri_queries = ArrayTrait::<FriLayerQuery>::new();

    let len: u32 = queries.len();
    let mut i: u32 = 0;
    loop {
        if i == len {
            break;
        }

        // Translate the coset to the homogenous group to have simple FRI equations.
        let shifted_x_value = (*x_values.at(i)) * FIELD_GENERATOR_INVERSE;

        fri_queries
            .append(
                FriLayerQuery {
                    index: *queries.at(i),
                    y_value: *evaluations.at(i),
                    x_inv_value: 1 / shifted_x_value,
                }
            );

        i += 1;
    };

    fri_queries
}
