use integrity::{
    air::layouts::recursive::{traces::TracesCommitment, global_values::InteractionElements},
    table_commitment::table_commitment::TableCommitment,
    vector_commitment::vector_commitment::{VectorCommitmentConfig, VectorCommitment},
    tests::stone_proof_fibonacci_keccak,
};

fn get() -> TracesCommitment {
    let unsent_commitment = stone_proof_fibonacci_keccak::traces::unsent_commitment::get();
    let traces_config = stone_proof_fibonacci_keccak::traces::config::get();

    return TracesCommitment {
        original: TableCommitment {
            config: traces_config.original,
            vector_commitment: VectorCommitment {
                config: VectorCommitmentConfig {
                    height: 0x14, n_verifier_friendly_commitment_layers: 0x64
                },
                commitment_hash: unsent_commitment.original,
            },
        },
        interaction_elements: stone_proof_fibonacci_keccak::interaction_elements::get(),
        interaction: TableCommitment {
            config: traces_config.interaction,
            vector_commitment: VectorCommitment {
                config: VectorCommitmentConfig {
                    height: 0x14, n_verifier_friendly_commitment_layers: 0x64
                },
                commitment_hash: unsent_commitment.interaction,
            },
        },
    };
}
