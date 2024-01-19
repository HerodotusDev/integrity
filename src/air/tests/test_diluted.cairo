use cairo_verifier::air::diluted::get_diluted_product;
use debug::PrintTrait;

#[test]
#[available_gas(9999999999)]
fn test_diluted_product() {
    let res = array![
        0x77236c66f48bc3c27dd07478f276be52b473a7ecbda1b8e6f672824e4627da9,
        0x54cb3ebd068990e0d154beb88a5c173257eed1b0b5904374300962d72e9b41,
        0x43e08864f8390c13772a7fe22a9d62e8259bf8f99740110c75c8ba803694a6a,
        0x3027d7f8b063e08733602c352a1b5ce86768bf5b0fc5f48a102e74ec6d98c9b,
        0x914182d27479fab56632ff69bc8a4ee9b579e7f9c8f84bf0fb58025a3a4b12,
        0x16751012db74a77b0c4fbd0b4f02f89ec20e7f3b866b354bacb7bd5a0f501ce,
        0x26d12d247dfe1fdecce2405225db1d18d89def2ca22b1239e79ed710b8990d1,
        0x60e66d5436985c1e1e1619a0fb319582bd09e38e21bb1da2b31794bd3207d2a,
        0x7881c5f6b6bfa06a45799dfe315284e8b2a6e450656584889068890bf98f881,
        0x656bd6a31349997ec60abfd7471725e9f1e3247ef2270a0242e480808d85725
    ];

    helper_test_diluted_product(16, 4, res.span());
}

fn helper_test_diluted_product(n_bits: felt252, spacing: felt252, res: Span<felt252>) {
    let z_arr = array![
        0x3c48e3094aeca888fe6781ad7594d14d7f88062bbe320c6d6913f44b116810,
        0x6813bd29a0c6fd6b95d8d73e35419f95acef279e47e4962adb687279763faf6,
        0x7b0c1a2f6cd6304624f7752edac7a87bfa8bb975be7cdfcea9a044bc20d3dec,
        0x51bc3297736a87e4684972602b4968d73feb6e09e68d9410e7e05b2f8c417b9,
        0x788a7025e36615cf27f6a05a057a87cc89b4c46b5b8255ee9da4e6b736bc017,
        0x4eea09d542e165d44189e413e87bf716ba52a42e14e6f13efe437a25472c9fb,
        0x5eef9cf19fb53bd33d8e6013843d0afc51dd52c9f951fe6d13dfd02e0a22ede,
        0x4a89959ccc754b250b1ed3a63e21d1db2104b7a70aa188403d97709fb317740,
        0x59897723dfed7667f695f22b24db7d8d57255d5276596ca54875efbc2b9e9f6,
        0x530f2e9b29fb3b165e6dbf6785f4490e4e1de17acd48389654971e8f3f57753
    ];

    let alpha_arr = array![
        0x1d7304763d588fc98a927959788ad2f21d76121918994f14fc417617e6e9747,
        0x52870fb223ef03ea39186779d76cec3a90e81ed3589be1444b4fc77a15b9882,
        0x476ad54dc1714414e5b501dfbcbf0facbca6eff4cb4011816b6bf02c723ad37,
        0x4b85d58acd28551ade61f1fa77072b8b616b33411a67f6a4f68a238d868380a,
        0x49acc926c92a39e8747d620f66e4a5dd7559d0ff2988086250f41b990e71ebe,
        0x47923b7712cb2d19b3cfd11e63ad10364e2580c9c18618b9d3e0f407514c485,
        0x410d525c8621078d3e5ed4884dfb54896d98caf47a36a105cda3c3a9e687238,
        0x49f2cc782433b76f7031c1f479022ceb1617c3379eb78410e3217b302967f02,
        0x7e9c8ccead9dc1932e044a80a08f66a9b9457f3060d3357d9b82e2c201223d7,
        0x78e6b8c8ac5dc6f4af5280d67d81398cea92d1df8f0230610f2780bbf1784b2
    ];

    assert(z_arr.len() == res.len(), 'Wrong test len');
    assert(alpha_arr.len() == res.len(), 'Wrong test len');

    let mut i = 0;
    loop {
        if i == res.len() {
            break;
        }

        assert(
            get_diluted_product(n_bits, spacing, *z_arr.at(i), *alpha_arr.at(i)) == *res.at(i),
            'Wrong diluted prod'
        );

        i += 1;
    };
}
