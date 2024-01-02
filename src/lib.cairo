mod channel;
mod common;
mod input_structs;
mod structs;
mod fri;
mod table_commitment;
mod vector_commitment;

use cairo_verifier::input_structs::stark_proof::StarkProof;

fn main(stark_proof: StarkProof) -> (felt252, felt252) {
    (stark_proof.config.traces.original.columns, stark_proof.config.traces.interaction.columns)
}
