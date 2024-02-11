use cairo_verifier::{queries::queries::sample_random_queries, channel::channel::ChannelTrait};
// === BLAKE ONLY BEGIN ===
// #[test]
// #[available_gas(9999999999)]
// fn test_sample_random_queries_0() {
//     let mut channel = ChannelTrait::new(
//         u256 { low: 0xf7685ebd40e852b164633a4acbd3244c, high: 0xe8e77626586f73b955364c7b4bbf0bb7 }
//     );
//     let queries = sample_random_queries(ref channel, 1, 12389012333);
//     assert(queries.len() == 4, 'Invalid value');
//     assert(*queries.at(0) == 0xc53fdd1e, 'Invalid value');
//     assert(*queries.at(1) == 0x166d56d3d, 'Invalid value');
//     assert(*queries.at(2) == 0x1e563d10b, 'Invalid value');
//     assert(*queries.at(3) == 0x2d9a2434f, 'Invalid value');
// }
// 
// #[test]
// #[available_gas(9999999999)]
// fn test_sample_random_queries_1() {
//     let mut channel = ChannelTrait::new(
//         u256 { low: 0xf7685ebd40e852b164633a4acbd3244c, high: 0xe8e77626586f73b955364c7b4bbf0bb7 }
//     );
//     let queries = sample_random_queries(ref channel, 10, 99809818624);
//     assert(queries.len() == 12, 'Invalid value');
//     assert(*queries.at(0) == 0x1405a07e8c, 'Invalid value');
//     assert(*queries.at(1) == 0x982d6fc79, 'Invalid value');
//     assert(*queries.at(2) == 0x6188b67d1, 'Invalid value');
//     assert(*queries.at(3) == 0xa733f8ed8, 'Invalid value');
//     assert(*queries.at(4) == 0x557cce2e5, 'Invalid value');
//     assert(*queries.at(5) == 0xbf23e4bf7, 'Invalid value');
//     assert(*queries.at(6) == 0x3247d4098, 'Invalid value');
//     assert(*queries.at(7) == 0xca83fb21d, 'Invalid value');
//     assert(*queries.at(8) == 0xc2321969b, 'Invalid value');
//     assert(*queries.at(9) == 0x52d896136, 'Invalid value');
//     assert(*queries.at(10) == 0xe4da8dce0, 'Invalid value');
//     assert(*queries.at(11) == 0x8cf7e0675, 'Invalid value');
// }
// === BLAKE ONLY END ===


