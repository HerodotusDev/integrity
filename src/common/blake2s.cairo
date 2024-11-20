use integrity::common::flip_endianness::FlipEndiannessTrait;
use core::num::traits::WrappingAdd;

fn blake2s(data: Array<u32>) -> u256 {
    let mut state = blake2s_init();
    state = blake2s_update(state, data);
    blake2s_final(state)
}

#[inline(always)]
fn rotr16(n: u32) -> u32 {
    let (high, low) = DivRem::div_rem(n, 65536);
    TryInto::<felt252, u32>::try_into(high.into() + low.into() * 65536).unwrap()
}

#[inline(always)]
fn rotr12(n: u32) -> u32 {
    let (high, low) = DivRem::div_rem(n, 4096);
    TryInto::<felt252, u32>::try_into(high.into() + low.into() * 1048576).unwrap()
}

#[inline(always)]
fn rotr8(n: u32) -> u32 {
    let (high, low) = DivRem::div_rem(n, 256);
    TryInto::<felt252, u32>::try_into(high.into() + low.into() * 16777216).unwrap()
}

#[inline(always)]
fn rotr7(n: u32) -> u32 {
    let (high, low) = DivRem::div_rem(n, 128);
    TryInto::<felt252, u32>::try_into(high.into() + low.into() * 33554432).unwrap()
}

#[derive(Drop, Clone)]
struct blake2s_state {
    h: Array<u32>, // length: 8
    t0: u32,
    t1: u32,
    f0: u32,
    buf: Array<u32>, // length: 16 (64 bytes)
    buflen: u32,
}

