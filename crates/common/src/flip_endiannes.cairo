use common::from_span::FromSpanTrait;
use core::array::ArrayTrait;
use common::to_array::ToArrayTrait;

trait FlipEndiannessTrait<F> {
    fn flip_endiannes(self: F) -> F;
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