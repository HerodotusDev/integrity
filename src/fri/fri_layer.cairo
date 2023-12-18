use core::array::SpanTrait;
use core::array::ArrayTrait;

// Constant parameters for computing the next FRI layer.
struct FriLayerComputationParams {
    coset_size: felt252,
    fri_group: Span<felt252>,
    eval_point: felt252,
}

struct FriLayerQuery {
    index: felt252,
    y_value: felt252,
    x_inv_value: felt252,
}

// Computes the elements of the coset starting at coset_start_index.
//
// Inputs:
//   - n_queries: the number of input queries.
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
    mut n_queries: felt252,
    queries: Span<FriLayerQuery>,
    sibling_witness: Span<felt252>,
    coset_size: felt252,
    coset_start_index: felt252,
    mut offset_within_coset: felt252,
    fri_group: Span<felt252>,
) -> (Array<felt252>, felt252) {
    let mut coset_elements = ArrayTrait::<felt252>::new();
    let mut coset_x_inv: felt252 = 1;

    let mut i: u32 = 0;
    let mut j: u32 = 0;

    loop {
        if offset_within_coset == coset_size {
            break;
        }

        if n_queries != 0 && *(queries.at(i)).index == coset_start_index + offset_within_coset {
            coset_elements.append(*(queries.at(i)).y_value);
            coset_x_inv = (*(queries.at(i)).x_inv_value) * (*(fri_group.at(i)));
            n_queries -= 1;
            i += 1;
        } else {
            coset_elements.append(*(sibling_witness.at(j)));
            j += 1;
        }
    };

    (coset_elements, coset_x_inv)
}
