use cairo_verifier::air::public_memory::{Page, PageTrait, AddrValue};

#[test]
#[available_gas(9999999999)]
fn test_page_get_product() {
    let page: Page = array![
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
    ];

    assert(
        page
            .get_product(
                0x46ecc57b0b528c3dde60dbb870596694b2879c57d0b0a34ac1122ebea470a8d,
                0x207a232fb05d8c8261c44be98177c09634d23e7aaaf4838d435a4423e3a025f
            ) == 0x1ea9b3c4492c868b2fc237cba11b554c71972ba67121a43d203896ac16dc416,
        'Invalid page prod'
    );
}
