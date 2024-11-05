use integrity::common::array_append::ArrayAppendTrait;

#[test]
#[available_gas(9999999999)]
fn test_array_append_le_1() {
    let value = 1827398791_u128; // = 0x6cebe487
    let mut result = ArrayTrait::<u32>::new();
    result.append_little_endian(value);
    assert((*result[0]) == 0x6cebe487, 'Invalid value');
    assert((*result[1]) == 0x00000000, 'Invalid value');
}

#[test]
#[available_gas(9999999999)]
fn test_array_append_le_2() {
    let value = 18273987910128309_u128; // = 0x40ec185e0352b5
    let mut result = ArrayTrait::<u32>::new();
    result.append_little_endian(value);
    assert((*result[0]) == 0x5e0352b5, 'Invalid value');
    assert((*result[1]) == 0x0040ec18, 'Invalid value');
}

#[test]
#[available_gas(9999999999)]
fn test_array_append_le_3() {
    let value =
        182739879101283091827398791012830918273987910128309_u256; // = 0x7d09239523c3e2d590e3500b26c941117ab49552b5
    let mut result = ArrayTrait::<u32>::new();
    result.append_little_endian(value);
    assert((*result[0]) == 0xb49552b5, 'Invalid value');
    assert((*result[1]) == 0xc941117a, 'Invalid value');
    assert((*result[2]) == 0xe3500b26, 'Invalid value');
    assert((*result[3]) == 0xc3e2d590, 'Invalid value');
    assert((*result[4]) == 0x09239523, 'Invalid value');
    assert((*result[5]) == 0x0000007d, 'Invalid value');
}

#[test]
#[available_gas(9999999999)]
fn test_array_append_le_4() {
    let value =
        18273987910112830918273987910128309910128309182739879101283099101283091827399_u256; // = 0x2866b5eb89ac02463b066d1405c0e20f5a19ba600c90767713f2ae1b6f254ac7
    let mut result = ArrayTrait::<u32>::new();
    result.append_little_endian(value);
    assert((*result[0]) == 0x6f254ac7, 'Invalid value');
    assert((*result[1]) == 0x13f2ae1b, 'Invalid value');
    assert((*result[2]) == 0x0c907677, 'Invalid value');
    assert((*result[3]) == 0x5a19ba60, 'Invalid value');
    assert((*result[4]) == 0x05c0e20f, 'Invalid value');
    assert((*result[5]) == 0x3b066d14, 'Invalid value');
    assert((*result[6]) == 0x89ac0246, 'Invalid value');
    assert((*result[7]) == 0x2866b5eb, 'Invalid value');
}

#[test]
#[available_gas(9999999999)]
fn test_array_append_le_5() {
    let value: Array<felt252> = array![1, 2, 3, 4];
    let mut result = ArrayTrait::<u32>::new();
    result.append_little_endian(value.span());
    assert((*result[0]) == 0x1, 'Invalid value');
    assert((*result[1]) == 0x0, 'Invalid value');
    assert((*result[2]) == 0x0, 'Invalid value');
    assert((*result[3]) == 0x0, 'Invalid value');
    assert((*result[4]) == 0x0, 'Invalid value');
    assert((*result[5]) == 0x0, 'Invalid value');
    assert((*result[6]) == 0x0, 'Invalid value');
    assert((*result[7]) == 0x0, 'Invalid value');
    assert((*result[8]) == 0x2, 'Invalid value');
    assert((*result[9]) == 0x0, 'Invalid value');
    assert((*result[10]) == 0x0, 'Invalid value');
    assert((*result[11]) == 0x0, 'Invalid value');
    assert((*result[12]) == 0x0, 'Invalid value');
    assert((*result[13]) == 0x0, 'Invalid value');
    assert((*result[14]) == 0x0, 'Invalid value');
    assert((*result[15]) == 0x0, 'Invalid value');
    assert((*result[16]) == 0x3, 'Invalid value');
    assert((*result[17]) == 0x0, 'Invalid value');
    assert((*result[18]) == 0x0, 'Invalid value');
    assert((*result[19]) == 0x0, 'Invalid value');
    assert((*result[20]) == 0x0, 'Invalid value');
    assert((*result[21]) == 0x0, 'Invalid value');
    assert((*result[22]) == 0x0, 'Invalid value');
    assert((*result[23]) == 0x0, 'Invalid value');
    assert((*result[24]) == 0x4, 'Invalid value');
    assert((*result[25]) == 0x0, 'Invalid value');
    assert((*result[26]) == 0x0, 'Invalid value');
    assert((*result[27]) == 0x0, 'Invalid value');
    assert((*result[28]) == 0x0, 'Invalid value');
    assert((*result[29]) == 0x0, 'Invalid value');
    assert((*result[30]) == 0x0, 'Invalid value');
    assert((*result[31]) == 0x0, 'Invalid value');
}
