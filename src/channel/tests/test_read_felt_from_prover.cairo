use cairo_verifier::channel::channel::ChannelTrait;

// test data from cairo0-verifier run on stone-prover generated proof
#[test]
#[available_gas(9999999999)]
fn test_read_felt_from_prover_0() {
    let mut channel = ChannelTrait::new_with_counter(
        u256 { low: 0x89a405dfb23e546ad03d498e88dee3ba, high: 0xe614bdb3e56768f45a22fd34e999734c },
        0x1
    );
    channel
        .read_felt_from_prover(0x3a63c21f32409c9ec7614199b40102547e7f698f903bdbbffe56785684b7e04);
    assert(
        channel
            .digest == u256 {
                low: 0xc123a2db28e4f285115f8c72934264ea, high: 0x810c2a15f74c5a93239754103cde49b0
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
        u256 { low: 0xc123a2db28e4f285115f8c72934264ea, high: 0x810c2a15f74c5a93239754103cde49b0 },
        0x0
    );
    channel
        .read_felt_from_prover(0x5652f216d992bbf255b97dd1b0a4dde72fab97f1bbcc4a4f53fde7fc50293c8);
    assert(
        channel
            .digest == u256 {
                low: 0x5f72255a95751e54a4f9704096d61310, high: 0x3c9277c30982b407ad5442334e7771d4
            },
        'Invalid value'
    );
    assert(channel.counter == 0, 'Invalid value');
}

// test data from cairo0-verifier run on stone-prover generated proof
#[test]
#[available_gas(9999999999)]
fn test_read_felt_from_prover_2() {
    let mut channel = ChannelTrait::new_with_counter(
        u256 { low: 0xfc5a98310398b13c3218fdeb624ec8f8, high: 0x59dfc32f7867d987d2d504e264f97faa },
        0x0
    );
    channel
        .read_felt_from_prover(0x787521b50c17169b9729a4522e1a0e7bdc028fc8ffdd87c70147bd67c5595d3);
    assert(
        channel
            .digest == u256 {
                low: 0x746ca09ffaaea6826e10c1b343da771e, high: 0x24a6464484140e30a7f7497204b5abbe
            },
        'Invalid value'
    );
    assert(channel.counter == 0, 'Invalid value');
}
