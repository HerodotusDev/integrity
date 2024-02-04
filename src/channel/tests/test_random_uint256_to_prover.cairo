use cairo_verifier::channel::channel::ChannelTrait;

// test data from cairo0-verifier-keccak-native run on stone-prover generated proof
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

// test data from cairo0-verifier-keccak-native run on stone-prover generated proof
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

// test data from cairo0-verifier-keccak-native run on stone-prover generated proof
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
