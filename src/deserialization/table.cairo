use integrity::{
    table_commitment::table_commitment::{
        TableCommitmentConfig, TableCommitmentWitness, TableDecommitment
    },
    deserialization::vector::{VectorCommitmentConfigWithSerde, VectorCommitmentWitnessWithSerde}
};

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
struct TableCommitmentWitnessWithSerde {
    vector: VectorCommitmentWitnessWithSerde,
}
impl IntoTableCommitmentWitness of Into<TableCommitmentWitnessWithSerde, TableCommitmentWitness> {
    fn into(self: TableCommitmentWitnessWithSerde) -> TableCommitmentWitness {
        TableCommitmentWitness { vector: self.vector.into(), }
    }
}
