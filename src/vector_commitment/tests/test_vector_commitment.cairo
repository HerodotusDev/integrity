use cairo_verifier::vector_commitment::vector_commitment::VectorCommitmentConfigTrait;
use cairo_verifier::vector_commitment::vector_commitment::{
    VectorCommitment, VectorCommitmentConfig, vector_commit
};
use cairo_verifier::channel::channel::Channel;


#[test]
#[available_gas(9999999999)]
fn test_vector_commit() {
    let mut channel = Channel {
        digest: 0x0f089f70240c88c355168624ec69ffa679a81fbc7d4d47306edc4b57f2fa327f,
        counter: 0x1690c7c85c57a4897623c1364852d8df91e4b36675085fddc7d10a7ea946fcbd,
    };
    let unsent_felt: felt252 = 0x4b774418541bbe409a801463d95e65b16da2be518ae8c7647867dc57911cd3e;
    let config = VectorCommitmentConfig { height: 15, n_verifier_friendly_commitment_layers: 5, };

    let res = vector_commit(ref channel, unsent_felt, config);

    assert(res.config.height == config.height, 'invalid config height');
    assert(
        res
            .config
            .n_verifier_friendly_commitment_layers == config
            .n_verifier_friendly_commitment_layers,
        'invalid config n_veri...'
    );
    assert(
        res.commitment_hash == 0x4b774418541bbe409a801463d95e65b16da2be518ae8c7647867dc57911cd3e,
        'invalid commitment_hash'
    );
}

#[test]
#[available_gas(9999999999)]
fn test_validate_vector_commitment() {
    let config = VectorCommitmentConfig { height: 21, n_verifier_friendly_commitment_layers: 7, };
    config.validate(21, 7);
}

#[test]
#[should_panic]
#[available_gas(9999999999)]
fn test_invalid_validate_vector_commitment_1() {
    let config = VectorCommitmentConfig { height: 21, n_verifier_friendly_commitment_layers: 7, };
    config.validate(21, 8);
}

#[test]
#[should_panic]
#[available_gas(9999999999)]
fn test_invalid_validate_vector_commitment_2() {
    let config = VectorCommitmentConfig { height: 21, n_verifier_friendly_commitment_layers: 7, };
    config.validate(22, 7);
}
