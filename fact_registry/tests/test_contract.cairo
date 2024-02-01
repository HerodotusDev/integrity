use core::keccak::keccak_u256s_be_inputs;
use starknet::ContractAddress;

use snforge_std::{declare, ContractClassTrait};

use fact_registry::IFactRegistrySafeDispatcher;
use fact_registry::IFactRegistrySafeDispatcherTrait;
use fact_registry::IFactRegistryDispatcher;
use fact_registry::IFactRegistryDispatcherTrait;
use tests::{
    get_stark_proof_with_serde::get_stark_proof_with_serde
};

fn deploy_contract(name: felt252) -> ContractAddress {
    let contract = declare(name);
    contract.deploy(@ArrayTrait::new()).unwrap()
}

#[test]
fn test_return_false_before_register() {
    let contract_address = deploy_contract('FactRegistry');
    let dispatcher = IFactRegistryDispatcher { contract_address };

    let program_hash =
        61181024339325263750486605072532484274138492424367337753502707002347571909007_u256;
    let program_output_hash = 0_u256;
    let fact = keccak_u256s_be_inputs(array![program_hash, program_output_hash].span());

    let result = dispatcher.is_valid(fact);
    assert(result == false, 'Fact should not be valid');
}

#[test]
#[available_gas(99999999999999999)]
fn test_valid_proof_registers_fact() {
    let contract_address = deploy_contract('FactRegistry');
    let dispatcher = IFactRegistryDispatcher { contract_address };
    let stark_proof = get_stark_proof_with_serde();

    dispatcher.verify_and_register_fact(stark_proof);

    let program_hash =
        61181024339325263750486605072532484274138492424367337753502707002347571909007_u256;
    let program_output_hash = 0_u256;
    let fact = keccak_u256s_be_inputs(array![program_hash, program_output_hash].span());

    let result = dispatcher.is_valid(fact);
    // assert(result == true, 'Invalid result');
}
