use core::traits::Into;
use core::to_byte_array::AppendFormattedToByteArray;
use core::to_byte_array::FormatAsByteArray;
use core::serde::Serde;
#[derive(Drop)]
struct Channel {
    digest: u256,
    counter: felt252,
}

trait ChannelTrait {
    fn new(digest: u256) -> Channel;

    // Generate randomness.
    fn random_uint256_to_prover(ref self: Channel) -> u256;
// fn random_felts_to_prover(ref self: Channel, n: felt252) -> Array<felt252>;

// // Reads a 64bit integer from the prover.
// fn read_uint256_from_prover(ref self: Channel) -> u256;
// // Reads a field elements from the prover
// fn read_felts_from_prover(ref self: Channel, n: felt252) -> Array<felt252>;
}

impl ChannelImpl of ChannelTrait {
    fn new(digest: u256) -> Channel {
        Channel { digest: digest, counter: 0 }
    }

    fn random_uint256_to_prover(ref self: Channel) -> u256 {
        let high = self.digest.high;
        let low = self.digest.low;

        0
    }
}
