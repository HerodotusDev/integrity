trait ToArrayTrait<F, T> {
    fn to_array(self: F, ref output: Array<T>);
}

impl U128ToArrayU8 of ToArrayTrait<u128, u8> {
    fn to_array(mut self: u128, ref output: Array<u8>) {
        let max = 256;
        let mut i = 16;
        loop {
            if i != 0 {
                i -= 1;
                output.append((self % max).try_into().unwrap());
                self = self / max;
            } else {
                break;
            }
        }
    }
}

impl U64ToArrayU8 of ToArrayTrait<u64, u8> {
    fn to_array(mut self: u64, ref output: Array<u8>) {
        let max = 256;
        let mut i = 8;
        loop {
            if i != 0 {
                i -= 1;
                output.append((self % max).try_into().unwrap());
                self = self / max;
            } else {
                break;
            }
        }
    }
}

impl U32ToArrayU8 of ToArrayTrait<u32, u8> {
    fn to_array(mut self: u32, ref output: Array<u8>) {
        let max = 256;
        let mut i = 4;
        loop {
            if i != 0 {
                i -= 1;
                output.append((self % max).try_into().unwrap());
                self = self / max;
            } else {
                break;
            }
        }
    }
}

impl U16ToArrayU8 of ToArrayTrait<u16, u8> {
    fn to_array(mut self: u16, ref output: Array<u8>) {
        let max = 256;
        let mut i = 2;
        loop {
            if i != 0 {
                i -= 1;
                output.append((self % max).try_into().unwrap());
                self = self / max;
            } else {
                break;
            }
        }
    }
}
