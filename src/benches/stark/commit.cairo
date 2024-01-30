use cairo_verifier::{
    stark::stark_commit::stark_commit, channel::channel::ChannelTrait, tests::stone_proof_fibonacci,
};

fn bench_stark_commit() {
    let mut channel = ChannelTrait::new_with_counter(
        u256 { low: 0xba9d17a3ebd900899148b125421c118f, high: 0x87433b8dd90acbfe5abea8474d795191 },
        0x0
    );

    let public_input = stone_proof_fibonacci::public_input::get();
    let unsent_commitment = stone_proof_fibonacci::stark::unsent_commitment::get();
    let config = stone_proof_fibonacci::stark::config::get();
    let stark_domains = stone_proof_fibonacci::stark::domains::get();

    stark_commit(ref channel, @public_input, @unsent_commitment, @config, @stark_domains);
}
