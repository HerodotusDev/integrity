use starknet::ContractAddress;

use snforge_std::{declare, ContractClassTrait};

use fact_registry::IFactRegistrySafeDispatcher;
use fact_registry::IFactRegistrySafeDispatcherTrait;
use fact_registry::IFactRegistryDispatcher;
use fact_registry::IFactRegistryDispatcherTrait;

fn deploy_contract(name: felt252) -> ContractAddress {
    let contract = declare(name);
    contract.deploy(@ArrayTrait::new()).unwrap()
}

#[test]
fn test_return_false_before_register() {
    let contract_address = deploy_contract('FactRegistry');
    let dispatcher = IFactRegistryDispatcher { contract_address };
}

#[test]
fn test_valid_proof_registers_fact() {
    let contract_address = deploy_contract('FactRegistry');
    let dispatcher = IFactRegistryDispatcher { contract_address };
}
