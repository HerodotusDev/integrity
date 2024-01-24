use cairo_verifier::{
    channel::channel::ChannelTrait, fri::fri::fri_commit, tests::stone_proof_fibonacci,
};

// test data from cairo0-verifier run on stone-prover generated proof
#[test]
#[available_gas(9999999999)]
fn test_fri_commit() {
    let mut channel = ChannelTrait::new_with_counter(
        u256 { low: 0xaddb0b52526024a1fd926e5da9d8d0ec, high: 0x4b7afc7a5bab4c0aab0b403f8daf81cf },
        0x1
    );

    let fri_config = stone_proof_fibonacci::fri::config::get();
    let unsent_commitment = stone_proof_fibonacci::fri::unsent_commitment::get();

    assert(
        fri_commit(
            ref channel, unsent_commitment, fri_config
        ) == stone_proof_fibonacci::fri::commitment::get(),
        'Invalid value'
    );
}
