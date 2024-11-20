use integrity::common::{
    flip_endianness::FlipEndiannessU32,
    split::{u16_split, u32_split, u64_split, u128_split, u256_split}
};

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

trait ArrayAppendTrait<ArrayElement, AppendElement> {
    fn append_little_endian(ref self: Array<ArrayElement>, element: AppendElement);
    fn append_big_endian(ref self: Array<ArrayElement>, element: AppendElement);
}

impl ArrayU32AppendU256 of ArrayAppendTrait<u32, u256> {
    fn append_little_endian(ref self: Array<u32>, element: u256) {
        self.append_little_endian(element.low);
        self.append_little_endian(element.high);
    }

    fn append_big_endian(ref self: Array<u32>, element: u256) {
        self.append_big_endian(element.high);
        self.append_big_endian(element.low);
    }
}

// input's MSB is padded with 0s
// (internally felt252 is converted to u256)
impl ArrayU32AppendFelt of ArrayAppendTrait<u32, felt252> {
    fn append_little_endian(ref self: Array<u32>, element: felt252) {
        self.append_little_endian(Into::<felt252, u256>::into(element));
    }

    fn append_big_endian(ref self: Array<u32>, element: felt252) {
        self.append_big_endian(Into::<felt252, u256>::into(element));
    }
}

impl ArrayU32AppendFeltsSpan of ArrayAppendTrait<u32, Span<felt252>> {
    fn append_little_endian(ref self: Array<u32>, mut element: Span<felt252>) {
        loop {
            match element.pop_front() {
                Option::Some(elem) => self.append_little_endian(*elem),
                Option::None => { break; }
            }
        }
    }
    fn append_big_endian(ref self: Array<u32>, mut element: Span<felt252>) {
        loop {
            match element.pop_front() {
                Option::Some(elem) => self.append_big_endian(*elem),
                Option::None => { break; }
            }
        }
    }
}

impl ArrayU32AppendU128 of ArrayAppendTrait<u32, u128> {
    fn append_little_endian(ref self: Array<u32>, mut element: u128) {
        let (high, low) = u128_split(element);
        self.append_little_endian(low);
        self.append_little_endian(high);
    }

    fn append_big_endian(ref self: Array<u32>, mut element: u128) {
        let (high, low) = u128_split(element);
        self.append_big_endian(high);
        self.append_big_endian(low);
    }
}

impl ArrayU32AppendU64 of ArrayAppendTrait<u32, u64> {
    fn append_little_endian(ref self: Array<u32>, mut element: u64) {
        let (high, low) = u64_split(element);
        self.append(low);
        self.append(high);
    }

    fn append_big_endian(ref self: Array<u32>, mut element: u64) {
        let (high, low) = u64_split(element);
        self.append(high.flip_endianness());
        self.append(low.flip_endianness());
    }
}

impl ArrayU8AppendU256 of ArrayAppendTrait<u8, u256> {
    fn append_little_endian(ref self: Array<u8>, element: u256) {
        self.append_little_endian(element.low);
        self.append_little_endian(element.high);
    }

    fn append_big_endian(ref self: Array<u8>, element: u256) {
        self.append_big_endian(element.high);
        self.append_big_endian(element.low);
    }
}

// input's MSB is padded with 0s
// (internally felt252 is converted to u256)
impl ArrayU8AppendFelt of ArrayAppendTrait<u8, felt252> {
    fn append_little_endian(ref self: Array<u8>, element: felt252) {
        self.append_little_endian(Into::<felt252, u256>::into(element));
    }

    fn append_big_endian(ref self: Array<u8>, element: felt252) {
        self.append_big_endian(Into::<felt252, u256>::into(element));
    }
}

impl ArrayU8AppendU128 of ArrayAppendTrait<u8, u128> {
    fn append_little_endian(ref self: Array<u8>, mut element: u128) {
        let (high, low) = u128_split(element);
        self.append_little_endian(low);
        self.append_little_endian(high);
    }

    fn append_big_endian(ref self: Array<u8>, mut element: u128) {
        let (high, low) = u128_split(element);
        self.append_big_endian(high);
        self.append_big_endian(low);
    }
}

impl ArrayU8AppendU64 of ArrayAppendTrait<u8, u64> {
    fn append_little_endian(ref self: Array<u8>, mut element: u64) {
        let (high, low) = u64_split(element);
        self.append_little_endian(low);
        self.append_little_endian(high);
    }

    fn append_big_endian(ref self: Array<u8>, mut element: u64) {
        let (high, low) = u64_split(element);
        self.append_big_endian(high);
        self.append_big_endian(low);
    }
}

impl ArrayU8AppendU32 of ArrayAppendTrait<u8, u32> {
    fn append_little_endian(ref self: Array<u8>, mut element: u32) {
        let (high, low) = u32_split(element);
        self.append_little_endian(low);
        self.append_little_endian(high);
    }

    fn append_big_endian(ref self: Array<u8>, mut element: u32) {
        let (high, low) = u32_split(element);
        self.append_big_endian(high);
        self.append_big_endian(low);
    }
}

impl ArrayU8AppendU16 of ArrayAppendTrait<u8, u16> {
    fn append_little_endian(ref self: Array<u8>, mut element: u16) {
        let (high, low) = u16_split(element);
        self.append(low);
        self.append(high);
    }

    fn append_big_endian(ref self: Array<u8>, mut element: u16) {
        let (high, low) = u16_split(element);
        self.append(high);
        self.append(low);
    }
}

impl ArrayU64AppendU256 of ArrayAppendTrait<u64, u256> {
    fn append_little_endian(ref self: Array<u64>, element: u256) {
        self.append_little_endian(element.low);
        self.append_little_endian(element.high);
    }

    fn append_big_endian(ref self: Array<u64>, element: u256) {
        self.append_big_endian(element.high);
        self.append_big_endian(element.low);
    }
}

impl ArrayU64AppendU128 of ArrayAppendTrait<u64, u128> {
    fn append_little_endian(ref self: Array<u64>, mut element: u128) {
        let (high, low) = u128_split(element);
        self.append(low);
        self.append(high);
    }

    fn append_big_endian(ref self: Array<u64>, mut element: u128) {
        let (high, low) = u128_split(element);
        self.append(high.flip_endianness());
        self.append(low.flip_endianness());
    }
}

impl ArrayU64AppendU64 of ArrayAppendTrait<u64, u64> {
    fn append_little_endian(ref self: Array<u64>, mut element: u64) {
        self.append(element);
    }

    fn append_big_endian(ref self: Array<u64>, mut element: u64) {
        self.append(element.flip_endianness());
    }
}

impl ArrayU64AppendFelt of ArrayAppendTrait<u64, felt252> {
    fn append_little_endian(ref self: Array<u64>, element: felt252) {
        self.append_little_endian(Into::<felt252, u256>::into(element));
    }

    fn append_big_endian(ref self: Array<u64>, element: felt252) {
        self.append_big_endian(Into::<felt252, u256>::into(element));
    }
}

impl ArrayU64AppendFeltSpan of ArrayAppendTrait<u64, Span<felt252>> {
    fn append_little_endian(ref self: Array<u64>, mut element: Span<felt252>) {
        loop {
            match element.pop_front() {
                Option::Some(element) => { self.append_big_endian(*element); },
                Option::None => { break; }
            }
        };
    }

    fn append_big_endian(ref self: Array<u64>, mut element: Span<felt252>) {
        loop {
            match element.pop_front() {
                Option::Some(element) => { self.append_big_endian(*element); },
                Option::None => { break; }
            }
        };
    }
}
