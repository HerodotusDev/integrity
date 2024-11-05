use integrity::{
    vector_commitment::vector_commitment::{
        VectorCommitment, VectorCommitmentConfig, VectorCommitmentWitness
    },
    table_commitment::table_commitment::{
        table_decommit, TableCommitment, TableCommitmentConfig, TableDecommitment,
        TableCommitmentWitness
    },
    tests::{stone_proof_fibonacci_keccak, stone_proof_fibonacci},
    settings::{VerifierSettings, HasherBitLength, StoneVersion, CairoVersion},
};

#[cfg(feature: 'blake2s')]
#[test]
#[available_gas(9999999999)]
fn test_table_commitment_decommit() {
    let commitment = stone_proof_fibonacci::traces::commitment::get().original;
    let queries = stone_proof_fibonacci::queries::get().span();
    let decommitment = stone_proof_fibonacci::traces::decommitment::get().original;
    let witness = stone_proof_fibonacci::traces::witness::get().original;

    let settings = VerifierSettings {
        cairo_version: CairoVersion::Cairo0,
        hasher_bit_length: HasherBitLength::Lsb160,
        stone_version: StoneVersion::Stone5,
    };
    table_decommit(commitment, queries, decommitment, witness, settings);
}

#[cfg(feature: 'keccak')]
#[test]
#[available_gas(9999999999)]
fn test_table_commitment_decommit() {
    let commitment = stone_proof_fibonacci_keccak::traces::commitment::get().original;
    let queries = stone_proof_fibonacci_keccak::queries::get().span();
    let decommitment = stone_proof_fibonacci_keccak::traces::decommitment::get().original;
    let witness = stone_proof_fibonacci_keccak::traces::witness::get().original;

    let settings = VerifierSettings {
        cairo_version: CairoVersion::Cairo0,
        hasher_bit_length: HasherBitLength::Lsb160,
        stone_version: StoneVersion::Stone5,
    };
    table_decommit(commitment, queries, decommitment, witness, @settings);
}
