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
                        height: 0x13, n_verifier_friendly_commitment_layers: 0x64,
                    },
                },
                vector_commitment: VectorCommitment {
                    config: VectorCommitmentConfig {
                        height: 0x13, n_verifier_friendly_commitment_layers: 0x64,
                    },
                    commitment_hash: 0x3d710625c60c2e534dbb7f0595315750e6b2c5b7ba19be7d6b34a22e1a7dcbc
                },
            },
            TableCommitment {
                config: TableCommitmentConfig {
                    n_columns: 0x8,
                    vector: VectorCommitmentConfig {
                        height: 0x10, n_verifier_friendly_commitment_layers: 0x64,
                    },
                },
                vector_commitment: VectorCommitment {
                    config: VectorCommitmentConfig {
                        height: 0x10, n_verifier_friendly_commitment_layers: 0x64,
                    },
                    commitment_hash: 0x1490a301a131a8887f32c59a8eb9fd702cc2be5dfc0ecfcc461f50d856b657a
                },
            },
            TableCommitment {
                config: TableCommitmentConfig {
                    n_columns: 0x8,
                    vector: VectorCommitmentConfig {
                        height: 0xd, n_verifier_friendly_commitment_layers: 0x64,
                    },
                },
                vector_commitment: VectorCommitment {
                    config: VectorCommitmentConfig {
                        height: 0xd, n_verifier_friendly_commitment_layers: 0x64,
                    },
                    commitment_hash: 0x23c7018a71142c60c465a7fe0169c96c043154d40f6a7dc3196bbf52c20902f
                },
            },
            TableCommitment {
                config: TableCommitmentConfig {
                    n_columns: 0x4,
                    vector: VectorCommitmentConfig {
                        height: 0xb, n_verifier_friendly_commitment_layers: 0x64,
                    },
                },
                vector_commitment: VectorCommitment {
                    config: VectorCommitmentConfig {
                        height: 0xb, n_verifier_friendly_commitment_layers: 0x64,
                    },
                    commitment_hash: 0x3515eb7f5c47a1f199e7089495de38c8dd80223a25c901bc7db5e84061b823c
                },
            },
        ]
            .span(),
        eval_points: array![
            0x474fa7f71cd9c8819a18fdd0d8dbf5fd0f2b4d4c6f9241e95cbeba7a867d6c4,
            0x54c4003ddcf9d5f4656fb8fd843449fd55d116780718491881e5691b74ac4c8,
            0x71e110a4de733d508aacf9378700fe52dbd19fa21a4b3f2b8c66649b80454b2,
            0x20e183b33eb18832be0054168d747921631c2c58bb18d41e1d4b2f59a0936bb,
        ]
            .span(),
        last_layer_coefficients: stone_proof_fibonacci::fri::last_layer_coefficients::get().span(),
    };
}
