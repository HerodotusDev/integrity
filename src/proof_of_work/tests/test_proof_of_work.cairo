use cairo_verifier::proof_of_work::proof_of_work::verify_proof_of_work;

#[test]
#[available_gas(9999999999)]
fn test_verify_proof_of_work_0() {
    let digest: u256 = u256 {
        low: 0x6308b38ae2841c18fb8c06c9acc9bcd5, high: 0x5d35fab3c11198da5f6fe41666993b16
    };
    let nonce: u64 = 0xd65397f;
    let n_bits: u8 = 0x1e;
    verify_proof_of_work(digest, n_bits, nonce);
}

#[test]
#[should_panic]
#[available_gas(9999999999)]
fn test_verify_proof_of_work_1() {
    let digest: u256 = u256 {
        low: 0x6308b38ae2841c18fb8c06c9acc9bcd5, high: 0x5d35fab3c11198da5f6fe41666993b16
    };
    let nonce: u64 = 0xd65397f + 1;
    let n_bits: u8 = 0x1e;
    verify_proof_of_work(digest, n_bits, nonce);
}

#[test]
#[available_gas(9999999999)]
fn test_verify_proof_of_work_2() {
    let digest: u256 = u256 {
        low: 0xaa161ad28fb8da3ccf6938931e57e7a1, high: 0x35dbd852ffd135485a3376a8187a2aed
    };
    let nonce: u64 = 0x544bb355;
    let n_bits: u8 = 0x1e;
    verify_proof_of_work(digest, n_bits, nonce);
}

#[test]
#[should_panic]
#[available_gas(9999999999)]
fn test_verify_proof_of_work_3() {
    let digest: u256 = u256 {
        low: 0xaa161ad28fb8da3ccf6938931e57e7a1, high: 0x35dbd852ffd135485a3376a8187a2aed
    };
    let nonce: u64 = 0x544bb355 - 1;
    let n_bits: u8 = 0x1e;
    verify_proof_of_work(digest, n_bits, nonce);
}
