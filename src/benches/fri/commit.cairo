use cairo_verifier::{
    channel::channel::ChannelTrait, fri::fri::fri_commit, tests::stone_proof_fibonacci,
};

fn bench_fri_commit() {
    let mut channel = ChannelTrait::new_with_counter(
        u256 { low: 0x22b3f4d7841a28271009bef644a84a5e, high: 0x8f17c0c0dcde2144cd36213ab3aaff1b },
        0x0,
    );

    let fri_config = stone_proof_fibonacci::fri::config::get();
    let unsent_commitment = stone_proof_fibonacci::fri::unsent_commitment::get();

    fri_commit(ref channel, unsent_commitment, fri_config);
}
