use core::hash::HashStateTrait;
use core::poseidon::{Poseidon, PoseidonImpl, HashStateImpl};

use starknet::ContractAddress;
use snforge_std::{declare, ContractClassTrait};

use fact_registry::IFactRegistrySafeDispatcher;
use fact_registry::IFactRegistrySafeDispatcherTrait;
use fact_registry::IFactRegistryDispatcher;
use fact_registry::IFactRegistryDispatcherTrait;
use tests::{get_stark_proof_with_serde::get_stark_proof_with_serde};

fn deploy_contract(name: felt252) -> ContractAddress {
    let contract = declare(name);
    contract.deploy(@ArrayTrait::new()).unwrap()
}

#[test]
fn test_return_false_before_register() {
    let contract_address = deploy_contract('FactRegistry');
    let dispatcher = IFactRegistryDispatcher { contract_address };

    let program_hash = 0;
    let program_output_hash = 0;
    let fact = PoseidonImpl::new().update(program_hash).update(program_output_hash).finalize();

    let result = dispatcher.is_valid(fact);
    assert(result == false, 'Fact should not be valid');
}

#[test]
fn test_valid_proof_registers_fact() {
    let contract_address = deploy_contract('FactRegistry');
    let dispatcher = IFactRegistryDispatcher { contract_address };
    let stark_proof = get_stark_proof_with_serde();

    dispatcher.verify_and_register_fact(stark_proof);

    let program_hash = 3079335794724869688242598235275801819928706317639282524427601876274248508975;
    let output_hash = 3125953701990409645607292272040066796400233313650038958016652175380834344318;
    let fact = PoseidonImpl::new().update(program_hash).update(output_hash).finalize();

    let result = dispatcher.is_valid(fact);
    assert(result == true, 'Invalid result');
}
