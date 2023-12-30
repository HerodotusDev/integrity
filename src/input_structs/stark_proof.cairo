use cairo_verifier::input_structs::{
    stark_config::StarkConfig, public_input::PublicInput,
    stark_unsent_commitment::StarkUnsentCommitment,
};


#[derive(Drop, Serde)]
struct StarkProof {
    config: StarkConfig,
    public_input: PublicInput,
    unsent_commitment: StarkUnsentCommitment,
// witness: StarkWitness,
}
