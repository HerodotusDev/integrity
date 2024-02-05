use cairo_verifier::{
    channel::channel::ChannelTrait, fri::fri::fri_commit, tests::stone_proof_fibonacci_keccak,
};

// test data from cairo0-verifier keccak-native run on stone-prover generated proof
#[test]
#[available_gas(9999999999)]
fn test_fri_commit() {
    let mut channel = ChannelTrait::new_with_counter(
        u256 { low: 0x7a2726f5068a28505c831535d1d24051, high: 0x7a7ff4546cc108f9b40fbb7c7c1c6cf2 },
        0x1
    );

    let fri_config = stone_proof_fibonacci_keccak::fri::config::get();
    let unsent_commitment = stone_proof_fibonacci_keccak::fri::unsent_commitment::get();

    assert(
        fri_commit(
            ref channel, unsent_commitment, fri_config
        ) == stone_proof_fibonacci_keccak::fri::commitment::get(),
        'Invalid value'
    );
}
