use core::array::SpanTrait;
use cairo_verifier::common::{
    flip_endianness::FlipEndiannessTrait, array_append::ArrayAppendTrait, hasher::hash,
    consts::{
        C_PRIME_AS_UINT256_LOW, C_PRIME_AS_UINT256_HIGH, STARK_PRIME, MONTGOMERY_R,
        MONTGOMERY_R_INVERSE
    }
};
use poseidon::{hades_permutation, poseidon_hash_span};
use core::integer::BoundedU128;

#[derive(Drop)]
struct Channel {
    digest: felt252,
    counter: felt252,
}

#[generate_trait]
impl ChannelImpl of ChannelTrait {
    fn new(digest: felt252) -> Channel {
        Channel { digest: digest, counter: 0 }
    }

    fn new_with_counter(digest: felt252, counter: felt252) -> Channel {
        Channel { digest: digest, counter: counter }
    }

    // fn random_uint256_to_prover(ref self: Channel) -> u256 {
    //     let mut hash_data = ArrayTrait::new(); // u32 for blake, u64 for keccak
    //     hash_data.append_big_endian(self.digest);
    //     hash_data.append_big_endian(self.counter);
    //     self.counter += 1;
    //     hash(hash_data).flip_endianness()
    // }

    // fn random_felt_to_prover(ref self: Channel) -> felt252 {
    //     let mut res: felt252 = 0;

    //     // To ensure a uniform distribution over field elements, if the generated 256-bit number x is in
    //     // range [0, C * PRIME), take x % PRIME. Otherwise, regenerate.
    //     // The maximal possible C is 2**256//PRIME = 31.        

    //     loop {
    //         let rand = self.random_uint256_to_prover();
    //         if (rand < u256 { low: C_PRIME_AS_UINT256_LOW, high: C_PRIME_AS_UINT256_HIGH }) {
    //             let to_append = (rand % STARK_PRIME).try_into().unwrap();
    //             res = to_append * MONTGOMERY_R_INVERSE;
    //             break;
    //         }
    //     };
    //     res
    // }

    fn random_felt_to_prover(ref self: Channel) -> felt252 {
        let (hash, _, _) = hades_permutation(self.digest, self.counter, 2);
        self.counter += 1;
        hash
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
// not sure what to do with it
// fn read_truncated_hash_from_prover(ref self: Channel, value: felt252) {
//     let mut hash_data = ArrayTrait::new(); // u32 for blake, u64 for keccak

//     assert(self.digest.low != BoundedU128::max(), 'digest low is 2^128-1');
//     hash_data.append_big_endian(self.digest + 1);
//     hash_data.append_big_endian(value);

//     self.digest = hash(hash_data).flip_endianness();
//     self.counter = 0;
// }

fn read_felt_from_prover(ref self: Channel, value: felt252) {
    let mut hash_data = ArrayTrait::new();
    hash_data.append(self.digest + 1);
    hash_data.append(value);

    self.digest = poseidon_hash_span(hash_data.span());
    self.counter = 0;
}

// fn read_felts_from_prover(ref self: Channel, mut values: Span<felt252>) {
//     loop {
//         match values.pop_front() {
//             Option::Some(value) => { self.read_felt_from_prover(*value); },
//             Option::None => { break; }
//         }
//     }
// }

    fn read_felt_vector_from_prover(ref self: Channel, mut values: Span<felt252>) {
        let mut hash_data = ArrayTrait::new();

        hash_data.append(self.digest + 1);

        loop {
            match values.pop_front() {
                Option::Some(value) => { hash_data.append(*value); },
                Option::None => { break; }
            }
        };

        self.digest = poseidon_hash_span(hash_data.span());
        self.counter = 0;
    }

    fn read_uint64_from_prover(ref self: Channel, value: u64) {
        self.read_felt_from_prover(value.into())
    }
}