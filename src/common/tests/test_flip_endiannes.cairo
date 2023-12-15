use cairo_verifier::common::flip_endiannes::FlipEndiannessTrait;

#[test]
#[available_gas(9999999999)]
fn test_flip_endiannes_0() {
    let le_val: u128 = 0x10000000000000000000009123092121;
    assert(le_val.flip_endiannes() == 0x21210923910000000000000000000010, 'Invalid value');
}

#[test]
#[available_gas(9999999999)]
fn test_flip_endiannes_1() {
    let le_val: u128 = 0x9123092121;
    assert(le_val.flip_endiannes().flip_endiannes() == le_val, 'Invalid value');
}

#[test]
#[available_gas(9999999999)]
fn test_flip_endiannes_2() {
    let le_val: u128 = 0x98071087308702187408710847087;
    assert(le_val.flip_endiannes().flip_endiannes() == le_val, 'Invalid value');
}

#[test]
#[available_gas(9999999999)]
fn test_flip_endiannes_3() {
    let le_val: u128 = 0xABCDEF0123456789ABCDEF0123456789;
    assert(le_val.flip_endiannes() == 0x8967452301EFCDAB8967452301EFCDAB, 'Invalid value');
}

#[test]
#[available_gas(9999999999)]
fn test_flip_endiannes_4() {
    let le_val: u128 = 0x00000000000000000000ABCDEF012345;
    assert(le_val.flip_endiannes() == 0x452301EFCDAB00000000000000000000, 'Invalid value');
}

#[test]
#[available_gas(9999999999)]
fn test_flip_endiannes_5() {
    let le_val: u128 = 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
    assert(le_val.flip_endiannes() == 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, 'Invalid value');
}

#[test]
#[available_gas(9999999999)]
fn test_flip_endiannes_6() {
    let le_val: u128 = 0x00000000000000000000000000000000;
    assert(le_val.flip_endiannes() == 0x00000000000000000000000000000000, 'Invalid value');
}

#[test]
#[available_gas(9999999999)]
fn test_flip_endiannes_7() {
    let le_val: u128 = 0x1234567890ABCDEF1234567890ABCDEF;
    assert(le_val.flip_endiannes().flip_endiannes() == le_val, 'Invalid value');
}
