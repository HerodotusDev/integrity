use cairo_verifier::{
    channel::channel::ChannelTrait,
    vector_commitment::vector_commitment::{VectorCommitment, VectorCommitmentConfig, vector_commit},
};

// test data from cairo0-verifier keccak-native run on stone-prover generated proof
#[test]
#[available_gas(9999999999)]
fn test_vector_commit() {
    let mut channel = ChannelTrait::new_with_counter(
        u256 { low: 0xba9f6f33755b2ba125243085a495cbce, high: 0xb32be56c99d069ae688842c915c4531c },
        0x1
    );

    let unsent_commitment = 0x6fb12bd48b9888a8e658379b2bc292a24683ba58ae04cc3f88ccea065cd1e29;

    let config = VectorCommitmentConfig {
        height: 0xb, n_verifier_friendly_commitment_layers: 0x64,
    };

    assert(
        vector_commit(
            ref channel, unsent_commitment, config
        ) == VectorCommitment { config: config, commitment_hash: unsent_commitment },
        'Invalid value'
    );

    assert(
        channel
            .digest == u256 {
                low: 0x5449a9fbc110816097171d407a006747, high: 0xba04b152453e14e6d4cd5bcb9d676a8b
            },
        'Invalid value'
    );
    assert(channel.counter == 0x0, 'Invalid value');
}
