use integrity::{
    fri::fri_config::FriConfig, table_commitment::table_commitment::{TableCommitmentConfig},
    vector_commitment::vector_commitment::{VectorCommitmentConfig}
};

fn get() -> FriConfig {
    return FriConfig {
        log_input_size: 0x16,
        n_layers: 0x5,
        inner_layers: array![
            TableCommitmentConfig {
                n_columns: 0x10,
                vector: VectorCommitmentConfig {
                    height: 0x12, n_verifier_friendly_commitment_layers: 0x64,
                },
            },
            TableCommitmentConfig {
                n_columns: 0x8,
                vector: VectorCommitmentConfig {
                    height: 0xf, n_verifier_friendly_commitment_layers: 0x64,
                },
            },
            TableCommitmentConfig {
                n_columns: 0x4,
                vector: VectorCommitmentConfig {
                    height: 0xd, n_verifier_friendly_commitment_layers: 0x64,
                },
            },
            TableCommitmentConfig {
                n_columns: 0x4,
                vector: VectorCommitmentConfig {
                    height: 0xb, n_verifier_friendly_commitment_layers: 0x64,
                },
            }
        ]
            .span(),
        // Array of size n_layers, each entry represents the FRI step size,
        // i.e. the number of FRI-foldings between layer i and i+1.
        fri_step_sizes: array![0x0, 0x4, 0x3, 0x2, 0x2].span(),
        log_last_layer_degree_bound: 0x7,
    };
}
