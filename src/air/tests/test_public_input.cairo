use cairo_verifier::{
    tests::{stone_proof_fibonacci, stone_proof_fibonacci_keccak},
    air::{public_input::PublicInputTrait}, domains::StarkDomainsTrait
};

#[test]
#[available_gas(9999999999)]
fn test_public_input_hash() {
    let public_input = stone_proof_fibonacci_keccak::public_input::get();

    assert(
        public_input
            .get_public_input_hash() == 0xaf91f2c71f4a594b1575d258ce82464475c82d8fb244142d0db450491c1b52,
        'Invalid value'
    )
}

#[test]
#[available_gas(9999999999)]
fn test_public_input_validate() {
    let public_input = stone_proof_fibonacci_keccak::public_input::get();

    let log_trace_domain_size = 0x12;
    let log_n_cosets = 0x4;
    let domain = StarkDomainsTrait::new(log_trace_domain_size, log_n_cosets);

    public_input.validate(@domain);
}

#[test]
#[available_gas(9999999999)]
fn test_public_input_verify() {
    let public_input = stone_proof_fibonacci::public_input::get();
    let (program_hash, output_hash) = public_input.verify();

    assert(
        program_hash == 0x7ac5582e353f8750487838481a46b5429ef84b2f18f909aaab9388f1fe0a28b,
        'Wrong program hash'
    );
    assert(
        output_hash == 0x60cbf4532b874a9a19557a55b45663831f71e21438525174b82842a1fab0ec4,
        'Wrong output hash'
    );
}
