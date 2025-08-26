use integrity::air::layouts::recursive::traces::TracesConfig;
use integrity::table_commitment::table_commitment::TableCommitmentConfig;
use integrity::vector_commitment::vector_commitment::VectorCommitmentConfig;

fn get() -> TracesConfig {
    return TracesConfig {
        original: TableCommitmentConfig {
            n_columns: 0x7,
            vector: VectorCommitmentConfig {
                height: 0x14, n_verifier_friendly_commitment_layers: 0x64,
            },
        },
        interaction: TableCommitmentConfig {
            n_columns: 0x3,
            vector: VectorCommitmentConfig {
                height: 0x14, n_verifier_friendly_commitment_layers: 0x64,
            },
        },
    };
}
