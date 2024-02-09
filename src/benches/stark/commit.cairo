use cairo_verifier::{
    stark::stark_commit::stark_commit, channel::channel::ChannelTrait,
    tests::stone_proof_fibonacci,
};

fn bench_stark_commit() {
    let mut channel = ChannelTrait::new_with_counter(
        u256 { low: 0x22b3f4d7841a28271009bef644a84a5e, high: 0x8f17c0c0dcde2144cd36213ab3aaff1b },
        0x0
    );

    let public_input = stone_proof_fibonacci::public_input::get();
    let unsent_commitment = stone_proof_fibonacci::stark::unsent_commitment::get();
    let config = stone_proof_fibonacci::stark::config::get();
    let stark_domains = stone_proof_fibonacci::stark::domains::get();

    stark_commit(ref channel, @public_input, @unsent_commitment, @config, @stark_domains);
}
