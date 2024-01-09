use cairo_verifier::proof_of_work::config::ProofOfWorkConfigTrait;
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

fn stark_config_validate(stark_config: StarkConfig, security_bits: felt252) {
    stark_config.proof_of_work.config_validate();

    // let log_eval_domain_size = stark_config.log_trace_domain_size + stark_config.log_n_cosets;
    // traces_config_validate(stark_config.traces, log_eval_domain_size, security_bits);

    // validate_vector_commitment(
    //     stark_config.composition.vector,
    //     log_eval_domain_size,
    //     stark_config.n_verifier_friendly_commitment_layers
    // );
    // fri_config_validate(
    //     stark_config.fri.into(),
    //     stark_config.log_n_cosets,
    //     stark_config.n_verifier_friendly_commitment_layers
    // );
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
