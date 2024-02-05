use cairo_verifier::{stark::StarkUnsentCommitment, tests::stone_proof_fibonacci_keccak};

fn get() -> StarkUnsentCommitment {
    return StarkUnsentCommitment {
        traces: stone_proof_fibonacci_keccak::traces::unsent_commitment::get(),
        composition: 0x671e750eb2c87f39263a909ab58b1ae4175bdff34dde999c02ca360490bb1e8,
        oods_values: stone_proof_fibonacci_keccak::stark::oods_values::get().span(),
        fri: stone_proof_fibonacci_keccak::fri::unsent_commitment::get(),
        proof_of_work: stone_proof_fibonacci_keccak::proof_of_work::unsent_commitment::get(),
    };
}
