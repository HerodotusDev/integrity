use cairo_verifier::channel::channel::ChannelTrait;

// === BLAKE ONLY BEGIN ===
// #[test]
// #[available_gas(9999999999)]
// fn test_random_felts_to_prover() {
//     let mut channel = ChannelTrait::new_with_counter(0x0, 0x0);
//     let random = channel.random_felts_to_prover(3);
//     assert(
//         *random[0] == 3199910790894706855027093840383592257502485581126271436027309705477370004002,
//         'invalid random felts[0]'
//     );
//     assert(
//         *random[1] == 2678311171676075552444787698918310126938416157877134200897080931937186268438,
//         'invalid random felts[1]'
//     );
//     assert(
//         *random[2] == 2409925148191156067407217062797240658947927224212800962983204460004996362724,
//         'invalid random felts[2]'
//     );
// }
// === BLAKE ONLY END ===

// === KECCAK ONLY BEGIN ===
#[test]
#[available_gas(9999999999)]
fn test_random_felts_to_prover() {
    let mut channel = ChannelTrait::new_with_counter(0x0, 0x0);

    assert(
        channel
            .random_felts_to_prover(
                6
            ) == array![
                0x414b15fa27add0f6811a50e1c8b9f15817894a0bbfe4f7f295197c1012dfb18,
                0x5e0bb5569c25cb8b8836880bab4e2ce6d4a4daa7884f6ca843d68cb2eebec0b,
                0x38a8e373b08e1edebe3a42c2ac362c3677b34831d0d99ae08961fe96518b7d4,
                0x2a56da11e2abe0a267e2ba40166bb50163c182ac042b88f75f681d6f30c8f37,
                0x1824b7b0c6c0036c4998f345f4b34e1548a03dc637480ff0c6f315d4eacac4a,
                0x39a70b321a5d31147bf5c3299bb5946da16db82658b25af58802bfe64d6fc74,
            ],
        'invalid random felts'
    );
    assert(channel.digest == 0x0, 'Invalid value');
    assert(channel.counter == 0x6, 'Invalid value');
}
// === KECCAK ONLY END ===


