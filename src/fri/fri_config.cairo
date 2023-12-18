use core::option::OptionTrait;
use core::array::SpanTrait;
use core::traits::Into;
use cairo_verifier::structs::table_commitment_config::TableCommitmentConfig;

const MAX_LAST_LAYER_LOG_DEGREE_BOUND: u32 = 15;
const MAX_FRI_LAYERS: u32 = 15;
const MAX_FRI_STEP: u32 = 4;

struct FriConfig {
    // Log2 of the size of the input layer to FRI.
    log_input_size: felt252,
    // Number of layers in the FRI. Inner + last layer.
    n_layers: felt252,
    // Array of size n_layers - 1, each entry is a configuration of a table commitment for the
    // corresponding inner layer.
    inner_layers: Span<TableCommitmentConfig>,
    // Array of size n_layers, each entry represents the FRI step size,
    // i.e. the number of FRI-foldings between layer i and i+1.
    fri_step_sizes: Span<felt252>,
    log_last_layer_degree_bound: felt252,
}

fn fri_config_validate(
    config: FriConfig, log_n_cosets: felt252, n_verifier_friendly_commitment_layers: felt252
) -> felt252 {
    assert(0_u256 <= config.log_last_layer_degree_bound.into(), '');
    assert(config.log_last_layer_degree_bound.try_into().unwrap() <= MAX_LAST_LAYER_LOG_DEGREE_BOUND, '');

    assert(2_u256 <= config.n_layers.into(), '');
    assert(config.n_layers.try_into().unwrap() <= MAX_FRI_LAYERS + 1, '');

    assert(*(config.fri_step_sizes[0]) == 0, '');

    let len: u32 = config.n_layers.try_into().unwrap();
    let mut i = 0_u32;
    let mut sum_of_step_sizes: felt252 = 0;
    let mut log_input_size = config.log_input_size;
    loop {
        if i == len { break; }
        let fri_step: felt252 = *(config.fri_step_sizes.at(i));
        assert(1_u32 <= fri_step.try_into().unwrap(), '');
        assert(fri_step.try_into().unwrap() <= MAX_FRI_STEP + 1, '');
        assert((*(config.inner_layers.at(i))).columns == fri_step * fri_step, '');
        i += 1;
        log_input_size -= fri_step;
        sum_of_step_sizes += fri_step;
        // validate_vector_commitment(
        //     config=layers[0].vector,
        //     expected_height=log_input_size,
        //     n_verifier_friendly_commitment_layers=n_verifier_friendly_commitment_layers,
        // );
    };


    let log_expected_input_degree = sum_of_step_sizes + config.log_last_layer_degree_bound;
    assert(log_expected_input_degree + log_n_cosets == config.log_input_size, '');
    log_expected_input_degree
}