use cairo_verifier::channel::channel::ChannelTrait;

// test data from cairo0-verifier-keccak-native run on stone-prover generated proof
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

// test data from cairo0-verifier-keccak-native run on stone-prover generated proof
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

// test data from cairo0-verifier-keccak-native run on stone-prover generated proof
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
