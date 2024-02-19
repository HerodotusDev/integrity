use cairo_verifier::channel::channel::ChannelTrait;

// === BLAKE ONLY BEGIN ===
// #[test]
// #[available_gas(9999999999)]
// fn test_read_truncated_hash_from_prover_0() {
//     let mut channel = ChannelTrait::new_with_counter(
//         u256 { low: 0xba9d17a3ebd900899148b125421c118f, high: 0x87433b8dd90acbfe5abea8474d795191 },
//         0x0
//     );
//     channel
//         .read_truncated_hash_from_prover(
//             0xa43e1b3b99d987d63116edc58aa49a7d510a667951852446419df5ede6a1cc
//         );
//     assert(
//         channel
//             .digest == u256 {
//                 low: 0xf59fd6b10ccc33fe2e1e1e94e3411f56, high: 0x6572033443ae2c5f7b83bfdcd817240e
//             },
//         'Invalid value'
//     );
//     assert(channel.counter == 0, 'Invalid value');
// }
// 
// #[test]
// #[available_gas(9999999999)]
// fn test_read_truncated_hash_from_prover_1() {
//     let mut channel = ChannelTrait::new_with_counter(
//         u256 { low: 0xf59fd6b10ccc33fe2e1e1e94e3411f56, high: 0x6572033443ae2c5f7b83bfdcd817240e },
//         0x6
//     );
//     channel
//         .read_truncated_hash_from_prover(
//             0x32b3d365d461b6c12ab7d3396b5225903bd17bc85216f300472afea65cab39a
//         );
//     assert(
//         channel
//             .digest == u256 {
//                 low: 0x8823a41f7994f81c6453f4bc3cad1c10, high: 0x75f85ae3fd3ff6b5f63029a51040037e
//             },
//         'Invalid value'
//     );
//     assert(channel.counter == 0, 'Invalid value');
// }
// 
// #[test]
// #[available_gas(9999999999)]
// fn test_read_truncated_hash_from_prover_2() {
//     let mut channel = ChannelTrait::new_with_counter(
//         u256 { low: 0x98cbce1a1c901460027570bd9aa93ccb, high: 0x2581182ce5a51e9dd0810917ad7250ab },
//         0x1
//     );
//     channel
//         .read_truncated_hash_from_prover(
//             0x7a73129c87d8a60cb07b26775437ac75790bbd415d47912e5eb1f7c7e11d42f
//         );
//     assert(
//         channel
//             .digest == u256 {
//                 low: 0x8a067e49d4c4f2bf2ca4e499d36bd71a, high: 0x4548bed8d91372df1a7674e0471e76e3
//             },
//         'Invalid value'
//     );
//     assert(channel.counter == 0, 'Invalid value');
// }
// === BLAKE ONLY END ===

// === KECCAK ONLY BEGIN ===
#[test]
#[available_gas(9999999999)]
fn test_read_truncated_hash_from_prover_0() {
    let mut channel = ChannelTrait::new_with_counter(
        u256 { low: 0x45b3420418a87dceced51bb7756c6833, high: 0x44768edae6365630783c1f09c1cedbc8 },
        0x0
    );
    channel
        .read_truncated_hash_from_prover(
            0x104b24dc152ce21002022cddc8ce78d5d3478a8757fc7cf6d49122cfece3a8b
        );
    assert(
        channel
            .digest == u256 {
                low: 0x31221b7950614c65772c2993e6727561, high: 0xfaa5d980c70cbe78934e534c13eaf18a
            },
        'Invalid value'
    );
    assert(channel.counter == 0x0, 'Invalid value');
}

#[test]
#[available_gas(9999999999)]
fn test_read_truncated_hash_from_prover_1() {
    let mut channel = ChannelTrait::new_with_counter(
        u256 { low: 0x31221b7950614c65772c2993e6727561, high: 0xfaa5d980c70cbe78934e534c13eaf18a },
        0x6
    );
    channel
        .read_truncated_hash_from_prover(
            0x3f357e1ca6d1b436e1e6e1b885a2a23d471c254cc14c56a8cf0684919ff5ac7
        );
    assert(
        channel
            .digest == u256 {
                low: 0xd190eb6478f0d295e60b2319531aa506, high: 0xb6ee5c6384b4664c8958f6fd73afff35
            },
        'Invalid value'
    );
    assert(channel.counter == 0x0, 'Invalid value');
}

#[test]
#[available_gas(9999999999)]
fn test_read_truncated_hash_from_prover_2() {
    let mut channel = ChannelTrait::new_with_counter(
        u256 { low: 0xd190eb6478f0d295e60b2319531aa506, high: 0xb6ee5c6384b4664c8958f6fd73afff35 },
        0x1
    );
    channel
        .read_truncated_hash_from_prover(
            0x45aeee8ab5801b064fe08cb15e2f1e3b5ac60316cba0309f47df924b7ad816e
        );
    assert(
        channel
            .digest == u256 {
                low: 0xf05211ddc7d39bdac47d77a10f1fec44, high: 0x570aa8f624aff81df1a44d65b15bc1e9
            },
        'Invalid value'
    );
    assert(channel.counter == 0x0, 'Invalid value');
}
// === KECCAK ONLY END ===


