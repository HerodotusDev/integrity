use cairo_verifier::proof_of_work::proof_of_work::verify_proof_of_work;

// 142085208829254859155982631899283860045, 50861399631734199073966002375401352892

#[test]
#[available_gas(9999999999)]
fn test_proof_of_work_0() {
    let digest: u256 = 0x1C5A5F4381DF1F5CD7CA1D48A19D8FF802A71D94169DE38382621FDC5514A10A;
    let nonce: u64 = 0x1683B;
    let n_bits: u8 = 20;
    verify_proof_of_work(digest, n_bits, nonce);
}