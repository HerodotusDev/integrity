pub mod transform;
pub mod vec252;

use cairo_vm::Felt252;
use clap::ValueEnum;
pub use vec252::VecFelt252;

#[derive(Copy, Clone, PartialEq, Eq, PartialOrd, Ord, ValueEnum)]
pub enum CairoVersion {
    Cairo0 = 0,
    Cairo1 = 1,
}

impl From<CairoVersion> for Felt252 {
    fn from(value: CairoVersion) -> Self {
        match value {
            CairoVersion::Cairo0 => Felt252::from(0),
            CairoVersion::Cairo1 => Felt252::from(1),
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

#[derive(Copy, Clone, PartialEq, Eq, PartialOrd, Ord, ValueEnum)]
pub enum HasherBitLength {
    Lsb160 = 0,
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
