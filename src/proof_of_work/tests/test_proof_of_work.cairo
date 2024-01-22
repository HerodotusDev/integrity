use cairo_verifier::proof_of_work::proof_of_work::verify_proof_of_work;

#[test]
#[available_gas(9999999999)]
fn test_verify_proof_of_work_0() {
    let digest: u256 = 0x1c5a5f4381df1f5cd7ca1d48a19d8ff802a71d94169de38382621fdc5514a10a;
    let nonce: u64 = 0x1683b;
    let n_bits: u8 = 20;
    verify_proof_of_work(digest, n_bits, nonce);
}

#[test]
#[should_panic]
#[available_gas(9999999999)]
fn test_verify_proof_of_work_1() {
    let digest: u256 = 0x1c5a5f4381df1f5cd7ca1d48a19d8ff802a71d94169de38382621fdc5514a10a;
    let nonce: u64 = 0x1683b + 1;
    let n_bits: u8 = 20;
    verify_proof_of_work(digest, n_bits, nonce);
}

#[test]
#[available_gas(9999999999)]
fn test_verify_proof_of_work_2() {
    let digest: u256 = u256 {
        low: 0x15aa9b8787d877d61588844c0cfe2fb9, high: 0x7cd36c3da65b8d57331341e661a86574
    };
    let nonce: u64 = 0x40719c5;
    let n_bits: u8 = 0x1e;
    verify_proof_of_work(digest, n_bits, nonce);
}
