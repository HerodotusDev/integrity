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
        point: 0x295db9e6b36bd5b5d2591d7d76a57e241821fd478b9f667778f0a09960d3a0f,
        trace_domain_size: 0x40000,
        trace_generator: 0x4768803ef85256034f67453635f87997ff61841e411ee63ce7b0a8b9745a046
    );
    assert(
        res == 0x245c787b658a0461241e840f1ffcf76ca5d29e6571e7a8edd80fdd968fddd45,
        'invalid composition_polynomial'
    );
}
