use cairo_verifier::common::math::{pow, mul_inverse};

#[test]
#[available_gas(9999999999)]
fn test_pow_1() {
    let base = 1934568044210770965733097210694395167600009938751278224656090409051406060084;
    let exp = 69439516760000993875127;
    assert(
        pow(
            base, exp
        ) == 2804690217475462062143361339624939640984649667966511418446363596075299761851,
        'Invalid value'
    );
}

#[test]
#[available_gas(9999999999)]
fn test_pow_2() {
    let base = 193456804421077096570009938751278224656090409051406060084;
    let exp = 193456804421077096570009938751278224656090409051406060084;
    assert(
        pow(
            base, exp
        ) == 2672162222334975109199941471365701890765112108683608796920114577809390903720,
        'Invalid value'
    );
}

#[test]
#[available_gas(9999999999)]
fn test_mul_inverse_1() {
    let x = 9751091999414713;
    let inv_x = mul_inverse(x);
    assert(x * inv_x == 1, 'Invalid value');
}

#[test]
#[available_gas(9999999999)]
fn test_mul_inverse_2() {
    let x = 97199414713;
    let inv_x = mul_inverse(x);
    assert(x * inv_x == 1, 'Invalid value');
}

#[test]
#[available_gas(9999999999)]
fn test_mul_inverse_3() {
    let x = 92011457780;
    let inv_x = mul_inverse(x);
    assert(x * inv_x == 1, 'Invalid value');
}

#[test]
#[available_gas(9999999999)]
fn test_mul_inverse_4() {
    let x = 193456804421077096570009938751278224656090409051406060084;
    let inv_inv_x = mul_inverse(mul_inverse(x));
    assert(x == inv_inv_x, 'Invalid value');
}

#[test]
#[available_gas(9999999999)]
fn test_mul_inverse_5() {
    let x = 19345680409051406060084;
    let inv_inv_x = mul_inverse(mul_inverse(x));
    assert(x == inv_inv_x, 'Invalid value');
}
