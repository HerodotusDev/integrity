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

mod benches;

use cairo_verifier::{
    deserialization::stark::StarkProofWithSerde, stark::{StarkProof, StarkProofImpl}
};

fn main(serialized_proof: Array<felt252>) {
    let mut serialized_proof_span = serialized_proof.span();
    let stark_proof: StarkProof = Serde::<
        StarkProofWithSerde
    >::deserialize(ref serialized_proof_span)
        .unwrap()
        .into();

    stark_proof.verify();
}
