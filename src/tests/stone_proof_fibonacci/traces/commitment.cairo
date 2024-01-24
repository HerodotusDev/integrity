use cairo_verifier::{
    channel::channel::{Channel, ChannelImpl},
    air::{
        public_input::PublicInput,
        traces::{
            traces_commit, traces_decommit, TracesCommitment, TracesDecommitment, TracesWitness,
            TracesUnsentCommitment, TracesConfig
        },
        global_values::InteractionElements, traces::TracesConfigTrait,
    },
    table_commitment::table_commitment::{
        TableCommitment, TableCommitmentConfig, TableDecommitment, TableCommitmentWitness
    },
    vector_commitment::vector_commitment::{
        VectorCommitmentConfig, VectorCommitment, VectorCommitmentWitness
    },
    tests::stone_proof_fibonacci,
};

fn get() -> TracesCommitment {
    let public_input = @stone_proof_fibonacci::public_input::get();
    let unsent_commitment = stone_proof_fibonacci::traces::unsent_commitment::get();
    let traces_config = stone_proof_fibonacci::traces::config::get();

    return TracesCommitment {
        public_input: public_input,
        original: TableCommitment {
            config: traces_config.original,
            vector_commitment: VectorCommitment {
                config: VectorCommitmentConfig {
                    height: 0x16, n_verifier_friendly_commitment_layers: 0x16
                },
                commitment_hash: unsent_commitment.original,
            },
        },
        interaction_elements: InteractionElements {
            memory_multi_column_perm_perm_interaction_elm: 0x46ecc57b0b528c3dde60dbb870596694b2879c57d0b0a34ac1122ebea470a8d,
            memory_multi_column_perm_hash_interaction_elm0: 0x207a232fb05d8c8261c44be98177c09634d23e7aaaf4838d435a4423e3a025f,
            rc16_perm_interaction_elm: 0x2984c71a0d0a47b1d9a406f6c7be890100941f67f5db0656970832e51d48ca6,
            diluted_check_permutation_interaction_elm: 0x7793f70cbb5b4ae3ac72e5bce7cd46d62cbe169227257e6925e5564e595ff88,
            diluted_check_interaction_z: 0x3c48e3094aeca888fe6781ad7594d14d7f88062bbe320c6d6913f44b116810,
            diluted_check_interaction_alpha: 0x1d7304763d588fc98a927959788ad2f21d76121918994f14fc417617e6e9747
        },
        interaction: TableCommitment {
            config: traces_config.interaction,
            vector_commitment: VectorCommitment {
                config: VectorCommitmentConfig {
                    height: 0x16, n_verifier_friendly_commitment_layers: 0x16
                },
                commitment_hash: unsent_commitment.interaction,
            },
        },
    };
}
