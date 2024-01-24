use cairo_verifier::{tests::stone_proof_fibonacci, air::{public_input::PublicInputTrait}};

// test generated based on cairo0-verifier run on fib proof from stone-prover
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
