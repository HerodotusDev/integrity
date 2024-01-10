mod air;
mod channel;
mod common;
mod deserialization;
mod fri;
mod oods;
mod proof_of_work;
mod queries;
mod stark;
mod table_commitment;
mod vector_commitment;

use cairo_verifier::deserialization::stark::StarkProofWithSerde;

fn main(x: Array<felt252>) {
    let mut x_span = x.span();
    let stark_proof: StarkProofWithSerde = Serde::deserialize(ref x_span).unwrap();
}
