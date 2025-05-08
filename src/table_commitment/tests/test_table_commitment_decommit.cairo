use integrity::settings::{HasherBitLength, StoneVersion, VerifierSettings};
use integrity::table_commitment::table_commitment::{
    TableCommitment, TableCommitmentConfig, TableCommitmentWitness, TableDecommitment,
    table_decommit,
};
use integrity::tests::{stone_proof_fibonacci, stone_proof_fibonacci_keccak};
use integrity::vector_commitment::vector_commitment::{
    VectorCommitment, VectorCommitmentConfig, VectorCommitmentWitness,
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
        memory_verification: 0, // strict
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
        memory_verification: 0, // strict
        hasher_bit_length: HasherBitLength::Lsb160,
        stone_version: StoneVersion::Stone5,
    };
    table_decommit(commitment, queries, decommitment, witness, @settings);
}
