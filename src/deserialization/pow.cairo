use integrity::proof_of_work::{
    config::ProofOfWorkConfig, proof_of_work::ProofOfWorkUnsentCommitment
};

#[derive(Drop, Serde)]
struct ProofOfWorkConfigWithSerde {
    // Proof of work difficulty (number of bits required to be 0).
    n_bits: felt252,
}
impl IntoProofOfWorkConfig of Into<ProofOfWorkConfigWithSerde, ProofOfWorkConfig> {
    fn into(self: ProofOfWorkConfigWithSerde) -> ProofOfWorkConfig {
        ProofOfWorkConfig { n_bits: self.n_bits.try_into().unwrap(), }
    }
}

#[derive(Drop, Serde)]
struct ProofOfWorkUnsentCommitmentWithSerde {
    nonce: felt252,
}
impl IntoProofOfWorkUnsentCommitment of Into<
    ProofOfWorkUnsentCommitmentWithSerde, ProofOfWorkUnsentCommitment
> {
    fn into(self: ProofOfWorkUnsentCommitmentWithSerde) -> ProofOfWorkUnsentCommitment {
        ProofOfWorkUnsentCommitment { nonce: self.nonce.try_into().unwrap(), }
    }
}
