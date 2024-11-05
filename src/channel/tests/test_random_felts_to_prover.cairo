use integrity::channel::channel::ChannelTrait;

#[test]
#[available_gas(9999999999)]
fn test_random_felts_to_prover() {
    let mut channel = ChannelTrait::new_with_counter(
        0x55c2e30068db90407013a4cfcedee7895b328c6ba64b8bd5e4c71e470af5fde, 0x0
    );

    assert(
        channel
            .random_felts_to_prover(
                3
            ) == array![
                0x120149e03e4939d3c2a4ca2fcaa6e9cfff0c64fbe115f54c439d76ff09c3dc7,
                0x3639344cc4b04d4c710b812e109e21f43f87c68d8648749cb25d30503037e4d,
                0xeca2849fb4c4c8e734eafe6d9cb7256c0f1bb43a5c4f2d27090cd8df21a699,
            ],
        'invalid random felts'
    );
    assert(
        channel.digest == 0x55c2e30068db90407013a4cfcedee7895b328c6ba64b8bd5e4c71e470af5fde,
        'Invalid value'
    );
    assert(channel.counter == 0x3, 'Invalid value');
}
