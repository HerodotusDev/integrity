use cairo_verifier::common::{from_span::FromSpanTrait, to_array::ToArrayTrait};

trait FlipEndiannessTrait<F> {
    fn flip_endiannes(self: F) -> F;
}

impl FlipEndiannessU32 of FlipEndiannessTrait<u32> {
    fn flip_endiannes(self: u32) -> u32 {
        (self % 256) * 16777216
            + (self / 256 % 256) * 65536
            + (self / 65536 % 256) * 256
            + (self / 16777216 % 256)
    }
}

impl FlipEndiannessU256 of FlipEndiannessTrait<u256> {
    fn flip_endiannes(self: u256) -> u256 {
        let mut data = ArrayTrait::<u32>::new();
        self.to_array_be(ref data);
        data.span().from_span_le()
    }
}

impl FlipEndiannessU128 of FlipEndiannessTrait<u128> {
    fn flip_endiannes(self: u128) -> u128 {
        let mut data = ArrayTrait::<u32>::new();
        self.to_array_be(ref data);
        data.span().from_span_le()
    }
}
