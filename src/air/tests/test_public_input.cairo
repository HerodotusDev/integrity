use cairo_verifier::{
    tests::stone_proof_fibonacci_keccak, air::{public_input::PublicInputTrait},
    domains::StarkDomainsTrait
};

// test data from cairo0-verifier keccak-native run on stone-prover generated proof
#[test]
#[available_gas(9999999999)]
fn test_public_input_hash() {
    let public_input = stone_proof_fibonacci_keccak::public_input::get();

    assert(
        public_input
            .get_public_input_hash() == u256 {
                low: 0x22b3f4d7841a28271009bef644a84a5e, high: 0x8f17c0c0dcde2144cd36213ab3aaff1b
            },
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
