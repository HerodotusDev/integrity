use cairo_verifier::air::public_input::CairoVersion;

#[derive(Drop, Copy, PartialEq, Serde)]
enum HasherBitLength {
    Lsb160,
    Lsb248,
}

#[derive(Drop, Copy, PartialEq, Serde)]
enum StoneVersion {
    Stone5,
    Stone6,
}

#[derive(Drop, Copy, Serde)]
struct VerifierSettings {
    cairo_version: CairoVersion,
    hasher_bit_length: HasherBitLength,
    stone_version: StoneVersion,
}

fn verifier_settings_to_tuple(settings: VerifierSettings) -> (felt252, felt252, felt252) {
    let cairo_version = match settings.cairo_version {
        CairoVersion::Cairo0 => 0,
        CairoVersion::Cairo1 => 1,
    };
    let hasher_bit_length = match settings.hasher_bit_length {
        HasherBitLength::Lsb160 => 0,
        HasherBitLength::Lsb248 => 1,
    };
    let stone_version = match settings.stone_version {
        StoneVersion::Stone5 => 0,
        StoneVersion::Stone6 => 1,
    };
    (cairo_version, hasher_bit_length, stone_version)
}

fn tuple_to_verifier_settings(tuple: (felt252, felt252, felt252)) -> VerifierSettings {
    let (cairo_verifier, hasher_bit_length, stone_version) = tuple;
    let cairo_version = match cairo_verifier {
        0 => CairoVersion::Cairo0,
        1 => CairoVersion::Cairo1,
        _ => {
            assert(false, 'invalid cairo_version');
            CairoVersion::Cairo0
        },
    };
    let hasher_bit_length = match hasher_bit_length {
        0 => HasherBitLength::Lsb160,
        1 => HasherBitLength::Lsb248,
        _ => {
            assert(false, 'invalid hasher_bit_length');
            HasherBitLength::Lsb160
        }
    };
    let stone_version = match stone_version {
        0 => StoneVersion::Stone5,
        1 => StoneVersion::Stone6,
        _ => {
            assert(false, 'invalid stone_version');
            StoneVersion::Stone5
        }
    };
    VerifierSettings {
        cairo_version,
        hasher_bit_length,
        stone_version,
    }
}
