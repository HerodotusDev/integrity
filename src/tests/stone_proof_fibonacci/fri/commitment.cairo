use integrity::{
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
                        height: 0x12, n_verifier_friendly_commitment_layers: 0x64,
                    },
                },
                vector_commitment: VectorCommitment {
                    config: VectorCommitmentConfig {
                        height: 0x12, n_verifier_friendly_commitment_layers: 0x64,
                    },
                    commitment_hash: 0x137de087f31f4e6f54222fc3cebb3c162469083196999e6ee4bb8ceb4d6b786
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
                    commitment_hash: 0x3bb3c75d228842edce6f6bf6fd6706ce51f5d83c6842a3ab4b4d89fad6f07b
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
                    commitment_hash: 0xb606d3c2b341ff9de5ead44f00121fdc4113f3720feb162eeaecb511e73d4f
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
                    commitment_hash: 0x787b0937a4cd02e0143e93979bb79139ca9546fc1654b4f755f8642c989ba20
                },
            },
        ]
            .span(),
        eval_points: array![
            0x2318111dbaa02700a1ac0d1ce605b756010af6c39b4e85422e9e8c848ec05ca,
            0xe32c017cfa9260ed2130df2d513340c4a5aaee766696beb2f640ad261e0261,
            0x4103675a55bf63ad036370ded26f12e273026699c056d578c6b01dff2c3e9e0,
            0x2cda81790074e40739eb81556de82ebc000056aafcc09c34f5ba52d6d0ff1ba
        ]
            .span(),
        last_layer_coefficients: stone_proof_fibonacci::fri::last_layer_coefficients::get().span(),
    };
}
