use cairo_verifier::structs::traces_config::TracesConfig;
use cairo_verifier::table_commitment::TableCommitmentConfig;
use cairo_verifier::fri::fri_config::FriConfig;
use cairo_verifier::structs::proof_of_work_config::ProofOfWorkConfig;

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
