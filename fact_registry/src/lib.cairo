mod component;

use component::StarkProofWithSerde;
use starknet::ContractAddress;

#[starknet::interface]
trait IFactRegistry<TContractState> {
    fn verify_and_register_fact(ref self: TContractState, stark_proof: StarkProofWithSerde);
    fn verify_and_register_fact_from_contract(
        ref self: TContractState, contract_address: ContractAddress
    );
    fn is_valid(self: @TContractState, fact: felt252) -> bool;
}

#[starknet::interface]
trait ISmartProof<TContractState> {
    fn get_proof(self: @TContractState) -> Array<felt252>;
}

#[starknet::contract]
mod FactRegistry {
    use starknet::ContractAddress;
    use core::{
        poseidon::{Poseidon, PoseidonImpl, HashStateImpl}, keccak::keccak_u256s_be_inputs,
        starknet::event::EventEmitter
    };
    use fact_registry::{
        component::{CairoVerifier, ICairoVerifier, StarkProofWithSerde}, IFactRegistry
    };
    use super::{ISmartProofDispatcher, ISmartProofDispatcherTrait};

    component!(path: CairoVerifier, storage: cairo_verifier, event: CairoVerifierEvent);

    #[storage]
    struct Storage {
        #[substorage(v0)]
        cairo_verifier: CairoVerifier::Storage,
        facts: LegacyMap<felt252, bool>,
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        #[flat]
        CairoVerifierEvent: CairoVerifier::Event,
        FactRegistered: FactRegistered,
    }

    #[derive(Drop, starknet::Event)]
    struct FactRegistered {
        #[key]
        fact: felt252,
    }

    #[abi(embed_v0)]
    impl FactRegistryImpl of IFactRegistry<ContractState> {
        fn verify_and_register_fact(ref self: ContractState, stark_proof: StarkProofWithSerde) {
            let (program_hash, output_hash) = self.cairo_verifier.verify_proof(stark_proof);
            let fact = PoseidonImpl::new().update(program_hash).update(output_hash).finalize();

            self.emit(Event::FactRegistered(FactRegistered { fact }));
            self.facts.write(fact, true);
        }

        fn verify_and_register_fact_from_contract(
            ref self: ContractState, contract_address: ContractAddress
        ) {
            let mut proof_array = ISmartProofDispatcher { contract_address }.get_proof().span();
            self
                .verify_and_register_fact(
                    Serde::<StarkProofWithSerde>::deserialize(ref proof_array).unwrap()
                );
        }

        fn is_valid(self: @ContractState, fact: felt252) -> bool {
            self.facts.read(fact)
        }
    }
}
