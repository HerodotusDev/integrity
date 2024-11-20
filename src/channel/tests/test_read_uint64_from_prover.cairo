use integrity::channel::channel::ChannelTrait;

#[test]
#[available_gas(9999999999)]
fn test_read_uint64_from_prover_0() {
    let mut channel = ChannelTrait::new_with_counter(
        0x69eb7eb40004d1d7375b1ff9ccff8f7aed629e669b4fc3e11db4e748fdfbb2f, 0x0
    );
    channel.read_uint64_from_prover(0x1e7e0);
    assert(
        channel.digest == 0xc5952bab5731090a953716ac821ee7374cc6c4bad31d21b7134f62d6e00593,
        'Invalid value'
    );
    assert(channel.counter == 0x0, 'Invalid value');
}
