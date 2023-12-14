use core::debug::PrintTrait;
use core::array::ArrayTrait;
use common::to_array::ToArrayTrait;

#[test]
fn test_to_array_le_1() {
    let value = 1827398791_u128; // = 0x6cebe487
    let mut result = ArrayTrait::<u32>::new();
    value.to_array_le(ref result);
    assert((*result[0]) == 0x6cebe487, 'Invalid value');
    assert((*result[1]) == 0x00000000, 'Invalid value');
}

#[test]
fn test_to_array_le_2() {
    let value = 18273987910128309_u128; // = 0x40ec185e0352b5
    let mut result = ArrayTrait::<u32>::new();
    value.to_array_le(ref result);
    assert((*result[0]) == 0x5e0352b5, 'Invalid value');
    assert((*result[1]) == 0x0040ec18, 'Invalid value');
}

#[test]
fn test_to_array_le_3() {
    let value =
        182739879101283091827398791012830918273987910128309_u256; // = 0x7d09239523c3e2d590e3500b26c941117ab49552b5
    let mut result = ArrayTrait::<u32>::new();
    value.to_array_le(ref result);
    assert((*result[0]) == 0xb49552b5, 'Invalid value');
    assert((*result[1]) == 0xc941117a, 'Invalid value');
    assert((*result[2]) == 0xe3500b26, 'Invalid value');
    assert((*result[3]) == 0xc3e2d590, 'Invalid value');
    assert((*result[4]) == 0x09239523, 'Invalid value');
    assert((*result[5]) == 0x0000007d, 'Invalid value');
}

#[test]
fn test_to_array_le_4() {
    let value =
        18273987910112830918273987910128309910128309182739879101283099101283091827399_u256; // = 0x2866b5eb89ac02463b066d1405c0e20f5a19ba600c90767713f2ae1b6f254ac7
    let mut result = ArrayTrait::<u32>::new();
    value.to_array_le(ref result);
    assert((*result[0]) == 0x6f254ac7, 'Invalid value');
    assert((*result[1]) == 0x13f2ae1b, 'Invalid value');
    assert((*result[2]) == 0x0c907677, 'Invalid value');
    assert((*result[3]) == 0x5a19ba60, 'Invalid value');
    assert((*result[4]) == 0x05c0e20f, 'Invalid value');
    assert((*result[5]) == 0x3b066d14, 'Invalid value');
    assert((*result[6]) == 0x89ac0246, 'Invalid value');
    assert((*result[7]) == 0x2866b5eb, 'Invalid value');
}
