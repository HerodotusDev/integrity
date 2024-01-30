use cairo_verifier::{
    channel::channel::ChannelImpl, air::{traces::traces_decommit}, tests::stone_proof_fibonacci,
};

fn bench_air_traces_decommit() {
    let queries = stone_proof_fibonacci::queries::get().span();
    let commitment = stone_proof_fibonacci::traces::commitment::get();
    let decommitment = stone_proof_fibonacci::traces::decommitment::get();
    let witness = stone_proof_fibonacci::traces::witness::get();

    traces_decommit(queries, commitment, decommitment, witness);
}
