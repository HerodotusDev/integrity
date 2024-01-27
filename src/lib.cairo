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

mod tests;

use cairo_verifier::{
    deserialization::stark::StarkProofWithSerde, stark::{StarkProof, StarkProofImpl},
    tests::stone_proof_fibonacci,
};

fn main() {
    let stark_proof = StarkProof {
        config: stone_proof_fibonacci::stark::config::get(),
        public_input: stone_proof_fibonacci::public_input::get(),
        unsent_commitment: stone_proof_fibonacci::stark::unsent_commitment::get(),
        witness: stone_proof_fibonacci::stark::witness::get(),
    };

    stark_proof.verify();
}
