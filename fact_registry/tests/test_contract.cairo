use core::hash::HashStateTrait;
use core::{keccak::keccak_u256s_be_inputs, poseidon::{Poseidon, PoseidonImpl, HashStateImpl}};

use starknet::ContractAddress;
use snforge_std::{declare, ContractClassTrait};

use fact_registry::IFactRegistrySafeDispatcher;
use fact_registry::IFactRegistrySafeDispatcherTrait;
use fact_registry::IFactRegistryDispatcher;
use fact_registry::IFactRegistryDispatcherTrait;
use fact_registry::{Config, HashAlgorithm};
use tests::{get_stark_proof_with_serde::get_stark_proof_with_serde};

fn deploy_contract(name: felt252) -> ContractAddress {
    let contract = declare(name);
    contract.deploy(@ArrayTrait::new()).unwrap()
}

#[test]
fn test_return_false_before_register() {
    let contract_address = deploy_contract('FactRegistry');
    let dispatcher = IFactRegistryDispatcher { contract_address };

    let program_hash = 1551631761987449313068479026839604705498481570694519235869911227847882150820;
    let output_hash = 2336063802160155556507656746920808233007292323159462153734705441523787563728;
    let fact = PoseidonImpl::new().update(program_hash).update(output_hash).finalize().into();

    let result = dispatcher.is_valid(fact);
    assert(result == false, 'Fact should not be valid');
}

#[test]
fn test_valid_proof_registers_fact() {
    let contract_address = deploy_contract('FactRegistry');
    let dispatcher = IFactRegistryDispatcher { contract_address };
    let stark_proof = get_stark_proof_with_serde();
    let config = Config { hash_algorithm: HashAlgorithm::Poseidon, };
    dispatcher.verify_and_register_fact(config, stark_proof);

    let program_hash = 1551631761987449313068479026839604705498481570694519235869911227847882150820;
    let output_hash = 2336063802160155556507656746920808233007292323159462153734705441523787563728;
    let fact = PoseidonImpl::new().update(program_hash).update(output_hash).finalize().into();

    let result = dispatcher.is_valid(fact);
    assert(result == true, 'Invalid result');
}

#[test]
fn test_valid_proof_registers_keccak_fact() {
    let contract_address = deploy_contract('FactRegistry');
    let dispatcher = IFactRegistryDispatcher { contract_address };
    let stark_proof = get_stark_proof_with_serde();
    let config = Config { hash_algorithm: HashAlgorithm::Keccak, };
    dispatcher.verify_and_register_fact(config, stark_proof);

    let program_hash = 1551631761987449313068479026839604705498481570694519235869911227847882150820;
    let output_hash = 2336063802160155556507656746920808233007292323159462153734705441523787563728;
    let fact = keccak_u256s_be_inputs(array![program_hash.into(), output_hash.into()].span());

    let result = dispatcher.is_valid(fact);
    assert(result == true, 'Invalid result');
}
