use integrity::{fri::fri::FriUnsentCommitment, tests::stone_proof_fibonacci};

fn get() -> FriUnsentCommitment {
    return FriUnsentCommitment {
        inner_layers: array![
            0x137de087f31f4e6f54222fc3cebb3c162469083196999e6ee4bb8ceb4d6b786,
            0x3bb3c75d228842edce6f6bf6fd6706ce51f5d83c6842a3ab4b4d89fad6f07b,
            0xb606d3c2b341ff9de5ead44f00121fdc4113f3720feb162eeaecb511e73d4f,
            0x787b0937a4cd02e0143e93979bb79139ca9546fc1654b4f755f8642c989ba20,
        ]
            .span(),
        last_layer_coefficients: stone_proof_fibonacci::fri::last_layer_coefficients::get().span(),
    };
}
