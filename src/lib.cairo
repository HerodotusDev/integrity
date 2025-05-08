#[cfg(feature: '_verifier_logic')]
mod air;

#[cfg(feature: 'recursive')]
mod benches;
#[cfg(feature: '_verifier_logic')]
mod channel;
#[cfg(feature: '_verifier_logic')]
mod common;
mod contracts;
#[cfg(feature: '_verifier_logic')]
mod deserialization;
#[cfg(feature: '_verifier_logic')]
mod domains;
#[cfg(feature: '_verifier_logic')]
mod fri;
mod lib_utils;
#[cfg(feature: '_verifier_logic')]
mod oods;
#[cfg(feature: '_verifier_logic')]
mod proof_of_work;
#[cfg(feature: '_verifier_logic')]
mod queries;

mod settings;
#[cfg(feature: '_verifier_logic')]
mod stark;
#[cfg(feature: '_verifier_logic')]
mod table_commitment;
#[cfg(feature: 'recursive')]
mod tests;
#[cfg(feature: '_verifier_logic')]
mod vector_commitment;
#[cfg(feature: 'dex')]
use integrity::air::layouts::dex::public_input::DexPublicInputImpl as PublicInputImpl;
#[cfg(feature: 'recursive')]
use integrity::air::layouts::recursive::public_input::RecursivePublicInputImpl as PublicInputImpl;
#[cfg(feature: 'recursive_with_poseidon')]
use integrity::air::layouts::recursive_with_poseidon::public_input::RecursiveWithPoseidonPublicInputImpl as PublicInputImpl;
#[cfg(feature: 'small')]
use integrity::air::layouts::small::public_input::SmallPublicInputImpl as PublicInputImpl;
#[cfg(feature: 'starknet')]
use integrity::air::layouts::starknet::public_input::StarknetPublicInputImpl as PublicInputImpl;
#[cfg(feature: 'starknet_with_keccak')]
use integrity::air::layouts::starknet_with_keccak::public_input::StarknetWithKeccakPublicInputImpl as PublicInputImpl;
#[cfg(feature: '_verifier_logic')]
use integrity::deserialization::stark::StarkProofWithSerde;
#[cfg(feature: '_verifier_logic')]
use integrity::stark::{StarkProof, StarkProofImpl};

// re-export
use integrity::{
    contracts::fact_registry_interface::{
        IFactRegistry, IFactRegistryDispatcher, IFactRegistryDispatcherTrait,
    },
    lib_utils::{
        INTEGRITY_ADDRESS, Integrity, IntegrityT, IntegrityTrait, IntegrityWithConfig,
        IntegrityWithConfigT, IntegrityWithConfigTrait, SHARP_BOOTLOADER_PROGRAM_HASH,
        STONE_BOOTLOADER_PROGRAM_HASH, calculate_bootloaded_fact_hash, calculate_fact_hash,
        get_verification_hash, get_verifier_config_hash,
    },
    settings::{
        FactHash, HasherBitLength, JobId, MemoryVerification, PresetHash, SecurityBits,
        StoneVersion, VerificationHash, VerifierConfiguration, VerifierPreset, VerifierSettings,
        split_settings,
    },
};
#[cfg(feature: '_verifier_logic')]
use starknet::contract_address::ContractAddressZero;


#[cfg(feature: '_verifier_logic')]
const SECURITY_BITS: u32 = 50;

#[cfg(feature: '_verifier_logic')]
#[cfg(feature: 'monolith')]
fn main(mut serialized: Span<felt252>, settings: @VerifierSettings) -> (felt252, felt252) {
    let stark_proof_serde = Serde::<StarkProofWithSerde>::deserialize(ref serialized).unwrap();
    let stark_proof: StarkProof = stark_proof_serde.into();

    let security_bits = stark_proof
        .verify(ContractAddressZero::zero(), ContractAddressZero::zero(), settings);
    assert(security_bits >= SECURITY_BITS, 'Security bits are too low');

    let (program_hash, output_hash) = match (*settings).memory_verification {
        0 => stark_proof.public_input.verify_strict(),
        1 => stark_proof.public_input.verify_relaxed(),
        2 => stark_proof.public_input.verify_cairo1(),
        _ => {
            assert(false, 'invalid memory_verification');
            (0, 0)
        },
    };

    (program_hash, output_hash)
}
