use integrity::channel::channel::ChannelTrait;

#[test]
#[available_gas(9999999999)]
fn test_read_felt_from_prover_0() {
    let mut channel = ChannelTrait::new_with_counter(
        0x6844d424314222ee92d547c4acf2e8bef666793a9ac7a87012e6ba2b4c79857, 0x0
    );
    channel
        .read_felt_from_prover(0x38eed0024fd52d22f0f2faf86d2a3d79cadad24762ee24ee457470cd6cd79f0);
    assert(
        channel.digest == 0x55c2e30068db90407013a4cfcedee7895b328c6ba64b8bd5e4c71e470af5fde,
        'Invalid value'
    );
    assert(channel.counter == 0x0, 'Invalid value');
}

#[test]
#[available_gas(9999999999)]
fn test_read_felt_from_prover_1() {
    let mut channel = ChannelTrait::new_with_counter(
        0x55c2e30068db90407013a4cfcedee7895b328c6ba64b8bd5e4c71e470af5fde, 0x3
    );
    channel.read_felt_from_prover(0xbf526d19978e73141431cd6f0e3131afb7ec700a07f41245aa510c5ea3d2f8);
    assert(
        channel.digest == 0x54d0627583471735a2948dbe3cf00d8104b8d99a3b3be8a8410daef4aa556f9,
        'Invalid value'
    );
    assert(channel.counter == 0x0, 'Invalid value');
}

