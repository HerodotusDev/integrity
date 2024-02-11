use cairo_verifier::{
    channel::channel::{Channel, ChannelTrait},
    vector_commitment::vector_commitment::{VectorCommitmentConfig, vector_commit, VectorCommitment}
};

// === BLAKE ONLY BEGIN ===
// #[test]
// #[available_gas(9999999999)]
// fn test_vector_commit_0() {
//     let mut channel = Channel {
//         digest: u256 {
//             low: 0xba9d17a3ebd900899148b125421c118f, high: 0x87433b8dd90acbfe5abea8474d795191
//         },
//         counter: 0x0,
//     };
//     let config = VectorCommitmentConfig {
//         height: 0x16, n_verifier_friendly_commitment_layers: 0x16,
//     };
//     let unsent_commitment: felt252 =
//         0xa43e1b3b99d987d63116edc58aa49a7d510a667951852446419df5ede6a1cc;

//     assert(
//         vector_commit(
//             ref channel, unsent_commitment, config
//         ) == VectorCommitment { config: config, commitment_hash: unsent_commitment },
//         'Invalid value'
//     );

//     assert(
//         channel
//             .digest == u256 {
//                 low: 0xf59fd6b10ccc33fe2e1e1e94e3411f56, high: 0x6572033443ae2c5f7b83bfdcd817240e
//             },
//         'Invalid value'
//     );
//     assert(channel.counter == 0x0, 'Invalid value');
// }

// #[test]
// #[available_gas(9999999999)]
// fn test_vector_commit_1() {
//     let mut channel = Channel {
//         digest: u256 {
//             low: 0xba9d17a3ebd900899148b125421c118f, high: 0x87433b8dd90acbfe5abea8474d795191
//         },
//         counter: 0x0,
//     };
//     let config = VectorCommitmentConfig {
//         height: 0x16, n_verifier_friendly_commitment_layers: 0x16,
//     };
//     let unsent_commitment: felt252 =
//         0xa43e1b3b99d987d63116edc58aa49a7d510a667951852446419df5ede6a1cc;

//     assert(
//         vector_commit(
//             ref channel, unsent_commitment, config
//         ) == VectorCommitment { config: config, commitment_hash: unsent_commitment },
//         'Invalid value'
//     );

//     assert(
//         channel
//             .digest == u256 {
//                 low: 0xf59fd6b10ccc33fe2e1e1e94e3411f56, high: 0x6572033443ae2c5f7b83bfdcd817240e
//             },
//         'Invalid value'
//     );
//     assert(channel.counter == 0x0, 'Invalid value');
// }
// === BLAKE ONLY END ===

// === KECCAK ONLY BEGIN ===
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
// === KECCAK ONLY END ===