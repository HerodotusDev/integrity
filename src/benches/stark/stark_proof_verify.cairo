use starknet::contract_address::ContractAddressZero;
use integrity::{
    stark::{StarkProof, StarkProofTrait}, tests::stone_proof_fibonacci_keccak,
    settings::{VerifierSettings, HasherBitLength, StoneVersion, CairoVersion},
};

fn bench_stark_proof_verify() {
    let SECURITY_BITS: u32 = 50;

    let stark_proof = StarkProof {
        config: stone_proof_fibonacci_keccak::stark::config::get(),
        public_input: stone_proof_fibonacci_keccak::public_input::get(),
        unsent_commitment: stone_proof_fibonacci_keccak::stark::unsent_commitment::get(),
        witness: stone_proof_fibonacci_keccak::stark::witness::get(),
    };

    let settings = VerifierSettings {
        cairo_version: CairoVersion::Cairo0,
        hasher_bit_length: HasherBitLength::Lsb160,
        stone_version: StoneVersion::Stone5,
    };
    let security_bits = stark_proof
        .verify(ContractAddressZero::zero(), ContractAddressZero::zero(), @settings);
    assert(security_bits >= SECURITY_BITS, 'Security bits too low');
}
