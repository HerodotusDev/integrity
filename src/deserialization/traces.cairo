use cairo_verifier::{
    air::{
        traces_config::TracesConfig,
        traces::{TracesUnsentCommitment, TracesDecommitment, TracesWitness}
    },
    deserialization::{
        vector::{
            VectorCommitmentConfig, VectorCommitmentWitness, VectorCommitmentConfigWithSerde,
            VectorCommitmentWitnessWithSerde
        }
    },
    table_commitment::{
        TableCommitmentConfig, TableCommitmentWitness, TableDecommitment, TableUnsentCommitment
    },
};

#[derive(Drop, Serde)]
struct TracesConfigWithSerde {
    original: TableCommitmentConfigWithSerde,
    interaction: TableCommitmentConfigWithSerde,
}
impl IntoTracesConfig of Into<TracesConfigWithSerde, TracesConfig> {
    fn into(self: TracesConfigWithSerde) -> TracesConfig {
        TracesConfig { original: self.original.into(), interaction: self.interaction.into(), }
    }
}

#[derive(Drop, Serde)]
struct TableCommitmentConfigWithSerde {
    n_columns: felt252,
    vector: VectorCommitmentConfigWithSerde,
}
impl IntoTableCommitmentConfig of Into<TableCommitmentConfigWithSerde, TableCommitmentConfig> {
    fn into(self: TableCommitmentConfigWithSerde) -> TableCommitmentConfig {
        TableCommitmentConfig { n_columns: self.n_columns, vector: self.vector.into(), }
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
