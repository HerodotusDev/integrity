use cairo_verifier::air::diluted::get_diluted_product;

#[test]
#[available_gas(9999999999)]
fn test_diluted_product_bits_16_spacing_4() {
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

#[test]
#[available_gas(9999999999)]
fn test_diluted_product_bits_8_spacing_4() {
    let res = array![
        0x18752401e75e69f83fc98b863b3a4c3e5e79f5650182c1df218b3ca29e5835a,
        0x7ac67e53584f33e2a63d9f4eb31b4c2cbbca8a48c2d750a7048e870ff47fa4c,
        0x4edc789c011c0a5be01c3bbda29e773917ef31c803bdf5679a7f5046bd97016,
        0x1c46d92d0b77212e6f5c6fc6d0aa079b467e1cc5c9bc08223ec0e25e3906712,
        0x5a0d2c17e9cc0b93cdf1a41f1ec3bbd6ce835458a1dabddc93df70ec1748468,
        0x4b03969520ad63b6dec6fbf0c844dae482e6f8e5b87d4c9fd00ed50de3416fb,
        0x5a870a34fce641bdd8d4ae06da8dd5f8e98fa368fac48723702d0f9f075208a,
        0x2dcdc3d2b00261f7a07281b1d79581f4ec070c05efaada09ca56015748dce0c,
        0x1c2d9212b3808991a61a64de551af75388fa02ab3c5a0293d7471ed4e72837c,
        0x35a8d259160bb1cc4c124cb81edbd1c77bf008c791b2670dd10014e07ea44fa
    ];

    helper_test_diluted_product(8, 4, res.span());
}

#[test]
#[available_gas(9999999999)]
fn test_diluted_product_bits_16_spacing_2() {
    let res = array![
        0x2d03b12988705fd15831dde5aa9aa4a79793016bd0a22ebad9211787d0a05b2,
        0x71e574bac4e58426e5c3537d08b58ee9c99720f816ba2202dd65b0b15fc198a,
        0xf7da7a7e0c0bfc469c085201489bffbd6c30449b547c6bbefaa7c7b16990eb,
        0x3785508048c3ef3b8c0bcae5ee6dc10790e186cfa13e52e8ef10c67a0aa91f8,
        0x64fb1baf4f455b606bfe0adf434bae08340d049c6ef07f17aaf4470e7a112c4,
        0x34ceb3253d98056fc322a90cf07b655da2e5f4820fdd59e17ed7534015200da,
        0x7301c7ba9c1772cc2b37fe7cd8553e3c4e88f0ea72713fabaa4de8d04a1e1c,
        0x2f76d2b3aa3f2a979621db4f06091dae99302193792056f822f5599f54aed17,
        0x788f2d9a6a5e7fd2d8e352890bf4e89a100ac0b0e37bdcb81f1e30a25d8450e,
        0x429f627f487f6e7d18c4608f742f72538a6624a356965a5f0820d1a1e7211b6
    ];

    helper_test_diluted_product(16, 2, res.span());
}

#[test]
#[available_gas(9999999999)]
fn test_diluted_product_bits_8_spacing_2() {
    let res = array![
        0x632b61015fb89ff3c699a6e57045432828c0295d7fe6329b30e720f4248b7ef,
        0x6ec94cecee4c25df064ddee2a4ffa9d9fea2a17b028ba98edfeedfd3bfba585,
        0x7703b82deb78228523d930d8168fecc212dea1d38537f5ea62766dbdf11a509,
        0x6f5bb96c92f66c2f35f9f1eed8cc74762f464ca6c361ade4cc00c6f86d63e43,
        0x36b2b57f7a8910c8a4f910489e32a4e18266144ca92779fee009a36fabf5419,
        0x6ee88cc132865b962868973639ce41b7c27d364e4f7e4e5b452c8e0aaa2f188,
        0x11cce009e17a3386a8d97dd05c2e50d2e17a5b436e6e20c103bee92b47518e8,
        0x22ed8293552315e78b12aeb70e4ab0eb9c006536ee535c701da9852f0326737,
        0x42076b59def678a7e34f23343f86684d4fb43a8fce62f003380842bda6377aa,
        0xd502678c91d8675c7088de077b8bec6a095991fd260e47b39c65f1cfa172fe
    ];

    helper_test_diluted_product(8, 2, res.span());
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
