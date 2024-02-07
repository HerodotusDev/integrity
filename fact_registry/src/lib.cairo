use component::StarkProofWithSerde;

mod component;

#[starknet::interface]
trait IFactRegistry<TContractState> {
    fn verify_and_register_fact(ref self: TContractState, stark_proof: StarkProofWithSerde);
    fn is_valid(self: @TContractState, fact: felt252) -> bool;
}

#[starknet::contract]
mod FactRegistry {
    use core::{poseidon::{Poseidon, PoseidonImpl, HashStateImpl}, starknet::event::EventEmitter};
    use fact_registry::component::{CairoVerifier, ICairoVerifier, StarkProofWithSerde};

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
    impl FactRegistryImpl of super::IFactRegistry<ContractState> {
        fn verify_and_register_fact(ref self: ContractState, stark_proof: StarkProofWithSerde) {
            let (program_hash, program_output_hash) = self.cairo_verifier.verify_proof(stark_proof);
            let fact = PoseidonImpl::new()
                .update(program_hash)
                .update(program_output_hash)
                .finalize();
            self.emit(Event::FactRegistered(FactRegistered { fact }));
            self.facts.write(fact, true);
        }
        fn is_valid(self: @ContractState, fact: felt252) -> bool {
            self.facts.read(fact)
        }
    }
}
