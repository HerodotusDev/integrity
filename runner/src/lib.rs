pub mod transform;
pub mod vec252;

use cairo_felt::Felt252;
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
