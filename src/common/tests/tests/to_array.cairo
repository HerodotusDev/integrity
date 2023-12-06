use core::debug::PrintTrait;
use core::array::ArrayTrait;
use common::to_array::ToArrayTrait;

#[test]
fn test_to_array_0() {
    let value = 256_u128;
    let mut result = ArrayTrait::<u8>::new();
    value.to_array(ref result);
    assert((*result[0]) == 0, 'Invalid value');
    assert((*result[1]) == 1, 'Invalid value');
    assert((*result[2]) == 0, 'Invalid value');
}