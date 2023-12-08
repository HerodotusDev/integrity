use core::debug::PrintTrait;
use core::array::ArrayTrait;
use channel::ChannelTrait;

#[test]
fn test_random_uint256_to_prover_0() {
    let mut channel = ChannelTrait::new(0);
    let random = channel.random_uint256_to_prover();
    random.print();
    channel.counter.print();
    channel.digest.print();
}
