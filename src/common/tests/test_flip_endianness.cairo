use cairo_verifier::common::flip_endianness::FlipEndiannessTrait;

#[test]
#[available_gas(9999999999)]
fn test_flip_endianness_0() {
    let le_val: u128 = 0x10000000000000000000009123092121;
    assert(le_val.flip_endianness() == 0x21210923910000000000000000000010, 'Invalid value');
}

#[test]
#[available_gas(9999999999)]
fn test_flip_endianness_1() {
    let le_val: u128 = 0x9123092121;
    assert(le_val.flip_endianness().flip_endianness() == le_val, 'Invalid value');
}

#[test]
#[available_gas(9999999999)]
fn test_flip_endianness_2() {
    let le_val: u128 = 0x98071087308702187408710847087;
    assert(le_val.flip_endianness().flip_endianness() == le_val, 'Invalid value');
}

#[test]
#[available_gas(9999999999)]
fn test_flip_endianness_3() {
    let le_val: u128 = 0xABCDEF0123456789ABCDEF0123456789;
    assert(le_val.flip_endianness() == 0x8967452301EFCDAB8967452301EFCDAB, 'Invalid value');
}

#[test]
#[available_gas(9999999999)]
fn test_flip_endianness_4() {
    let le_val: u128 = 0x00000000000000000000ABCDEF012345;
    assert(le_val.flip_endianness() == 0x452301EFCDAB00000000000000000000, 'Invalid value');
}

#[test]
#[available_gas(9999999999)]
fn test_flip_endianness_5() {
    let le_val: u128 = 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
    assert(le_val.flip_endianness() == 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, 'Invalid value');
}

#[test]
#[available_gas(9999999999)]
fn test_flip_endianness_6() {
    let le_val: u128 = 0x00000000000000000000000000000000;
    assert(le_val.flip_endianness() == 0x00000000000000000000000000000000, 'Invalid value');
}

#[test]
#[available_gas(9999999999)]
fn test_flip_endianness_7() {
    let le_val: u128 = 0x1234567890ABCDEF1234567890ABCDEF;
    assert(le_val.flip_endianness().flip_endianness() == le_val, 'Invalid value');
}
