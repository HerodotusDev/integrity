use cairo_verifier::common::flip_endianness::FlipEndiannessU32;

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
    fn append_little_endian(ref self: Array<u32>, element: Span<felt252>) {
        let mut i = 0;
        loop {
            if i == element.len() {
                break;
            }
            self.append_little_endian(*element[i]);
            i += 1;
        };
    }
    fn append_big_endian(ref self: Array<u32>, element: Span<felt252>) {
        let mut i = 0;
        loop {
            if i == element.len() {
                break;
            }
            self.append_big_endian(*element[i]);
            i += 1;
        };
    }
}

impl ArrayU32AppendU128 of ArrayAppendTrait<u32, u128> {
    fn append_little_endian(ref self: Array<u32>, mut element: u128) {
        let mut i = 4;
        let max = U128maxU32.try_into().unwrap();
        loop {
            if i != 0 {
                i -= 1;
                let (q, r) = DivRem::div_rem(element, max);
                self.append(r.try_into().unwrap());
                element = q;
            } else {
                break;
            }
        }
    }

    fn append_big_endian(ref self: Array<u32>, mut element: u128) {
        let mut array = ArrayTrait::<u32>::new();
        array.append_little_endian(element);
        let mut span = array.span();
        loop {
            match span.pop_back() {
                Option::Some(elem) => { self.append((*elem).flip_endianness()); },
                Option::None => { break; }
            }
        }
    }
}

impl ArrayU32AppendU64 of ArrayAppendTrait<u32, u64> {
    fn append_little_endian(ref self: Array<u32>, mut element: u64) {
        let mut i = 2;
        let max = U64maxU32.try_into().unwrap();
        loop {
            if i != 0 {
                i -= 1;
                let (q, r) = DivRem::div_rem(element, max);
                self.append(r.try_into().unwrap());
                element = q;
            } else {
                break;
            }
        }
    }

    fn append_big_endian(ref self: Array<u32>, mut element: u64) {
        let mut array = ArrayTrait::<u32>::new();
        array.append_little_endian(element);
        let mut span = array.span();
        loop {
            match span.pop_back() {
                Option::Some(elem) => { self.append((*elem).flip_endianness()); },
                Option::None => { break; }
            }
        }
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
        let mut i = 16;
        let max = U128maxU8.try_into().unwrap();
        loop {
            if i != 0 {
                i -= 1;
                let (q, r) = DivRem::div_rem(element, max);
                self.append(r.try_into().unwrap());
                element = q;
            } else {
                break;
            }
        }
    }

    fn append_big_endian(ref self: Array<u8>, mut element: u128) {
        let mut array = ArrayTrait::<u8>::new();
        array.append_little_endian(element);
        let mut span = array.span();
        loop {
            match span.pop_back() {
                Option::Some(elem) => { self.append(*elem); },
                Option::None => { break; }
            }
        }
    }
}

impl ArrayU8AppendU64 of ArrayAppendTrait<u8, u64> {
    fn append_little_endian(ref self: Array<u8>, mut element: u64) {
        let mut i = 8;
        let max = U64maxU8.try_into().unwrap();
        loop {
            if i != 0 {
                i -= 1;
                let (q, r) = DivRem::div_rem(element, max);
                self.append(r.try_into().unwrap());
                element = q;
            } else {
                break;
            }
        }
    }

    fn append_big_endian(ref self: Array<u8>, mut element: u64) {
        let mut array = ArrayTrait::<u8>::new();
        array.append_little_endian(element);
        let mut span = array.span();
        loop {
            match span.pop_back() {
                Option::Some(elem) => { self.append(*elem); },
                Option::None => { break; }
            }
        }
    }
}

impl ArrayU8AppendU32 of ArrayAppendTrait<u8, u32> {
    fn append_little_endian(ref self: Array<u8>, mut element: u32) {
        let mut i = 4;
        let max = U32maxU8.try_into().unwrap();
        loop {
            if i != 0 {
                i -= 1;
                let (q, r) = DivRem::div_rem(element, max);
                self.append(r.try_into().unwrap());
                element = q;
            } else {
                break;
            }
        }
    }

    fn append_big_endian(ref self: Array<u8>, mut element: u32) {
        let mut array = ArrayTrait::<u8>::new();
        array.append_little_endian(element);
        let mut span = array.span();
        loop {
            match span.pop_back() {
                Option::Some(elem) => { self.append(*elem); },
                Option::None => { break; }
            }
        }
    }
}
