use integrity::{
    common::{
        flip_endianness::FlipEndiannessTrait, hasher::hash_n_bytes, array_append::ArrayAppendTrait,
        math::pow,
    },
    channel::channel::{Channel, ChannelTrait}, proof_of_work::config::ProofOfWorkConfig
};

const MAGIC: u64 = 0x0123456789abcded;

#[derive(Drop, Copy, Serde)]
struct ProofOfWorkUnsentCommitment {
    nonce: u64,
}

fn proof_of_work_commit(
    ref channel: Channel, unsent_commitment: ProofOfWorkUnsentCommitment, config: ProofOfWorkConfig
) {
    verify_proof_of_work(channel.digest.into(), config.n_bits, unsent_commitment.nonce);
    channel.read_uint64_from_prover(unsent_commitment.nonce);
}

fn verify_proof_of_work(digest: u256, n_bits: u8, nonce: u64) {
    // Compute the initial hash.
    // Hash(0x0123456789abcded || digest   || n_bits )
    //      8 bytes            || 32 bytes || 1 byte
    // Total of 0x29 = 41 bytes.

    let mut init_hash_data = ArrayTrait::new(); // u8 with blake, u64 with keccak
    init_hash_data.append_big_endian(MAGIC);
    init_hash_data.append_big_endian(digest);
    let init_hash = hash_n_bytes(init_hash_data, n_bits.into(), true).flip_endianness();

    // Compute Hash(init_hash || nonce   )
    //              32 bytes  || 8 bytes
    // Total of 0x28 = 40 bytes.

    let mut hash_data = ArrayTrait::new(); // u8 with blake, u64 with keccak
    hash_data.append_big_endian(init_hash);
    hash_data.append_big_endian(nonce);
    let hash = hash_n_bytes(hash_data, 0, false).flip_endianness();

    let work_limit = pow(2, 128 - n_bits.into());
    assert(
        Into::<u128, u256>::into(hash.high) < Into::<felt252, u256>::into(work_limit),
        'proof of work failed'
    )
}
