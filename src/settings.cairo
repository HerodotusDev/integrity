type FactHash = felt252;
type VerificationHash = felt252;
type PresetHash = felt252;
type SecurityBits = u32;
type JobId = felt252;


#[derive(Drop, Copy, PartialEq, Serde, starknet::Store)]
enum CairoVersion {
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
    cairo_version: felt252, // should be CairoVersion but causes compiler bug
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
    cairo_version: felt252, // cairo0 or cairo1
}

fn split_settings(verifier_config: VerifierConfiguration) -> (VerifierSettings, VerifierPreset) {
    let layout = verifier_config.layout;

    let cairo_version = if verifier_config.cairo_version == 'strict' {
        0 // CairoVersion::Strict
    } else if verifier_config.cairo_version == 'relaxed' {
        1 // CairoVersion::Relaxed
    } else {
        assert(verifier_config.cairo_version == 'cairo1', 'Unsupported cairo version');
        2 // CairoVersion::Cairo1
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
        VerifierSettings { cairo_version, hasher_bit_length, stone_version },
        VerifierPreset { layout, hasher }
    )
}
