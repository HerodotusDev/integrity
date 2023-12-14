use common::flip_endiannes::FlipEndiannessTrait;
use core::option::OptionTrait;
use core::traits::TryInto;
use core::array::ArrayTrait;
use core::traits::Into;
use common::to_array::ToArrayTrait;
use cairo_blake2s::blake2s::blake2s;

const C_PRIME_AS_UINT256_LOW: u128 = 31;
const C_PRIME_AS_UINT256_HIGH: u128 =
    329648542954659146201578277794459156480; // 31 * 0x8000000000000110000000000000000;
const STARK_PRIME: u256 =
    3618502788666131213697322783095070105623107215331596699973092056135872020481;

#[derive(Drop)]
struct Channel {
    digest: u256,
    counter: u256,
}

trait ChannelTrait {
    fn new(digest: u256) -> Channel;

    // Generate randomness.
    fn random_uint256_to_prover(ref self: Channel) -> u256;
    fn random_felts_to_prover(ref self: Channel, n: felt252) -> Array<felt252>;
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
        let mut hash_data = ArrayTrait::<u32>::new();
        self.digest.to_array_be(ref hash_data);
        self.counter.to_array_be(ref hash_data);
        self.counter += 1;
        blake2s(hash_data).flip_endiannes()
    }

    fn random_felts_to_prover(ref self: Channel, mut n: felt252) -> Array<felt252> {
        let mut res = ArrayTrait::<felt252>::new();

        // To ensure a uniform distribution over field elements, if the generated 256-bit number x is in
        // range [0, C * PRIME), take x % PRIME. Otherwise, regenerate.
        // The maximal possible C is 2**256//PRIME = 31.        

        loop {
            if n != 0 {
                let rand = self.random_uint256_to_prover();
                if (rand < u256 { low: C_PRIME_AS_UINT256_LOW, high: C_PRIME_AS_UINT256_HIGH }) {
                    n -= 1;
                    res.append((rand % STARK_PRIME).try_into().unwrap());
                }
            } else {
                break;
            }
        };
        res
    }
}
