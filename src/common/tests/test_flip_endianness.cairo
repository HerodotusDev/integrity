use integrity::common::flip_endianness::FlipEndiannessTrait;

#[test]
#[available_gas(9999999999)]
fn test_flip_endianness_0() {
    let le_val: u128 = 0x10000000000000000000009123092121;
    assert(le_val.flip_endianness() == 0x21210923910000000000000000000010, 'Invalid value');
    assert(le_val == 0x10000000000000000000009123092121, 'Original value has mutated');
}

#[test]
#[available_gas(9999999999)]
fn test_flip_endianness_1() {
    let le_val: u128 = 0x9123092121;
    assert(le_val.flip_endianness().flip_endianness() == le_val, 'Invalid value');
    assert(le_val == 0x9123092121, 'Original value has mutated');
}

#[test]
#[available_gas(9999999999)]
fn test_flip_endianness_2() {
    let le_val: u128 = 0x98071087308702187408710847087;
    assert(le_val.flip_endianness().flip_endianness() == le_val, 'Invalid value');
    assert(le_val == 0x98071087308702187408710847087, 'Original value has mutated');
}

#[test]
#[available_gas(9999999999)]
fn test_flip_endianness_3() {
    let le_val: u128 = 0xABCDEF0123456789ABCDEF0123456789;
    assert(le_val.flip_endianness() == 0x8967452301EFCDAB8967452301EFCDAB, 'Invalid value');
    assert(le_val == 0xABCDEF0123456789ABCDEF0123456789, 'Original value has mutated');
}

#[test]
#[available_gas(9999999999)]
fn test_flip_endianness_4() {
    let le_val: u128 = 0x00000000000000000000ABCDEF012345;
    assert(le_val.flip_endianness() == 0x452301EFCDAB00000000000000000000, 'Invalid value');
    assert(le_val == 0x00000000000000000000ABCDEF012345, 'Original value has mutated');
}

#[test]
#[available_gas(9999999999)]
fn test_flip_endianness_5() {
    let le_val: u128 = 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
    assert(le_val.flip_endianness() == 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, 'Invalid value');
    assert(le_val == 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, 'Original value has mutated');
}

#[test]
#[available_gas(9999999999)]
fn test_flip_endianness_6() {
    let le_val: u128 = 0x00000000000000000000000000000000;
    assert(le_val.flip_endianness() == 0x00000000000000000000000000000000, 'Invalid value');
    assert(le_val == 0x00000000000000000000000000000000, 'Original value has mutated');
}

#[test]
#[available_gas(9999999999)]
fn test_flip_endianness_7() {
    let le_val: u128 = 0x1234567890ABCDEF1234567890ABCDEF;
    assert(le_val.flip_endianness().flip_endianness() == le_val, 'Invalid value');
    assert(le_val == 0x1234567890ABCDEF1234567890ABCDEF, 'Original value has mutated');
}

#[test]
#[available_gas(9999999999)]
fn test_flip_endianness_256() {
    let le_val: u256 = 0xb8c727aa44f32839b875a9323a8f204a330c70f29ca91581be9207a703f70d74;
    let be_val: u256 = 0x740df703a70792be8115a99cf2700c334a208f3a32a975b83928f344aa27c7b8;
    assert(le_val.flip_endianness() == be_val, 'Invalid value');
}
