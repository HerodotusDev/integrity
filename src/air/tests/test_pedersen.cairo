use cairo_verifier::air::pedersen::{eval_pedersen_x, eval_pedersen_y};
use debug::PrintTrait;

#[test]
#[available_gas(9999999999)]
fn test_eval_pedersen_x() {
    assert(
        eval_pedersen_x(
            0x5bfda0d697168970d9aa181f78ae785603f258082b88be3b1854d29f3b34dc2
        ) == 0x347c3b5a473a369fe0dff299f20584e10d90a74d02c860f2c05405a0962380e,
        'Wrong pedersen eval'
    );
}

#[test]
#[available_gas(9999999999)]
fn test_eval_pedersen_y() {
    assert(
        eval_pedersen_y(
            0x5bfda0d697168970d9aa181f78ae785603f258082b88be3b1854d29f3b34dc2
        ) == 0x6da3790bceac8aa7c3ee46dff8a34b1eeff45f5d4b5a5e60f07caab341d9040,
        'Wrong pedersen eval'
    );
}
