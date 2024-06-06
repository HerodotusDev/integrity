mod air;
// === RECURSIVE BEGIN ===
mod benches;
// === RECURSIVE END ===
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

// === RECURSIVE BEGIN ===
mod tests;
// === RECURSIVE END ===

use cairo_verifier::{
    air::public_input::CairoVersion, deserialization::stark::StarkProofWithSerde,
    stark::{StarkProof, StarkProofImpl},
    // === DEX BEGIN ===
    // air::layouts::dex::public_input::DexPublicInputImpl as PublicInputImpl,
    // === DEX END ===
    // === RECURSIVE BEGIN ===
    air::layouts::recursive::public_input::RecursivePublicInputImpl as PublicInputImpl,
// === RECURSIVE END ===
// === RECURSIVE_WITH_POSEIDON BEGIN ===
// air::layouts::recursive_with_poseidon::public_input::RecursiveWithPoseidonPublicInputImpl as PublicInputImpl,
// === RECURSIVE_WITH_POSEIDON END ===
// === SMALL BEGIN ===
// air::layouts::small::public_input::SmallPublicInputImpl as PublicInputImpl,
// === SMALL END ===
// === STARKNET BEGIN ===
// air::layouts::starknet::public_input::StarknetPublicInputImpl as PublicInputImpl,
// === STARKNET END ===
// === STARKNET_WITH_KECCAK BEGIN ===
// air::layouts::starknet_with_keccak::public_input::StarknetWithKeccakPublicInputImpl as PublicInputImpl,
// === STARKNET_WITH_KECCAK END ===
};

const SECURITY_BITS: felt252 = 50;

fn main(mut serialized: Span<felt252>, cairo_version: CairoVersion) -> (felt252, felt252) {
    let stark_proof_serde = Serde::<StarkProofWithSerde>::deserialize(ref serialized).unwrap();
    let stark_proof: StarkProof = stark_proof_serde.into();

    stark_proof.verify(SECURITY_BITS);
    let (program_hash, output_hash) = stark_proof.public_input.verify(cairo_version);

    (program_hash, output_hash)
}
