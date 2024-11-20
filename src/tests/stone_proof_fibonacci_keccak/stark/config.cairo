use integrity::{
    stark::StarkConfig, table_commitment::table_commitment::TableCommitmentConfig,
    vector_commitment::vector_commitment::VectorCommitmentConfig,
    tests::stone_proof_fibonacci_keccak,
};

fn get() -> StarkConfig {
    return StarkConfig {
        traces: stone_proof_fibonacci_keccak::traces::config::get(),
        composition: TableCommitmentConfig {
            n_columns: 0x2,
            vector: VectorCommitmentConfig {
                height: 0x14, n_verifier_friendly_commitment_layers: 0x64,
            },
        },
        fri: stone_proof_fibonacci_keccak::fri::config::get(),
        proof_of_work: stone_proof_fibonacci_keccak::proof_of_work::config::get(),
        log_trace_domain_size: 0x12,
        n_queries: 0xa,
        log_n_cosets: 0x2,
        n_verifier_friendly_commitment_layers: 0x64,
    };
}
