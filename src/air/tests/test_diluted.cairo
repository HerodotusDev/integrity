use cairo_verifier::air::diluted::get_diluted_product;

#[test]
#[available_gas(9999999999)]
fn test_diluted_product() {
    assert(
        get_diluted_product(
            16,
            14,
            0x3c48e3094aeca888fe6781ad7594d14d7f88062bbe320c6d6913f44b116810,
            0x1d7304763d588fc98a927959788ad2f21d76121918994f14fc417617e6e9747
        ) == 0x77236c66f48bc3c27dd07478f276be52b473a7ecbda1b8e6f672824e4627da9,
        'Wrong diluted prod'
    );
}
