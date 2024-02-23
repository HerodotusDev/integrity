use cairo_verifier::channel::channel::ChannelTrait;

// === BLAKE ONLY BEGIN ===
// #[test]
// #[available_gas(9999999999)]
// fn test_read_felt_from_prover_0() {
//     let mut channel = ChannelTrait::new_with_counter(0x0, 0x0);
//     channel
//         .read_felt_from_prover(0x3a63c21f32409c9ec7614199b40102547e7f698f903bdbbffe56785684b7e04);
//     assert(channel.digest == 0x0, 'Invalid value');
//     assert(channel.counter == 0, 'Invalid value');
// }
// 
// #[test]
// #[available_gas(9999999999)]
// fn test_read_felt_from_prover_1() {
//     let mut channel = ChannelTrait::new_with_counter(0x0, 0x0);
//     channel
//         .read_felt_from_prover(0x5652f216d992bbf255b97dd1b0a4dde72fab97f1bbcc4a4f53fde7fc50293c8);
//     assert(channel.digest == 0x0, 'Invalid value');
//     assert(channel.counter == 0, 'Invalid value');
// }
// 
// #[test]
// #[available_gas(9999999999)]
// fn test_read_felt_from_prover_2() {
//     let mut channel = ChannelTrait::new_with_counter(0x0, 0x0);
//     channel
//         .read_felt_from_prover(0x787521b50c17169b9729a4522e1a0e7bdc028fc8ffdd87c70147bd67c5595d3);
//     assert(channel.digest == 0x0, 'Invalid value');
//     assert(channel.counter == 0, 'Invalid value');
// }
// === BLAKE ONLY END ===

// === KECCAK ONLY BEGIN ===
#[test]
#[available_gas(9999999999)]
fn test_read_felt_from_prover_0() {
    let mut channel = ChannelTrait::new_with_counter(0x0, 0x0);
    channel
        .read_felt_from_prover(0x2bfd93b32c219ece244588f15f8aae89867abc7da1a579bf84ca9544f969c53);
    assert(channel.digest == 0x0, 'Invalid value');
    assert(channel.counter == 0, 'Invalid value');
}

#[test]
#[available_gas(9999999999)]
fn test_read_felt_from_prover_1() {
    let mut channel = ChannelTrait::new_with_counter(0x0, 0x0);
    channel
        .read_felt_from_prover(0x5ab21b56b09e48e84b089eb21cd476ccb00fa7963b089a9ba9df2a0a5f3e49d);
    assert(channel.digest == 0x0, 'Invalid value');
    assert(channel.counter == 0, 'Invalid value');
}
// === KECCAK ONLY END ===


