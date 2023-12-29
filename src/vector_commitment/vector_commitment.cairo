use cairo_verifier::common::flip_endianness::FlipEndiannessTrait;
use cairo_verifier::common::{
    array_append::ArrayAppendTrait,
    blake2s::blake2s,
};
use poseidon::hades_permutation;


fn hash_blake_or_poseidon(x: felt252, y: felt252, is_verifier_friendly: bool) -> felt252 {
    if is_verifier_friendly {
        let (hash, _, _) = hades_permutation(x, y, 2);
        hash
    } else {
        truncated_blake2s(x, y)
    }
}

fn truncated_blake2s(x: felt252, y: felt252) -> felt252 {
    let mut data = ArrayTrait::<u32>::new();
    data.append_big_endian(x);
    data.append_big_endian(y);
    let hash = blake2s(data).flip_endianness() % 0x10000000000000000000000000000000000000000;
    hash.try_into().unwrap()
}