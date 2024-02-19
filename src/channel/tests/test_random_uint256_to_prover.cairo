use cairo_verifier::channel::channel::ChannelTrait;

// === BLAKE ONLY BEGIN ===
// #[test]
// #[available_gas(9999999999)]
// fn test_random_uint256_to_prover_0() {
//     let mut channel = ChannelTrait::new_with_counter(
//         u256 { low: 0xf59fd6b10ccc33fe2e1e1e94e3411f56, high: 0x6572033443ae2c5f7b83bfdcd817240e },
//         0x0
//     );
//     assert(
//         channel
//             .random_uint256_to_prover() == u256 {
//                 low: 0x5f1758ec5d5517006c3eac3c624dcda2, high: 0xb24fe50c70859073b185937f3e1eb93d
//             },
//         'Invalid value'
//     );
// }
// 
// #[test]
// #[available_gas(9999999999)]
// fn test_random_uint256_to_prover_1() {
//     let mut channel = ChannelTrait::new_with_counter(
//         u256 { low: 0xf59fd6b10ccc33fe2e1e1e94e3411f56, high: 0x6572033443ae2c5f7b83bfdcd817240e },
//         0x1
//     );
//     assert(
//         channel
//             .random_uint256_to_prover() == u256 {
//                 low: 0xad772a40c7f3c4e6f77db1daa5f8d8e, high: 0x96014698ef9d4df3438cf2da8aa483a4
//             },
//         'Invalid value'
//     );
// }
// 
// #[test]
// #[available_gas(9999999999)]
// fn test_random_uint256_to_prover_2() {
//     let mut channel = ChannelTrait::new_with_counter(
//         u256 { low: 0x8823a41f7994f81c6453f4bc3cad1c10, high: 0x75f85ae3fd3ff6b5f63029a51040037e },
//         0x0
//     );
//     assert(
//         channel
//             .random_uint256_to_prover() == u256 {
//                 low: 0xf1466cd5383c0644def10ee2658b7a05, high: 0x32f0741071fba06bdee46d938b942542
//             },
//         'Invalid value'
//     );
// }
// 
// #[test]
// #[available_gas(9999999999)]
// fn test_random_uint256_to_prover_3() {
//     let mut channel = ChannelTrait::new_with_counter(
//         u256 { low: 0x89a405dfb23e546ad03d498e88dee3ba, high: 0xe614bdb3e56768f45a22fd34e999734c },
//         0x0
//     );
//     assert(
//         channel
//             .random_uint256_to_prover() == u256 {
//                 low: 0x538dd6434921187f80b76fd1d804af3b, high: 0x1172f921f177f82f29a3d97f9cffd2df
//             },
//         'Invalid value'
//     );
// }
// 
// #[test]
// #[available_gas(9999999999)]
// fn test_random_uint256_to_prover_4() {
//     let mut channel = ChannelTrait::new(0);
//     let random = channel.random_uint256_to_prover();
//     assert(
//         random == 0xae09db7cd54f42b490ef09b6bc541af688e4959bb8c53f359a6f56e38ab454a3,
//         'invalid random uint256'
//     );
// }
// === BLAKE ONLY END ===

// === KECCAK ONLY BEGIN ===
#[test]
#[available_gas(9999999999)]
fn test_random_uint256_to_prover_0() {
    let mut channel = ChannelTrait::new_with_counter(
        u256 { low: 0x31221b7950614c65772c2993e6727561, high: 0xfaa5d980c70cbe78934e534c13eaf18a },
        0x0
    );
    assert(
        channel
            .random_uint256_to_prover() == u256 {
                low: 0x6249f523d42a9a89f8a41bbcffb837ee, high: 0x704fab98abe015f67ce8c5651141e746
            },
        'Invalid value'
    );
    assert(
        channel
            .digest == u256 {
                low: 0x31221b7950614c65772c2993e6727561, high: 0xfaa5d980c70cbe78934e534c13eaf18a
            },
        'Invalid value'
    );
    assert(channel.counter == 0x1, 'Invalid value');
}

#[test]
#[available_gas(9999999999)]
fn test_random_uint256_to_prover_1() {
    let mut channel = ChannelTrait::new_with_counter(
        u256 { low: 0x31221b7950614c65772c2993e6727561, high: 0xfaa5d980c70cbe78934e534c13eaf18a },
        0x4
    );
    assert(
        channel
            .random_uint256_to_prover() == u256 {
                low: 0x9dd4eacd6e611a8f0da6dfcb9c1206d6, high: 0x67cb6d23cfb26dc408dac8c0c6a71602
            },
        'Invalid value'
    );
    assert(
        channel
            .digest == u256 {
                low: 0x31221b7950614c65772c2993e6727561, high: 0xfaa5d980c70cbe78934e534c13eaf18a
            },
        'Invalid value'
    );
    assert(channel.counter == 0x5, 'Invalid value');
}

#[test]
#[available_gas(9999999999)]
fn test_random_uint256_to_prover_2() {
    let mut channel = ChannelTrait::new_with_counter(
        u256 { low: 0x4ccd3b3aab8d3e3c4d99af0aa61de9d1, high: 0x8e5ef0503c12ab78b594db03b634546d },
        0x3
    );
    assert(
        channel
            .random_uint256_to_prover() == u256 {
                low: 0x4220300fcccb24c97922cba73e4bcaa3, high: 0x6c733c0f5ab453eff35531225ebfcf65
            },
        'Invalid value'
    );
    assert(
        channel
            .digest == u256 {
                low: 0x4ccd3b3aab8d3e3c4d99af0aa61de9d1, high: 0x8e5ef0503c12ab78b594db03b634546d
            },
        'Invalid value'
    );
    assert(channel.counter == 0x4, 'Invalid value');
}
// === KECCAK ONLY END ===


