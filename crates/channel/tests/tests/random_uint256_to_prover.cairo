use core::debug::PrintTrait;
use core::array::ArrayTrait;
use channel::ChannelTrait;

#[test]
fn test_random_uint256_to_prover_0() {
    let mut channel = ChannelTrait::new(0);
    let random = channel.random_uint256_to_prover();
    assert(random == 0xae09db7cd54f42b490ef09b6bc541af688e4959bb8c53f359a6f56e38ab454a3, 'invalid random uint256');
}
