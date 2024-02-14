mod abstract_air;
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

#[cfg(test)]
mod tests;

use cairo_verifier::{
    deserialization::stark::StarkProofWithSerde, stark::{StarkProof, StarkProofImpl},
    air::public_input::PublicInputTrait
};

fn main(serialized_proof: StarkProofWithSerde) -> (felt252, felt252) {
    
    (0, 0)
}
