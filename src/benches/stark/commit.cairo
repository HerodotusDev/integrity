use integrity::{
    stark::stark_commit::stark_commit, channel::channel::ChannelTrait,
    tests::stone_proof_fibonacci_keccak,
};

fn bench_stark_commit() {
    let mut channel = ChannelTrait::new_with_counter(
        0xaf91f2c71f4a594b1575d258ce82464475c82d8fb244142d0db450491c1b52, 0x0
    );

    let public_input = stone_proof_fibonacci_keccak::public_input::get();
    let unsent_commitment = stone_proof_fibonacci_keccak::stark::unsent_commitment::get();
    let config = stone_proof_fibonacci_keccak::stark::config::get();
    let stark_domains = stone_proof_fibonacci_keccak::stark::domains::get();

    stark_commit(
        ref channel,
        @public_input,
        @unsent_commitment,
        @config,
        @stark_domains,
        0.try_into().unwrap()
    );
}
