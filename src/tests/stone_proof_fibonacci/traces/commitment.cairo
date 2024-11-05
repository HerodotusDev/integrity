use integrity::{
    air::layouts::recursive::{traces::TracesCommitment, global_values::InteractionElements},
    table_commitment::table_commitment::TableCommitment,
    vector_commitment::vector_commitment::{VectorCommitmentConfig, VectorCommitment},
    tests::stone_proof_fibonacci,
};

fn get() -> TracesCommitment {
    let unsent_commitment = stone_proof_fibonacci::traces::unsent_commitment::get();
    let traces_config = stone_proof_fibonacci::traces::config::get();

    return TracesCommitment {
        original: TableCommitment {
            config: traces_config.original,
            vector_commitment: VectorCommitment {
                config: VectorCommitmentConfig {
                    height: 0x16, n_verifier_friendly_commitment_layers: 0x64
                },
                commitment_hash: unsent_commitment.original,
            },
        },
        interaction_elements: stone_proof_fibonacci::interaction_elements::get(),
        interaction: TableCommitment {
            config: traces_config.interaction,
            vector_commitment: VectorCommitment {
                config: VectorCommitmentConfig {
                    height: 0x16, n_verifier_friendly_commitment_layers: 0x64
                },
                commitment_hash: unsent_commitment.interaction,
            },
        },
    };
}
