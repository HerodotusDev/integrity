use component::StarkProofWithSerde;

mod component;

#[derive(Drop, Serde)]
enum HashAlgorithm {
    Poseidon,
    Keccak,
}

#[derive(Drop, Serde)]
struct Config {
    hash_algorithm: HashAlgorithm,
}

#[starknet::interface]
trait IFactRegistry<TContractState> {
    fn verify_and_register_fact(
        ref self: TContractState, config: Config, stark_proof: StarkProofWithSerde
    );
    fn is_valid(self: @TContractState, fact: u256) -> bool;
}

#[starknet::contract]
mod FactRegistry {
    use core::{
        poseidon::{Poseidon, PoseidonImpl, HashStateImpl}, keccak::keccak_u256s_be_inputs,
        starknet::event::EventEmitter
    };
    use fact_registry::{
        component::{CairoVerifier, ICairoVerifier, StarkProofWithSerde}, Config, HashAlgorithm
    };

    component!(path: CairoVerifier, storage: cairo_verifier, event: CairoVerifierEvent);

    #[storage]
    struct Storage {
        #[substorage(v0)]
        cairo_verifier: CairoVerifier::Storage,
        facts: LegacyMap<u256, bool>,
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
        fact: u256,
    }

    #[abi(embed_v0)]
    impl FactRegistryImpl of super::IFactRegistry<ContractState> {
        fn verify_and_register_fact(
            ref self: ContractState, config: Config, stark_proof: StarkProofWithSerde
        ) {
            let (program_hash, output_hash) = self.cairo_verifier.verify_proof(stark_proof);
            let fact = match config.hash_algorithm {
                HashAlgorithm::Poseidon => PoseidonImpl::new()
                    .update(program_hash)
                    .update(output_hash)
                    .finalize()
                    .into(),
                HashAlgorithm::Keccak => keccak_u256s_be_inputs(
                    array![program_hash.into(), output_hash.into()].span()
                ),
            };
            self.emit(Event::FactRegistered(FactRegistered { fact }));
            self.facts.write(fact, true);
        }
        fn is_valid(self: @ContractState, fact: u256) -> bool {
            self.facts.read(fact)
        }
    }
}
