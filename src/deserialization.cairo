use core::traits::Into;
use core::traits::TryInto;
use core::array::ArrayTrait;
use cairo_verifier::{
    air::{
        config::TracesConfig, public_input::{ContinuousPageHeader, PublicInput, SegmentInfo},
        public_memory::{AddrValue, Page},
        traces::{TracesUnsentCommitment, TracesDecommitment, TracesWitness}
    },
    fri::{fri_config::FriConfig, fri::{FriUnsentCommitment, FriWitness, FriLayerWitness}},
    stark::{StarkProof, StarkConfig, StarkUnsentCommitment, StarkWitness},
    table_commitment::{
        TableCommitmentConfig, TableCommitmentWitness, TableDecommitment, TableUnsentCommitment
    },
    proof_of_work::{config::ProofOfWorkConfig, proof_of_work::ProofOfWorkUnsentCommitment},
    vector_commitment::vector_commitment::{VectorCommitmentConfig, VectorCommitmentWitness},
};

#[derive(Drop, Serde)]
struct StarkProofWithSerde {
    config: StarkConfigWithSerde,
    public_input: PublicInputWithSerde,
    unsent_commitment: StarkUnsentCommitmentWithSerde,
    witness: StarkWitnessWithSerde,
}
impl IntoStarkProof of Into<StarkProofWithSerde, StarkProof> {
    fn into(self: StarkProofWithSerde) -> StarkProof {
        StarkProof {
            config: self.config.into(),
            public_input: self.public_input.into(),
            unsent_commitment: self.unsent_commitment.into(),
            witness: self.witness.into(),
        }
    }
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
impl IntoPublicInput of Into<PublicInputWithSerde, PublicInput> {
    fn into(self: PublicInputWithSerde) -> PublicInput {
        let mut segments = ArrayTrait::<SegmentInfo>::new();
        let mut i = 0;
        loop {
            if i == self.segments.len() {
                break;
            }

            segments
                .append(
                    SegmentInfo { begin_addr: *self.segments[i], stop_ptr: *self.segments[i + 1], }
                );
            i += 2;
        };

        let mut page = ArrayTrait::<AddrValue>::new();
        let mut i = 0;
        loop {
            if i == self.main_page.len() {
                break;
            }

            page.append(AddrValue { address: *self.main_page[i], value: *self.main_page[i + 1], });

            i += 2;
        };

        let mut continuous_page_headers = ArrayTrait::<ContinuousPageHeader>::new();
        let mut i = 0;
        loop {
            if i == self.continuous_page_headers.len() {
                break;
            }

            continuous_page_headers
                .append(
                    ContinuousPageHeader {
                        start_address: *self.continuous_page_headers[i],
                        size: *self.continuous_page_headers[i + 1],
                        hash: (*self.continuous_page_headers[i + 2]).into(),
                        prod: *self.continuous_page_headers[i + 3],
                    }
                );

            i += 4;
        };
        PublicInput {
            log_n_steps: self.log_n_steps,
            rc_min: self.range_check_min,
            rc_max: self.range_check_max,
            layout: self.layout,
            dynamic_params: self.dynamic_params,
            segments: segments,
            padding_addr: self.padding_addr,
            padding_value: self.padding_value,
            main_page: page.into(),
            continuous_page_headers: continuous_page_headers,
        }
    }
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
impl IntoStarkConfig of Into<StarkConfigWithSerde, StarkConfig> {
    fn into(self: StarkConfigWithSerde) -> StarkConfig {
        StarkConfig {
            traces: self.traces.into(),
            composition: self.composition.into(),
            fri: self.fri.into(),
            proof_of_work: self.proof_of_work.into(),
            log_trace_domain_size: self.log_trace_domain_size,
            n_queries: self.n_queries,
            log_n_cosets: self.log_n_cosets,
            n_verifier_friendly_commitment_layers: self.n_verifier_friendly_commitment_layers,
        }
    }
}

#[derive(Drop, Serde)]
struct TracesConfigWithSerde {
    original: TableCommitmentConfigWithSerde,
    interaction: TableCommitmentConfigWithSerde,
}
impl IntoTracesConfig of Into<TracesConfigWithSerde, TracesConfig> {
    fn into(self: TracesConfigWithSerde) -> TracesConfig {
        TracesConfig {
            original: TableCommitmentConfig {
                n_columns: self.original.n_columns,
                vector: VectorCommitmentConfig {
                    height: self.original.vector.height,
                    n_verifier_friendly_commitment_layers: self
                        .original
                        .vector
                        .n_verifier_friendly_commitment_layers,
                }
            },
            interaction: TableCommitmentConfig {
                n_columns: self.interaction.n_columns,
                vector: VectorCommitmentConfig {
                    height: self.interaction.vector.height,
                    n_verifier_friendly_commitment_layers: self
                        .interaction
                        .vector
                        .n_verifier_friendly_commitment_layers,
                }
            },
        }
    }
}

#[derive(Drop, Serde)]
struct TableCommitmentConfigWithSerde {
    n_columns: felt252,
    vector: VectorCommitmentConfigWithSerde,
}
impl IntoTableCommitmentConfig of Into<TableCommitmentConfigWithSerde, TableCommitmentConfig> {
    fn into(self: TableCommitmentConfigWithSerde) -> TableCommitmentConfig {
        TableCommitmentConfig {
            n_columns: self.n_columns,
            vector: VectorCommitmentConfig {
                height: self.vector.height,
                n_verifier_friendly_commitment_layers: self
                    .vector
                    .n_verifier_friendly_commitment_layers,
            }
        }
    }
}

#[derive(Drop, Serde)]
struct VectorCommitmentConfigWithSerde {
    height: felt252,
    n_verifier_friendly_commitment_layers: felt252,
}
impl IntoVectorCommitmentConfig of Into<VectorCommitmentConfigWithSerde, VectorCommitmentConfig> {
    fn into(self: VectorCommitmentConfigWithSerde) -> VectorCommitmentConfig {
        VectorCommitmentConfig {
            height: self.height,
            n_verifier_friendly_commitment_layers: self.n_verifier_friendly_commitment_layers,
        }
    }
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
impl IntoFriConfig of Into<FriConfigWithSerde, FriConfig> {
    fn into(self: FriConfigWithSerde) -> FriConfig {
        let mut inner_layers = ArrayTrait::<TableCommitmentConfig>::new();
        let mut i = 0;
        loop {
            if i == self.inner_layers.len() {
                break;
            }

            inner_layers
                .append(
                    TableCommitmentConfig {
                        n_columns: *self.inner_layers.at(i),
                        vector: VectorCommitmentConfig {
                            height: *self.inner_layers.at(i + 1),
                            n_verifier_friendly_commitment_layers: *self.inner_layers.at(i + 2),
                        }
                    }
                );
            i += 3;
        };
        FriConfig {
            log_input_size: self.log_input_size,
            n_layers: self.n_layers,
            inner_layers: inner_layers.span(),
            fri_step_sizes: self.fri_step_sizes.span(),
            log_last_layer_degree_bound: self.log_last_layer_degree_bound,
        }
    }
}

#[derive(Drop, Serde)]
struct ProofOfWorkConfigWithSerde {
    // Proof of work difficulty (number of bits required to be 0).
    n_bits: felt252,
}
impl IntoProofOfWorkConfig of Into<ProofOfWorkConfigWithSerde, ProofOfWorkConfig> {
    fn into(self: ProofOfWorkConfigWithSerde) -> ProofOfWorkConfig {
        ProofOfWorkConfig { n_bits: self.n_bits.try_into().unwrap(), }
    }
}

#[derive(Drop, Serde)]
struct StarkUnsentCommitmentWithSerde {
    traces: TracesUnsentCommitmentWithSerde,
    composition: felt252,
    oods_values: Array<felt252>,
    fri: FriUnsentCommitmentWithSerde,
    proof_of_work: ProofOfWorkUnsentCommitmentWithSerde,
}
impl IntoStarkUnsentCommitment of Into<StarkUnsentCommitmentWithSerde, StarkUnsentCommitment> {
    fn into(self: StarkUnsentCommitmentWithSerde) -> StarkUnsentCommitment {
        StarkUnsentCommitment {
            traces: self.traces.into(),
            composition: self.composition,
            oods_values: self.oods_values.span(),
            fri: self.fri.into(),
            proof_of_work: self.proof_of_work.into(),
        }
    }
}

#[derive(Drop, Serde)]
struct TracesUnsentCommitmentWithSerde {
    original: felt252,
    interaction: felt252,
}
impl IntoTracesUnsentCommitment of Into<TracesUnsentCommitmentWithSerde, TracesUnsentCommitment> {
    fn into(self: TracesUnsentCommitmentWithSerde) -> TracesUnsentCommitment {
        TracesUnsentCommitment {
            original: TableUnsentCommitment { vector: self.original },
            interaction: TableUnsentCommitment { vector: self.original },
        }
    }
}

#[derive(Drop, Serde)]
struct FriUnsentCommitmentWithSerde {
    inner_layers: Array<felt252>,
    last_layer_coefficients: Array<felt252>,
}
impl IntoFriUnsentCommitment of Into<FriUnsentCommitmentWithSerde, FriUnsentCommitment> {
    fn into(self: FriUnsentCommitmentWithSerde) -> FriUnsentCommitment {
        let mut inner_layers = ArrayTrait::<TableUnsentCommitment>::new();
        let mut i = 0;
        loop {
            if i == self.inner_layers.len() {
                break;
            }
            inner_layers.append(TableUnsentCommitment { vector: *self.inner_layers[i] });
            i += 1;
        };
        FriUnsentCommitment {
            inner_layers: inner_layers.span(),
            last_layer_coefficients: self.last_layer_coefficients.span(),
        }
    }
}

#[derive(Drop, Serde)]
struct ProofOfWorkUnsentCommitmentWithSerde {
    nonce: felt252,
}
impl IntoProofOfWorkUnsentCommitment of Into<
    ProofOfWorkUnsentCommitmentWithSerde, ProofOfWorkUnsentCommitment
> {
    fn into(self: ProofOfWorkUnsentCommitmentWithSerde) -> ProofOfWorkUnsentCommitment {
        ProofOfWorkUnsentCommitment { nonce: self.nonce.try_into().unwrap(), }
    }
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
impl IntoStarkWitness of Into<StarkWitnessWithSerde, StarkWitness> {
    fn into(self: StarkWitnessWithSerde) -> StarkWitness {
        StarkWitness {
            traces_decommitment: self.traces_decommitment.into(),
            traces_witness: self.traces_witness.into(),
            interaction: self.interaction.into(),
            composition_decommitment: self.composition_decommitment.into(),
            composition_witness: self.composition_witness.into(),
            fri_witness: self.fri_witness.into(),
        }
    }
}

#[derive(Drop, Serde)]
struct TracesDecommitmentWithSerde {
    original: TableDecommitmentWithSerde,
    interaction: TableDecommitmentWithSerde,
}
impl IntoTracesDecommitment of Into<TracesDecommitmentWithSerde, TracesDecommitment> {
    fn into(self: TracesDecommitmentWithSerde) -> TracesDecommitment {
        TracesDecommitment { original: self.original.into(), interaction: self.interaction.into(), }
    }
}

#[derive(Drop, Serde)]
struct TableDecommitmentWithSerde {
    n_values: felt252,
    values: Array<felt252>,
}
impl IntoTableDecommitment of Into<TableDecommitmentWithSerde, TableDecommitment> {
    fn into(self: TableDecommitmentWithSerde) -> TableDecommitment {
        TableDecommitment { values: self.values.span(), }
    }
}

#[derive(Drop, Serde)]
struct TracesWitnessWithSerde {
    original: TableCommitmentWitnessWithSerde,
    interaction: TableCommitmentWitnessWithSerde,
}
impl IntoTracesWitness of Into<TracesWitnessWithSerde, TracesWitness> {
    fn into(self: TracesWitnessWithSerde) -> TracesWitness {
        TracesWitness { original: self.original.into(), interaction: self.interaction.into(), }
    }
}

#[derive(Drop, Serde)]
struct TableCommitmentWitnessWithSerde {
    vector: VectorCommitmentWitnessWithSerde,
}
impl IntoTableCommitmentWitness of Into<TableCommitmentWitnessWithSerde, TableCommitmentWitness> {
    fn into(self: TableCommitmentWitnessWithSerde) -> TableCommitmentWitness {
        TableCommitmentWitness { vector: self.vector.into(), }
    }
}

#[derive(Drop, Serde)]
struct VectorCommitmentWitnessWithSerde {
    n_authentications: felt252,
    authentications: Array<felt252>,
}
impl IntoVectorCommitmentWitness of Into<
    VectorCommitmentWitnessWithSerde, VectorCommitmentWitness
> {
    fn into(self: VectorCommitmentWitnessWithSerde) -> VectorCommitmentWitness {
        VectorCommitmentWitness { authentications: self.authentications.span(), }
    }
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
