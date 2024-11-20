use integrity::{stark::StarkUnsentCommitment, tests::stone_proof_fibonacci};

fn get() -> StarkUnsentCommitment {
    return StarkUnsentCommitment {
        traces: stone_proof_fibonacci::traces::unsent_commitment::get(),
        composition: 0x420cd425d306a0ae0692c16909c51f42a16f848e318fd2d0ea61255e5f0ca76,
        oods_values: stone_proof_fibonacci::stark::oods_values::get().span(),
        fri: stone_proof_fibonacci::fri::unsent_commitment::get(),
        proof_of_work: stone_proof_fibonacci::proof_of_work::unsent_commitment::get(),
    };
}
