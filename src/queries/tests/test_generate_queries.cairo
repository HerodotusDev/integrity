use cairo_verifier::{queries::queries::generate_queries, channel::channel::ChannelTrait};

#[test]
#[available_gas(9999999999)]
fn test_generate_queries_0() {
    let mut channel = ChannelTrait::new(
        u256 { low: 0xf7685ebd40e852b164633a4acbd3244c, high: 0xe8e77626586f73b955364c7b4bbf0bb7 }
    );
    assert(
        generate_queries(
            ref channel, 4, 12389012333
        ) == array![0xc53fdd1e, 0x166d56d3d, 0x1e563d10b, 0x2d9a2434f],
        'Invalid value'
    );
}

#[test]
#[available_gas(9999999999)]
fn test_generate_queries_1() {
    let mut channel = ChannelTrait::new(
        u256 { low: 0xf7685ebd40e852b164633a4acbd3244c, high: 0xe8e77626586f73b955364c7b4bbf0bb7 }
    );
    assert(
        generate_queries(
            ref channel, 10, 99809818624
        ) == array![
            0x3247d4098,
            0x52d896136,
            0x557cce2e5,
            0x6188b67d1,
            0x982d6fc79,
            0xa733f8ed8,
            0xbf23e4bf7,
            0xc2321969b,
            0xca83fb21d,
            0x1405a07e8c
        ],
        'Invalid value'
    );
}

// test generated based on cairo0-verifier run on fib proof from stone-prover
#[test]
#[available_gas(9999999999)]
fn test_generate_queries_2() {
    let mut channel = ChannelTrait::new(
        u256 { low: 0x2c31f04a6b9c83c2464b2f1688fc719e, high: 0xe631d91ef56f7e4cc7fe09cff2cc4e94 }
    );
    assert(
        generate_queries(
            ref channel, 18, 0x400000
        ) == array![
            0x4c3e3,
            0x53e5f,
            0x5e7ae,
            0x6f76e,
            0xde621,
            0xe0f5a,
            0xf5b8c,
            0x13d133,
            0x180758,
            0x1eeb19,
            0x20d785,
            0x21f804,
            0x245054,
            0x3883ce,
            0x3970d6,
            0x3a8f8e,
            0x3b9258,
            0x3c7016,
        ],
        'Invalid value'
    );
}
