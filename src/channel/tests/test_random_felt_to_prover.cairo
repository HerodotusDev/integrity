use integrity::channel::channel::ChannelTrait;

#[test]
#[available_gas(9999999999)]
fn test_random_felts_to_prover_0() {
    let mut channel = ChannelTrait::new_with_counter(
        0x55c2e30068db90407013a4cfcedee7895b328c6ba64b8bd5e4c71e470af5fde, 0x0
    );

    assert(
        channel
            .random_felt_to_prover() == 0x120149e03e4939d3c2a4ca2fcaa6e9cfff0c64fbe115f54c439d76ff09c3dc7,
        'invalid random felts'
    );
    assert(
        channel.digest == 0x55c2e30068db90407013a4cfcedee7895b328c6ba64b8bd5e4c71e470af5fde,
        'Invalid value'
    );
    assert(channel.counter == 0x1, 'Invalid value');
}

#[test]
#[available_gas(9999999999)]
fn test_random_felts_to_prover_1() {
    let mut channel = ChannelTrait::new_with_counter(
        0xc5952bab5731090a953716ac821ee7374cc6c4bad31d21b7134f62d6e00593, 0x1
    );

    assert(
        channel
            .random_felt_to_prover() == 0x2aaadb36d1b43f25fa226bf80910dbf930cde1b14b6fea843ae83ff4ed3babc,
        'invalid random felts'
    );
    assert(
        channel.digest == 0xc5952bab5731090a953716ac821ee7374cc6c4bad31d21b7134f62d6e00593,
        'Invalid value'
    );
    assert(channel.counter == 0x2, 'Invalid value');
}
