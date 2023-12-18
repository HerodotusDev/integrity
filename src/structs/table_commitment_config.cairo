use cairo_verifier::structs::vector_commitment_config::VectorCommitmentConfig;

#[derive(Drop, Copy)]
struct TableCommitmentConfig {
    columns: felt252,
    vector: VectorCommitmentConfig
}
