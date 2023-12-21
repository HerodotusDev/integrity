use cairo_verifier::common::{
    flip_endiannes::FlipEndiannessTrait, to_array::ToArrayTrait, blake2s::blake2s
};
use poseidon::poseidon_hash_span;

const C_PRIME_AS_UINT256_LOW: u128 = 31;
const C_PRIME_AS_UINT256_HIGH: u128 =
    329648542954659146201578277794459156480; // 31 * 0x8000000000000110000000000000000;
const STARK_PRIME: u256 =
    3618502788666131213697322783095070105623107215331596699973092056135872020481;
const MONTGOMERY_R: felt252 = 3618502788666127798953978732740734578953660990361066340291730267701097005025; // 2**256 % STARK_PRIME
const MONTGOMERY_R_INVERSE_MOD_STARK_PRIME: felt252 =
    113078212145816603762751633895895194930089271709401121343797004406777446400;

#[derive(Drop)]
struct Channel {
    digest: u256,
    counter: u256,
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
                    let to_append = (rand % STARK_PRIME).try_into().unwrap();
                    res.append(to_append * MONTGOMERY_R_INVERSE_MOD_STARK_PRIME);
                }
            } else {
                break;
            }
        };
        res
    }

    fn read_felt_from_prover(ref self: Channel, value: felt252) {
        let value_u256: u256 = value.into();
        let mut hash_data = ArrayTrait::<u32>::new();

        assert(self.digest.low != 0xffffffffffffffffffffffffffffffff, 'digest low is 2^128-1');
        (self.digest + 1).to_array_be(ref hash_data);
        value_u256.to_array_be(ref hash_data);

        self.digest = blake2s(hash_data).flip_endiannes();
    }

    fn read_felts_from_prover(ref self: Channel, values: Span<felt252>) {
        let hashed = poseidon_hash_span(values);
        self.read_felt_from_prover(hashed);
    }

    fn read_felt_vector_from_prover(ref self: Channel, values: Span<felt252>) {
        let mut hash_data = ArrayTrait::<u32>::new();

        assert(self.digest.low != 0xffffffffffffffffffffffffffffffff, 'digest low is 2^128-1');
        (self.digest + 1).to_array_be(ref hash_data);

        let mut i = 0;
        loop {
            if i == values.len() {
                break;
            };
            let value_u256: u256 = (*values[i] * MONTGOMERY_R).into();
            value_u256.to_array_be(ref hash_data);
            i += 1;
        };

        self.digest = blake2s(hash_data).flip_endiannes();
    }

    fn read_uint64_from_prover(ref self: Channel, value: u64) {
        let mut hash_data = ArrayTrait::<u32>::new();

        assert(self.digest.low != 0xffffffffffffffffffffffffffffffff, 'digest low is 2^128-1');
        (self.digest + 1).to_array_be(ref hash_data);

        let low: u32 = (value % 0x100000000).try_into().unwrap();
        let high: u32 = (value / 0x100000000).try_into().unwrap();
        hash_data.append(high.flip_endiannes());
        hash_data.append(low.flip_endiannes());

        self.digest = blake2s(hash_data).flip_endiannes();
    }
}
