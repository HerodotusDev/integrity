use cairo_verifier::{
    channel::channel::ChannelTrait, fri::fri::fri_commit,
    tests::{stone_proof_fibonacci, stone_proof_fibonacci_keccak},
};

// === BLAKE ONLY BEGIN ===
// #[test]
// #[available_gas(9999999999)]
// fn test_fri_commit() {
//     let mut channel = ChannelTrait::new_with_counter(0x0, 0x0);
// 
//     let fri_config = stone_proof_fibonacci::fri::config::get();
//     let unsent_commitment = stone_proof_fibonacci::fri::unsent_commitment::get();
// 
//     assert(
//         fri_commit(
//             ref channel, unsent_commitment, fri_config
//         ) == stone_proof_fibonacci::fri::commitment::get(),
//         'Invalid value'
//     );
// 
//     assert(channel.digest == 0x0, 'Invalid value');
//     assert(channel.counter == 0x0, 'Invalid value');
// }
// === BLAKE ONLY END ===

// === KECCAK ONLY BEGIN ===
#[test]
#[available_gas(9999999999)]
fn test_fri_commit() {
    let mut channel = ChannelTrait::new_with_counter(
        0x3612d68f9f68b263d83b0854b812018fd1b7ba0359d7514fffdabd44f0696e6, 0x1
    );

    let fri_config = stone_proof_fibonacci_keccak::fri::config::get();
    let unsent_commitment = stone_proof_fibonacci_keccak::fri::unsent_commitment::get();

    assert(
        fri_commit(
            ref channel, unsent_commitment, fri_config
        ) == stone_proof_fibonacci_keccak::fri::commitment::get(),
        'Invalid value'
    );
}
// === KECCAK ONLY END ===


