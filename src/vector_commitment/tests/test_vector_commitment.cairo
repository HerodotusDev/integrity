use cairo_verifier::vector_commitment::vector_commitment::truncated_blake2s;
use core::debug::PrintTrait;

#[test]
#[available_gas(9999999999)]
fn test_truncated_blake2s() {
    let x = 1157029198022238202306346125123666191662554108005;
    let y = 129252051435949032402481343903845417193011527432;
    let out = truncated_blake2s(x, y);
    assert(out == 642191007116032514313255519742888271333651019057, 'invalid truncated_blake2s');
}