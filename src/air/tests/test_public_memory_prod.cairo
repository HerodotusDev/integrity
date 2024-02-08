use cairo_verifier::{
    air::{public_memory::{PageTrait, get_continuous_pages_product}, public_input::PublicInputTrait},
    tests::stone_proof_fibonacci
};

fn helper_get_z_alpha() -> (Array<felt252>, Array<felt252>) {
    let z_arr = array![
        0x46ecc57b0b528c3dde60dbb870596694b2879c57d0b0a34ac1122ebea470a8d,
        0x3c48e3094aeca888fe6781ad7594d14d7f88062bbe320c6d6913f44b116810,
        0x6813bd29a0c6fd6b95d8d73e35419f95acef279e47e4962adb687279763faf6,
        0x7b0c1a2f6cd6304624f7752edac7a87bfa8bb975be7cdfcea9a044bc20d3dec,
        0x51bc3297736a87e4684972602b4968d73feb6e09e68d9410e7e05b2f8c417b9,
        0x788a7025e36615cf27f6a05a057a87cc89b4c46b5b8255ee9da4e6b736bc017,
        0x4eea09d542e165d44189e413e87bf716ba52a42e14e6f13efe437a25472c9fb,
        0x5eef9cf19fb53bd33d8e6013843d0afc51dd52c9f951fe6d13dfd02e0a22ede,
        0x4a89959ccc754b250b1ed3a63e21d1db2104b7a70aa188403d97709fb317740,
        0x59897723dfed7667f695f22b24db7d8d57255d5276596ca54875efbc2b9e9f6
    ];

    let alpha_arr = array![
        0x207a232fb05d8c8261c44be98177c09634d23e7aaaf4838d435a4423e3a025f,
        0x1d7304763d588fc98a927959788ad2f21d76121918994f14fc417617e6e9747,
        0x52870fb223ef03ea39186779d76cec3a90e81ed3589be1444b4fc77a15b9882,
        0x476ad54dc1714414e5b501dfbcbf0facbca6eff4cb4011816b6bf02c723ad37,
        0x4b85d58acd28551ade61f1fa77072b8b616b33411a67f6a4f68a238d868380a,
        0x49acc926c92a39e8747d620f66e4a5dd7559d0ff2988086250f41b990e71ebe,
        0x47923b7712cb2d19b3cfd11e63ad10364e2580c9c18618b9d3e0f407514c485,
        0x410d525c8621078d3e5ed4884dfb54896d98caf47a36a105cda3c3a9e687238,
        0x49f2cc782433b76f7031c1f479022ceb1617c3379eb78410e3217b302967f02,
        0x7e9c8ccead9dc1932e044a80a08f66a9b9457f3060d3357d9b82e2c201223d7
    ];

    assert(z_arr.len() == alpha_arr.len(), 'Wrong lenghts');

    (z_arr, alpha_arr)
}

#[test]
#[available_gas(9999999999)]
fn test_page_get_product() {
    let public_input = stone_proof_fibonacci::public_input::get();

    let (z, alpha) = helper_get_z_alpha();

    let res = array![
        0x1ea9b3c4492c868b2fc237cba11b554c71972ba67121a43d203896ac16dc416,
        0x5cfb41dd448aa7528024786dfb01822633ae5db7febdd52f3e4b0e57ea41a90,
        0xbfd4ce49e96443656ab07bae546acdf6b45b8c5bd90cc810526a2ca983359e,
        0x69e00c709f8fc7cada024c8bb093c8955509c8eb5998651a610caf5fd7fa151,
        0x1dd74fcdb23f37264c5277947481e6f350e3d05d036b206aebd7d29bceab318,
        0x6f27ea981803040c6c0c50d9a656edf966783a2d00350b74ad1e0de41c47da9,
        0x2019d16ccf39d9c225d3395924cdfe1a217558f953f4649f58761269a9bfadf,
        0x4d1ec1af5da54edacb592ce644b51bd2ddb3427401952654601445451d83c52,
        0x430908be378a81911a1aaa1a3671729ad8d2860db824699a080509580de7f07,
        0x425b4a9482939405cc33802ce06ddec70a7ae80b2e54995d2b23b58dda5fc97
    ];

    assert(res.len() == z.len(), 'Wrong res len');

    let mut i = 0;
    loop {
        if i == res.len() {
            break;
        }

        assert(
            public_input.main_page.get_product(*z.at(i), *alpha.at(i)) == *res.at(i),
            'Invalid page prod'
        );

        i += 1;
    };
}

