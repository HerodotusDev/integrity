use integrity::{
    channel::channel::ChannelTrait, fri::fri::fri_commit, tests::stone_proof_fibonacci_keccak,
};

fn bench_fri_commit() {
    let mut channel = ChannelTrait::new_with_counter(
        0x3612d68f9f68b263d83b0854b812018fd1b7ba0359d7514fffdabd44f0696e6, 0x1
    );

    let fri_config = stone_proof_fibonacci_keccak::fri::config::get();
    let unsent_commitment = stone_proof_fibonacci_keccak::fri::unsent_commitment::get();

    fri_commit(ref channel, unsent_commitment, fri_config);
}
