use cairo_verifier::{
    channel::channel::ChannelTrait,
    vector_commitment::vector_commitment::{VectorCommitment, VectorCommitmentConfig},
    table_commitment::table_commitment::{table_commit, TableCommitment, TableCommitmentConfig,}
};
// test data from cairo0-verifier keccak-native run on stone-prover generated proof
#[test]
#[available_gas(9999999999)]
fn test_table_commitment_commit() {
    let mut channel = ChannelTrait::new_with_counter(
        u256 { low: 0x22b3f4d7841a28271009bef644a84a5e, high: 0x8f17c0c0dcde2144cd36213ab3aaff1b },
        0x0
    );

    let unsent_commitment = 0x61cb9987d55c793fdb238238311dcea46c75cd8698e52f1d01cf74cd25dc797;

    let config = TableCommitmentConfig {
        n_columns: 0x7,
        vector: VectorCommitmentConfig {
            height: 0x16, n_verifier_friendly_commitment_layers: 0x64,
        }
    };

    assert(
        table_commit(
            ref channel, unsent_commitment, config
        ) == TableCommitment {
            config: config,
            vector_commitment: VectorCommitment {
                config: config.vector, commitment_hash: unsent_commitment
            },
        },
        'Invalid value'
    );

    assert(
        channel
            .digest == u256 {
                low: 0x7bf7f5f2fcd827533f816f0f31bd2b54, high: 0xefa8681c3f5a52d031dceb1423a8d8ec
            },
        'Invalid value'
    );
    assert(channel.counter == 0x0, 'Invalid value');
}

