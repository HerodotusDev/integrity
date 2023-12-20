// Commitment values for a vector commitment. Used to generate a commitment by "reading" these
// values from the channel.
#[derive(Drop, Copy)]
struct VectorUnsentCommitment {
    a: felt252, // dummy
// commitment_hash: ChannelUnsentFelt,
}

// Commitment for a vector of field elements.
#[derive(Drop, Copy)]
struct VectorCommitment {
    a: felt252, // dummy
// config: VectorCommitmentConfig*,
// commitment_hash: ChannelSentFelt,
}

#[derive(Drop, Copy)]
struct VectorCommitmentConfig {
    height: felt252,
    verifier_friendly_commitment_layers: felt252,
}

fn validate_vector_commitment(
    config: VectorCommitmentConfig,
    expected_height: felt252,
    n_verifier_friendly_commitment_layers: felt252,
) {}
