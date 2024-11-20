use integrity::{
    channel::channel::ChannelImpl, air::layouts::recursive::{traces::traces_commit},
    tests::stone_proof_fibonacci_keccak,
};

fn bench_air_traces_commit() {
    let mut channel = ChannelImpl::new_with_counter(
        0xaf91f2c71f4a594b1575d258ce82464475c82d8fb244142d0db450491c1b52, 0x0
    );
    let unsent_commitment = stone_proof_fibonacci_keccak::traces::unsent_commitment::get();
    let traces_config = stone_proof_fibonacci_keccak::traces::config::get();

    traces_commit(ref channel, unsent_commitment, traces_config);
}
