use cairo_verifier::{stark::StarkUnsentCommitment, tests::stone_proof_fibonacci,};

fn get() -> StarkUnsentCommitment {
    return StarkUnsentCommitment {
        traces: stone_proof_fibonacci::traces::unsent_commitment::get(),
        composition: 0x6e8740c697a0302b55c1b26d955e4befbaedc6bceeeeb54ee6f2dbc9a68bca1,
        oods_values: stone_proof_fibonacci::stark::oods_values::get().span(),
        fri: stone_proof_fibonacci::fri::unsent_commitment::get(),
        proof_of_work: stone_proof_fibonacci::proof_of_work::unsent_commitment::get(),
    };
}
