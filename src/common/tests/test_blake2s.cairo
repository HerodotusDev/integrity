use cairo_verifier::common::blake2s::{blake2s, truncated_blake2s, load32};

fn get_arr_v1(n: u32) -> Array<u32> {
    let mut arr = ArrayTrait::new();
    let mut i: u32 = 1;
    loop {
        arr.append((i % 256).try_into().unwrap());
        if i == 4 * n {
            break;
        }
        i += 1;
    };
    let mut out = ArrayTrait::new();
    i = 0;
    loop {
        out.append(load32(*arr[4 * i], *arr[4 * i + 1], *arr[4 * i + 2], *arr[4 * i + 3]));
        i += 1;
        if i == n {
            break;
        };
    };
    out
}

fn get_arr_v2(n: u32) -> Array<u32> {
    let mut arr = ArrayTrait::new();
    let mut s: u32 = 1;
    let mut i: u32 = 1;
    loop {
        s *= 17;
        s = s ^ i;
        s %= 256;
        arr.append(s.try_into().unwrap());
        if i == 4 * n {
            break;
        }
        i += 1;
    };
    let mut out = ArrayTrait::new();
    i = 0;
    loop {
        out.append(load32(*arr[4 * i], *arr[4 * i + 1], *arr[4 * i + 2], *arr[4 * i + 3]));
        i += 1;
        if i == n {
            break;
        };
    };
    out
}

#[test]
#[available_gas(9999999999)]
fn test_blake2s_v1() {
    assert(
        blake2s(
            get_arr_v1(1)
        ) == 0x035c8c55b225b3cad27dec93997fb528978127b9aa3c145c4308b8b6a4b0c7d4,
        'invalid hash (1)'
    );
    assert(
        blake2s(
            get_arr_v1(2)
        ) == 0x676da142c9e15751cf6c94e96ebc05925408612bbcf56437adf6fb21822fca4b,
        'invalid hash (2)'
    );
    assert(
        blake2s(
            get_arr_v1(16)
        ) == 0xc7fa21bb08b0bd19600ad212c0fa0f7ff332f415ae1527282a939406413299aa,
        'invalid hash (16)'
    );
    assert(
        blake2s(
            get_arr_v1(17)
        ) == 0x6acb015d7514d821091ec780120b89ba4663f65e6ff6588d458ef333fe8c8a39,
        'invalid hash (17)'
    );
    assert(
        blake2s(
            get_arr_v1(32)
        ) == 0x5651036b64f7affbe498f0409950e06a352bcae03f5a79b78fec58a4cebe10d5,
        'invalid hash (32)'
    );
    assert(
        blake2s(
            get_arr_v1(33)
        ) == 0x42d5eeff1aa4972630bcca469f37bbe8c2f8014937e28cbedbc671571d3eb87c,
        'invalid hash (33)'
    );
    assert(
        blake2s(
            get_arr_v1(250)
        ) == 0x33fc848fc73514d8bc3f338b23ba684d945081da37e5a8e490db5032eac34630,
        'invalid hash (250)'
    );
    assert(
        blake2s(
            get_arr_v1(272)
        ) == 0x1b5ad0d1b82600127a6add8e1cf604a075843c3d35bbe31d636fa071674c9432,
        'invalid hash (272)'
    );
}

#[test]
#[available_gas(9999999999)]
fn test_blake2s_v2() {
    assert(
        blake2s(
            get_arr_v2(1)
        ) == 0x3becbdec8344113fbee53542a4ef696e97db25efb96cef60d2919bb4dd00ed3e,
        'invalid hash (1)'
    );
    assert(
        blake2s(
            get_arr_v2(2)
        ) == 0x5229f5d506302edae36f9cac3f5d176cd9b6aa8420da6d74d7956789099faf70,
        'invalid hash (2)'
    );
    assert(
        blake2s(
            get_arr_v2(16)
        ) == 0xdfe91aa5523f1df5e6549d98121e9bdbac4cbba4375e93d812ef487d0fe562f6,
        'invalid hash (16)'
    );
    assert(
        blake2s(
            get_arr_v2(17)
        ) == 0x49f2c2bb269d275a111a04c459c847838a0cf7c488d6366577a21f75620243e6,
        'invalid hash (17)'
    );
    assert(
        blake2s(
            get_arr_v2(32)
        ) == 0x83e9b2b70274d9198b6b77a1760ebacfd1f0fe232a0ed78f1c722e154ee72362,
        'invalid hash (32)'
    );
    assert(
        blake2s(
            get_arr_v2(33)
        ) == 0x93a7f68b8ea17374c11e1da719885513b598c4e191825fb584e399206c05ae15,
        'invalid hash (33)'
    );
    assert(
        blake2s(
            get_arr_v2(250)
        ) == 0xe4e6bd453ba2eb5a378d7933576dbf697b6d31cf38061c550ea36f6843a9bf43,
        'invalid hash (250)'
    );
    assert(
        blake2s(
            get_arr_v2(272)
        ) == 0x5906fef89f21466142323029000040f6c25be2ff87d581a8f752b94ad3662762,
        'invalid hash (272)'
    );
}

#[test]
#[available_gas(9999999999)]
fn test_truncated_blake2s() {
    let x = 1157029198022238202306346125123666191662554108005;
    let y = 129252051435949032402481343903845417193011527432;
    let out = truncated_blake2s(x, y);
    assert(out == 642191007116032514313255519742888271333651019057, 'invalid truncated_blake2s');
}

// notice: this test takes a lot of time and computation
//         uncomment it when making changes to blake2s
// #[test]
// #[available_gas(9999999999)]
fn test_blake2s_big() {
    let mut sum: u256 = 0;
    let mut arr = ArrayTrait::new();
    let mut i: u32 = 0;
    loop {
        arr.append(i);
        i += 1;
        if i == 512 {
            break;
        };
    };
    loop {
        let mut new_arr: Array<u32> = ArrayTrait::new();
        let arr_span = arr.span();
        let mut j = 0;
        loop {
            new_arr.append(*arr_span[j]);
            j += 1;
            if j == arr_span.len() {
                break;
            };
        };
        let res = blake2s(new_arr);
        sum = sum ^ res;
        let to_append: u32 = (res % 0x100000000).try_into().unwrap();
        arr.append(to_append);
        i += 1;
        if i == 529 {
            break;
        };
    };
    assert(
        sum == 0x75dab924b6592ce2d9e0173c0d69ed45b4d8125da10a9db234fbdac721477df5, 'invalid hash'
    );
}
