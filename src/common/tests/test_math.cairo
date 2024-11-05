use integrity::common::math::{pow, DivRemFelt252};

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
fn test_div_rem_felt252() {
    let (q, r) = DivRem::div_rem(17, 2.try_into().unwrap());
    assert(q == 8, 'wrong quotient');
    assert(r == 1, 'wrong remainder');
}
