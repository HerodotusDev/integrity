use cairo_verifier::{
    channel::channel::Channel,
    table_commitment::table_commitment::{table_commit, TableCommitment, TableCommitmentConfig},
    vector_commitment::vector_commitment::{VectorCommitment, VectorCommitmentConfig},
};

// test generated based on cairo0-verifier run on fib proof from stone-prover
#[test]
#[available_gas(9999999999)]
fn test_table_commit_0() {
    let mut channel = Channel {
        digest: u256 {
            low: 0x158e1d17e5d7ab440767c172f7c82b88, high: 0x2c002c69395245b6186a155edd381cd7
        },
        counter: 0x1,
    };
    let config = TableCommitmentConfig {
        n_columns: 0x8,
        vector: VectorCommitmentConfig {
            height: 0xf, n_verifier_friendly_commitment_layers: 0x16,
        },
    };

    let unsent_commitment: felt252 =
        0x821aaa485d3fbdf7b0a06d773e565370f794c06bbcb4e23279a39544782c1e;

    let vector_commitment = VectorCommitment {
        config: VectorCommitmentConfig {
            height: 0xf, n_verifier_friendly_commitment_layers: 0x16,
        },
        commitment_hash: unsent_commitment
    };

    assert(
        table_commit(
            ref channel, unsent_commitment, config
        ) == TableCommitment { config: config, vector_commitment: vector_commitment },
        'Invalid value'
    );

    assert(
        channel
            .digest == u256 {
                low: 0x98cbce1a1c901460027570bd9aa93ccb, high: 0x2581182ce5a51e9dd0810917ad7250ab
            },
        'Invalid value'
    );
    assert(channel.counter == 0x0, 'Invalid value');
}

// test generated based on cairo0-verifier run on fib proof from stone-prover
#[test]
#[available_gas(9999999999)]
fn test_table_commit_1() {
    let mut channel = Channel {
        digest: u256 {
            low: 0x98cbce1a1c901460027570bd9aa93ccb, high: 0x2581182ce5a51e9dd0810917ad7250ab
        },
        counter: 0x1,
    };
    let config = TableCommitmentConfig {
        n_columns: 0x4,
        vector: VectorCommitmentConfig {
            height: 0xd, n_verifier_friendly_commitment_layers: 0x16,
        },
    };

    let unsent_commitment: felt252 =
        0x7a73129c87d8a60cb07b26775437ac75790bbd415d47912e5eb1f7c7e11d42f;

    let vector_commitment = VectorCommitment {
        config: VectorCommitmentConfig {
            height: 0xd, n_verifier_friendly_commitment_layers: 0x16,
        },
        commitment_hash: unsent_commitment
    };

    assert(
        table_commit(
            ref channel, unsent_commitment, config
        ) == TableCommitment { config: config, vector_commitment: vector_commitment },
        'Invalid value'
    );

    assert(
        channel
            .digest == u256 {
                low: 0x8a067e49d4c4f2bf2ca4e499d36bd71a, high: 0x4548bed8d91372df1a7674e0471e76e3
            },
        'Invalid value'
    );
    assert(channel.counter == 0x0, 'Invalid value');
}
