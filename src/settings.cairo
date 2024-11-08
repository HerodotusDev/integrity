type FactHash = felt252;
type VerificationHash = felt252;
type PresetHash = felt252;
type SecurityBits = u32;
type JobId = felt252;


#[derive(Drop, Copy, PartialEq, Serde, starknet::Store)]
enum MemoryVerification {
    Strict,
    Relaxed,
    Cairo1,
}

#[derive(Drop, Copy, PartialEq, Serde, starknet::Store)]
enum HasherBitLength {
    Lsb160,
    Lsb248,
}

#[derive(Drop, Copy, PartialEq, Serde, starknet::Store)]
enum StoneVersion {
    Stone5,
    Stone6,
}

// settings accepted by verifier (parameters for verification)
#[derive(Drop, Copy, Serde, starknet::Store)]
struct VerifierSettings {
    memory_verification: felt252, // should be MemoryVerification but causes compiler bug
    hasher_bit_length: HasherBitLength,
    stone_version: StoneVersion,
}

// preset that identify the verifier (hardcoded in verifier)
#[derive(Drop, Copy, Serde)]
struct VerifierPreset {
    layout: felt252,
    hasher: felt252,
}

// both preset and settings merged together
#[derive(Drop, Copy, Serde, starknet::Store)]
struct VerifierConfiguration {
    layout: felt252, // string encoded as hex
    hasher: felt252, // function and number of bits
    stone_version: felt252, // stone5 or stone6
    memory_verification: felt252, // strict, relaxed or cairo1
}

fn split_settings(verifier_config: VerifierConfiguration) -> (VerifierSettings, VerifierPreset) {
    let layout = verifier_config.layout;

    let memory_verification = if verifier_config.memory_verification == 'strict' {
        0 // MemoryVerification::Strict
    } else if verifier_config.memory_verification == 'relaxed' {
        1 // MemoryVerification::Relaxed
    } else {
        assert(verifier_config.memory_verification == 'cairo1', 'Unsupported cairo version');
        2 // MemoryVerification::Cairo1
    };

    let (hasher, hasher_bit_length) = if verifier_config.hasher == 'keccak_160_lsb' {
        ('keccak', HasherBitLength::Lsb160)
    } else if verifier_config.hasher == 'keccak_248_lsb' {
        ('keccak', HasherBitLength::Lsb248)
    } else if verifier_config.hasher == 'blake2s_160_lsb' {
        ('blake2s', HasherBitLength::Lsb248)
    } else {
        assert(verifier_config.hasher == 'blake2s_248_lsb', 'Unsupported hasher variant');
        ('blake2s', HasherBitLength::Lsb248)
    };

    let stone_version = if verifier_config.stone_version == 'stone5' {
        StoneVersion::Stone5
    } else {
        assert(verifier_config.stone_version == 'stone6', 'Unsupported stone version');
        StoneVersion::Stone6
    };

    (
        VerifierSettings { memory_verification, hasher_bit_length, stone_version },
        VerifierPreset { layout, hasher }
    )
}
