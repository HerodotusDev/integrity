use integrity::vector_commitment::vector_commitment::{
    VectorCommitmentConfig, VectorCommitmentWitness
};

#[derive(Drop, Serde)]
struct VectorCommitmentConfigWithSerde {
    height: felt252,
    n_verifier_friendly_commitment_layers: felt252,
}
impl IntoVectorCommitmentConfig of Into<VectorCommitmentConfigWithSerde, VectorCommitmentConfig> {
    fn into(self: VectorCommitmentConfigWithSerde) -> VectorCommitmentConfig {
        VectorCommitmentConfig {
            height: self.height,
            n_verifier_friendly_commitment_layers: self.n_verifier_friendly_commitment_layers,
        }
    }
}

#[derive(Drop, Serde)]
struct VectorCommitmentWitnessWithSerde {
    n_authentications: felt252,
    authentications: Array<felt252>,
}
impl IntoVectorCommitmentWitness of Into<
    VectorCommitmentWitnessWithSerde, VectorCommitmentWitness
> {
    fn into(self: VectorCommitmentWitnessWithSerde) -> VectorCommitmentWitness {
        VectorCommitmentWitness { authentications: self.authentications.span(), }
    }
}
