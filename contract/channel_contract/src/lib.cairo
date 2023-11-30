use channel::add;

#[starknet::interface]
trait IChannelContract<TContractState> {
    fn add(ref self: TContractState, a: felt252, b: felt252) -> felt252;
}

#[starknet::contract]
mod ChannelContract {
    #[storage]
    struct Storage {}

    #[external(v0)]
    impl ChannelContractImpl of super::IChannelContract<ContractState> {
        fn add(ref self: ContractState, a: felt252, b: felt252) -> felt252 {
            channel::add(a, b)
        }
    }
}
