use cairo_verifier::{
    channel::channel::ChannelImpl,
    air::{traces::{traces_commit, traces_decommit}, traces::TracesConfigTrait},
    tests::{stone_proof_fibonacci, stone_proof_fibonacci_keccak},
};

// === BLAKE ONLY BEGIN ===
// #[test]
// #[available_gas(9999999999)]
// fn test_traces_config() {
//     let traces_config = stone_proof_fibonacci::traces::config::get();
// 
//     traces_config.validate(0x16, 0x16);
// }
// 
// #[test]
// #[available_gas(9999999999)]
// fn test_traces_commit() {
//     let mut channel = ChannelImpl::new_with_counter(0x0, 0x0);
//     let public_input = @stone_proof_fibonacci::public_input::get();
//     let unsent_commitment = stone_proof_fibonacci::traces::unsent_commitment::get();
//     let traces_config = stone_proof_fibonacci::traces::config::get();
// 
//     assert(
//         traces_commit(
//             ref channel, public_input, unsent_commitment, traces_config
//         ) == stone_proof_fibonacci::traces::commitment::get(),
//         'Invalid value'
//     );
// 
//     assert(channel.digest == 0x0, 'Invalid value');
//     assert(channel.counter == 0x0, 'Invalid value')
// }
// 
// #[test]
// #[available_gas(9999999999)]
// fn test_traces_decommit() {
//     let queries = stone_proof_fibonacci::queries::get().span();
//     let commitment = stone_proof_fibonacci::traces::commitment::get();
//     let decommitment = stone_proof_fibonacci::traces::decommitment::get();
//     let witness = stone_proof_fibonacci::traces::witness::get();
// 
//     traces_decommit(queries, commitment, decommitment, witness);
// }
// === BLAKE ONLY END ===

// === KECCAK ONLY BEGIN ===
#[test]
#[available_gas(9999999999)]
fn test_traces_config() {
    let traces_config = stone_proof_fibonacci_keccak::traces::config::get();

    traces_config.validate(0x16, 0x64);
}

#[test]
#[available_gas(9999999999)]
fn test_traces_commit() {
    let mut channel = ChannelImpl::new_with_counter(0x0, 0x0);
    let public_input = @stone_proof_fibonacci_keccak::public_input::get();
    let unsent_commitment = stone_proof_fibonacci_keccak::traces::unsent_commitment::get();
    let traces_config = stone_proof_fibonacci_keccak::traces::config::get();

    assert(
        traces_commit(
            ref channel, public_input, unsent_commitment, traces_config
        ) == stone_proof_fibonacci_keccak::traces::commitment::get(),
        'Invalid value'
    );

    assert(channel.digest == 0x0, 'Invalid value');

    assert(channel.counter == 0x0, 'Invalid value')
}

#[test]
#[available_gas(9999999999)]
fn test_traces_decommit() {
    let queries = stone_proof_fibonacci_keccak::queries::get().span();
    let commitment = stone_proof_fibonacci_keccak::traces::commitment::get();
    let decommitment = stone_proof_fibonacci_keccak::traces::decommitment::get();
    let witness = stone_proof_fibonacci_keccak::traces::witness::get();

    traces_decommit(queries, commitment, decommitment, witness);
}
// === KECCAK ONLY END ===


