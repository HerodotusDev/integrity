use cairo_verifier::{
    air::{
        config::TracesConfig, public_input::PublicInput,
        traces::{TracesUnsentCommitment, TracesDecommitment, TracesWitness}
    },
    fri::{fri_config::FriConfig, fri::{FriUnsentCommitment, FriWitness}},
    table_commitment::{TableCommitmentConfig, TableCommitmentWitness, TableDecommitment},
    proof_of_work::{config::ProofOfWorkConfig, proof_of_work::ProofOfWorkUnsentCommitment},
};

mod stark_commit;
mod stark_verify;

#[cfg(test)]
mod tests;

#[derive(Drop)]
struct StarkProof {
    config: StarkConfig,
    public_input: PublicInput,
    unsent_commitment: StarkUnsentCommitment,
    witness: StarkWitness,
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

#[derive(Drop)]
struct StarkUnsentCommitment {
    traces: TracesUnsentCommitment,
    composition: felt252,
    oods_values: Array<felt252>,
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
