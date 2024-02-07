use cairo_verifier::{
    tests::stone_proof_fibonacci, air::{public_input::PublicInputTrait}, domains::StarkDomainsTrait
};

// test data from cairo0-verifier run on stone-prover generated proof
#[test]
#[available_gas(9999999999)]
fn test_public_input_hash() {
    let public_input = stone_proof_fibonacci::public_input::get();

    assert(
        public_input
            .get_public_input_hash() == u256 {
                low: 0xba9d17a3ebd900899148b125421c118f, high: 0x87433b8dd90acbfe5abea8474d795191
            },
        'Invalid value'
    )
}

#[test]
#[available_gas(9999999999)]
fn test_public_input_validate() {
    let public_input = stone_proof_fibonacci::public_input::get();

    let log_trace_domain_size = 0x12;
    let log_n_cosets = 0x4;
    let domain = StarkDomainsTrait::new(log_trace_domain_size, log_n_cosets);

    public_input.validate(@domain);
}

#[test]
#[available_gas(9999999999)]
fn test_public_input_verify() {
    let public_input = stone_proof_fibonacci::public_input::get();
    public_input.verify();
}

