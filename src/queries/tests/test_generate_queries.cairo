use cairo_verifier::{
    queries::queries::generate_queries, channel::channel::ChannelTrait,
    tests::{stone_proof_fibonacci, stone_proof_fibonacci_keccak}
};

// === BLAKE ONLY BEGIN ===
// #[test]
// #[available_gas(9999999999)]
// fn test_generate_queries_0() {
//     let mut channel = ChannelTrait::new(
//         u256 { low: 0xf7685ebd40e852b164633a4acbd3244c, high: 0xe8e77626586f73b955364c7b4bbf0bb7 }
//     );
//     assert(
//         generate_queries(
//             ref channel, 4, 12389012333
//         ) == array![0xc53fdd1e, 0x166d56d3d, 0x1e563d10b, 0x2d9a2434f],
//         'Invalid value'
//     );
//     assert(channel.counter == 1, 'Invalid value');
// }
// 
// #[test]
// #[available_gas(9999999999)]
// fn test_generate_queries_1() {
//     let mut channel = ChannelTrait::new(
//         u256 { low: 0xf7685ebd40e852b164633a4acbd3244c, high: 0xe8e77626586f73b955364c7b4bbf0bb7 }
//     );
//     assert(
//         generate_queries(
//             ref channel, 10, 99809818624
//         ) == array![
//             0x3247d4098,
//             0x52d896136,
//             0x557cce2e5,
//             0x6188b67d1,
//             0x982d6fc79,
//             0xa733f8ed8,
//             0xbf23e4bf7,
//             0xc2321969b,
//             0xca83fb21d,
//             0x1405a07e8c
//         ],
//         'Invalid value'
//     );
//     assert(channel.counter == 3, 'Invalid value');
// }
// 
// #[test]
// #[available_gas(9999999999)]
// fn test_generate_queries_2() {
//     let mut channel = ChannelTrait::new(
//         u256 { low: 0x2c31f04a6b9c83c2464b2f1688fc719e, high: 0xe631d91ef56f7e4cc7fe09cff2cc4e94 }
//     );
//     assert(
//         generate_queries(ref channel, 18, 0x400000) == stone_proof_fibonacci::queries::get(),
//         'Invalid value'
//     );
//     assert(channel.counter == 5, 'Invalid value');
// }
// === BLAKE ONLY END ===

// === KECCAK ONLY BEGIN ===
#[test]
#[available_gas(9999999999)]
fn test_generate_queries_0() {
    let mut channel = ChannelTrait::new(
        u256 { low: 0x210c99e614db21dcd882b7f3734a477b, high: 0x29786ad320869955ebf8c196e16009e1 }
    );
    assert(
        generate_queries(ref channel, 18, 0x400000) == stone_proof_fibonacci_keccak::queries::get(),
        'Invalid value'
    );
    assert(channel.counter == 5, 'Invalid value');
}
// === KECCAK ONLY END ===

