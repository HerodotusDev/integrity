mod abstract_air;
mod air;
mod channel;
mod common;
// mod deserialization;
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

use cairo_verifier::{stark::{StarkProof, StarkProofImpl}, air::public_input::PublicInputTrait,};

fn main(proof: StarkProof) -> (felt252, felt252) {
    proof.verify();
    let (program_hash, output_hash) = proof.public_input.verify();
    (program_hash, output_hash)
}
