use cairo_verifier::channel::channel::ChannelTrait;

// test data from cairo0-verifier run on stone-prover generated proof
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

// test data from cairo0-verifier run on stone-prover generated proof
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