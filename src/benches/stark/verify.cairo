use integrity::air::layouts::recursive::constants::{NUM_COLUMNS_FIRST, NUM_COLUMNS_SECOND};
use integrity::settings::{HasherBitLength, StoneVersion, VerifierSettings};
use integrity::stark::stark_verify::stark_verify;
use integrity::tests::stone_proof_fibonacci_keccak;

fn bench_stark_verify() {
    let queries = stone_proof_fibonacci_keccak::queries::get().span();
    let commitment = stone_proof_fibonacci_keccak::stark::commitment::get();
    let witness = stone_proof_fibonacci_keccak::stark::witness::get();
    let stark_domains = stone_proof_fibonacci_keccak::stark::domains::get();

    let settings = VerifierSettings {
        memory_verification: 0, // strict
        hasher_bit_length: HasherBitLength::Lsb160,
        stone_version: StoneVersion::Stone5,
    };
    stark_verify(
        NUM_COLUMNS_FIRST,
        NUM_COLUMNS_SECOND,
        queries,
        commitment,
        witness,
        stark_domains,
        0.try_into().unwrap(),
        @settings,
    );
}
