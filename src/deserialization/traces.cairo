#[cfg(feature: 'dex')]
use integrity::air::layouts::dex::traces::{
    TracesConfig, TracesDecommitment, TracesUnsentCommitment, TracesWitness,
};
#[cfg(feature: 'recursive')]
use integrity::air::layouts::recursive::traces::{
    TracesConfig, TracesDecommitment, TracesUnsentCommitment, TracesWitness,
};
#[cfg(feature: 'recursive_with_poseidon')]
use integrity::air::layouts::recursive_with_poseidon::traces::{
    TracesConfig, TracesDecommitment, TracesUnsentCommitment, TracesWitness,
};
#[cfg(feature: 'small')]
use integrity::air::layouts::small::traces::{
    TracesConfig, TracesDecommitment, TracesUnsentCommitment, TracesWitness,
};
#[cfg(feature: 'starknet')]
use integrity::air::layouts::starknet::traces::{
    TracesConfig, TracesDecommitment, TracesUnsentCommitment, TracesWitness,
};
#[cfg(feature: 'starknet_with_keccak')]
use integrity::air::layouts::starknet_with_keccak::traces::{
    TracesConfig, TracesDecommitment, TracesUnsentCommitment, TracesWitness,
};
use integrity::deserialization::table::{
    TableCommitmentConfigWithSerde, TableCommitmentWitnessWithSerde, TableDecommitmentWithSerde,
};
use integrity::deserialization::vector::{
    VectorCommitmentConfig, VectorCommitmentConfigWithSerde, VectorCommitmentWitness,
    VectorCommitmentWitnessWithSerde,
};
use integrity::table_commitment::table_commitment::{
    TableCommitmentConfig, TableCommitmentWitness, TableDecommitment,
};

#[derive(Drop, Serde)]
struct TracesConfigWithSerde {
    original: TableCommitmentConfigWithSerde,
    interaction: TableCommitmentConfigWithSerde,
}
impl IntoTracesConfig of Into<TracesConfigWithSerde, TracesConfig> {
    fn into(self: TracesConfigWithSerde) -> TracesConfig {
        TracesConfig { original: self.original.into(), interaction: self.interaction.into() }
    }
}

#[derive(Drop, Serde)]
struct TracesDecommitmentWithSerde {
    original: TableDecommitmentWithSerde,
    interaction: TableDecommitmentWithSerde,
}
impl IntoTracesDecommitment of Into<TracesDecommitmentWithSerde, TracesDecommitment> {
    fn into(self: TracesDecommitmentWithSerde) -> TracesDecommitment {
        TracesDecommitment { original: self.original.into(), interaction: self.interaction.into() }
    }
}

#[derive(Drop, Serde)]
struct TracesUnsentCommitmentWithSerde {
    original: felt252,
    interaction: felt252,
}
impl IntoTracesUnsentCommitment of Into<TracesUnsentCommitmentWithSerde, TracesUnsentCommitment> {
    fn into(self: TracesUnsentCommitmentWithSerde) -> TracesUnsentCommitment {
        TracesUnsentCommitment { original: self.original, interaction: self.interaction }
    }
}

#[derive(Drop, Serde)]
struct TracesWitnessWithSerde {
    original: TableCommitmentWitnessWithSerde,
    interaction: TableCommitmentWitnessWithSerde,
}
impl IntoTracesWitness of Into<TracesWitnessWithSerde, TracesWitness> {
    fn into(self: TracesWitnessWithSerde) -> TracesWitness {
        TracesWitness { original: self.original.into(), interaction: self.interaction.into() }
    }
}
