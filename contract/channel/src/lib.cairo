use channel::add;

#[starknet::interface]
trait IChannel<TContractState> {
    fn add(ref self: TContractState, a: felt252, b: felt252) -> felt252;
}

#[starknet::contract]
mod Channel {
    #[storage]
    struct Storage {}

    #[external(v0)]
    impl ChannelImpl of super::IChannel<ContractState> {
        fn add(ref self: ContractState, a: felt252, b: felt252) -> felt252 {
            channel::add(a, b)
        }
    }
}
