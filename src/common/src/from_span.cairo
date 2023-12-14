use core::array::SpanTrait;
use core::traits::Into;

// 2^8 = 256
const U128maxU8: u128 = 256;
const U64maxU8: u64 = 256;
const U32maxU8: u32 = 256;
const U16maxU8: u16 = 256;

// 2^16 = 65536
const U128maxU16: u128 = 65536;
const U64maxU16: u64 = 65536;
const U32maxU16: u32 = 65536;

// 2^32 = 4294967296
const U128maxU32: u128 = 4294967296;
const U64maxU32: u64 = 4294967296;

trait FromSpanTrait<F, T> {
    fn from_span(self: Span<F>) -> T;
}

impl U256FromSpanU32 of FromSpanTrait<u32, u256> {
    fn from_span(self: Span<u32>) -> u256 {
        u256 { low: self.from_span(), high: self.slice(4, 4).from_span(), }
    }
}

impl U128FromSpanU32 of FromSpanTrait<u32, u128> {
    fn from_span(self: Span<u32>) -> u128 {
        let mut out = 0_u128;
        let mut i = 4;
        loop {
            if i != 0 {
                i -= 1;
                out = out * U128maxU32;
                out = out + (*self.at(i)).into();
            } else {
                break;
            }
        };
        out
    }
}
