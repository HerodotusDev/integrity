use core::array::ArrayTrait;
use cairo_verifier::{
    air::{
        config::TracesConfig, public_input::PublicInput,
        traces::{TracesUnsentCommitment, TracesDecommitment, TracesWitness}
    },
    fri::{fri_config::FriConfig, fri::{FriUnsentCommitment, FriWitness, FriLayerWitness}},
    table_commitment::{TableCommitmentConfig, TableCommitmentWitness, TableDecommitment},
    proof_of_work::{config::ProofOfWorkConfig, proof_of_work::ProofOfWorkUnsentCommitment},
    vector_commitment::vector_commitment::VectorCommitmentWitness,
};

#[derive(Drop, Serde)]
struct StarkProofWithSerde {
    config: StarkConfigWithSerde,
    public_input: PublicInputWithSerde,
    unsent_commitment: StarkUnsentCommitmentWithSerde,
    witness: StarkWitnessWithSerde,
}

#[derive(Drop, Serde)]
struct PublicInputWithSerde {
    log_n_steps: felt252,
    range_check_min: felt252,
    range_check_max: felt252,
    layout: felt252,
    dynamic_params: Array<felt252>,
    n_segments: felt252,
    segments: Array<felt252>,
    padding_addr: felt252,
    padding_value: felt252,
    main_page_len: felt252,
    main_page: Array<felt252>,
    n_continuous_pages: felt252,
    continuous_page_headers: Array<felt252>,
}

#[derive(Drop, Serde)]
struct StarkConfigWithSerde {
    traces: TracesConfigWithSerde,
    composition: TableCommitmentConfigWithSerde,
    fri: FriConfigWithSerde,
    proof_of_work: ProofOfWorkConfigWithSerde,
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

#[derive(Drop, Serde)]
struct TracesConfigWithSerde {
    original: TableCommitmentConfigWithSerde,
    interaction: TableCommitmentConfigWithSerde,
}

#[derive(Drop, Serde)]
struct TableCommitmentConfigWithSerde {
    columns: felt252,
    vector: VectorCommitmentConfigWithSerde,
}

#[derive(Drop, Serde)]
struct VectorCommitmentConfigWithSerde {
    height: felt252,
    verifier_friendly_commitment_layers: felt252,
}

#[derive(Drop, Serde)]
struct FriConfigWithSerde {
    // Log2 of the size of the input layer to FRI.
    log_input_size: felt252,
    // Number of layers in the FRI. Inner + last layer.
    n_layers: felt252,
    // Array of size n_layers - 1, each entry is a configuration of a table commitment for the
    // corresponding inner layer.
    inner_layers: Array<felt252>,
    // Array of size n_layers, each entry represents the FRI step size,
    // i.e. the number of FRI-foldings between layer i and i+1.
    fri_step_sizes: Array<felt252>,
    log_last_layer_degree_bound: felt252,
}

#[derive(Drop, Serde)]
struct ProofOfWorkConfigWithSerde {
    // Proof of work difficulty (number of bits required to be 0).
    n_bits: felt252,
}

#[derive(Drop, Serde)]
struct StarkUnsentCommitmentWithSerde {
    traces: TracesUnsentCommitmentWithSerde,
    composition: felt252,
    oods_values: Array<felt252>,
    fri: FriUnsentCommitmentWithSerde,
    proof_of_work: ProofOfWorkUnsentCommitmentWithSerde,
}

#[derive(Drop, Serde)]
struct TracesUnsentCommitmentWithSerde {
    original: felt252,
    interaction: felt252,
}

#[derive(Drop, Serde)]
struct FriUnsentCommitmentWithSerde {
    inner_layers: Array<felt252>,
    last_layer_coefficients: Array<felt252>,
}

#[derive(Drop, Serde)]
struct ProofOfWorkUnsentCommitmentWithSerde {
    nonce: felt252,
}

#[derive(Drop, Serde)]
struct StarkWitnessWithSerde {
    traces_decommitment: TracesDecommitmentWithSerde,
    traces_witness: TracesWitnessWithSerde,
    interaction: TableCommitmentWitnessWithSerde,
    composition_decommitment: TableDecommitmentWithSerde,
    composition_witness: TableCommitmentWitnessWithSerde,
    fri_witness: FriWitnessWithSerde,
}

#[derive(Drop, Serde)]
struct TracesDecommitmentWithSerde {
    original: TableDecommitmentWithSerde,
    interaction: TableDecommitmentWithSerde,
}

#[derive(Drop, Serde)]
struct TableDecommitmentWithSerde {
    n_values: felt252,
    values: Array<felt252>,
}

#[derive(Drop, Serde)]
struct TracesWitnessWithSerde {
    original: TableCommitmentWitnessWithSerde,
}

#[derive(Drop, Serde)]
struct TableCommitmentWitnessWithSerde {
    vector: VectorCommitmentWitnessWithSerde,
}

#[derive(Drop, Serde)]
struct VectorCommitmentWitnessWithSerde {
    n_authentications: felt252,
    authentications: Array<felt252>,
}

#[derive(Drop, Serde)]
struct FriWitnessWithSerde {
    layers: Array<felt252>,
}
impl IntoFriWitness of Into<FriWitnessWithSerde, FriWitness> {
    fn into(self: FriWitnessWithSerde) -> FriWitness {
        let layers_span = self.layers.span();
        let mut layers = ArrayTrait::<FriLayerWitness>::new();
        let mut i = 0;
        loop {
            if i == layers_span.len() {
                break;
            }

            let n = *layers_span[i];
            i += 1;
            let mut leaves = ArrayTrait::<felt252>::new();
            let mut j = 0;
            loop {
                if j == n {
                    break;
                }

                leaves.append(*layers_span[i]);
                i += 1;
                j += 1;
            };

            let n = *layers_span[i];
            i += 1;
            let mut authentications = ArrayTrait::<felt252>::new();
            let mut j = 0;
            loop {
                if j == n {
                    break;
                }
                authentications.append(*layers_span[i]);
                i += 1;
                j += 1;
            };

            layers
                .append(
                    FriLayerWitness {
                        leaves: leaves.span(),
                        table_witness: TableCommitmentWitness {
                            vector: VectorCommitmentWitness {
                                authentications: authentications.span(),
                            }
                        },
                    }
                );

            i += 1;
        };

        FriWitness { layers: layers.span(), }
    }
}
