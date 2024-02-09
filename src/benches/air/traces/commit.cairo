use cairo_verifier::{
    channel::channel::ChannelImpl, air::{traces::traces_commit}, tests::stone_proof_fibonacci,
};

fn bench_air_traces_commit() {
    let mut channel = ChannelImpl::new_with_counter(
        u256 { low: 0xba9d17a3ebd900899148b125421c118f, high: 0x87433b8dd90acbfe5abea8474d795191 },
        0x0,
    );
    let public_input = @stone_proof_fibonacci::public_input::get();
    let unsent_commitment = stone_proof_fibonacci::traces::unsent_commitment::get();
    let traces_config = stone_proof_fibonacci::traces::config::get();

    traces_commit(ref channel, public_input, unsent_commitment, traces_config);
}
