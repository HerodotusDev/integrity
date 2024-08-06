use cairo_verifier::{
    common::math::pow, channel::channel::{Channel, ChannelTrait},
    fri::{
        fri_config::FriConfig, fri_first_layer::gather_first_layer_queries,
        fri_group::get_fri_group,
        fri_layer::{FriLayerQuery, FriLayerComputationParams, compute_next_layer},
        fri_last_layer::verify_last_layer,
    },
    table_commitment::table_commitment::{
        TableCommitmentWitness, TableDecommitment, TableCommitment, TableCommitmentConfig,
        table_commit, table_decommit
    }
};

// Commitment values for FRI. Used to generate a commitment by "reading" these values
// from the channel.
#[derive(Drop, Copy, Serde)]
struct FriUnsentCommitment {
    // Array of size n_layers - 1 containing unsent table commitments for each inner layer.
    inner_layers: Span<felt252>,
    // Array of size 2**log_last_layer_degree_bound containing coefficients for the last layer
    // polynomial.
    last_layer_coefficients: Span<felt252>,
}

#[derive(Drop, Copy, PartialEq, Serde)]
struct FriCommitment {
    config: FriConfig,
    // Array of size n_layers - 1 containing table commitments for each inner layer.
    inner_layers: Span<TableCommitment>,
    // Array of size n_layers, of one evaluation point for each layer.
    eval_points: Span<felt252>,
    // Array of size 2**log_last_layer_degree_bound containing coefficients for the last layer
    // polynomial.
    last_layer_coefficients: Span<felt252>,
}

#[derive(Drop, Copy, Serde)]
struct FriDecommitment {
    // Array of size n_values, containing the values of the input layer at query indices.
    values: Span<felt252>,
    // Array of size n_values, containing the field elements that correspond to the query indices
    // (See queries_to_points).
    points: Span<felt252>,
}

// A witness for the decommitment of the FRI layers over queries.
#[derive(Drop, Copy, Serde)]
struct FriWitness {
    // An array of size n_layers - 1, containing a witness for each inner layer.
    layers: Span<FriLayerWitness>,
}

// A witness for a single FRI layer. This witness is required to verify the transition from an
// inner layer to the following layer.
#[derive(Drop, Copy, Serde)]
struct FriLayerWitness {
    // Values for the sibling leaves required for decommitment.
    leaves: Span<felt252>,
    // Table commitment witnesses for decommiting all the leaves.
    table_witness: TableCommitmentWitness,
}

// A FRI phase with N layers starts with a single input layer.
// Afterwards, there are N - 1 inner layers resulting from FRI-folding each preceding layer.
// Each such layer has a separate table commitment, for a total of N - 1 commitments.
// Lastly, there is another FRI-folding resulting in the last FRI layer, that is commited by
// sending the polynomial coefficients, instead of a table commitment.
// Each folding has a step size.
// Illustration:
// InputLayer, no commitment.
//   fold step 0
// InnerLayer 0, Table commitment
//   fold step 1
// ...
// InnerLayer N - 2, Table commitment
//   fold step N - 1
// LastLayer, Polynomial coefficients
//
// N steps.
// N - 1 inner layers.

// Performs FRI commitment phase rounds. Each round reads a commitment on a layer, and sends an
// evaluation point for the next round.
fn fri_commit_rounds(
    ref channel: Channel,
    n_layers: felt252,
    configs: Span<TableCommitmentConfig>,
    unsent_commitments: Span<felt252>,
    step_sizes: Span<felt252>,
) -> (Array<TableCommitment>, Array<felt252>) {
    let mut commitments = ArrayTrait::<TableCommitment>::new();
    let mut eval_points = ArrayTrait::<felt252>::new();

    let mut i: u32 = 0;
    let len: u32 = n_layers.try_into().unwrap();
    loop {
        if i == len {
            break;
        }
        // Read commitments.
        commitments.append(table_commit(ref channel, *unsent_commitments.at(i), *configs.at(i)));
        // Send the next eval_points.
        eval_points.append(channel.random_felt_to_prover());

        i += 1;
    };

    (commitments, eval_points)
}

