use cairo_verifier::{
    stark::{StarkUnsentCommitment, StarkConfig, StarkCommitment, stark_commit::stark_commit},
    channel::channel::ChannelTrait,
    air::{
        public_input::{PublicInput, SegmentInfo}, public_memory::AddrValue,
        global_values::InteractionElements,
        traces::{TracesUnsentCommitment, TracesConfig, TracesCommitment}
    },
    fri::fri::{FriUnsentCommitment, FriConfig, FriCommitment},
    proof_of_work::{proof_of_work::ProofOfWorkUnsentCommitment, config::ProofOfWorkConfig},
    table_commitment::table_commitment::{TableCommitmentConfig, TableCommitment},
    vector_commitment::vector_commitment::{VectorCommitmentConfig, VectorCommitment},
    domains::StarkDomains, tests::stone_proof_fibonacci,
};

fn get() -> StarkConfig {
    return StarkConfig {
        traces: stone_proof_fibonacci::traces::config::get(),
        composition: TableCommitmentConfig {
            n_columns: 0x2,
            vector: VectorCommitmentConfig {
                height: 0x16, n_verifier_friendly_commitment_layers: 0x16,
            },
        },
        fri: stone_proof_fibonacci::fri::config::get(),
        proof_of_work: stone_proof_fibonacci::proof_of_work::config::get(),
        log_trace_domain_size: 0x12,
        n_queries: 0x12,
        log_n_cosets: 0x4,
        n_verifier_friendly_commitment_layers: 0x16,
    };
}
