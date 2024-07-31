mod verifier;

use cairo_verifier::{StarkProofWithSerde, CairoVersion};
use starknet::ContractAddress;


#[derive(Drop, Copy, Serde)]
struct VerifierSettings {
    layout: felt252,
    hasher: felt252,
    security_bits: felt252,
    version: felt252,
}

#[starknet::interface]
trait IFactRegistry<TContractState> {
    fn verify_and_register_fact(
        ref self: TContractState,
        stark_proof: StarkProofWithSerde,
        cairo_version: CairoVersion,
        settings: VerifierSettings,
    );
    fn is_valid(self: @TContractState, fact: felt252) -> bool;
    fn register_verifier(ref self: TContractState, settings: VerifierSettings, address: ContractAddress);
    fn transfer_ownership(ref self: TContractState, new_owner: ContractAddress);
}

#[starknet::contract]
mod FactRegistry {
    use cairo_verifier::{StarkProofWithSerde, CairoVersion};
    use starknet::{ContractAddress, get_caller_address};
    use core::{
        poseidon::{Poseidon, PoseidonImpl, HashStateImpl}, keccak::keccak_u256s_be_inputs,
        starknet::event::EventEmitter
    };
    use fact_registry::{verifier::{ICairoVerifierDispatcher, ICairoVerifierDispatcherTrait, StarkProof}, IFactRegistry};
    use super::VerifierSettings;

    #[storage]
    struct Storage {
        owner: ContractAddress,
        verifiers: LegacyMap<felt252, ContractAddress>,
        facts: LegacyMap<felt252, bool>,
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        // #[flat]
        // CairoVerifierEvent: CairoVerifier::Event,
        FactRegistered: FactRegistered,
        OwnershipTransferred: OwnershipTransferred,
    }

    #[derive(Drop, starknet::Event)]
    struct FactRegistered {
        #[key]
        fact: felt252,
    }

    #[derive(Drop, starknet::Event)]
    struct OwnershipTransferred {
        previous_owner: ContractAddress,
        new_owner: ContractAddress
    }

    #[constructor]
    fn constructor(ref self: ContractState, owner: ContractAddress) {
        self.owner.write(owner);
    }

    #[abi(embed_v0)]
    impl FactRegistryImpl of IFactRegistry<ContractState> {
        fn verify_and_register_fact(
            ref self: ContractState,
            stark_proof: StarkProofWithSerde,
            cairo_version: CairoVersion,
            settings: VerifierSettings,
        ) {
            let verifier_address = self.verifiers.read(self._hash_settings(settings));
            assert(verifier_address.into() != 0, 'VERIFIER_NOT_FOUND');
            let (program_hash, output_hash) = ICairoVerifierDispatcher {
                contract_address: verifier_address
            }.verify_proof(stark_proof.into(), cairo_version);
            self._register_fact(program_hash, output_hash);
        }

        fn is_valid(self: @ContractState, fact: felt252) -> bool {
            self.facts.read(fact)
        }

        fn register_verifier(ref self: ContractState, settings: VerifierSettings, address: ContractAddress) {
            assert(self.owner.read() == get_caller_address(), 'ONLY_OWNER');
            assert(address.into() != 0, 'INVALID_VERIFIER_ADDRESS');
            let settings_hash = self._hash_settings(settings);
            assert(self.verifiers.read(settings_hash).into() == 0, 'VERIFIER_ALREADY_EXISTS');
            self.verifiers.write(settings_hash, address);
        }

        fn transfer_ownership(ref self: ContractState, new_owner: ContractAddress) {
            let caller = get_caller_address();
            assert(self.owner.read() == caller, 'ONLY_OWNER');
            self.owner.write(new_owner);

            self
                .emit(
                    Event::OwnershipTransferred(
                        OwnershipTransferred { previous_owner: caller, new_owner }
                    )
                );
        }
    }

    #[generate_trait]
    impl InternalFactRegistry of InternalFactRegistryTrait {
        fn _register_fact(ref self: ContractState, program_hash: felt252, output_hash: felt252,) {
            let fact = PoseidonImpl::new().update(program_hash).update(output_hash).finalize();
            self.emit(Event::FactRegistered(FactRegistered { fact }));
            self.facts.write(fact, true);
        }

        fn _hash_settings(self: @ContractState, settings: VerifierSettings) -> felt252 {
            PoseidonImpl::new()
                .update(settings.layout)
                .update(settings.hasher)
                .update(settings.security_bits)
                .update(settings.version)
                .finalize()
        }
    }
}
