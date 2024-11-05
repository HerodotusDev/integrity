#[cfg(feature: 'feature_change_my_name')]
mod air;
#[cfg(feature: 'feature_change_my_name')]
mod channel;
#[cfg(feature: 'feature_change_my_name')]
mod common;
#[cfg(feature: 'feature_change_my_name')]
mod deserialization;
#[cfg(feature: 'feature_change_my_name')]
mod domains;
#[cfg(feature: 'feature_change_my_name')]
mod fri;
#[cfg(feature: 'feature_change_my_name')]
mod oods;
#[cfg(feature: 'feature_change_my_name')]
mod proof_of_work;
#[cfg(feature: 'feature_change_my_name')]
mod queries;
#[cfg(feature: 'feature_change_my_name')]
mod stark;
#[cfg(feature: 'feature_change_my_name')]
mod table_commitment;
#[cfg(feature: 'feature_change_my_name')]
mod vector_commitment;

mod settings;
mod contracts;

#[cfg(feature: 'recursive')]
mod benches;
#[cfg(feature: 'recursive')]
mod tests;

#[cfg(feature: 'feature_change_my_name')]
use integrity::{
    deserialization::stark::StarkProofWithSerde, stark::{StarkProof, StarkProofImpl},
};
#[cfg(feature: 'feature_change_my_name')]
use starknet::contract_address::ContractAddressZero;

// re-export
use integrity::{
    contracts::fact_registry_interface::{
        IFactRegistry, IFactRegistryDispatcher, IFactRegistryDispatcherTrait
    },
    settings::{
        FactHash, VerificationHash, PresetHash, SecurityBits, JobId, CairoVersion, HasherBitLength,
        StoneVersion, VerifierSettings, VerifierPreset, VerifierConfiguration, split_settings
    },
};

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


#[cfg(feature: 'feature_change_my_name')]
const SECURITY_BITS: u32 = 50;

#[cfg(feature: 'feature_change_my_name')]
#[cfg(feature: 'monolith')]
fn main(mut serialized: Span<felt252>, settings: @VerifierSettings) -> (felt252, felt252) {
    let stark_proof_serde = Serde::<StarkProofWithSerde>::deserialize(ref serialized).unwrap();
    let stark_proof: StarkProof = stark_proof_serde.into();

    let security_bits = stark_proof
        .verify(ContractAddressZero::zero(), ContractAddressZero::zero(), settings);
    assert(security_bits >= SECURITY_BITS, 'Security bits are too low');

    let (program_hash, output_hash) = match settings.cairo_version {
        CairoVersion::Cairo0 => stark_proof.public_input.verify_cairo0(),
        CairoVersion::Cairo1 => stark_proof.public_input.verify_cairo1(),
    };

    (program_hash, output_hash)
}
