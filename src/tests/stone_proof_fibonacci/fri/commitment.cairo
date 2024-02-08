use cairo_verifier::{
    fri::fri::FriCommitment,
    table_commitment::table_commitment::{TableCommitmentConfig, TableCommitment},
    vector_commitment::vector_commitment::{VectorCommitmentConfig, VectorCommitment},
    tests::stone_proof_fibonacci,
};

fn get() -> FriCommitment {
    return FriCommitment {
        config: stone_proof_fibonacci::fri::config::get(),
        inner_layers: array![
            TableCommitment {
                config: TableCommitmentConfig {
                    n_columns: 0x10,
                    vector: VectorCommitmentConfig {
                        height: 0x12, n_verifier_friendly_commitment_layers: 0x16,
                    },
                },
                vector_commitment: VectorCommitment {
                    config: VectorCommitmentConfig {
                        height: 0x12, n_verifier_friendly_commitment_layers: 0x16,
                    },
                    commitment_hash: 0x6288a59e1970d629fdfb5bdea93ad3203511b3c27340db1467a39cf7951de3
                },
            },
            TableCommitment {
                config: TableCommitmentConfig {
                    n_columns: 0x8,
                    vector: VectorCommitmentConfig {
                        height: 0xf, n_verifier_friendly_commitment_layers: 0x16,
                    },
                },
                vector_commitment: VectorCommitment {
                    config: VectorCommitmentConfig {
                        height: 0xf, n_verifier_friendly_commitment_layers: 0x16,
                    },
                    commitment_hash: 0x821aaa485d3fbdf7b0a06d773e565370f794c06bbcb4e23279a39544782c1e
                },
            },
            TableCommitment {
                config: TableCommitmentConfig {
                    n_columns: 0x4,
                    vector: VectorCommitmentConfig {
                        height: 0xd, n_verifier_friendly_commitment_layers: 0x16,
                    },
                },
                vector_commitment: VectorCommitment {
                    config: VectorCommitmentConfig {
                        height: 0xd, n_verifier_friendly_commitment_layers: 0x16,
                    },
                    commitment_hash: 0x7a73129c87d8a60cb07b26775437ac75790bbd415d47912e5eb1f7c7e11d42f
                },
            },
            TableCommitment {
                config: TableCommitmentConfig {
                    n_columns: 0x4,
                    vector: VectorCommitmentConfig {
                        height: 0xb, n_verifier_friendly_commitment_layers: 0x16,
                    },
                },
                vector_commitment: VectorCommitment {
                    config: VectorCommitmentConfig {
                        height: 0xb, n_verifier_friendly_commitment_layers: 0x16,
                    },
                    commitment_hash: 0x3ce8c532eab6fcbf597abd8817cc406cc884f6000ab2d79c9a9ea3a12b4c038
                },
            },
        ]
            .span(),
        eval_points: array![
            0xbdb64eae5fbad13b4faf374043e73f68b9c428eb0d6b78097c64539add8c6e,
            0x511356e0c2eca37e8d4ed5d88cabe83b8dfba6e3a9ea0c793b114a5fb0a8147,
            0x73cbfe687c88476eed31b84b03c0027712369d3e2ba6947422c8ea8cb72f2d7,
            0x34b2eb47b0eca404696f00d7bf1cb6238cdc6cd3c3560ba9c532a7fa372fb2f,
        ]
            .span(),
        last_layer_coefficients: stone_proof_fibonacci::fri::last_layer_coefficients::get().span(),
    };
}
