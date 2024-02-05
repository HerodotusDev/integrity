use cairo_verifier::{fri::fri::FriUnsentCommitment, tests::stone_proof_fibonacci,};

fn get() -> FriUnsentCommitment {
    return FriUnsentCommitment {
        inner_layers: array![
            0x3d710625c60c2e534dbb7f0595315750e6b2c5b7ba19be7d6b34a22e1a7dcbc,
            0x1490a301a131a8887f32c59a8eb9fd702cc2be5dfc0ecfcc461f50d856b657a,
            0x23c7018a71142c60c465a7fe0169c96c043154d40f6a7dc3196bbf52c20902f,
            0x3515eb7f5c47a1f199e7089495de38c8dd80223a25c901bc7db5e84061b823c,
        ]
            .span(),
        last_layer_coefficients: stone_proof_fibonacci::fri::last_layer_coefficients::get().span(),
    };
}
