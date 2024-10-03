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
mod settings;
mod contracts;

#[cfg(feature: 'recursive')]
mod benches;
#[cfg(feature: 'recursive')]
mod tests;

use cairo_verifier::{
    deserialization::stark::StarkProofWithSerde, stark::{StarkProof, StarkProofImpl},
    settings::{VerifierSettings, CairoVersion},
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


const SECURITY_BITS: u32 = 50;

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

use cairo_verifier::fri::fri::{FriVerificationStateConstant, FriVerificationStateVariable};
use core::poseidon::{Poseidon, PoseidonImpl, HashStateImpl};

struct Calldata {
    const_state: FriVerificationStateConstant,
    variable_state: Span<FriVerificationStateVariable>,
    fact_hash: felt252,
}

fn get_calldata(mut serialized: Span<felt252>, settings: @VerifierSettings) -> Calldata {
    let stark_proof_serde = Serde::<StarkProofWithSerde>::deserialize(ref serialized).unwrap();
    let stark_proof: StarkProof = stark_proof_serde.into();
    let (program_hash, output_hash) = match settings.cairo_version {
        CairoVersion::Cairo0 => stark_proof.public_input.verify_cairo0(),
        CairoVersion::Cairo1 => stark_proof.public_input.verify_cairo1(),
    };

    let mut variable_states = array![];

    let fact_hash = PoseidonImpl::new().update(program_hash).update(output_hash).finalize();
    
    let (mut const_state, mut variable_state, last_layer_coefficients, _) = stark_proof
        .verify_initial(0.try_into().unwrap(), 0.try_into().unwrap(), settings);

    for witness in stark_proof.witness.fri_witness.layers {
        variable_states.append(variable_state.clone());
        let (new_const_state, new_variable_state) = StarkProofImpl::verify_step(
            const_state, variable_state, *witness, settings
        );
        variable_state = new_variable_state;
        const_state = new_const_state;
    };

    variable_states.append(variable_state.clone());
    StarkProofImpl::verify_final(const_state.clone(), variable_state, last_layer_coefficients);

    Calldata {
        const_state,
        variable_state: variable_states.span(),
        fact_hash,
    }
}