#[test]
#[available_gas(9999999999)]
fn test_get_continuous_pages_product() {
    // TODO test with non empty continuous pages (not supported in cairo-lang verifier)
    let pages = array![].span();

    assert(get_continuous_pages_product(pages) == (1, 0), 'Invalid pages prod');
}
#[test]
#[available_gas(9999999999)]
fn test_public_memory_product() {
    let public_input = stone_proof_fibonacci::public_input::get();

    let (z, alpha) = helper_get_z_alpha();

    let res = array![
        0x1ea9b3c4492c868b2fc237cba11b554c71972ba67121a43d203896ac16dc416,
        0x5cfb41dd448aa7528024786dfb01822633ae5db7febdd52f3e4b0e57ea41a90,
        0xbfd4ce49e96443656ab07bae546acdf6b45b8c5bd90cc810526a2ca983359e,
        0x69e00c709f8fc7cada024c8bb093c8955509c8eb5998651a610caf5fd7fa151,
        0x1dd74fcdb23f37264c5277947481e6f350e3d05d036b206aebd7d29bceab318,
        0x6f27ea981803040c6c0c50d9a656edf966783a2d00350b74ad1e0de41c47da9,
        0x2019d16ccf39d9c225d3395924cdfe1a217558f953f4649f58761269a9bfadf,
        0x4d1ec1af5da54edacb592ce644b51bd2ddb3427401952654601445451d83c52,
        0x430908be378a81911a1aaa1a3671729ad8d2860db824699a080509580de7f07,
        0x425b4a9482939405cc33802ce06ddec70a7ae80b2e54995d2b23b58dda5fc97
    ];

    assert(res.len() == z.len(), 'Wrong res len');

    let main_page_len: felt252 = public_input.main_page.len().into();
    let mut i = 0;
    loop {
        if i == res.len() {
            break;
        }

        assert(
            public_input
                .get_public_memory_product(*z.at(i), *alpha.at(i)) == (*res.at(i), main_page_len),
            'Invalid pub mem prod'
        );

        i += 1;
    };
}

#[test]
#[available_gas(9999999999)]
fn test_public_memory_product_ratio() {
    let public_input = stone_proof_fibonacci::public_input::get();

    let (z, alpha) = helper_get_z_alpha();

    let res = array![
        0x222cf8713d938af4954d6e3c98921720e296d5e9d21d5cc9b562245a009af1d,
        0x4be7477cb3aef375ba7a19aab6380a0aa55d46afe541631dd07c3e181976702,
        0x41642f18c8df22596673d4ce5fb18614e3e6734395199b62b62921c637b262f,
        0x42a98ae4ade3e6e31d85e71d7ebbd6d615410ebfd9c7c6ea5306fa8136c75b9,
        0x1bd284a7795f57d724dc0fc957b7acd511ffda2dd78b9b89ca3e6479e1215e1,
        0x7779575492fca29eff5e153dca9580cce1785be772f4d36aed54cd333d6ad6a,
        0x1458182ed5e5a2b82341360dd385785156acd741041754f6af2ceaee728177f,
        0x38b2dd01e4d76d056ccc3970767e70cf1e657c105c5c0c1ff72d50182b351b7,
        0x30f6ef82a1ba854a18b82b1a1b35165444b63c6cab7383026de25a23992489,
        0x93684e9a5faaaa0429d81601a290bea9ba5cf365165ae5a2916d9beaee1fd2
    ];

    let mut i = 0;
    loop {
        if i == res.len() {
            break;
        }

        assert(
            public_input
                .get_public_memory_product_ratio(*z.at(i), *alpha.at(i), 0x4000) == *res
                .at(i),
            'Invalid pub mem prod rat'
        );

        i += 1;
    };
}
