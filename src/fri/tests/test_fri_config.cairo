use cairo_verifier::{
    fri::{fri::fri_commit, fri_config::{FriConfig, FriConfigTrait}}, channel::channel::ChannelTrait,
    table_commitment::table_commitment::TableCommitmentConfig,
    vector_commitment::vector_commitment::VectorCommitmentConfig,
};

// test generated based on cairo0-verifier run on fib proof from stone-prover
#[test]
#[available_gas(9999999999)]
fn test_fri_config() {
    let fri_config = FriConfig {
        log_input_size: 0x16,
        n_layers: 0x5,
        inner_layers: array![
            TableCommitmentConfig {
                n_columns: 0x10,
                vector: VectorCommitmentConfig {
                    height: 0x12, n_verifier_friendly_commitment_layers: 0x16,
                },
            },
            TableCommitmentConfig {
                n_columns: 0x8,
                vector: VectorCommitmentConfig {
                    height: 0xf, n_verifier_friendly_commitment_layers: 0x16,
                },
            },
            TableCommitmentConfig {
                n_columns: 0x4,
                vector: VectorCommitmentConfig {
                    height: 0xd, n_verifier_friendly_commitment_layers: 0x16,
                },
            },
            TableCommitmentConfig {
                n_columns: 0x4,
                vector: VectorCommitmentConfig {
                    height: 0xb, n_verifier_friendly_commitment_layers: 0x16,
                },
            }
        ]
            .span(),
        // Array of size n_layers, each entry represents the FRI step size,
        // i.e. the number of FRI-foldings between layer i and i+1.
        fri_step_sizes: array![0x0, 0x4, 0x3, 0x2, 0x2,].span(),
        log_last_layer_degree_bound: 0x7,
    };

    let log_n_cosets = 0x4;
    let n_verifier_friendly_commitment_layers = 0x16;
    let log_expected_input_degree = 0x12;

    assert(
        fri_config
            .validate(
                log_n_cosets, n_verifier_friendly_commitment_layers
            ) == log_expected_input_degree,
        'Invalid value'
    );
}
