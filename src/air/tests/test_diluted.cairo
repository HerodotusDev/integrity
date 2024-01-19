use cairo_verifier::air::diluted::get_diluted_product;
use debug::PrintTrait;

#[test]
#[available_gas(9999999999)]
fn test_diluted_product() {
    let z_arr = array![
        0x3c48e3094aeca888fe6781ad7594d14d7f88062bbe320c6d6913f44b116810,
        0x6813bd29a0c6fd6b95d8d73e35419f95acef279e47e4962adb687279763faf6,
        0x7b0c1a2f6cd6304624f7752edac7a87bfa8bb975be7cdfcea9a044bc20d3dec,
        0x51bc3297736a87e4684972602b4968d73feb6e09e68d9410e7e05b2f8c417b9,
        0x788a7025e36615cf27f6a05a057a87cc89b4c46b5b8255ee9da4e6b736bc017,
        0x4eea09d542e165d44189e413e87bf716ba52a42e14e6f13efe437a25472c9fb,
        0x5eef9cf19fb53bd33d8e6013843d0afc51dd52c9f951fe6d13dfd02e0a22ede,
        0x4a89959ccc754b250b1ed3a63e21d1db2104b7a70aa188403d97709fb317740,
        0x59897723dfed7667f695f22b24db7d8d57255d5276596ca54875efbc2b9e9f6,
        0x530f2e9b29fb3b165e6dbf6785f4490e4e1de17acd48389654971e8f3f57753
    ];

    let res = array![
        0x77236c66f48bc3c27dd07478f276be52b473a7ecbda1b8e6f672824e4627da9,
        0x30a26a9cdf459b2a107dac627b4c3dbbe7ba383fadeb1d7d70bcabd05f480b6,
        0x160d46ab484ee15d2f23a79b01d85ffc385584921a123f66a505d1f49696ab9,
        0x6306e01c2c5fedcbafde711a80dee91a371c4faa9510f125803d93fef5a981f,
        0x500980d369ccd1afbcdc5683a582f6433973a4ccad58e799c19911217f6743,
        0x5924f164ced008abea0d18954658a11da2a957cebf9c6a7d9622b1d0414a1cf,
        0x401f1f9e4b715ad0afe7205600673994598f62eab95d106bcdcf8d857ddedee,
        0x35d20139c38c004206e9087d6442405483d9d5de1004554cdc8799350289fb8,
        0x187f1983a18c3e3cfbbe754cdc17c82fd1d86ab92d18b8802059b7ceaca4ad9,
        0x7462a1a0e6decaba89a6b2321e974e7f9a96551d9b89a5a564699e99e505e5f
    ];

    assert(z_arr.len() == res.len(), 'Wrong test len');
    let mut i = 0;
    assert(
        get_diluted_product(
            16, 4, *z_arr.at(i), 0x1d7304763d588fc98a927959788ad2f21d76121918994f14fc417617e6e9747
        ) == *res
            .at(i),
        'Wrong diluted prod'
    );
}
