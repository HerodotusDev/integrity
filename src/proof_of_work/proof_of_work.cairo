use cairo_verifier::{
    common::{blake2s::blake2s, array_append::ArrayAppendTrait, math::pow},
    channel::channel::{Channel, ChannelTrait},
    proof_of_work::config::{ProofOfWorkConfig, BYTE_UPPER_BOUND, WORD_UPPER_BOUND}
};

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
    // Hash(0123456789abcded || digest     || n_bits)
    //      8 bytes          || 0x20 bytes || 1 byte
    // Total of 0x29 bytes.
    // Arrange the hash input according to the keccak requirement of 0x10 byte chunks.
    let init_hash_value: u256 = 0x0123456789abcded000000000000000000000000000000000000000000000000
        // digest >> 12 -> digest << 4
        + digest / 79228162514264337593543950336 * 4294967296
        // nbits << 3
        + n_bits.into() * 16777216;

    let mut init_hash_data = ArrayTrait::<u32>::new();
    init_hash_data.append_big_endian(init_hash_value);
    let init_hash = blake2s(init_hash_data);

    // Compute Hash(init_hash  || nonce   )
    //              0x20 bytes || 8 bytes
    // Total of 0x28 bytes.

    // init_hash >> 12 -> init_hash << 8 + 4
    let hash_value: u256 = init_hash / 79228162514264337593543950336 * 79228162514264337593543950336
        // nonce << 4
        + nonce.into() * 4294967296;

    let mut hash_data = ArrayTrait::<u32>::new();
    hash_data.append_big_endian(hash_value);
    let hash = blake2s(hash_data);
    let work_limit = pow(2, 128 - n_bits.into());

    assert(
        Into::<u128, u256>::into(hash.high) < Into::<felt252, u256>::into(work_limit),
        'proof of work failed'
    )
}
