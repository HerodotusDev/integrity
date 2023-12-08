use core::debug::PrintTrait;
use core::array::ArrayTrait;
use channel::ChannelTrait;

#[test]
fn test_random_felts_to_prover_0() {
    let mut channel = ChannelTrait::new(
        u256 { low: 0xf7685ebd40e852b164633a4acbd3244c, high: 0xe8e77626586f73b955364c7b4bbf0bb7 }
    );
    let random = channel.random_felts_to_prover(3);
    (*random[0]).print();
    (*random[1]).print();
    (*random[2]).print();
}
