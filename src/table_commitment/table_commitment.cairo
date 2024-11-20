use integrity::{
    common::{
        flip_endianness::FlipEndiannessTrait, array_append::ArrayAppendTrait,
        math::Felt252PartialOrd, consts::MONTGOMERY_R, hasher::hash_truncated,
    },
    vector_commitment::vector_commitment::{
        VectorCommitmentConfig, VectorCommitment, VectorCommitmentWitness, vector_commit,
        VectorQuery, vector_commitment_decommit
    },
    channel::channel::Channel, settings::VerifierSettings,
};
use poseidon::poseidon_hash_span;


// Commitment for a table (n_rows x n_columns) of field elements in montgomery form.
#[derive(Drop, Copy, PartialEq, Serde)]
struct TableCommitment {
    config: TableCommitmentConfig,
    vector_commitment: VectorCommitment,
}

#[derive(Drop, Copy, PartialEq, Serde)]
struct TableCommitmentConfig {
    n_columns: felt252,
    vector: VectorCommitmentConfig,
}

// Responses for queries to the table commitment.
// Each query corresponds to a full row of the table.
#[derive(Drop, Copy, Serde)]
struct TableDecommitment {
    // n_columns * n_queries values to decommit.
    values: Span<felt252>,
}

// Witness for a decommitment over queries.
#[derive(Drop, Copy, Serde)]
struct TableCommitmentWitness {
    vector: VectorCommitmentWitness,
}

fn table_commit(
    ref channel: Channel, unsent_commitment: felt252, config: TableCommitmentConfig
) -> TableCommitment {
    let vector_commitment = vector_commit(ref channel, unsent_commitment, config.vector);
    TableCommitment { config: config, vector_commitment: vector_commitment, }
}

// Decommits a TableCommitment at multiple indices.
// rows must be sorted and unique.
// Args:
// commitment - the table commitment.
// n_queries - number of queries to decommit.
// queries - the claimed indices.
// decommitment - the claimed values at those indices.
// witness - the decommitment witness.
fn table_decommit(
    commitment: TableCommitment,
    queries: Span<felt252>,
    decommitment: TableDecommitment,
    witness: TableCommitmentWitness,
    settings: @VerifierSettings,
) {
    let n_queries: felt252 = queries.len().into();

    // Determine if the table commitment should use a verifier friendly hash function for the bottom
    // layer. The other layers' hash function will be determined in the vector_commitment logic.
    let n_verifier_friendly_layers = commitment
        .vector_commitment
        .config
        .n_verifier_friendly_commitment_layers;

    // An extra layer is added to the height since the table is considered as a layer, which is not
    // included in vector_commitment.config.
    let bottom_layer_depth = commitment.vector_commitment.config.height + 1;
    let is_bottom_layer_verifier_friendly = n_verifier_friendly_layers >= bottom_layer_depth;

    // Must have at least 1 column
    let n_columns = commitment.config.n_columns;
    assert(n_columns >= 1, 'Must have at least 1 column');

    assert(
        decommitment.values.len().into() == n_queries * n_columns, 'Invalid decommitment length'
    );

    // Convert decommitment values to Montgomery form, since the commitment is in that form.
    let montgomery_values = to_montgomery(decommitment.values);

    // Generate queries to the underlying vector commitment.
    let vector_queries = generate_vector_queries(
        queries,
        montgomery_values.span(),
        n_columns.try_into().unwrap(),
        is_bottom_layer_verifier_friendly,
        settings,
    );

    vector_commitment_decommit(
        commitment.vector_commitment, vector_queries.span(), witness.vector, settings
    );
}

fn to_montgomery(mut arr: Span<felt252>) -> Array<felt252> {
    let mut res = ArrayTrait::new();
    loop {
        match arr.pop_front() {
            Option::Some(elem) => { res.append(*elem * MONTGOMERY_R); },
            Option::None => { break; }
        }
    };
    res
}

fn generate_vector_queries(
    queries: Span<felt252>,
    values: Span<felt252>,
    n_columns: u32,
    is_verifier_friendly: bool,
    settings: @VerifierSettings
) -> Array<VectorQuery> {
    let queries_len = queries.len();
    let mut vector_queries = ArrayTrait::new();
    if queries_len == 0 {
        return vector_queries;
    }
    let mut i = 0;
    loop {
        if i == queries_len {
            break;
        }
        let hash = if n_columns == 1 {
            *values[i]
        } else if is_verifier_friendly {
            let slice = values.slice(i * n_columns, n_columns);
            poseidon_hash_span(slice)
        } else {
            let slice = values.slice(i * n_columns, n_columns);
            let mut data = ArrayTrait::new(); // u32 for blake, u64 for keccak
            data.append_big_endian(slice);
            hash_truncated(data, settings)
        };
        vector_queries.append(VectorQuery { index: *queries[i], value: hash });
        i += 1;
    };
    vector_queries
}
