use cairo_verifier::input_structs::stark_config::StarkConfig;

#[derive(Copy, Drop)]
struct StarkProof {
    config: StarkConfig,
// public_input: PublicInput,
// unsent_commitment: StarkUnsentCommitment,
// witness: StarkWitness,
}
