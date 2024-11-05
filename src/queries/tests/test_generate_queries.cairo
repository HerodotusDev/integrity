use integrity::{
    queries::queries::generate_queries, channel::channel::ChannelTrait,
    tests::{stone_proof_fibonacci, stone_proof_fibonacci_keccak}
};

#[test]
#[available_gas(9999999999)]
fn test_generate_queries_0() {
    let mut channel = ChannelTrait::new_with_counter(
        0x28f12249c8cba51796d59e7573019ce2b4608c9a8cdeee26e821b0763c69229, 0x0
    );
    assert(
        generate_queries(
            ref channel, 0xa, 0x100000
        ) == stone_proof_fibonacci_keccak::queries::get(),
        'Invalid value'
    );

    assert(
        channel.digest == 0x28f12249c8cba51796d59e7573019ce2b4608c9a8cdeee26e821b0763c69229,
        'Invalid value'
    );
    assert(channel.counter == 0xa, 'Invalid value');
}
