use integrity::{
    channel::channel::Channel,
    vector_commitment::vector_commitment::{
        VectorCommitment, VectorCommitmentConfig, vector_commit, VectorCommitmentConfigTrait
    }
};

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
