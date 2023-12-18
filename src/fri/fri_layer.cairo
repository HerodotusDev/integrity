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
