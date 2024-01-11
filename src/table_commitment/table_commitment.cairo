use cairo_verifier::vector_commitment::vector_commitment::{
    VectorCommitmentConfig, VectorCommitment, VectorCommitmentWitness, vector_commit,
};
use cairo_verifier::channel::channel::Channel;

// Commitment for a table (n_rows x n_columns) of field elements in montgomery form.
#[derive(Drop, Copy)]
struct TableCommitment {
    config: TableCommitmentConfig,
    vector_commitment: VectorCommitment,
}

#[derive(Drop, Copy)]
struct TableCommitmentConfig {
    n_columns: felt252,
    vector: VectorCommitmentConfig,
}

// Responses for queries to the table commitment.
// Each query corresponds to a full row of the table.
#[derive(Drop, Copy)]
struct TableDecommitment {
    // n_columns * n_queries values to decommit.
    values: Span<felt252>,
}

// Witness for a decommitment over queries.
#[derive(Drop, Copy)]
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
) {}

