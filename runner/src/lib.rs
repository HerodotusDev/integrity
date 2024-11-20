pub mod transform;
pub mod vec252;

use cairo_vm::Felt252;
use clap::ValueEnum;
pub use vec252::VecFelt252;

#[derive(Copy, Clone, PartialEq, Eq, PartialOrd, Ord, ValueEnum)]
pub enum MemoryVerification {
    Strict = 0,
    Relaxed = 1,
    Cairo1 = 2,
}

impl From<MemoryVerification> for Felt252 {
    fn from(value: MemoryVerification) -> Self {
        match value {
            MemoryVerification::Strict => Felt252::from(0),
            MemoryVerification::Relaxed => Felt252::from(1),
            MemoryVerification::Cairo1 => Felt252::from(2),
        }
    }
}

#[derive(Copy, Clone, PartialEq, Eq, PartialOrd, Ord, ValueEnum)]
pub enum StoneVersion {
    Stone5 = 0,
    Stone6 = 1,
}

impl From<StoneVersion> for Felt252 {
    fn from(value: StoneVersion) -> Self {
        match value {
            StoneVersion::Stone5 => Felt252::from(0),
            StoneVersion::Stone6 => Felt252::from(1),
        }
    }
}

#[derive(Copy, Clone, PartialEq, Eq, PartialOrd, Ord, Debug, ValueEnum)]
pub enum HasherBitLength {
    #[clap(name = "160_lsb")]
    Lsb160 = 0,
    #[clap(name = "248_lsb")]
    Lsb248 = 1,
}

impl From<HasherBitLength> for Felt252 {
    fn from(value: HasherBitLength) -> Self {
        match value {
            HasherBitLength::Lsb160 => Felt252::from(0),
            HasherBitLength::Lsb248 => Felt252::from(1),
        }
    }
}
