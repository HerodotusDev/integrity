use cairo_verifier::channel::channel::ChannelTrait;

#[test]
#[available_gas(9999999999)]
fn test_read_uint64_from_prover_0() {
    let mut channel = ChannelTrait::new_with_counter(
        u256 { low: 0x15aa9b8787d877d61588844c0cfe2fb9, high: 0x7cd36c3da65b8d57331341e661a86574 },
        0x0
    );
    channel.read_uint64_from_prover(0x40719c5);
    assert(
        channel
            .digest == u256 {
                low: 0x2c31f04a6b9c83c2464b2f1688fc719e, high: 0xe631d91ef56f7e4cc7fe09cff2cc4e94
            },
        'Invalid value'
    );
    assert(channel.counter == 0, 'Invalid value');
}
