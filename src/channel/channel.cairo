use core::array::ArrayTrait;
use cairo_verifier::common::{
    flip_endiannes::FlipEndiannessTrait, to_array::ToArrayTrait, blake2s::blake2s
};

const C_PRIME_AS_UINT256_LOW: u128 = 31;
const C_PRIME_AS_UINT256_HIGH: u128 =
    329648542954659146201578277794459156480; // 31 * 0x8000000000000110000000000000000;
const STARK_PRIME: u256 =
    3618502788666131213697322783095070105623107215331596699973092056135872020481;
const INVERSE_2_TO_256_MOD_STARK_PRIME: felt252 =
    113078212145816603762751633895895194930089271709401121343797004406777446400;

#[derive(Drop)]
struct Channel {
    digest: u256,
    counter: u256,
}

// A wrapper around felt with a guarantee that the felt must be read from the channel before
// use.
#[derive(Drop, Copy)]
struct ChannelUnsentFelt {
    value: felt252,
}

// A wrapper around felt with a guarantee that the felt was read from the channel as data from the
// prover.
#[derive(Drop, Copy)]
struct ChannelSentFelt {
    value: felt252,
}

#[generate_trait]
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

    fn random_felt_to_prover(ref self: Channel) -> felt252 {
        let mut res: felt252 = 0;

        // To ensure a uniform distribution over field elements, if the generated 256-bit number x is in
        // range [0, C * PRIME), take x % PRIME. Otherwise, regenerate.
        // The maximal possible C is 2**256//PRIME = 31.        

        loop {
            let rand = self.random_uint256_to_prover();
            if (rand < u256 { low: C_PRIME_AS_UINT256_LOW, high: C_PRIME_AS_UINT256_HIGH }) {
                let to_append = (rand % STARK_PRIME).try_into().unwrap();
                res = to_append * INVERSE_2_TO_256_MOD_STARK_PRIME;
                break;
            }
        };
        res
    }

    fn random_felts_to_prover(ref self: Channel, mut n: felt252) -> Array<felt252> {
        let mut res = ArrayTrait::<felt252>::new();
        loop {
            if n != 0 {
                res.append(self.random_felt_to_prover());
                n -= 1;
            } else {
                break;
            }
        };
        res
    }

    // Reads a field element vector from the prover. Unlike read_felts_from_prover, this hashes all the
    // field elements at once. See Channel.
    fn read_felt_vector_from_prover(
        ref self: Channel, values: Span<ChannelUnsentFelt>
    ) -> Array<ChannelSentFelt> {
        let sent_felts = ArrayTrait::<ChannelSentFelt>::new();
        sent_felts
    }
}
