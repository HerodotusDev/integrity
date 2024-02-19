use cairo_verifier::{
    fri::fri::FriCommitment,
    table_commitment::table_commitment::{TableCommitmentConfig, TableCommitment},
    vector_commitment::vector_commitment::{VectorCommitmentConfig, VectorCommitment},
    tests::stone_proof_fibonacci_keccak,
};

fn get() -> FriCommitment {
    return FriCommitment {
        config: stone_proof_fibonacci_keccak::fri::config::get(),
        inner_layers: array![
            TableCommitment {
                config: TableCommitmentConfig {
                    n_columns: 0x10,
                    vector: VectorCommitmentConfig {
                        height: 0x12, n_verifier_friendly_commitment_layers: 0x64,
                    },
                },
                vector_commitment: VectorCommitment {
                    config: VectorCommitmentConfig {
                        height: 0x12, n_verifier_friendly_commitment_layers: 0x64,
                    },
                    commitment_hash: 0x279143db565360bb784ae426d9c99b535716a7faa9fb12b6fb041135129a1c6
                },
            },
            TableCommitment {
                config: TableCommitmentConfig {
                    n_columns: 0x8,
                    vector: VectorCommitmentConfig {
                        height: 0xf, n_verifier_friendly_commitment_layers: 0x64,
                    },
                },
                vector_commitment: VectorCommitment {
                    config: VectorCommitmentConfig {
                        height: 0xf, n_verifier_friendly_commitment_layers: 0x64,
                    },
                    commitment_hash: 0x27485d2bc1d16cad6cbac91f39fa94cb794aecf8c4f3e04330ed982a11937ab
                },
            },
            TableCommitment {
                config: TableCommitmentConfig {
                    n_columns: 0x4,
                    vector: VectorCommitmentConfig {
                        height: 0xd, n_verifier_friendly_commitment_layers: 0x64,
                    },
                },
                vector_commitment: VectorCommitment {
                    config: VectorCommitmentConfig {
                        height: 0xd, n_verifier_friendly_commitment_layers: 0x64,
                    },
                    commitment_hash: 0x664b97e07c1d2d52c314eb9887912695e34e404d3aceec5f340dbfd2e1750c4
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
                    commitment_hash: 0x6fb12bd48b9888a8e658379b2bc292a24683ba58ae04cc3f88ccea065cd1e29
                },
            },
        ]
            .span(),
        eval_points: array![
            0x398fb2dd5ae945fe667e632daa36e90868f8b9149fe91da928d5826d553621f,
            0xc355b79eac98b46a9c0c2e3d85819db1dd32e74d4bf6aa6cdce5290f11ea61,
            0x24efdb5bb443555985c49d03f7e4ababfbd8005b102babfa8731652d664c275,
            0x77e29eae6c87e2e7924d5d19b857dfe7de9b682aacdd2ed75999cc4272d685c,
        ]
            .span(),
        last_layer_coefficients: stone_proof_fibonacci_keccak::fri::last_layer_coefficients::get()
            .span(),
    };
}
