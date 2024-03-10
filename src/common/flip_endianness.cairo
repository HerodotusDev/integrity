use core::integer::u128_byte_reverse;

trait FlipEndiannessTrait<F> {
    fn flip_endianness(self: F) -> F;
}

impl FlipEndiannessU16 of FlipEndiannessTrait<u16> {
    fn flip_endianness(self: u16) -> u16 {
        (u128_byte_reverse(self.into()) / 0x10000000000000000000000000000).try_into().unwrap()
    }
}

impl FlipEndiannessU32 of FlipEndiannessTrait<u32> {
    fn flip_endianness(self: u32) -> u32 {
        (u128_byte_reverse(self.into()) / 0x1000000000000000000000000).try_into().unwrap()
    }
}

impl FlipEndiannessU64 of FlipEndiannessTrait<u64> {
    fn flip_endianness(self: u64) -> u64 {
        (u128_byte_reverse(self.into()) / 0x10000000000000000).try_into().unwrap()
    }
}

impl FlipEndiannessU256 of FlipEndiannessTrait<u256> {
    fn flip_endianness(self: u256) -> u256 {
        u256 { low: u128_byte_reverse(self.high), high: u128_byte_reverse(self.low) }
    }
}

impl FlipEndiannessU128 of FlipEndiannessTrait<u128> {
    fn flip_endianness(self: u128) -> u128 {
        u128_byte_reverse(self)
    }
}
