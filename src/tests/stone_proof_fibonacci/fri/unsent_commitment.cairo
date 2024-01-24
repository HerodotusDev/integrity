use cairo_verifier::{fri::fri::FriUnsentCommitment, tests::stone_proof_fibonacci,};

fn get() -> FriUnsentCommitment {
    return FriUnsentCommitment {
        inner_layers: array![
            0x6288a59e1970d629fdfb5bdea93ad3203511b3c27340db1467a39cf7951de3,
            0x821aaa485d3fbdf7b0a06d773e565370f794c06bbcb4e23279a39544782c1e,
            0x7a73129c87d8a60cb07b26775437ac75790bbd415d47912e5eb1f7c7e11d42f,
            0x3ce8c532eab6fcbf597abd8817cc406cc884f6000ab2d79c9a9ea3a12b4c038,
        ]
            .span(),
        last_layer_coefficients: stone_proof_fibonacci::fri::last_layer_coefficients::get().span(),
    };
}
