use cairo_verifier::air::public_memory::{Page, PageTrait, AddrValue, get_continuous_pages_product};
use cairo_verifier::air::public_input::{PublicInput, PublicInputTrait, SegmentInfo};

fn helper_get_main_page() -> Page {
    array![
        AddrValue { address: 0x1, value: 0x40780017fff7fff },
        AddrValue { address: 0x2, value: 0x4 },
        AddrValue { address: 0x3, value: 0x1104800180018000 },
        AddrValue { address: 0x4, value: 0x4 },
        AddrValue { address: 0x5, value: 0x10780017fff7fff },
        AddrValue { address: 0x6, value: 0x0 },
        AddrValue { address: 0x7, value: 0x40780017fff7fff },
        AddrValue { address: 0x8, value: 0x1 },
        AddrValue { address: 0x9, value: 0x400380007ffa8000 },
        AddrValue { address: 0xa, value: 0x480680017fff8000 },
        AddrValue { address: 0xb, value: 0x1 },
        AddrValue { address: 0xc, value: 0x480680017fff8000 },
        AddrValue { address: 0xd, value: 0x1 },
        AddrValue { address: 0xe, value: 0x480a80007fff8000 },
        AddrValue { address: 0xf, value: 0x1104800180018000 },
        AddrValue { address: 0x10, value: 0x9 },
        AddrValue { address: 0x11, value: 0x400280017ffa7fff },
        AddrValue { address: 0x12, value: 0x482680017ffa8000 },
        AddrValue { address: 0x13, value: 0x2 },
        AddrValue { address: 0x14, value: 0x480a7ffb7fff8000 },
        AddrValue { address: 0x15, value: 0x480a7ffc7fff8000 },
        AddrValue { address: 0x16, value: 0x480a7ffd7fff8000 },
        AddrValue { address: 0x17, value: 0x208b7fff7fff7ffe },
        AddrValue { address: 0x18, value: 0x20780017fff7ffd },
        AddrValue { address: 0x19, value: 0x4 },
        AddrValue { address: 0x1a, value: 0x480a7ffc7fff8000 },
        AddrValue { address: 0x1b, value: 0x208b7fff7fff7ffe },
        AddrValue { address: 0x1c, value: 0x480a7ffc7fff8000 },
        AddrValue { address: 0x1d, value: 0x482a7ffc7ffb8000 },
        AddrValue { address: 0x1e, value: 0x482680017ffd8000 },
        AddrValue {
            address: 0x1f, value: 0x800000000000011000000000000000000000000000000000000000000000000
        },
        AddrValue { address: 0x20, value: 0x1104800180018000 },
        AddrValue {
            address: 0x21, value: 0x800000000000010fffffffffffffffffffffffffffffffffffffffffffffff9
        },
        AddrValue { address: 0x22, value: 0x208b7fff7fff7ffe },
        AddrValue { address: 0x23, value: 0x25 },
        AddrValue { address: 0x24, value: 0x0 },
        AddrValue { address: 0x25, value: 0x68 },
        AddrValue { address: 0x26, value: 0x6a },
        AddrValue { address: 0x27, value: 0x1ea },
        AddrValue { address: 0x28, value: 0x9ea },
        AddrValue { address: 0x64, value: 0x6a },
        AddrValue { address: 0x65, value: 0x6a },
        AddrValue { address: 0x66, value: 0x1ea },
        AddrValue { address: 0x67, value: 0x9ea },
        AddrValue { address: 0x68, value: 0xa },
        AddrValue { address: 0x69, value: 0x90 }
    ]
}

fn helper_get_public_input() -> PublicInput {
    PublicInput {
        log_n_steps: 0xe,
        rc_min: 0x7ffa,
        rc_max: 0x8001,
        layout: 0x726563757273697665,
        dynamic_params: array![],
        segments: array![
            SegmentInfo { begin_addr: 0x1, stop_ptr: 0x5 },
            SegmentInfo { begin_addr: 0x25, stop_ptr: 0x68 },
            SegmentInfo { begin_addr: 0x68, stop_ptr: 0x6a },
            SegmentInfo { begin_addr: 0x6a, stop_ptr: 0x6a },
            SegmentInfo { begin_addr: 0x1ea, stop_ptr: 0x1ea },
            SegmentInfo { begin_addr: 0x9ea, stop_ptr: 0x9ea },
        ],
        padding_addr: 0x1,
        padding_value: 0x40780017fff7fff,
        main_page: helper_get_main_page(),
        continuous_page_headers: array![],
    }
}

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

    assert(z_arr.len() == alpha_arr.len(), 'Wrong lens');

    (z_arr, alpha_arr)
}

#[test]
#[available_gas(9999999999)]
fn test_page_get_product() {
    let page = helper_get_main_page();

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

        assert(page.get_product(*z.at(i), *alpha.at(i)) == *res.at(i), 'Invalid page prod');

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
    let public_input = helper_get_public_input();

    assert(
        public_input
            .get_public_memory_product(
                0x46ecc57b0b528c3dde60dbb870596694b2879c57d0b0a34ac1122ebea470a8d,
                0x207a232fb05d8c8261c44be98177c09634d23e7aaaf4838d435a4423e3a025f
            ) == (
                0x1ea9b3c4492c868b2fc237cba11b554c71972ba67121a43d203896ac16dc416,
                public_input.main_page.len().into()
            ),
        'Invalid pub mem prod'
    );
}

#[test]
#[available_gas(9999999999)]
fn test_public_memory_product_ratio() {
    let public_input = helper_get_public_input();

    assert(
        public_input
            .get_public_memory_product_ratio(
                0x46ecc57b0b528c3dde60dbb870596694b2879c57d0b0a34ac1122ebea470a8d,
                0x207a232fb05d8c8261c44be98177c09634d23e7aaaf4838d435a4423e3a025f,
                0x4000
            ) == 0x222cf8713d938af4954d6e3c98921720e296d5e9d21d5cc9b562245a009af1d,
        'Invalid pub mem prod rat'
    );
}
