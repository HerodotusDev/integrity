mod models;

use structs::stark_proof::StarkProof;
use models::CairoVerifierOutput;

fn verify_proof(ref stark_proof: StarkProof) -> CairoVerifierOutput {
    // TODO verify proof
    CairoVerifierOutput { program_hash: 0, output_hash: 0 }
}
