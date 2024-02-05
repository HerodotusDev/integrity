use cairo_verifier::{fri::fri::FriUnsentCommitment, tests::stone_proof_fibonacci_keccak};

fn get() -> FriUnsentCommitment {
    return FriUnsentCommitment {
        inner_layers: array![
            0x279143db565360bb784ae426d9c99b535716a7faa9fb12b6fb041135129a1c6,
            0x27485d2bc1d16cad6cbac91f39fa94cb794aecf8c4f3e04330ed982a11937ab,
            0x664b97e07c1d2d52c314eb9887912695e34e404d3aceec5f340dbfd2e1750c4,
            0x6fb12bd48b9888a8e658379b2bc292a24683ba58ae04cc3f88ccea065cd1e29,
        ]
            .span(),
        last_layer_coefficients: stone_proof_fibonacci_keccak::fri::last_layer_coefficients::get().span(),
    };
}
