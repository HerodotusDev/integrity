use cairo_verifier::{
    StarkProofWithSerde, CairoVersion,
    fri::fri::{FriLayerWitness, FriVerificationStateConstant, FriVerificationStateVariable},
    verifier::InitResult,
};
use starknet::ContractAddress;

#[derive(Drop, Copy, Serde)]
struct VerifierSettings {
    layout: felt252,
    hasher: felt252,
    version: felt252,
}

#[starknet::interface]
trait IFactRegistry<TContractState> {
    fn verify_proof_full_and_register_fact(
        ref self: TContractState,
        stark_proof: StarkProofWithSerde,
        cairo_version: CairoVersion,
        settings: VerifierSettings,
    );

    fn verify_proof_initial(
        self: @TContractState,
        job_id: felt252,
        stark_proof_serde: StarkProofWithSerde,
        cairo_version: CairoVersion,
        settings: VerifierSettings,
    ) -> InitResult;

    fn verify_proof_step(
        self: @TContractState,
        job_id: felt252,
        state_constant: FriVerificationStateConstant,
        state_variable: FriVerificationStateVariable,
        witness: FriLayerWitness,
        settings: VerifierSettings,
    ) -> (FriVerificationStateVariable, u32);

    fn verify_proof_final_and_register_fact(
        ref self: TContractState,
        job_id: felt252,
        state_constant: FriVerificationStateConstant,
        state_variable: FriVerificationStateVariable,
        last_layer_coefficients: Span<felt252>,   
        settings: VerifierSettings,
    );

    fn is_valid(self: @TContractState, fact: felt252) -> bool;
    fn get_verifier_address(self: @TContractState, settings: VerifierSettings) -> ContractAddress;
    fn register_verifier(ref self: TContractState, settings: VerifierSettings, address: ContractAddress);
    fn transfer_ownership(ref self: TContractState, new_owner: ContractAddress);
}

#[starknet::contract]
mod FactRegistry {
    use cairo_verifier::{
        StarkProofWithSerde, StarkProof, CairoVersion,
        verifier::{
            InitResult, ICairoVerifierDispatcher, ICairoVerifierDispatcherTrait
        },
        fri::fri::{FriLayerWitness, FriVerificationStateConstant, FriVerificationStateVariable},
    };
    use starknet::{ContractAddress, get_caller_address};
    use core::{
        poseidon::{Poseidon, PoseidonImpl, HashStateImpl}, keccak::keccak_u256s_be_inputs,
        starknet::event::EventEmitter
    };
    use super::{VerifierSettings, IFactRegistry};

    #[storage]
    struct Storage {
        owner: ContractAddress,
        verifiers: LegacyMap<felt252, ContractAddress>,
        facts: LegacyMap<felt252, bool>,
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        FactRegistered: FactRegistered,
        OwnershipTransferred: OwnershipTransferred,
        VerifierRegistered: VerifierRegistered,
    }

    #[derive(Drop, starknet::Event)]
    struct FactRegistered {
        #[key]
        fact: felt252,
        #[key]
        verifier_address: ContractAddress,
        #[key]
        security_bits: u32,
    }

    #[derive(Drop, starknet::Event)]
    struct VerifierRegistered {
        #[key]
        settings: VerifierSettings,
        #[key]
        address: ContractAddress,
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
        fn verify_proof_full_and_register_fact(
            ref self: ContractState,
            stark_proof: StarkProofWithSerde,
            cairo_version: CairoVersion,
            settings: VerifierSettings,
        ) {
            let verifier_address = self.get_verifier_address(settings);
            let (fact, security_bits) = ICairoVerifierDispatcher {
                contract_address: verifier_address
            }.verify_proof_full(stark_proof.into(), cairo_version);

            self.emit(Event::FactRegistered(FactRegistered { fact, verifier_address, security_bits }));
            self.facts.write(fact, true);
        }

        fn verify_proof_initial(
            self: @ContractState,
            job_id: felt252,
            stark_proof_serde: StarkProofWithSerde,
            cairo_version: CairoVersion,
            settings: VerifierSettings,
        ) -> InitResult {
            ICairoVerifierDispatcher {
                contract_address: self.get_verifier_address(settings)
            }.verify_proof_initial(job_id, stark_proof_serde, cairo_version)
        }

        fn verify_proof_step(
            self: @ContractState,
            job_id: felt252,
            state_constant: FriVerificationStateConstant,
            state_variable: FriVerificationStateVariable,
            witness: FriLayerWitness,
            settings: VerifierSettings,
        ) -> (FriVerificationStateVariable, u32) {
            ICairoVerifierDispatcher {
                contract_address: self.get_verifier_address(settings)
            }.verify_proof_step(job_id, state_constant, state_variable, witness)
        }

        fn verify_proof_final_and_register_fact(
            ref self: ContractState,
            job_id: felt252,
            state_constant: FriVerificationStateConstant,
            state_variable: FriVerificationStateVariable,
            last_layer_coefficients: Span<felt252>,
            settings: VerifierSettings,
        ) {
            let verifier_address = self.get_verifier_address(settings);
            assert(verifier_address.into() != 0, 'VERIFIER_NOT_FOUND');
            let (fact, security_bits) = ICairoVerifierDispatcher {
                contract_address: verifier_address
            }.verify_proof_final(job_id, state_constant, state_variable, last_layer_coefficients);

            self.emit(Event::FactRegistered(FactRegistered { fact, verifier_address, security_bits }));
            self.facts.write(fact, true);
        }

        fn is_valid(self: @ContractState, fact: felt252) -> bool {
            self.facts.read(fact)
        }

        fn get_verifier_address(self: @ContractState, settings: VerifierSettings) -> ContractAddress {
            let verifier_address = self.verifiers.read(self._hash_settings(settings));
            assert(verifier_address.into() != 0, 'VERIFIER_NOT_FOUND');
            verifier_address
        }

        fn register_verifier(ref self: ContractState, settings: VerifierSettings, address: ContractAddress) {
            assert(self.owner.read() == get_caller_address(), 'ONLY_OWNER');
            assert(address.into() != 0, 'INVALID_VERIFIER_ADDRESS');
            let settings_hash = self._hash_settings(settings);
            assert(self.verifiers.read(settings_hash).into() == 0, 'VERIFIER_ALREADY_EXISTS');
            self.verifiers.write(settings_hash, address);
            self.emit(Event::VerifierRegistered(VerifierRegistered {
                settings, address
            }));
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
        fn _hash_settings(self: @ContractState, settings: VerifierSettings) -> felt252 {
            PoseidonImpl::new()
                .update(settings.layout)
                .update(settings.hasher)
                .update(settings.version)
                .finalize()
        }
    }
}