use cairo_verifier::stark::stark_commit::stark_commit;
use cairo_verifier::channel::channel::ChannelTrait;
use cairo_verifier::air::public_input::PublicInput;
use cairo_verifier::air::global_values::InteractionElements;
use cairo_verifier::stark::{StarkUnsentCommitment, StarkConfig, StarkCommitment};
use cairo_verifier::air::traces::{TracesUnsentCommitment, TracesConfig, TracesCommitment};
use cairo_verifier::fri::fri::{FriUnsentCommitment, FriConfig, FriCommitment};
use cairo_verifier::proof_of_work::proof_of_work::ProofOfWorkUnsentCommitment;
use cairo_verifier::proof_of_work::config::ProofOfWorkConfig;
use cairo_verifier::table_commitment::table_commitment::{TableCommitmentConfig, TableCommitment};
use cairo_verifier::vector_commitment::vector_commitment::{
    VectorCommitmentConfig, VectorCommitment
};
use cairo_verifier::domains::StarkDomains;

#[test]
#[available_gas(9999999999)]
fn test_stark_commit() {
    let mut channel = ChannelTrait::new_with_counter(
        u256 { low: 0xba9d17a3ebd900899148b125421c118f, high: 0x87433b8dd90acbfe5abea8474d795191 },
        0x0
    );

    let public_input = @PublicInput {
        log_n_steps: 0,
        rc_min: 0,
        rc_max: 0,
        layout: 0,
        dynamic_params: array![],
        segments: array![],
        padding_addr: 0,
        padding_value: 0,
        main_page: array![],
        continuous_page_headers: array![],
    };

    let unsent_commitment = @StarkUnsentCommitment {
        traces: TracesUnsentCommitment { original: 0x0, interaction: 0x0, },
        composition: 0x0,
        oods_values: array![].span(),
        fri: FriUnsentCommitment {
            inner_layers: array![].span(), last_layer_coefficients: array![].span(),
        },
        proof_of_work: ProofOfWorkUnsentCommitment { nonce: 0, },
    };

    let config = @StarkConfig {
        traces: TracesConfig {
            original: TableCommitmentConfig {
                n_columns: 0x0,
                vector: VectorCommitmentConfig {
                    height: 0x0, n_verifier_friendly_commitment_layers: 0x0,
                }
            },
            interaction: TableCommitmentConfig {
                n_columns: 0x0,
                vector: VectorCommitmentConfig {
                    height: 0x0, n_verifier_friendly_commitment_layers: 0x0,
                }
            },
        },
        composition: TableCommitmentConfig {
            n_columns: 0x0,
            vector: VectorCommitmentConfig {
                height: 0x0, n_verifier_friendly_commitment_layers: 0x0,
            }
        },
        fri: FriConfig {
            log_input_size: 0x0,
            n_layers: 0x0,
            inner_layers: array![].span(),
            fri_step_sizes: array![].span(),
            log_last_layer_degree_bound: 0x0,
        },
        proof_of_work: ProofOfWorkConfig { n_bits: 0x0, },
        log_trace_domain_size: 0x0,
        n_queries: 0x0,
        log_n_cosets: 0x0,
        n_verifier_friendly_commitment_layers: 0x0,
    };

    let stark_domains = @StarkDomains {
        log_eval_domain_size: 0x0,
        eval_domain_size: 0x0,
        eval_generator: 0x0,
        log_trace_domain_size: 0x0,
        trace_domain_size: 0x0,
        trace_generator: 0x0,
    };

    assert(
        stark_commit(
            ref channel, public_input, unsent_commitment, config, stark_domains
        ) == StarkCommitment {
            traces: TracesCommitment {
                public_input: public_input,
                original: TableCommitment {
                    config: TableCommitmentConfig {
                        n_columns: 0x0,
                        vector: VectorCommitmentConfig {
                            height: 0x0, n_verifier_friendly_commitment_layers: 0x0,
                        }
                    },
                    vector_commitment: VectorCommitment {
                        config: VectorCommitmentConfig {
                            height: 0x0, n_verifier_friendly_commitment_layers: 0x0,
                        },
                        commitment_hash: 0x0
                    },
                },
                interaction_elements: InteractionElements {
                    memory_multi_column_perm_perm_interaction_elm: 0x0,
                    memory_multi_column_perm_hash_interaction_elm0: 0x0,
                    rc16_perm_interaction_elm: 0x0,
                    diluted_check_permutation_interaction_elm: 0x0,
                    diluted_check_interaction_z: 0x0,
                    diluted_check_interaction_alpha: 0x0,
                },
                interaction: TableCommitment {
                    config: TableCommitmentConfig {
                        n_columns: 0x0,
                        vector: VectorCommitmentConfig {
                            height: 0x0, n_verifier_friendly_commitment_layers: 0x0,
                        }
                    },
                    vector_commitment: VectorCommitment {
                        config: VectorCommitmentConfig {
                            height: 0x0, n_verifier_friendly_commitment_layers: 0x0,
                        },
                        commitment_hash: 0x0
                    },
                },
            },
            composition: TableCommitment {
                config: TableCommitmentConfig {
                    n_columns: 0x0,
                    vector: VectorCommitmentConfig {
                        height: 0x0, n_verifier_friendly_commitment_layers: 0x0,
                    }
                },
                vector_commitment: VectorCommitment {
                    config: VectorCommitmentConfig {
                        height: 0x0, n_verifier_friendly_commitment_layers: 0x0,
                    },
                    commitment_hash: 0x0
                },
            },
            interaction_after_composition: 0x0,
            oods_values: array![].span(),
            interaction_after_oods: array![].span(),
            fri: FriCommitment {
                config: FriConfig {
                    log_input_size: 0x16,
                    n_layers: 0x5,
                    inner_layers: array![].span(),
                    fri_step_sizes: array![0x0, 0x4, 0x3, 0x2, 0x2,].span(),
                    log_last_layer_degree_bound: 0x7,
                },
                inner_layers: array![].span(),
                eval_points: array![].span(),
                last_layer_coefficients: array![].span(),
            },
        },
        'Invalid value'
    );

    assert(
        channel
            .digest == u256 {
                low: 0x2c31f04a6b9c83c2464b2f1688fc719e, high: 0xe631d91ef56f7e4cc7fe09cff2cc4e94
            },
        'Invalid value'
    );
    assert(channel.counter == 0, 'Invalid value');
}
