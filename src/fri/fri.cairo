use core::option::OptionTrait;
use core::traits::TryInto;
use core::array::SpanTrait;
use core::traits::Destruct;
use cairo_verifier::channel::channel::ChannelTrait;
use cairo_verifier::table_commitment::{
    TableCommitment, TableCommitmentConfig, TableUnsentCommitment
};
use core::array::ArrayTrait;
use cairo_verifier::table_commitment::table_commit;
use cairo_verifier::channel::channel::Channel;
use cairo_verifier::channel::channel::{ChannelUnsentFelt, ChannelSentFelt};
use cairo_verifier::fri::fri_config::FriConfig;
use cairo_verifier::common::math;
use cairo_verifier::table_commitment::TableCommitmentWitness;
use cairo_verifier::fri::fri_first_layer::gather_first_layer_queries;
use cairo_verifier::fri::fri_group::get_fri_group;
use cairo_verifier::fri::fri_layer::FriLayerQuery;

// Commitment values for FRI. Used to generate a commitment by "reading" these values
// from the channel.
#[derive(Drop, Copy)]
struct FriUnsentCommitment {
    // Array of size n_layers - 1 containing unsent table commitments for each inner layer.
    inner_layers: Span<TableUnsentCommitment>,
    // Array of size 2**log_last_layer_degree_bound containing coefficients for the last layer
    // polynomial.
    last_layer_coefficients: Span<ChannelUnsentFelt>,
}

#[derive(Drop, Copy)]
struct FriCommitment {
    config: FriConfig,
    // Array of size n_layers - 1 containing table commitments for each inner layer.
    inner_layers: Span<TableCommitment>,
    // Array of size n_layers, of one evaluation point for each layer.
    eval_points: Span<felt252>,
    // Array of size 2**log_last_layer_degree_bound containing coefficients for the last layer
    // polynomial.
    last_layer_coefficients: Span<ChannelSentFelt>,
}

#[derive(Drop, Copy)]
struct FriDecommitment {
    // Number of queries.
    n_values: felt252,
    // Array of size n_values, containing the values of the input layer at query indices.
    values: Span<felt252>,
    // Array of size n_values, containing the field elements that correspond to the query indices
    // (See queries_to_points).
    points: Span<felt252>,
}

// A witness for the decommitment of the FRI layers over queries.
#[derive(Drop, Copy)]
struct FriWitness {
    // An array of size n_layers - 1, containing a witness for each inner layer.
    layers: Span<FriLayerWitness>,
}

// A witness for a single FRI layer. This witness is required to verify the transition from an
// inner layer to the following layer.
#[derive(Drop, Copy)]
struct FriLayerWitness {
    // Values for the sibling leaves required for decommitment.
    n_leaves: felt252,
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
    unsent_commitments: Span<TableUnsentCommitment>,
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

        commitments.append(table_commit(*(unsent_commitments.at(i)), *(configs.at(i))));
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
        config.n_layers,
        config.inner_layers,
        unsent_commitment.inner_layers,
        config.fri_step_sizes,
    );

    // Read last layer coefficients.
    let n_coefficients = math::pow(2, config.log_last_layer_degree_bound);
    let coefficients = channel
        .read_felt_vector_from_prover(unsent_commitment.last_layer_coefficients);

    FriCommitment {
        config: config,
        inner_layers: commitments.span(),
        eval_points: eval_points.span(),
        last_layer_coefficients: coefficients.span()
    }
}

fn fri_decommit_layers(
    fri_group: Span<felt252>,
    n_layers: felt252,
    commitment: Span<TableCommitment>,
    layer_witness: Span<FriLayerWitness>,
    eval_points: Span<felt252>,
    step_sizes: Span<felt252>,
    queries: Span<felt252>,
) -> Array<FriLayerQuery> {
    let last_queries = ArrayTrait::<FriLayerQuery>::new();
    let len: u32 = n_layers.try_into().unwrap();
    let mut i: u32 = 0;

    loop {
        if i == len {
            break;
        }
    //

    };

    last_queries
}

// FRI protocol component decommitment.
fn fri_decommit(
    queries: Span<felt252>,
    commitment: FriCommitment,
    decommitment: FriDecommitment,
    witness: FriWitness,
) {
    assert(queries.len().into() == decommitment.n_values, 'Invalid value');
    let fri_first_layer_evaluations = decommitment.values;

    let fri_queries = gather_first_layer_queries(
        queries, decommitment.values, decommitment.points,
    );

    let fri_group = get_fri_group();
}
