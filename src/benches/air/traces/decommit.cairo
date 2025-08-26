use integrity::air::layouts::recursive::traces::traces_decommit;
use integrity::channel::channel::ChannelImpl;
use integrity::settings::{HasherBitLength, MemoryVerification, StoneVersion, VerifierSettings};
use integrity::tests::stone_proof_fibonacci;

fn bench_air_traces_decommit() {
    let queries = stone_proof_fibonacci::queries::get().span();
    let commitment = stone_proof_fibonacci::traces::commitment::get();
    let decommitment = stone_proof_fibonacci::traces::decommitment::get();
    let witness = stone_proof_fibonacci::traces::witness::get();

    let settings = VerifierSettings {
        memory_verification: 0, // strict
        hasher_bit_length: HasherBitLength::Lsb160,
        stone_version: StoneVersion::Stone5,
    };
    traces_decommit(queries, commitment, decommitment, witness, @settings);
}
