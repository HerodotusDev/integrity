use cairo_verifier::{
    air::{
        traces_config::{TracesConfig, TracesConfigTrait}, public_input::PublicInput,
        traces::{TracesUnsentCommitment, TracesDecommitment, TracesWitness}
    },
    fri::{fri_config::{FriConfig, FriConfigTrait}, fri::{FriUnsentCommitment, FriWitness}},
    table_commitment::{TableCommitmentConfig, TableCommitmentWitness, TableDecommitment},
    proof_of_work::{
        config::{ProofOfWorkConfig, ProofOfWorkConfigTrait},
        proof_of_work::ProofOfWorkUnsentCommitment
    },
    vector_commitment::vector_commitment::VectorCommitmentConfigTrait,
};

mod stark_commit;
mod stark_verify;

#[cfg(test)]
mod tests;

const SECURITY_BITS: felt252 = 9;


#[derive(Drop)]
struct StarkProof {
    config: StarkConfig,
    public_input: PublicInput,
    unsent_commitment: StarkUnsentCommitment,
    witness: StarkWitness,
}

#[generate_trait]
impl StarkProofImpl of StarkProofTrait {
    fn verify(self: @StarkProof) {
        self.config.validate(SECURITY_BITS);
    }
}


#[derive(Drop, Copy)]
struct StarkConfig {
    traces: TracesConfig,
    composition: TableCommitmentConfig,
    fri: FriConfig,
    proof_of_work: ProofOfWorkConfig,
    // Log2 of the trace domain size.
    log_trace_domain_size: felt252,
    // Number of queries to the last component, FRI.
    n_queries: felt252,
    // Log2 of the number of cosets composing the evaluation domain, where the coset size is the
    // trace length.
    log_n_cosets: felt252,
    // Number of layers that use a verifier friendly hash in each commitment.
    n_verifier_friendly_commitment_layers: felt252,
}

#[generate_trait]
impl StarkConfigImpl of StarkConfigTrait {
    fn validate(self: @StarkConfig, security_bits: felt252) {
        self.proof_of_work.config_validate();

        let log_eval_domain_size = *self.log_trace_domain_size + *self.log_n_cosets;
        self.traces.validate(log_eval_domain_size, security_bits);

        self
            .composition
            .vector
            .validate(log_eval_domain_size, *self.n_verifier_friendly_commitment_layers);

        self.fri.validate(*self.log_n_cosets, *self.n_verifier_friendly_commitment_layers);
    }
}

#[derive(Drop)]
struct StarkUnsentCommitment {
    traces: TracesUnsentCommitment,
    composition: felt252,
    oods_values: Span<felt252>,
    fri: FriUnsentCommitment,
    proof_of_work: ProofOfWorkUnsentCommitment,
}

#[derive(Drop)]
struct StarkWitness {
    traces_decommitment: TracesDecommitment,
    traces_witness: TracesWitness,
    interaction: TableCommitmentWitness,
    composition_decommitment: TableDecommitment,
    composition_witness: TableCommitmentWitness,
    fri_witness: FriWitness,
}
