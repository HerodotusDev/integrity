use cairo_verifier::{
    channel::channel::ChannelImpl,
    air::{traces::{traces_commit, traces_decommit}, traces::TracesConfigTrait},
    tests::stone_proof_fibonacci_keccak,
};

// test data from cairo0-verifier keccak-native run on stone-prover generated proof
#[test]
#[available_gas(9999999999)]
fn test_traces_config() {
    let traces_config = stone_proof_fibonacci_keccak::traces::config::get();

    traces_config.validate(0x16, 0x64);
}

// test data from cairo0-verifier keccak-native run on stone-prover generated proof
#[test]
#[available_gas(9999999999)]
fn test_traces_commit() {
    let mut channel = ChannelImpl::new_with_counter(
        u256 { low: 0x22b3f4d7841a28271009bef644a84a5e, high: 0x8f17c0c0dcde2144cd36213ab3aaff1b },
        0x0,
    );
    let public_input = @stone_proof_fibonacci_keccak::public_input::get();
    let unsent_commitment = stone_proof_fibonacci_keccak::traces::unsent_commitment::get();
    let traces_config = stone_proof_fibonacci_keccak::traces::config::get();

    assert(
        traces_commit(
            ref channel, public_input, unsent_commitment, traces_config
        ) == stone_proof_fibonacci_keccak::traces::commitment::get(),
        'Invalid value'
    );

    assert(
        channel
            .digest == u256 {
                low: 0xa1a3e0273721e6961814f180b2d8caeb, high: 0x6f68726d3fdeb87e6c9b3d3072531b07
            },
        'Invalid value'
    );

    assert(channel.counter == 0x0, 'Invalid value')
}

// test data from cairo0-verifier keccak-native run on stone-prover generated proof
#[test]
#[available_gas(9999999999)]
fn test_traces_decommit() {
    let queries = stone_proof_fibonacci_keccak::queries::get().span();
    let commitment = stone_proof_fibonacci_keccak::traces::commitment::get();
    let decommitment = stone_proof_fibonacci_keccak::traces::decommitment::get();
    let witness = stone_proof_fibonacci_keccak::traces::witness::get();

    traces_decommit(queries, commitment, decommitment, witness);
}
