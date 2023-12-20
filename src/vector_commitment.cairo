// Commitment values for a vector commitment. Used to generate a commitment by "reading" these
// values from the channel.
#[derive(Drop)]
struct VectorUnsentCommitment {
    a: felt252, // dummy
    // commitment_hash: ChannelUnsentFelt,
}

// Commitment for a vector of field elements.
#[derive(Drop)]
struct VectorCommitment {
    a: felt252, // dummy
    // config: VectorCommitmentConfig*,
    // commitment_hash: ChannelSentFelt,
}

#[derive(Drop)]
struct VectorCommitmentConfig {
    a: felt252, // dummy
    // height: felt,
    // n_verifier_friendly_commitment_layers: felt,
}
