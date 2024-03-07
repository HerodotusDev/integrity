use cairo_verifier::{
    channel::channel::ChannelImpl,
    air::{traces::{traces_commit, traces_decommit}, traces::TracesConfigTrait},
    tests::{stone_proof_fibonacci_keccak, stone_proof_fibonacci}
};

// === BLAKE ONLY BEGIN ===
#[test]
#[available_gas(9999999999)]
fn test_traces_config() {
    let traces_config = stone_proof_fibonacci::traces::config::get();

    traces_config.validate(0x16, 0x64);
}

#[test]
#[available_gas(9999999999)]
fn test_traces_commit() {
    let mut channel = ChannelImpl::new_with_counter(0xaf91f2c71f4a594b1575d258ce82464475c82d8fb244142d0db450491c1b52, 0x0);
    let public_input = @stone_proof_fibonacci::public_input::get();
    let unsent_commitment = stone_proof_fibonacci::traces::unsent_commitment::get();
    let traces_config = stone_proof_fibonacci::traces::config::get();

    assert(
        traces_commit(
            ref channel, public_input, unsent_commitment, traces_config
        ) == stone_proof_fibonacci::traces::commitment::get(),
        'Invalid value'
    );

    assert(channel.digest == 0x484f5da62866b3e2a0d4ceb5e00cf7ba33ec5c57ce032df6ca74a40cc6015a0, 'Invalid value');
    assert(channel.counter == 0x0, 'Invalid value')
}

#[test]
#[available_gas(9999999999)]
fn test_traces_decommit() {
    let queries = stone_proof_fibonacci::queries::get().span();
    let commitment = stone_proof_fibonacci::traces::commitment::get();
    let decommitment = stone_proof_fibonacci::traces::decommitment::get();
    let witness = stone_proof_fibonacci::traces::witness::get();

    traces_decommit(queries, commitment, decommitment, witness);
}
// === BLAKE ONLY END ===

// === KECCAK ONLY BEGIN ===
// #[test]
// #[available_gas(9999999999)]
// fn test_traces_config() {
//     let traces_config = stone_proof_fibonacci_keccak::traces::config::get();
// 
//     traces_config.validate(0x14, 0x64);
// }
// 
// #[test]
// #[available_gas(9999999999)]
// fn test_traces_commit() {
//     let mut channel = ChannelImpl::new_with_counter(
//         0xaf91f2c71f4a594b1575d258ce82464475c82d8fb244142d0db450491c1b52, 0x0
//     );
//     let public_input = @stone_proof_fibonacci_keccak::public_input::get();
//     let unsent_commitment = stone_proof_fibonacci_keccak::traces::unsent_commitment::get();
//     let traces_config = stone_proof_fibonacci_keccak::traces::config::get();
// 
//     assert(
//         traces_commit(
//             ref channel, public_input, unsent_commitment, traces_config
//         ) == stone_proof_fibonacci_keccak::traces::commitment::get(),
//         'Invalid value'
//     );
// 
//     assert(
//         channel.digest == 0x39d06a4cd9e64c43aaec44a5415c4cbdf530040b2fc82308ceddb5f2be39dd5,
//         'Invalid value'
//     );
//     assert(channel.counter == 0x0, 'Invalid value')
// }
// 
// #[test]
// #[available_gas(9999999999)]
// fn test_traces_decommit() {
//     let queries = stone_proof_fibonacci_keccak::queries::get().span();
//     let commitment = stone_proof_fibonacci_keccak::traces::commitment::get();
//     let decommitment = stone_proof_fibonacci_keccak::traces::decommitment::get();
//     let witness = stone_proof_fibonacci_keccak::traces::witness::get();
// 
//     traces_decommit(queries, commitment, decommitment, witness);
// }
// === KECCAK ONLY END ===


