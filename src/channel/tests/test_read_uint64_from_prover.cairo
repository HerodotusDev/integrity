use cairo_verifier::channel::channel::ChannelTrait;

// === BLAKE ONLY BEGIN ===
// #[test]
// #[available_gas(9999999999)]
// fn test_read_uint64_from_prover_0() {
//     let mut channel = ChannelTrait::new_with_counter(0x0, 0x0);
//     channel.read_uint64_from_prover(0x40719c5);
//     assert(channel.digest == 0x0, 'Invalid value');
//     assert(channel.counter == 0, 'Invalid value');
// }
// === BLAKE ONLY END ===

// === KECCAK ONLY BEGIN ===
#[test]
#[available_gas(9999999999)]
fn test_read_uint64_from_prover_0() {
    let mut channel = ChannelTrait::new_with_counter(0x0, 0x0);
    channel.read_uint64_from_prover(0xd65397f);
    assert(channel.digest == 0x0, 'Invalid value');
    assert(channel.counter == 0, 'Invalid value');
}
// === KECCAK ONLY END ===


