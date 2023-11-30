use starknet::ContractAddress;

use snforge_std::{declare, ContractClassTrait};

use channel_contract::IChannelContractSafeDispatcher;
use channel_contract::IChannelContractSafeDispatcherTrait;

fn deploy_contract(name: felt252) -> ContractAddress {
    let contract = declare(name);
    contract.deploy(@ArrayTrait::new()).unwrap()
}

#[test]
fn test_add() {
    let contract_address = deploy_contract('ChannelContract');
    let safe_dispatcher = IChannelContractSafeDispatcher { contract_address };
    let result = safe_dispatcher.add(42, 11).unwrap();
    assert(result == 53, 'Invalid value');
}
