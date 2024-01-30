use cairo_verifier::{
    channel::channel::Channel,
    vector_commitment::vector_commitment::{VectorCommitmentConfig, vector_commit}
};

fn bench_vector_commitment_commit() {
    let mut channel = Channel {
        digest: 0x0f089f70240c88c355168624ec69ffa679a81fbc7d4d47306edc4b57f2fa327f,
        counter: 0x1690c7c85c57a4897623c1364852d8df91e4b36675085fddc7d10a7ea946fcbd,
    };
    let unsent_felt: felt252 = 0x4b774418541bbe409a801463d95e65b16da2be518ae8c7647867dc57911cd3e;
    let config = VectorCommitmentConfig { height: 15, n_verifier_friendly_commitment_layers: 5, };

    vector_commit(ref channel, unsent_felt, config);
}
