use cairo_verifier::{
    table_commitment::TableCommitmentConfig,
    vector_commitment::vector_commitment::{validate_vector_commitment, VectorCommitmentConfig},
};

const MAX_LAST_LAYER_LOG_DEGREE_BOUND: u32 = 15;
const MAX_FRI_LAYERS: u32 = 15;
const MAX_FRI_STEP: u32 = 4;

#[derive(Drop, Copy)]
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
    let n_layers: u32 = config.n_layers.try_into().unwrap();
    let log_last_layer_degree_bound: u32 = config.log_last_layer_degree_bound.try_into().unwrap();

    assert(log_last_layer_degree_bound <= MAX_LAST_LAYER_LOG_DEGREE_BOUND, 'Value too big');

    assert(*config.fri_step_sizes.at(0) == 0, 'Invalid value');

    assert(n_layers >= 2, 'Value too small');
    assert(n_layers <= MAX_FRI_LAYERS + 1, 'Value too big');

    let mut i: u32 = 1;
    let mut sum_of_step_sizes: felt252 = 0;
    let mut log_input_size = config.log_input_size;
    loop {
        if i == n_layers {
            break;
        }

        let fri_step: felt252 = *config.fri_step_sizes.at(i);
        let table_commitment = *config.inner_layers.at(i);

        let fri_step_u32: u32 = fri_step.try_into().unwrap();
        assert(fri_step_u32 >= 1, 'Value too small');
        assert(fri_step_u32 <= MAX_FRI_STEP + 1, 'Value too big');
        assert(table_commitment.n_columns == fri_step * fri_step, 'Invalid value');

        i += 1;
        log_input_size -= fri_step;
        sum_of_step_sizes += fri_step;

        validate_vector_commitment(
            table_commitment.vector, log_input_size, n_verifier_friendly_commitment_layers,
        );
    };

    let log_expected_input_degree = sum_of_step_sizes + config.log_last_layer_degree_bound;
    assert(log_expected_input_degree + log_n_cosets == config.log_input_size, '');
    log_expected_input_degree
}

