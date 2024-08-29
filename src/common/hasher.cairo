use cairo_verifier::common::{
    blake2s::blake2s, blake2s::truncated_blake2s, blake2s_u8::blake2s as blake2s_u8,
    flip_endianness::FlipEndiannessTrait
};

// === BLAKE2S BEGIN ===
// fn hash_n_bytes(mut data: Array<u8>, n: u8, hash_len: bool) -> u256 {
//     if hash_len {
//         data.append(n);
//     }
//     blake2s_u8(data)
// }
// fn hash_truncated(data: Array<u32>) -> felt252 {
//     (blake2s(data).flip_endianness() & 0x00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF)
//          .try_into()
//          .unwrap()
// }
// fn hash(data: Array<u32>) -> u256 {
//     blake2s(data)
// }
// === BLAKE2S END ===

// === KECCAK BEGIN ===
fn hash_n_bytes(mut data: Array<u64>, n: u8, hash_len: bool) -> u256 {
    if hash_len {
        keccak::cairo_keccak(ref data, n.into(), 1)
    } else {
        keccak::cairo_keccak(ref data, 0, 0)
    }
}
fn hash_truncated(mut data: Array<u64>) -> felt252 {
    (keccak::cairo_keccak(ref data, 0, 0).flip_endianness()
        & 0x00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF)
        .try_into()
        .unwrap()
}
fn hash(mut data: Array<u64>) -> u256 {
    keccak::cairo_keccak(ref data, 0, 0)
}
// === KECCAK END ===


