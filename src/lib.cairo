mod air;
mod benches;
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

#[cfg(test)]
mod tests;

use cairo_verifier::{
    deserialization::stark::StarkProofWithSerde, stark::{StarkProof, StarkProofImpl},
    air::public_input::PublicInputTrait
};

fn main(serialized_proof: Array<felt252>) -> (felt252, felt252) {
    let mut serialized_proof_span = serialized_proof.span();
    let stark_proof: StarkProof = Serde::<
        StarkProofWithSerde
    >::deserialize(ref serialized_proof_span)
        .unwrap()
        .into();

    stark_proof.verify();
    let (program_hash, output_hash) = stark_proof.public_input.verify();

    (program_hash, output_hash)
}
