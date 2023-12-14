use core::debug::PrintTrait;
use core::array::ArrayTrait;
use common::from_span::FromSpanTrait;

#[test]
fn test_from_array_1() {
    let mut array = ArrayTrait::<u32>::new();
    array.append(0x6cebe487);
    array.append(0x00000000);
    array.append(0x00000000);
    array.append(0x00000000);
    assert(array.span().from_span() == 1827398791_u128, 'Invalid value');
}

#[test]
fn test_from_array_2() {
    let mut array = ArrayTrait::<u32>::new();
    array.append(0x5e0352b5);
    array.append(0x0040ec18);
    array.append(0x00000000);
    array.append(0x00000000);
    assert(array.span().from_span() == 18273987910128309_u128, 'Invalid value');
}

#[test]
fn test_from_array_3() {
    let mut array = ArrayTrait::<u32>::new();
    array.append(0xb49552b5);
    array.append(0xc941117a);
    array.append(0xe3500b26);
    array.append(0xc3e2d590);
    array.append(0x09239523);
    array.append(0x0000007d);
    array.append(0x00000000);
    array.append(0x00000000);
    assert(
        array.span().from_span() == 182739879101283091827398791012830918273987910128309_u256,
        'Invalid value'
    );
}

#[test]
fn test_from_array_4() {
    let mut array = ArrayTrait::<u32>::new();
    array.append(0x6f254ac7);
    array.append(0x13f2ae1b);
    array.append(0x0c907677);
    array.append(0x5a19ba60);
    array.append(0x05c0e20f);
    array.append(0x3b066d14);
    array.append(0x89ac0246);
    array.append(0x2866b5eb);
    assert(
        array
            .span()
            .from_span() == 18273987910112830918273987910128309910128309182739879101283099101283091827399_u256,
        'Invalid value'
    );
}