fn fri_commit(
    ref channel: Channel, unsent_commitment: FriUnsentCommitment, config: FriConfig
) -> FriCommitment {
    assert((*config.fri_step_sizes.at(0)) == 0, 'Invalid value');

    let (commitments, eval_points) = fri_commit_rounds(
        ref channel,
        config.n_layers - 1,
        config.inner_layers,
        unsent_commitment.inner_layers,
        config.fri_step_sizes,
    );

    // Read last layer coefficients.
    channel.read_felt_vector_from_prover(unsent_commitment.last_layer_coefficients);
    let coefficients = unsent_commitment.last_layer_coefficients;

    assert(
        pow(2, config.log_last_layer_degree_bound) == coefficients.len().into(), 'Invalid value'
    );

    FriCommitment {
        config: config,
        inner_layers: commitments.span(),
        eval_points: eval_points.span(),
        last_layer_coefficients: coefficients
    }
}

fn fri_verify_layer_step(
    queries: Span<FriLayerQuery>,
    step_size: felt252,
    eval_point: felt252,
    commitment: TableCommitment,
    layer_witness: FriLayerWitness,
) -> Array<FriLayerQuery> {
    // Compute fri_group.
    let fri_group = get_fri_group().span();

    // Params.
    let coset_size = pow(2, step_size);
    let params = FriLayerComputationParams {
        coset_size, fri_group, eval_point: eval_point
    };

    // Compute next layer queries.
    let (next_queries, verify_indices, verify_y_values) = compute_next_layer(
        queries, layer_witness.leaves, params
    );

    // Table decommitment.
    table_decommit(
        commitment,
        verify_indices.span(),
        TableDecommitment { values: verify_y_values.span() },
        layer_witness.table_witness
    );

    next_queries
}

fn fri_verify_layers(
    n_layers: felt252,
    commitment: Span<TableCommitment>,
    layer_witness: Span<FriLayerWitness>,
    eval_points: Span<felt252>,
    step_sizes: Span<felt252>,
    mut queries: Array<FriLayerQuery>,
) -> Array<FriLayerQuery> {
    let len: u32 = n_layers.try_into().unwrap();
    let mut i: u32 = 0;

    loop {
        if i == len {
            break;
        }

        let step_size = *step_sizes.at(i);
        let eval_point = *eval_points.at(i);
        let single_commitment = *commitment.at(i);
        let single_layer_witness = *layer_witness.at(i);
        // queries

        queries = fri_verify_layer_step(
            queries.span(),
            step_size,
            eval_point,
            single_commitment,
            single_layer_witness,
        );

        i += 1;
    };

    queries
}

// FRI protocol component decommitment.
fn fri_verify(
    queries: Span<felt252>,
    commitment: FriCommitment,
    decommitment: FriDecommitment,
    witness: FriWitness,
) {
    assert(queries.len() == decommitment.values.len(), 'Invalid value');

    // Compute first FRI layer queries.
    let fri_queries = gather_first_layer_queries(
        queries, decommitment.values, decommitment.points,
    );


    // Verify inner layers.
    let last_queries = fri_verify_layers(
        commitment.config.n_layers - 1,
        commitment.inner_layers,
        witness.layers,
        commitment.eval_points,
        commitment.config.fri_step_sizes.slice(1, commitment.config.fri_step_sizes.len() - 1),
        fri_queries,
    );

    // Last layer.
    assert(
        commitment
            .last_layer_coefficients
            .len()
            .into() == pow(2, commitment.config.log_last_layer_degree_bound),
        'Invlid value'
    );
    verify_last_layer(last_queries.span(), commitment.last_layer_coefficients);
}
