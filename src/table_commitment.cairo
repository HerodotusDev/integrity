// Commitment values for a table commitment protocol. Used to generate a commitment by "reading"
// these values from the channel.
#[derive(Drop, Copy)]
struct TableUnsentCommitment {
    // vector: VectorUnsentCommitment,
}

// Commitment for a table (n_rows x n_columns) of field elements in montgomery form.
#[derive(Drop, Copy)]
struct TableCommitment {
    // config: TableCommitmentConfig*,
    // vector_commitment: VectorCommitment*,
}

#[derive(Drop, Copy)]
struct TableCommitmentConfig {
    // n_columns: felt,
    // vector: VectorCommitmentConfig*,
}

fn table_commit(unsent_commitment: TableUnsentCommitment, config: TableCommitmentConfig) -> TableCommitment{
    TableCommitment{}
}