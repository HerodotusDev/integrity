use cairo_verifier::common::array_extend::ArrayExtendTrait;
use core::box::BoxTrait;
use core::debug::PrintTrait;
use core::option::OptionTrait;
use core::traits::TryInto;
use core::traits::Into;
use core::array::SpanTrait;
use core::array::ArrayTrait;
use cairo_verifier::fri::fri_formula::fri_formula;
use cairo_verifier::common::math;

#[derive(Drop, Copy)]
struct FriLayerComputationParams {
    coset_size: felt252,
    fri_group: Span<felt252>,
    eval_point: felt252,
}

#[derive(Drop, Copy, PartialEq)]
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
//   - offset_within_coset: the offset of the current processed element within the coset.
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
    mut offset_within_coset: felt252,
    fri_group: Span<felt252>,
) -> (Array<felt252>, felt252) {
    let mut coset_elements = ArrayTrait::<felt252>::new();
    let mut coset_x_inv: felt252 = 0;
    let mut i: u32 = 0;
    loop {
        if offset_within_coset == coset_size {
            break;
        }

        match queries.get(0) {
            Option::Some(q) => {
                if *q.unbox().index == coset_start_index + offset_within_coset {
                    let query = *queries.pop_front().unwrap();
                    coset_elements.append(query.y_value);
                    coset_x_inv = (query.x_inv_value) * (*fri_group.at(i));
                } else {
                    coset_elements.append(*sibling_witness.pop_front().unwrap());
                }
            },
            Option::None => { coset_elements.append(*sibling_witness.pop_front().unwrap()); },
        }

        i += 1;
        offset_within_coset += 1;
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

        let index_u256: u256 = (*queries.at(0).index).into();
        let coset_size_u256: u256 = coset_size.into();

        let coset_index = (index_u256 / coset_size_u256).low.into();
        assert(coset_index.into() >= 0_u256, 'Must be non negative value');

        verify_indices.append(coset_index);

        let (coset_elements, coset_x_inv) = compute_coset_elements(
            ref queries,
            ref sibling_witness,
            coset_size,
            coset_index * coset_size,
            0,
            params.fri_group
        );

        // Verify that at least one query was consumed.
        let coset_elements_len = coset_elements.len();
        assert(coset_elements_len >= 0, 'Must be non negative value');

        let coset_elements_span = coset_elements.span();

        verify_y_values.extend(coset_elements_span);

        let fri_formula_res = fri_formula(
            coset_elements_span, params.eval_point, coset_x_inv, coset_size,
        );

        // Write next layer query.
        let next_x_inv = math::pow(coset_x_inv, params.coset_size);
        next_queries
            .append(
                FriLayerQuery {
                    index: coset_index, y_value: fri_formula_res, x_inv_value: next_x_inv
                }
            );
    };

    (next_queries, verify_indices, verify_y_values)
}
