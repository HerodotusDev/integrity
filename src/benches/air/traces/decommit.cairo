use integrity::{
    channel::channel::ChannelImpl, air::layouts::recursive::{traces::traces_decommit},
    tests::stone_proof_fibonacci,
    settings::{VerifierSettings, HasherBitLength, StoneVersion, CairoVersion},
};

fn bench_air_traces_decommit() {
    let queries = stone_proof_fibonacci::queries::get().span();
    let commitment = stone_proof_fibonacci::traces::commitment::get();
    let decommitment = stone_proof_fibonacci::traces::decommitment::get();
    let witness = stone_proof_fibonacci::traces::witness::get();

    let settings = VerifierSettings {
        cairo_version: CairoVersion::Cairo0,
        hasher_bit_length: HasherBitLength::Lsb160,
        stone_version: StoneVersion::Stone5,
    };
    traces_decommit(queries, commitment, decommitment, witness, @settings);
}
