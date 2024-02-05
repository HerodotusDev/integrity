use cairo_verifier::channel::channel::ChannelTrait;

// test data from cairo0-verifier keccak-native run on stone-prover generated proof
#[test]
#[available_gas(9999999999)]
fn test_read_uint64_from_prover_0() {
    let mut channel = ChannelTrait::new_with_counter(
        u256 { low: 0x6308b38ae2841c18fb8c06c9acc9bcd5, high: 0x5d35fab3c11198da5f6fe41666993b16 },
        0x0
    );
    channel.read_uint64_from_prover(0xd65397f);
    assert(
        channel
            .digest == u256 {
                low: 0x4ccd3b3aab8d3e3c4d99af0aa61de9d1, high: 0x8e5ef0503c12ab78b594db03b634546d
            },
        'Invalid value'
    );
    assert(channel.counter == 0, 'Invalid value');
}