fn blake2s_init() -> blake2s_state {
    let blake2s_IV = array![
        0x6A09E667 ^ 0x01010020, // xor (depth, fanout, digest_length)
        0xBB67AE85,
        0x3C6EF372,
        0xA54FF53A,
        0x510E527F,
        0x9B05688C,
        0x1F83D9AB,
        0x5BE0CD19
    ];
    let mut buf = array![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

    blake2s_state { h: blake2s_IV, t0: 0, t1: 0, f0: 0, buf: buf, buflen: 0 }
}

fn blake2s_compress(mut s: blake2s_state, m: Array<u32>) -> blake2s_state {
    assert(m.len() == 16, 'in array must have length 16');

    let mut v0: u32 = *s.h[0];
    let mut v1: u32 = *s.h[1];
    let mut v2: u32 = *s.h[2];
    let mut v3: u32 = *s.h[3];
    let mut v4: u32 = *s.h[4];
    let mut v5: u32 = *s.h[5];
    let mut v6: u32 = *s.h[6];
    let mut v7: u32 = *s.h[7];
    let mut v8: u32 = 0x6A09E667;
    let mut v9: u32 = 0xBB67AE85;
    let mut v10: u32 = 0x3C6EF372;
    let mut v11: u32 = 0xA54FF53A;
    let mut v12: u32 = s.t0 ^ 0x510E527F;
    let mut v13: u32 = s.t1 ^ 0x9B05688C;
    let mut v14: u32 = s.f0 ^ 0x1F83D9AB;
    let mut v15: u32 = 0x5BE0CD19; // f1 is always 0

    let m_span = m.span();
    let mut sigma = array![
        0,
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        10,
        11,
        12,
        13,
        14,
        15,
        14,
        10,
        4,
        8,
        9,
        15,
        13,
        6,
        1,
        12,
        0,
        2,
        11,
        7,
        5,
        3,
        11,
        8,
        12,
        0,
        5,
        2,
        15,
        13,
        10,
        14,
        3,
        6,
        7,
        1,
        9,
        4,
        7,
        9,
        3,
        1,
        13,
        12,
        11,
        14,
        2,
        6,
        5,
        10,
        4,
        0,
        15,
        8,
        9,
        0,
        5,
        7,
        2,
        4,
        10,
        15,
        14,
        1,
        11,
        12,
        6,
        8,
        3,
        13,
        2,
        12,
        6,
        10,
        0,
        11,
        8,
        3,
        4,
        13,
        7,
        5,
        15,
        14,
        1,
        9,
        12,
        5,
        1,
        15,
        14,
        13,
        4,
        10,
        0,
        7,
        6,
        3,
        9,
        2,
        8,
        11,
        13,
        11,
        7,
        14,
        12,
        1,
        3,
        9,
        5,
        0,
        15,
        4,
        8,
        6,
        2,
        10,
        6,
        15,
        14,
        9,
        11,
        3,
        0,
        8,
        12,
        2,
        13,
        7,
        1,
        4,
        10,
        5,
        10,
        2,
        8,
        4,
        7,
        6,
        1,
        5,
        15,
        11,
        9,
        14,
        3,
        12,
        13,
        0,
    ]
        .span();

    loop {
        if sigma.is_empty() {
            break;
        }

        // ROUND function begin

        // 0 - 0,4,8,12
        v0 =
            WrappingAdd::wrapping_add(
                WrappingAdd::wrapping_add(v0, v4), *m_span.at(*sigma.pop_front().unwrap())
            );
        v12 = rotr16(v12 ^ v0);
        v8 = WrappingAdd::wrapping_add(v8, v12);
        v4 = rotr12(v4 ^ v8);
        v0 =
            WrappingAdd::wrapping_add(
                WrappingAdd::wrapping_add(v0, v4), *m_span.at(*sigma.pop_front().unwrap())
            );
        v12 = rotr8(v12 ^ v0);
        v8 = WrappingAdd::wrapping_add(v8, v12);
        v4 = rotr7(v4 ^ v8);

        // 1 - 1,5,9,13
        v1 =
            WrappingAdd::wrapping_add(
                WrappingAdd::wrapping_add(v1, v5), *m_span.at(*sigma.pop_front().unwrap())
            );
        v13 = rotr16(v13 ^ v1);
        v9 = WrappingAdd::wrapping_add(v9, v13);
        v5 = rotr12(v5 ^ v9);
        v1 =
            WrappingAdd::wrapping_add(
                WrappingAdd::wrapping_add(v1, v5), *m_span.at(*sigma.pop_front().unwrap())
            );
        v13 = rotr8(v13 ^ v1);
        v9 = WrappingAdd::wrapping_add(v9, v13);
        v5 = rotr7(v5 ^ v9);

        // 2 - 2,6,10,14
        v2 =
            WrappingAdd::wrapping_add(
                WrappingAdd::wrapping_add(v2, v6), *m_span.at(*sigma.pop_front().unwrap())
            );
        v14 = rotr16(v14 ^ v2);
        v10 = WrappingAdd::wrapping_add(v10, v14);
        v6 = rotr12(v6 ^ v10);
        v2 =
            WrappingAdd::wrapping_add(
                WrappingAdd::wrapping_add(v2, v6), *m_span.at(*sigma.pop_front().unwrap())
            );
        v14 = rotr8(v14 ^ v2);
        v10 = WrappingAdd::wrapping_add(v10, v14);
        v6 = rotr7(v6 ^ v10);

        // 3 - 3,7,11,15
        v3 =
            WrappingAdd::wrapping_add(
                WrappingAdd::wrapping_add(v3, v7), *m_span.at(*sigma.pop_front().unwrap())
            );
        v15 = rotr16(v15 ^ v3);
        v11 = WrappingAdd::wrapping_add(v11, v15);
        v7 = rotr12(v7 ^ v11);
        v3 =
            WrappingAdd::wrapping_add(
                WrappingAdd::wrapping_add(v3, v7), *m_span.at(*sigma.pop_front().unwrap())
            );
        v15 = rotr8(v15 ^ v3);
        v11 = WrappingAdd::wrapping_add(v11, v15);
        v7 = rotr7(v7 ^ v11);

        // 4 - 0,5,10,15
        v0 =
            WrappingAdd::wrapping_add(
                WrappingAdd::wrapping_add(v0, v5), *m_span.at(*sigma.pop_front().unwrap())
            );
        v15 = rotr16(v15 ^ v0);
        v10 = WrappingAdd::wrapping_add(v10, v15);
        v5 = rotr12(v5 ^ v10);
        v0 =
            WrappingAdd::wrapping_add(
                WrappingAdd::wrapping_add(v0, v5), *m_span.at(*sigma.pop_front().unwrap())
            );
        v15 = rotr8(v15 ^ v0);
        v10 = WrappingAdd::wrapping_add(v10, v15);
        v5 = rotr7(v5 ^ v10);

        // 5 - 1,6,11,12
        v1 =
            WrappingAdd::wrapping_add(
                WrappingAdd::wrapping_add(v1, v6), *m_span.at(*sigma.pop_front().unwrap())
            );
        v12 = rotr16(v12 ^ v1);
        v11 = WrappingAdd::wrapping_add(v11, v12);
        v6 = rotr12(v6 ^ v11);
        v1 =
            WrappingAdd::wrapping_add(
                WrappingAdd::wrapping_add(v1, v6), *m_span.at(*sigma.pop_front().unwrap())
            );
        v12 = rotr8(v12 ^ v1);
        v11 = WrappingAdd::wrapping_add(v11, v12);
        v6 = rotr7(v6 ^ v11);

        // 6 - 2,7,8,13
        v2 =
            WrappingAdd::wrapping_add(
                WrappingAdd::wrapping_add(v2, v7), *m_span.at(*sigma.pop_front().unwrap())
            );
        v13 = rotr16(v13 ^ v2);
        v8 = WrappingAdd::wrapping_add(v8, v13);
        v7 = rotr12(v7 ^ v8);
        v2 =
            WrappingAdd::wrapping_add(
                WrappingAdd::wrapping_add(v2, v7), *m_span.at(*sigma.pop_front().unwrap())
            );
        v13 = rotr8(v13 ^ v2);
        v8 = WrappingAdd::wrapping_add(v8, v13);
        v7 = rotr7(v7 ^ v8);

        // 7 - 3,4,9,14
        v3 =
            WrappingAdd::wrapping_add(
                WrappingAdd::wrapping_add(v3, v4), *m_span.at(*sigma.pop_front().unwrap())
            );
        v14 = rotr16(v14 ^ v3);
        v9 = WrappingAdd::wrapping_add(v9, v14);
        v4 = rotr12(v4 ^ v9);
        v3 =
            WrappingAdd::wrapping_add(
                WrappingAdd::wrapping_add(v3, v4), *m_span.at(*sigma.pop_front().unwrap())
            );
        v14 = rotr8(v14 ^ v3);
        v9 = WrappingAdd::wrapping_add(v9, v14);
        v4 = rotr7(v4 ^ v9);
    };

    let mut new_h = ArrayTrait::new();
    new_h.append((*s.h[0]) ^ v0 ^ v8);
    new_h.append((*s.h[1]) ^ v1 ^ v9);
    new_h.append((*s.h[2]) ^ v2 ^ v10);
    new_h.append((*s.h[3]) ^ v3 ^ v11);
    new_h.append((*s.h[4]) ^ v4 ^ v12);
    new_h.append((*s.h[5]) ^ v5 ^ v13);
    new_h.append((*s.h[6]) ^ v6 ^ v14);
    new_h.append((*s.h[7]) ^ v7 ^ v15);
    s.h = new_h;

    s
}

fn blake2s_update(mut s: blake2s_state, in: Array<u32>) -> blake2s_state {
    let mut in_len = in.len();
    let mut in_shift = 0;
    let in_span = in.span();
    if in_len != 0 {
        let left = s.buflen;
        let fill = 16 - left;
        if in_len > fill {
            s.buflen = 0;

            let mut new_buf = ArrayTrait::new();
            let buf_span = s.buf.span();
            let mut i: u32 = 0;
            loop {
                if i == left {
                    break;
                }
                new_buf.append(*buf_span.at(i));
                i += 1;
            };

            i = 0;
            loop {
                if i == fill {
                    break;
                }
                new_buf.append(*in_span[i]);
                i += 1;
            };

            // blake2s_increment_counter
            s.t0 = WrappingAdd::wrapping_add(s.t0, 64_u32);
            if s.t0 < 64_u32 {
                s.t1 = WrappingAdd::wrapping_add(s.t1, 1);
            }

            s = blake2s_compress(s, new_buf);

            in_shift += fill;
            in_len -= fill;

            loop {
                if in_len <= 16 {
                    break;
                }

                // blake2s_increment_counter
                s.t0 = WrappingAdd::wrapping_add(s.t0, 64_u32);
                if s.t0 < 64_u32 {
                    s.t1 = WrappingAdd::wrapping_add(s.t1, 1);
                }

                let mut compress_in = ArrayTrait::new();
                i = 0;
                loop {
                    if i == 16 {
                        break;
                    }
                    compress_in.append(*in_span[in_shift + i]);
                    i += 1;
                };

                s = blake2s_compress(s, compress_in);

                in_shift += 16;
                in_len -= 16;
            };
        }

        let mut new_buf = ArrayTrait::new();
        let buf_span = s.buf.span();
        let mut i = 0;
        loop {
            if i == s.buflen {
                break;
            }
            new_buf.append(*buf_span[i]);
            i += 1;
        };
        i = 0;
        loop {
            if i == in_len {
                break;
            }
            new_buf.append(*in_span[in_shift + i]);
            i += 1;
        };
        loop {
            if new_buf.len() == 16 {
                break;
            }
            new_buf.append(0);
        };
        s.buf = new_buf;
        s.buflen += in_len;
    }

    s
}

fn blake2s_final(mut s: blake2s_state) -> u256 {
    assert(s.f0 == 0, 'blake2s_is_lastblock');

    // blake2s_increment_counter
    s.t0 = WrappingAdd::wrapping_add(s.t0, s.buflen * 4);
    if s.t0 < s.buflen {
        s.t1 = WrappingAdd::wrapping_add(s.t1, 1);
    }

    s.f0 = 0xffffffff;

    let mut i = 0;
    let buf_span = s.buf.span();
    let mut buf = ArrayTrait::new();
    loop {
        if i == s.buflen {
            break;
        }
        buf.append(*buf_span[i]);
        i += 1;
    };
    loop {
        if i == 16 {
            break;
        }
        buf.append(0);
        i += 1;
    };

    s = blake2s_compress(s, buf);

    let mut result: u256 = 0;
    let mut multiplier: u256 = 1;
    i = 0;
    loop {
        result += (*s.h[i]).into() * multiplier;
        i += 1;
        if i == 8 {
            break;
        }
        multiplier *= 0x100000000;
    };

    result
}
