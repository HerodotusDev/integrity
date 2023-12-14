use common::flip_endiannes::FlipEndiannessTrait;
use core::debug::PrintTrait;

#[test]
fn test_flip_endiannes_0() {
    let le_val: u128 = 0x00000000000000000000009123092121;
    le_val.flip_endiannes().print();
    assert(le_val.flip_endiannes() == 0x21210923910000000000000000000000, 'Invalid value');
}

#[test]
fn test_flip_endiannes_1() {
    let le_val: u128 = 0x9123092121;
    assert(le_val.flip_endiannes().flip_endiannes() == le_val, 'Invalid value');
}

#[test]
fn test_flip_endiannes_2() {
    let le_val: u128 = 0x98071087308702187408710847087;
    assert(le_val.flip_endiannes().flip_endiannes() == le_val, 'Invalid value');
}