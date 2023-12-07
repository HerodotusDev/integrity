use core::traits::Destruct;
use core::option::OptionTrait;
use core::traits::TryInto;
use core::DivRem;
use core::zeroable::NonZero;

// 2^8 = 256
const U128maxU8: u128 = 256;
const U64axU8: u64 = 256;
const U32axU8: u32 = 256;
const U16axU8: u16 = 256;

// 2^16 = 65536
const U128maxU16: u128 = 65536;
const U64axU16: u64 = 65536;
const U32axU16: u32 = 65536;

// 2^32 = 4294967296
const U128axU32: u128 = 4294967296;
const U64axU32: u64 = 4294967296;

trait ToArrayTrait<F, T> {
    fn to_array(self: F, ref output: Array<T>);
}

impl U128ToArrayU8 of ToArrayTrait<u128, u8> {
    fn to_array(mut self: u128, ref output: Array<u8>) {
        let mut i = 16;
        loop {
            if i != 0 {
                i -= 1;
                let (q, r) = DivRem::div_rem(self, U128maxU8.try_into().unwrap());
                output.append(r.try_into().unwrap());
                self = q;
            } else {
                break;
            }
        }
    }
}

impl U64ToArrayU8 of ToArrayTrait<u64, u8> {
    fn to_array(mut self: u64, ref output: Array<u8>) {
        let mut i = 8;
        loop {
            if i != 0 {
                i -= 1;
                let (q, r) = DivRem::div_rem(self, U64axU8.try_into().unwrap());
                output.append(r.try_into().unwrap());
                self = q;
            } else {
                break;
            }
        }
    }
}

impl U32ToArrayU8 of ToArrayTrait<u32, u8> {
    fn to_array(mut self: u32, ref output: Array<u8>) {
        let mut i = 4;
        loop {
            if i != 0 {
                i -= 1;
                let (q, r) = DivRem::div_rem(self, U32axU8.try_into().unwrap());
                output.append(r.try_into().unwrap());
                self = q;
            } else {
                break;
            }
        }
    }
}

impl U16ToArrayU8 of ToArrayTrait<u16, u8> {
    fn to_array(mut self: u16, ref output: Array<u8>) {
        let mut i = 2;
        loop {
            if i != 0 {
                i -= 1;
                let (q, r) = DivRem::div_rem(self, U16axU8.try_into().unwrap());
                output.append(r.try_into().unwrap());
                self = q;
            } else {
                break;
            }
        }
    }
}

impl U64ToArrayU16 of ToArrayTrait<u128, u16> {
    fn to_array(mut self: u128, ref output: Array<u16>) {
        let mut i = 8;
        loop {
            if i != 0 {
                i -= 1;
                let (q, r) = DivRem::div_rem(self, U128maxU16.try_into().unwrap());
                output.append(r.try_into().unwrap());
                self = q;
            } else {
                break;
            }
        }
    }
}

impl U32ToArrayU16 of ToArrayTrait<u64, u16> {
    fn to_array(mut self: u64, ref output: Array<u16>) {
        let mut i = 4;
        loop {
            if i != 0 {
                i -= 1;
                let (q, r) = DivRem::div_rem(self, U64axU16.try_into().unwrap());
                output.append(r.try_into().unwrap());
                self = q;
            } else {
                break;
            }
        }
    }
}

impl U16ToArrayU16 of ToArrayTrait<u32, u16> {
    fn to_array(mut self: u32, ref output: Array<u16>) {
        let mut i = 2;
        loop {
            if i != 0 {
                i -= 1;
                let (q, r) = DivRem::div_rem(self, U32axU16.try_into().unwrap());
                output.append(r.try_into().unwrap());
                self = q;
            } else {
                break;
            }
        }
    }
}

impl U256ToArrayU32 of ToArrayTrait<u256, u32> {
    fn to_array(mut self: u256, ref output: Array<u32>) {
        self.low.to_array(ref output);
        self.high.to_array(ref output);
    }
}

impl U128ToArrayU32 of ToArrayTrait<u128, u32> {
    fn to_array(mut self: u128, ref output: Array<u32>) {
        let mut i = 4;
        loop {
            if i != 0 {
                i -= 1;
                let (q, r) = DivRem::div_rem(self, U128axU32.try_into().unwrap());
                output.append(r.try_into().unwrap());
                self = q;
            } else {
                break;
            }
        }
    }
}

impl U64ToArrayU32 of ToArrayTrait<u64, u32> {
    fn to_array(mut self: u64, ref output: Array<u32>) {
        let mut i = 2;
        loop {
            if i != 0 {
                i -= 1;
                let (q, r) = DivRem::div_rem(self, U64axU32.try_into().unwrap());
                output.append(r.try_into().unwrap());
                self = q;
            } else {
                break;
            }
        }
    }
}
