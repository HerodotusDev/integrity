use cairo_verifier::channel::channel::ChannelTrait;

#[test]
#[available_gas(9999999999)]
fn test_random_uint256_to_prover_0() {
    let mut channel = ChannelTrait::new_with_counter(
        u256 { low: 0xf59fd6b10ccc33fe2e1e1e94e3411f56, high: 0x6572033443ae2c5f7b83bfdcd817240e },
        0x0
    );
    assert(
        channel
            .random_uint256_to_prover() == u256 {
                low: 0x5f1758ec5d5517006c3eac3c624dcda2, high: 0xb24fe50c70859073b185937f3e1eb93d
            },
        'Invalid value'
    );
}

#[test]
#[available_gas(9999999999)]
fn test_random_uint256_to_prover_1() {
    let mut channel = ChannelTrait::new_with_counter(
        u256 { low: 0xf59fd6b10ccc33fe2e1e1e94e3411f56, high: 0x6572033443ae2c5f7b83bfdcd817240e },
        0x1
    );
    assert(
        channel
            .random_uint256_to_prover() == u256 {
                low: 0xad772a40c7f3c4e6f77db1daa5f8d8e, high: 0x96014698ef9d4df3438cf2da8aa483a4
            },
        'Invalid value'
    );
}

#[test]
#[available_gas(9999999999)]
fn test_random_uint256_to_prover_2() {
    let mut channel = ChannelTrait::new_with_counter(
        u256 { low: 0x8823a41f7994f81c6453f4bc3cad1c10, high: 0x75f85ae3fd3ff6b5f63029a51040037e },
        0x0
    );
    assert(
        channel
            .random_uint256_to_prover() == u256 {
                low: 0xf1466cd5383c0644def10ee2658b7a05, high: 0x32f0741071fba06bdee46d938b942542
            },
        'Invalid value'
    );
}

#[test]
#[available_gas(9999999999)]
fn test_random_uint256_to_prover_3() {
    let mut channel = ChannelTrait::new_with_counter(
        u256 { low: 0x89a405dfb23e546ad03d498e88dee3ba, high: 0xe614bdb3e56768f45a22fd34e999734c },
        0x0
    );
    assert(
        channel
            .random_uint256_to_prover() == u256 {
                low: 0x538dd6434921187f80b76fd1d804af3b, high: 0x1172f921f177f82f29a3d97f9cffd2df
            },
        'Invalid value'
    );
}

#[test]
#[available_gas(9999999999)]
fn test_random_uint256_to_prover_4() {
    let mut channel = ChannelTrait::new(0);
    let random = channel.random_uint256_to_prover();
    assert(
        random == 0xae09db7cd54f42b490ef09b6bc541af688e4959bb8c53f359a6f56e38ab454a3,
        'invalid random uint256'
    );
}
