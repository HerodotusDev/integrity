fn u256_split(input: u256) -> (u128, u128) {
    (input.high, input.low)
}

fn u128_split(input: u128) -> (u64, u64) {
    let (high, low) = core::integer::u128_safe_divmod(
        input, 0x10000000000000000_u128.try_into().unwrap(),
    );

    (high.try_into().unwrap(), low.try_into().unwrap())
}

fn u64_split(input: u64) -> (u32, u32) {
    let (high, low) = core::integer::u64_safe_divmod(input, 0x100000000_u64.try_into().unwrap());

    (high.try_into().unwrap(), low.try_into().unwrap())
}

fn u32_split(input: u32) -> (u16, u16) {
    let (high, low) = core::integer::u32_safe_divmod(input, 0x10000_u32.try_into().unwrap());

    (high.try_into().unwrap(), low.try_into().unwrap())
}

fn u16_split(input: u16) -> (u8, u8) {
    let (high, low) = core::integer::u16_safe_divmod(input, 0x100_u16.try_into().unwrap());

    (high.try_into().unwrap(), low.try_into().unwrap())
}
