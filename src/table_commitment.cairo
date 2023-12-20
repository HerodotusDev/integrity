// Commitment values for a table commitment protocol. Used to generate a commitment by "reading"
// these values from the channel.
#[derive(Drop, Copy)]
struct TableUnsentCommitment {
    a: felt252, // dummy
// vector: VectorUnsentCommitment,
}

// Commitment for a table (n_rows x n_columns) of field elements in montgomery form.
#[derive(Drop, Copy)]
struct TableCommitment {
    a: felt252, // dummy
// config: TableCommitmentConfig*,
// vector_commitment: VectorCommitment*,
}

#[derive(Drop, Copy)]
struct TableCommitmentConfig {
    a: felt252, // dummy
// n_columns: felt,
// vector: VectorCommitmentConfig*,
}

fn table_commit(
    unsent_commitment: TableUnsentCommitment, config: TableCommitmentConfig
) -> TableCommitment {
    TableCommitment { a: 0 }
}
