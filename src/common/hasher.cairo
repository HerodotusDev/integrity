use cairo_verifier::common::{blake2s::blake2s, blake2s::truncated_blake2s, blake2s_u8::blake2s as blake2s_u8};

// blake hasher

// fn hash_u8(data: Array<u8>) -> u256 {
//     blake2s_u8(data)
// }

// fn hash_truncated(data: Array<u32>) -> felt252 {
//     truncated_blake2s(data)
// }

// fn hash(data: Array<u32>) -> u256 {
//     blake2s(data)
// }

// keccak hasher

fn hash_u8(data: Array<u64>) -> u256 {

}

fn hash_truncated(data: Array<u64>) -> felt252 {

}

fn hash(mut data: Array<u64>) -> u256 {
    keccak::cairo_keccak(ref data, 0, 0)
}