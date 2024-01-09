use cairo_verifier::table_commitment::TableCommitmentConfig;

const MAX_N_COLUMNS: felt252 = 128;

// Configuration for the Traces component.
#[derive(Drop, Copy)]
struct TracesConfig {
    original: TableCommitmentConfig,
    interaction: TableCommitmentConfig,
}
// TODO traces_config_validate

