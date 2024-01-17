use cairo_verifier::channel::channel::ChannelTrait;

#[test]
#[available_gas(9999999999)]
fn test_read_truncated_hash_from_prover_0() {
    let mut channel = ChannelTrait::new_with_counter(
        u256 { low: 0xba9d17a3ebd900899148b125421c118f, high: 0x87433b8dd90acbfe5abea8474d795191 },
        0x0
    );
    channel
        .read_truncated_hash_from_prover(
            0xa43e1b3b99d987d63116edc58aa49a7d510a667951852446419df5ede6a1cc
        );
    assert(
        channel
            .digest == u256 {
                low: 0xf59fd6b10ccc33fe2e1e1e94e3411f56, high: 0x6572033443ae2c5f7b83bfdcd817240e
            },
        'Invalid value'
    );
    assert(channel.counter == 0, 'Invalid value');
}

#[test]
#[available_gas(9999999999)]
fn test_read_truncated_hash_from_prover_1() {
    let mut channel = ChannelTrait::new_with_counter(
        u256 { low: 0xf59fd6b10ccc33fe2e1e1e94e3411f56, high: 0x6572033443ae2c5f7b83bfdcd817240e },
        0x6
    );
    channel
        .read_truncated_hash_from_prover(
            0x32b3d365d461b6c12ab7d3396b5225903bd17bc85216f300472afea65cab39a
        );
    assert(
        channel
            .digest == u256 {
                low: 0x8823a41f7994f81c6453f4bc3cad1c10, high: 0x75f85ae3fd3ff6b5f63029a51040037e
            },
        'Invalid value'
    );
    assert(channel.counter == 0, 'Invalid value');
}

#[test]
#[available_gas(9999999999)]
fn test_read_truncated_hash_from_prover_2() {
    let mut channel = ChannelTrait::new_with_counter(
        u256 { low: 0x98cbce1a1c901460027570bd9aa93ccb, high: 0x2581182ce5a51e9dd0810917ad7250ab },
        0x1
    );
    channel
        .read_truncated_hash_from_prover(
            0x7a73129c87d8a60cb07b26775437ac75790bbd415d47912e5eb1f7c7e11d42f
        );
    assert(
        channel
            .digest == u256 {
                low: 0x8a067e49d4c4f2bf2ca4e499d36bd71a, high: 0x4548bed8d91372df1a7674e0471e76e3
            },
        'Invalid value'
    );
    assert(channel.counter == 0, 'Invalid value');
}
