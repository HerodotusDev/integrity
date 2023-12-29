use cairo_verifier::channel::channel::ChannelTrait;

#[test]
#[available_gas(9999999999)]
fn test_random_felts_to_prover() {
    let mut channel = ChannelTrait::new(
        u256 { low: 0xf7685ebd40e852b164633a4acbd3244c, high: 0xe8e77626586f73b955364c7b4bbf0bb7 }
    );
    let random = channel.random_felts_to_prover(3);
    assert(
        *random[0] == 3199910790894706855027093840383592257502485581126271436027309705477370004002,
        'invalid random felts[0]'
    );
    assert(
        *random[1] == 2678311171676075552444787698918310126938416157877134200897080931937186268438,
        'invalid random felts[1]'
    );
    assert(
        *random[2] == 2409925148191156067407217062797240658947927224212800962983204460004996362724,
        'invalid random felts[2]'
    );
}

#[test]
#[available_gas(9999999999)]
fn test_random_uint256_to_prover() {
    let mut channel = ChannelTrait::new(0);
    let random = channel.random_uint256_to_prover();
    assert(
        random == 0xae09db7cd54f42b490ef09b6bc541af688e4959bb8c53f359a6f56e38ab454a3,
        'invalid random uint256'
    );
}

#[test]
#[available_gas(9999999999)]
fn test_read_from_prover() {
    let mut channel = ChannelTrait::new(0);

    channel.read_felt_from_prover(0xffffffffffffffffffffffffffffffffffffffff);

    assert(channel.counter == 0, 'invalid read felt');
    assert(
        channel.digest == 0xb056692f5fc4f27dedd1fb6269b02c542a415f1d84555708a354ffb25cf97ad5,
        'invalid read felt'
    );

    let mut arr = ArrayTrait::<felt252>::new();
    arr.append(2);
    arr.append(3);
    arr.append(-1);
    channel.read_felts_from_prover(arr.span());

    assert(channel.counter == 0, 'invalid read felts');
    assert(
        channel.digest == 0x135bc3291210bb6248a09cea1a97b0023c5602b18a9e0786aeed16352972504,
        'invalid read felts'
    );

    channel.read_felt_vector_from_prover(arr.span());

    assert(channel.counter == 0, 'invalid read felts');
    assert(
        channel.digest == 0x413b1e08fe14f181acc48007a89e4d044a9edb54523e8eae5829fde606d4074d,
        'invalid read felts'
    );

    channel.read_uint64_from_prover(6969);

    assert(channel.counter == 0, 'invalid read uint64');
    assert(
        channel.digest == 0xeeee1f1910516152d49bea3829151bdd149fcd878fe4e7b52881300c113395ce,
        'invalid read uint64'
    );
}

#[test]
#[available_gas(9999999999)]
fn test_read_felt_from_prover() {
    let mut channel = ChannelTrait::new(
        32204560462099576052071116479981543464788400881991862378480356767528153881242
    );

    channel
        .read_felt_from_prover(
            2189543135532000975073223102299103804374316765743393096814633396722915142781
        );

    assert(channel.counter == 0, 'invalid read felt');
    assert(
        channel
            .digest == 45225624675187382281293799788723729210709046294536191403393069808321359573734,
        'invalid read felt'
    );
}

#[test]
#[available_gas(9999999999)]
fn test_read_felts_from_prover() {
    let mut channel = ChannelTrait::new(
        32204560462099576052071116479981543464788400881991862378480356767528153881242
    );

    let input: Array<felt252> = array![
        801118498771077385876680702501056689617384700744497628665736844456538025970,
        136480279717397680743751578088474164975408857089091902035326656170846663451,
        2651216551934055237793488162754368170820458364194359599585259842725151359862,
        1329979499816441827238714390674457535408265475870499110057295862043364226076,
        1296657666566505608212940111737606773084572384346777899263419033521078751013,
        2670331407575655388711197125855776741254884375650252030276227999952482413107,
        495372650276597730770783063328923909247361253131174237717335302286062865236,
    ];

    channel.read_felts_from_prover(input.span());

    assert(channel.counter == 0, 'invalid read felts');
    assert(
        channel
            .digest == 9361551412742470520142265470561908553217097453533185961440210388135835515653,
        'invalid read felts'
    );
}

#[test]
#[available_gas(9999999999)]
fn test_read_felt_vector_from_prover() {
    let mut channel = ChannelTrait::new(
        32204560462099576052071116479981543464788400881991862378480356767528153881242
    );

    let input: Array<felt252> = array![
        801118498771077385876680702501056689617384700744497628665736844456538025970,
        136480279717397680743751578088474164975408857089091902035326656170846663451,
        2651216551934055237793488162754368170820458364194359599585259842725151359862,
        1329979499816441827238714390674457535408265475870499110057295862043364226076,
        1296657666566505608212940111737606773084572384346777899263419033521078751013,
        2670331407575655388711197125855776741254884375650252030276227999952482413107,
        495372650276597730770783063328923909247361253131174237717335302286062865236,
        530987496743476398107560876052655845720523049587973335384780354401593620645,
        3345549494797593157992468861554060638252345356820185819238082993079257164020
    ];

    channel.read_felt_vector_from_prover(input.span());

    assert(channel.counter == 0, 'invalid read felts');
    assert(
        channel
            .digest == 4348116345188292541807408380512632346270917025990245174258204584556253737000,
        'invalid read felts'
    );
}

#[test]
#[available_gas(9999999999)]
fn test_read_uint64_from_prover() {
    let mut channel = ChannelTrait::new(
        32204560462099576052071116479981543464788400881991862378480356767528153881242
    );

    channel.read_uint64_from_prover(4815830333676699184);

    assert(channel.counter == 0, 'invalid read uint64');
    assert(
        channel
            .digest == 82019160662385672738794368995803566011653417904767166511054323305428036240181,
        'invalid read uint64'
    );
}
