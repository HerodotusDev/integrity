use integrity::{
    common::{
        blake2s::blake2s, blake2s_u8::blake2s as blake2s_u8, flip_endianness::FlipEndiannessTrait,
    },
    settings::{VerifierSettings, HasherBitLength},
};


#[cfg(feature: 'blake2s')]
fn hash(data: Array<u32>) -> u256 {
    blake2s(data)
}

#[cfg(feature: 'keccak')]
fn hash(mut data: Array<u64>) -> u256 {
    keccak::cairo_keccak(ref data, 0, 0)
}

#[cfg(feature: 'blake2s')]
fn hash_truncated(data: Array<u32>, settings: @VerifierSettings) -> felt252 {
    let mask = if *settings.hasher_bit_length == HasherBitLength::Lsb160 {
        0x000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
    } else {
        0x00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
    };
    (blake2s(data).flip_endianness() & mask).try_into().unwrap()
}

#[cfg(feature: 'keccak')]
fn hash_truncated(mut data: Array<u64>, settings: @VerifierSettings) -> felt252 {
    let mask = if *settings.hasher_bit_length == HasherBitLength::Lsb160 {
        0x000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
    } else {
        0x00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
    };
    (keccak::cairo_keccak(ref data, 0, 0).flip_endianness() & mask).try_into().unwrap()
}

#[cfg(feature: 'blake2s')]
fn hash_n_bytes(mut data: Array<u8>, n: u8, hash_len: bool) -> u256 {
    if hash_len {
        data.append(n);
    }
    blake2s_u8(data)
}

#[cfg(feature: 'keccak')]
fn hash_n_bytes(mut data: Array<u64>, n: u8, hash_len: bool) -> u256 {
    if hash_len {
        keccak::cairo_keccak(ref data, n.into(), 1)
    } else {
        keccak::cairo_keccak(ref data, 0, 0)
    }
}
