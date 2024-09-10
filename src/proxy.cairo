use cairo_verifier::{
    StarkProofWithSerde, CairoVersion,
    fri::fri::{FriLayerWitness, FriVerificationStateConstant, FriVerificationStateVariable},
    verifier::InitResult, fact_registry::{FactRegistered, VerifierSettings},
};
use starknet::{ContractAddress, ClassHash};

fn settings_to_struct(tuple: (felt252, felt252, felt252)) -> VerifierSettings {
    let (layout, hasher, version) = tuple;
    VerifierSettings { layout, hasher, version }
}

fn settings_from_struct(settings: VerifierSettings) -> (felt252, felt252, felt252) {
    (settings.layout, settings.hasher, settings.version)
}

#[starknet::interface]
trait IProxy<TContractState> {
    fn verify_proof_full_and_register_fact(
        ref self: TContractState,
        stark_proof: StarkProofWithSerde,
        cairo_version: CairoVersion,
        settings: VerifierSettings,
    ) -> FactRegistered;

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
    ) -> FactRegistered;

    fn get_all_verifications_for_fact_hash(
        self: @TContractState, fact_hash: felt252
    ) -> Array<(felt252, u32, VerifierSettings)>;
    fn is_verification_hash_registered(self: @TContractState, verification_hash: felt252) -> bool;

    fn get_verifier_address(self: @TContractState, settings: VerifierSettings) -> ContractAddress;
    fn register_verifier(
        ref self: TContractState, settings: VerifierSettings, address: ContractAddress
    );
    fn transfer_ownership(ref self: TContractState, new_owner: ContractAddress);

    fn set_fact_registry(ref self: TContractState, fact_registry: ContractAddress);
    fn replace_classhash(ref self: TContractState, classhash: ClassHash);
}

#[starknet::contract]
mod Proxy {
    use cairo_verifier::{
        fact_registry::{
            IFactRegistryDispatcher, IFactRegistryDispatcherTrait,
            FactRegistry::{VerifierRegistered, OwnershipTransferred},
        },
        StarkProofWithSerde, StarkProof, CairoVersion,
        verifier::{InitResult, ICairoVerifierDispatcher, ICairoVerifierDispatcherTrait},
        fri::fri::{FriLayerWitness, FriVerificationStateConstant, FriVerificationStateVariable},
    };
    use starknet::{ContractAddress, ClassHash, get_caller_address, syscalls};
    use core::{
        poseidon::{Poseidon, PoseidonImpl, HashStateImpl}, keccak::keccak_u256s_be_inputs,
        starknet::event::EventEmitter
    };
    use super::{VerifierSettings, IProxy, FactRegistered, settings_from_struct, settings_to_struct};

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        FactRegistered: FactRegistered,
        OwnershipTransferred: OwnershipTransferred,
        VerifierRegistered: VerifierRegistered,
    }

    #[storage]
    struct Storage {
        owner: ContractAddress,
        fact_registry: ContractAddress,
    }

    #[constructor]
    fn constructor(ref self: ContractState, owner: ContractAddress) {
        self.owner.write(owner);
    }

    #[abi(embed_v0)]
    impl Proxy of IProxy<ContractState> {
        fn verify_proof_full_and_register_fact(
            ref self: ContractState,
            stark_proof: StarkProofWithSerde,
            cairo_version: CairoVersion,
            settings: VerifierSettings,
        ) -> FactRegistered {
            let fact = IFactRegistryDispatcher { contract_address: self.fact_registry.read() }
                .verify_proof_full_and_register_fact(stark_proof, cairo_version, settings);

            self.emit(fact);
            fact
        }

        fn verify_proof_initial(
            self: @ContractState,
            job_id: felt252,
            stark_proof_serde: StarkProofWithSerde,
            cairo_version: CairoVersion,
            settings: VerifierSettings,
        ) -> InitResult {
            IFactRegistryDispatcher { contract_address: self.fact_registry.read() }
                .verify_proof_initial(job_id, stark_proof_serde, cairo_version, settings)
        }

        fn verify_proof_step(
            self: @ContractState,
            job_id: felt252,
            state_constant: FriVerificationStateConstant,
            state_variable: FriVerificationStateVariable,
            witness: FriLayerWitness,
            settings: VerifierSettings,
        ) -> (FriVerificationStateVariable, u32) {
            IFactRegistryDispatcher { contract_address: self.fact_registry.read() }
                .verify_proof_step(job_id, state_constant, state_variable, witness, settings)
        }

        fn verify_proof_final_and_register_fact(
            ref self: ContractState,
            job_id: felt252,
            state_constant: FriVerificationStateConstant,
            state_variable: FriVerificationStateVariable,
            last_layer_coefficients: Span<felt252>,
            settings: VerifierSettings,
        ) -> FactRegistered {
            let fact = IFactRegistryDispatcher { contract_address: self.fact_registry.read() }
                .verify_proof_final_and_register_fact(
                    job_id, state_constant, state_variable, last_layer_coefficients, settings
                );

            self.emit(fact);
            fact
        }

        fn get_all_verifications_for_fact_hash(
            self: @ContractState, fact_hash: felt252
        ) -> Array<(felt252, u32, VerifierSettings)> {
            IFactRegistryDispatcher { contract_address: self.fact_registry.read() }
                .get_all_verifications_for_fact_hash(fact_hash)
        }

        fn is_verification_hash_registered(
            self: @ContractState, verification_hash: felt252
        ) -> bool {
            IFactRegistryDispatcher { contract_address: self.fact_registry.read() }
                .is_verification_hash_registered(verification_hash)
        }

        fn get_verifier_address(
            self: @ContractState, settings: VerifierSettings
        ) -> ContractAddress {
            IFactRegistryDispatcher { contract_address: self.fact_registry.read() }
                .get_verifier_address(settings)
        }

        fn register_verifier(
            ref self: ContractState, settings: VerifierSettings, address: ContractAddress
        ) {
            IFactRegistryDispatcher { contract_address: self.fact_registry.read() }
                .register_verifier(settings, address);
            self.emit(Event::VerifierRegistered(VerifierRegistered { settings, address }));
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

        fn set_fact_registry(ref self: ContractState, fact_registry: ContractAddress) {
            assert(self.owner.read() == get_caller_address(), 'ONLY_OWNER');
            self.fact_registry.write(fact_registry);
        }

        fn replace_classhash(ref self: ContractState, classhash: ClassHash) {
            assert(self.owner.read() == get_caller_address(), 'ONLY_OWNER');
            syscalls::replace_class_syscall(classhash).unwrap();
        }
    }
}
