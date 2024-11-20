use integrity::{
    fri::{fri_config::FriConfig, fri::{FriUnsentCommitment, FriWitness, FriLayerWitness}},
    table_commitment::table_commitment::{TableCommitmentConfig, TableCommitmentWitness},
    vector_commitment::vector_commitment::{VectorCommitmentConfig, VectorCommitmentWitness},
};

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
struct FriUnsentCommitmentWithSerde {
    inner_layers: Array<felt252>,
    last_layer_coefficients: Array<felt252>,
}
impl IntoFriUnsentCommitment of Into<FriUnsentCommitmentWithSerde, FriUnsentCommitment> {
    fn into(self: FriUnsentCommitmentWithSerde) -> FriUnsentCommitment {
        let mut inner_layers = ArrayTrait::<felt252>::new();
        let mut i = 0;
        loop {
            if i == self.inner_layers.len() {
                break;
            }
            inner_layers.append(*self.inner_layers[i]);
            i += 1;
        };
        FriUnsentCommitment {
            inner_layers: inner_layers.span(),
            last_layer_coefficients: self.last_layer_coefficients.span(),
        }
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
        };

        FriWitness { layers: layers.span(), }
    }
}
