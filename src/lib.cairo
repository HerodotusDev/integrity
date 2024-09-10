mod air;
mod channel;
mod common;
mod deserialization;
mod domains;
mod fri;
mod oods;
mod proof_of_work;
mod queries;
mod stark;
mod table_commitment;
mod vector_commitment;
mod verifier;

#[cfg(feature: 'recursive')]
mod benches;
#[cfg(feature: 'recursive')]
mod tests;

use cairo_verifier::{
    air::public_input::CairoVersion, deserialization::stark::StarkProofWithSerde,
    stark::{StarkProof, StarkProofImpl},
};
use starknet::contract_address::ContractAddressZero;

#[cfg(feature: 'dex')]
use cairo_verifier::air::layouts::dex::public_input::DexPublicInputImpl as PublicInputImpl;
#[cfg(feature: 'recursive')]
use cairo_verifier::air::layouts::recursive::public_input::RecursivePublicInputImpl as PublicInputImpl;
#[cfg(feature: 'recursive_with_poseidon')]
use cairo_verifier::air::layouts::recursive_with_poseidon::public_input::RecursiveWithPoseidonPublicInputImpl as PublicInputImpl;
#[cfg(feature: 'small')]
use cairo_verifier::air::layouts::small::public_input::SmallPublicInputImpl as PublicInputImpl;
#[cfg(feature: 'starknet')]
use cairo_verifier::air::layouts::starknet::public_input::StarknetPublicInputImpl as PublicInputImpl;
#[cfg(feature: 'starknet_with_keccak')]
use cairo_verifier::air::layouts::starknet_with_keccak::public_input::StarknetWithKeccakPublicInputImpl as PublicInputImpl;


const SECURITY_BITS: felt252 = 50;

#[cfg(feature: 'monolit')]
fn main(mut serialized: Span<felt252>, cairo_version: CairoVersion) -> (felt252, felt252) {
    let stark_proof_serde = Serde::<StarkProofWithSerde>::deserialize(ref serialized).unwrap();
    let stark_proof: StarkProof = stark_proof_serde.into();

    stark_proof.verify(SECURITY_BITS, ContractAddressZero::zero(), ContractAddressZero::zero());
    let (program_hash, output_hash) = match cairo_version {
        CairoVersion::Cairo0 => stark_proof.public_input.verify_cairo0(),
        CairoVersion::Cairo1 => stark_proof.public_input.verify_cairo1(),
    };

    (program_hash, output_hash)
}
