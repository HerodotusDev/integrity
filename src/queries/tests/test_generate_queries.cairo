use cairo_verifier::{
    queries::queries::generate_queries, channel::channel::ChannelTrait,
    tests::stone_proof_fibonacci_keccak
};

// test data from cairo0-verifier keccak-native run on stone-prover generated proof
#[test]
#[available_gas(9999999999)]
fn test_generate_queries_0() {
    let mut channel = ChannelTrait::new(
        u256 { low: 0x210c99e614db21dcd882b7f3734a477b, high: 0x29786ad320869955ebf8c196e16009e1 }
    );
    assert(
        generate_queries(ref channel, 18, 0x400000) == stone_proof_fibonacci_keccak::queries::get(),
        'Invalid value'
    );
    assert(channel.counter == 5, 'Invalid value');
}
