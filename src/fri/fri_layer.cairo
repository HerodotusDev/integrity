use integrity::{
    common::{array_extend::ArrayExtendTrait, math::pow}, fri::fri_formula::fri_formula
};

#[derive(Drop, Copy)]
struct FriLayerComputationParams {
    coset_size: felt252,
    fri_group: Span<felt252>,
    eval_point: felt252,
}

#[derive(Drop, Copy, PartialEq, Serde)]
struct FriLayerQuery {
    index: felt252,
    y_value: felt252,
    x_inv_value: felt252,
}

// Computes the elements of the coset starting at coset_start_index.
//
// Inputs:
//   - queries: an iterator over the input queries.
//   - sibling_witness: a list of all the query's siblings.
//   - coset_size: the number of elements in the coset.
//   - coset_start_index: the index of the first element of the coset being calculated.
//   - fri_group: holds the group <g> in bit reversed order, where g is the generator of the coset.
//
// Outputs:
//   - coset_elements: the values of the coset elements.
//   - coset_x_inv: x_inv of the first element in the coset. This value is set only if at least one
//     query was consumed by this function.

fn compute_coset_elements(
    ref queries: Span<FriLayerQuery>,
    ref sibling_witness: Span<felt252>,
    coset_size: felt252,
    coset_start_index: felt252,
    fri_group: Span<felt252>,
) -> (Array<felt252>, felt252) {
    let mut coset_elements = ArrayTrait::<felt252>::new();
    let mut coset_x_inv: felt252 = 0;
    let mut i: u32 = 0;
    loop {
        if coset_size == i.into() {
            break;
        }

        let q = queries.get(0);
        if q.is_some() && *q.unwrap().unbox().index == coset_start_index + i.into() {
            let query = *queries.pop_front().unwrap();
            coset_elements.append(query.y_value);
            coset_x_inv = query.x_inv_value * (*fri_group.at(i));
        } else {
            coset_elements
                .append(*sibling_witness.pop_front().expect('invalid sibling_withness length'));
        }

        i += 1;
    };

    (coset_elements, coset_x_inv)
}

// Computes FRI next layer for the given queries. I.e., takes the given i-th layer queries
// and produces queries for layer i+1 (a single query for each coset in the i-th layer).
//
// Inputs:
//   - queries: input queries.
//   - sibling_witness: a list of all the query's siblings.
//   - params: the parameters to use for the layer computation.
//
// Outputs:
//   - next_queries: queries for the next layer.
//   - verify_indices: query indices of the given layer for Merkle verification.
//   - verify_y_values: query y values of the given layer for Merkle verification.
fn compute_next_layer(
    mut queries: Span<FriLayerQuery>,
    mut sibling_witness: Span<felt252>,
    params: FriLayerComputationParams,
) -> (Array<FriLayerQuery>, Array<felt252>, Array<felt252>) {
    let mut next_queries = ArrayTrait::<FriLayerQuery>::new();
    let mut verify_indices = ArrayTrait::<felt252>::new();
    let mut verify_y_values = ArrayTrait::<felt252>::new();

    let coset_size = params.coset_size;
    loop {
        if queries.len() == 0 {
            break;
        }

        let coset_index = (Into::<felt252, u256>::into(*queries.at(0).index)
            / Into::<felt252, u256>::into(coset_size))
            .try_into()
            .unwrap();

        verify_indices.append(coset_index);

        let (coset_elements, coset_x_inv) = compute_coset_elements(
            ref queries, ref sibling_witness, coset_size, coset_index * coset_size, params.fri_group
        );

        // Verify that at least one query was consumed.
        assert(coset_elements.len() > 0, 'Must be non negative value');

        let coset_elements_span = coset_elements.span();

        verify_y_values.extend(coset_elements_span);

        let fri_formula_res = fri_formula(
            coset_elements_span, params.eval_point, coset_x_inv, coset_size,
        );

        // Write next layer query.
        let next_x_inv = pow(coset_x_inv, params.coset_size);
        next_queries
            .append(
                FriLayerQuery {
                    index: coset_index, y_value: fri_formula_res, x_inv_value: next_x_inv
                }
            );
    };

    (next_queries, verify_indices, verify_y_values)
}
