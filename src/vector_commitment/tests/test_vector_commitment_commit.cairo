use cairo_verifier::{
    channel::channel::{Channel, ChannelTrait},
    vector_commitment::vector_commitment::{VectorCommitmentConfig, vector_commit, VectorCommitment}
};

// === BLAKE ONLY BEGIN ===
// #[test]
// #[available_gas(9999999999)]
// fn test_vector_commit_0() {
//     let mut channel = ChannelTrait::new_with_counter(0x0, 0x0);
// 
//     let config = VectorCommitmentConfig {
//         height: 0x16, n_verifier_friendly_commitment_layers: 0x16,
//     };
//     let unsent_commitment: felt252 =
//         0xa43e1b3b99d987d63116edc58aa49a7d510a667951852446419df5ede6a1cc;
// 
//     assert(
//         vector_commit(
//             ref channel, unsent_commitment, config
//         ) == VectorCommitment { config: config, commitment_hash: unsent_commitment },
//         'Invalid value'
//     );
// 
//     assert(channel.digest == 0x0, 'Invalid value');
//     assert(channel.counter == 0x0, 'Invalid value');
// }
// 
// #[test]
// #[available_gas(9999999999)]
// fn test_vector_commit_1() {
//     let mut channel = ChannelTrait::new_with_counter(0x0, 0x0);
// 
//     let config = VectorCommitmentConfig {
//         height: 0x16, n_verifier_friendly_commitment_layers: 0x16,
//     };
//     let unsent_commitment: felt252 =
//         0xa43e1b3b99d987d63116edc58aa49a7d510a667951852446419df5ede6a1cc;
// 
//     assert(
//         vector_commit(
//             ref channel, unsent_commitment, config
//         ) == VectorCommitment { config: config, commitment_hash: unsent_commitment },
//         'Invalid value'
//     );
// 
//     assert(channel.digest == 0x0, 'Invalid value');
//     assert(channel.counter == 0x0, 'Invalid value');
// }
// === BLAKE ONLY END ===

// === KECCAK ONLY BEGIN ===
#[test]
#[available_gas(9999999999)]
fn test_vector_commit() {
    let mut channel = ChannelTrait::new_with_counter(0x0, 0x0);

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

    assert(channel.digest == 0x0, 'Invalid value');
    assert(channel.counter == 0x0, 'Invalid value');
}
// === KECCAK ONLY END ===


