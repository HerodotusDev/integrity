use cairo_verifier::channel::channel::ChannelTrait;

// === BLAKE ONLY BEGIN ===
// #[test]
// #[available_gas(9999999999)]
// fn test_read_felt_from_prover_0() {
//     let mut channel = ChannelTrait::new_with_counter(
//         u256 { low: 0x89a405dfb23e546ad03d498e88dee3ba, high: 0xe614bdb3e56768f45a22fd34e999734c },
//         0x1
//     );
//     channel
//         .read_felt_from_prover(0x3a63c21f32409c9ec7614199b40102547e7f698f903bdbbffe56785684b7e04);
//     assert(
//         channel
//             .digest == u256 {
//                 low: 0xc123a2db28e4f285115f8c72934264ea, high: 0x810c2a15f74c5a93239754103cde49b0
//             },
//         'Invalid value'
//     );
//     assert(channel.counter == 0, 'Invalid value');
// }

// #[test]
// #[available_gas(9999999999)]
// fn test_read_felt_from_prover_1() {
//     let mut channel = ChannelTrait::new_with_counter(
//         u256 { low: 0xc123a2db28e4f285115f8c72934264ea, high: 0x810c2a15f74c5a93239754103cde49b0 },
//         0x0
//     );
//     channel
//         .read_felt_from_prover(0x5652f216d992bbf255b97dd1b0a4dde72fab97f1bbcc4a4f53fde7fc50293c8);
//     assert(
//         channel
//             .digest == u256 {
//                 low: 0x5f72255a95751e54a4f9704096d61310, high: 0x3c9277c30982b407ad5442334e7771d4
//             },
//         'Invalid value'
//     );
//     assert(channel.counter == 0, 'Invalid value');
// }

// #[test]
// #[available_gas(9999999999)]
// fn test_read_felt_from_prover_2() {
//     let mut channel = ChannelTrait::new_with_counter(
//         u256 { low: 0xfc5a98310398b13c3218fdeb624ec8f8, high: 0x59dfc32f7867d987d2d504e264f97faa },
//         0x0
//     );
//     channel
//         .read_felt_from_prover(0x787521b50c17169b9729a4522e1a0e7bdc028fc8ffdd87c70147bd67c5595d3);
//     assert(
//         channel
//             .digest == u256 {
//                 low: 0x746ca09ffaaea6826e10c1b343da771e, high: 0x24a6464484140e30a7f7497204b5abbe
//             },
//         'Invalid value'
//     );
//     assert(channel.counter == 0, 'Invalid value');
// }
// === BLAKE ONLY END ===

// === KECCAK ONLY BEGIN ===
#[test]
#[available_gas(9999999999)]
fn test_read_felt_from_prover_0() {
    let mut channel = ChannelTrait::new_with_counter(
        u256 { low: 0x6b78b49c94cbdf349708a9d94a799c14, high: 0x83fed9107fa49a64270e4e0060b93633 },
        0x0
    );
    channel
        .read_felt_from_prover(0x2bfd93b32c219ece244588f15f8aae89867abc7da1a579bf84ca9544f969c53);
    assert(
        channel
            .digest == u256 {
                low: 0xa55020e872dfef9f7999a8f22098dfdf, high: 0xaaaf25698614d5c0216e7d570510039f
            },
        'Invalid value'
    );
    assert(channel.counter == 0, 'Invalid value');
}

#[test]
#[available_gas(9999999999)]
fn test_read_felt_from_prover_1() {
    let mut channel = ChannelTrait::new_with_counter(
        u256 { low: 0x9245c7cf213bdcb501bdf9cb543e29e2, high: 0x4186a538a62f83802cde11ec1f7f4d29 },
        0x0
    );
    channel
        .read_felt_from_prover(0x5ab21b56b09e48e84b089eb21cd476ccb00fa7963b089a9ba9df2a0a5f3e49d);
    assert(
        channel
            .digest == u256 {
                low: 0x64c793e5f748d5d8c75d73916db389cb, high: 0x3616f6f0bfece8772bedda20d54a3d34
            },
        'Invalid value'
    );
    assert(channel.counter == 0, 'Invalid value');
}
// === KECCAK ONLY END ===

