use cairo_verifier::air::{
    composition::eval_composition_polynomial, public_input::{PublicInput, SegmentInfo},
    public_memory::AddrValue, global_values::InteractionElements,
};
use cairo_verifier::vector_commitment::vector_commitment::{
    VectorCommitment, VectorCommitmentConfig
};
use cairo_verifier::table_commitment::table_commitment::{TableCommitment, TableCommitmentConfig};
use cairo_verifier::tests::stone_proof_fibonacci;

#[test]
#[available_gas(9999999999)]
fn test_eval_composition_polynomial() {
    let public_input = stone_proof_fibonacci::public_input::get();
    let interaction_elements = stone_proof_fibonacci::interaction_elements::get();
    let mask_values = stone_proof_fibonacci::stark::oods_values::get();
    let constraint_coefficients = stone_proof_fibonacci::constraint_coefficients::get();

    let res = eval_composition_polynomial(
        interaction_elements,
        @public_input,
        mask_values.span(),
        constraint_coefficients.span(),
        point: 0x47148421d376a8ca07af1e4c89890bf29c90272f63b16103646397d907281a8,
        trace_domain_size: 0x40000,
        trace_generator: 0x4768803ef85256034f67453635f87997ff61841e411ee63ce7b0a8b9745a046
    );
    assert(
        res == 0x511668bf439c0999c57d3c05c9f1bcf12095ef76d5a032985bd2350f1731604, 'invalid value'
    );
}
