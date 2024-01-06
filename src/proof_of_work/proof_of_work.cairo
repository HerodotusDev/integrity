use core::array::SpanTrait;
use core::array::ArrayTrait;
use cairo_verifier::common::flip_endianness::FlipEndiannessTrait;
use core::debug::PrintTrait;
use cairo_verifier::{
    common::{blake2s::blake2s, array_append::ArrayAppendTrait, math::pow},
    channel::channel::{Channel, ChannelTrait},
    proof_of_work::config::{ProofOfWorkConfig, BYTE_UPPER_BOUND, WORD_UPPER_BOUND}
};
use cairo_verifier::common::array_print::{SpanPrintTrait, ArrayPrintTrait};

const POW_2_12: u256 = 79228162514264337593543950336;
const POW_2_4: u256 = 4294967296;
const POW_2_3: u256 = 16777216;

#[derive(Drop, Copy)]
struct ProofOfWorkUnsentCommitment {
    nonce: u64,
}

fn proof_of_work_commit(
    ref channel: Channel, unsent_commitment: ProofOfWorkUnsentCommitment, config: ProofOfWorkConfig
) {
    channel.read_uint64_from_prover(unsent_commitment.nonce);
    verify_proof_of_work(channel.digest, config.n_bits, unsent_commitment.nonce);
}

fn verify_proof_of_work(digest: u256, n_bits: u8, nonce: u64) {
    // Compute the initial hash.
    // Hash(0123456789abcded || digest   || n_bits )
    //      8 bytes          || 32 bytes || 1 byte
    // Total of 0x29 = 41 bytes.

    // let init_hash_value: u256 = 0x0123456789abcded000000000000000000000000000000000000000000000000
    //     // digest >> 12 -> digest << 4 -> nbits << 3
    //     + digest / POW_2_12 * POW_2_4 + n_bits.into() * POW_2_3;

    let mut init_hash_data = ArrayTrait::<u8>::new();
    init_hash_data.append_big_endian(u256{low: 0xD7CA1D48A19D8FF802A71D94169DE383, high: 0x0123456789ABCDED1C5A5F4381DF1F5C});
    init_hash_data.append_big_endian(u256{low: 0x00000000000000000000000000000000, high: 0x82621FDC5514A10A1400000000000000});
    let span = init_hash_data.span().slice(0,41);
    let mut arr = ArrayTrait::<u8>::new();
    let mut i:u32 = 0;
    loop {
        if i == span.len() {
            break;
        }

        arr.append(*span.at(i));
        i+=1;
    };
    let init_hash = blake2s(arr).flip_endianness();
    init_hash.print();

    //  correct hash on test data:
    //  0x6ae49da749fbe3fc98f114c0f8342a4d
    //  0x26438c9c119a3b222f70d564d5df2ebc

    // // Compute Hash(init_hash || nonce   )
    // //              32 bytes  || 8 bytes
    // // Total of 0x28 = 40 bytes.

    // // init_hash >> 12 -> init_hash << 8 + 4 -> nonce << 4
    // let hash_value: u256 = init_hash / POW_2_12 * POW_2_12 + nonce.into() * POW_2_4;

    // let mut hash_data = ArrayTrait::<u32>::new();
    // hash_data.append_big_endian(hash_value);
    // let hash = blake2s(hash_data);
    // let work_limit = pow(2, 128 - n_bits.into());

    // assert(
    //     Into::<u128, u256>::into(hash.high) < Into::<felt252, u256>::into(work_limit),
    //     'proof of work failed'
    // )
}
