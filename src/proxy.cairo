use cairo_verifier::{
    StarkProofWithSerde, CairoVersion,
    fri::fri::{FriLayerWitness, FriVerificationStateConstant, FriVerificationStateVariable},
    verifier::InitResult,
    fact_registry::{
        FactRegistered, Configuration, VerificationListElement, Verification, VerifierProperties
    },
};
use starknet::{ContractAddress, ClassHash};

#[starknet::interface]
trait IProxy<TContractState> {
    fn verify_proof_full_and_register_fact(
        ref self: TContractState, settings: Configuration, stark_proof: StarkProofWithSerde,
    ) -> FactRegistered;

    fn verify_proof_initial(
        ref self: TContractState,
        job_id: felt252,
        settings: Configuration,
        stark_proof: StarkProofWithSerde,
    ) -> InitResult;

    fn verify_proof_step(
        ref self: TContractState,
        job_id: felt252,
        state_constant: FriVerificationStateConstant,
        state_variable: FriVerificationStateVariable,
        witness: FriLayerWitness,
    ) -> (FriVerificationStateVariable, u32);

    fn verify_proof_final_and_register_fact(
        ref self: TContractState,
        job_id: felt252,
        state_constant: FriVerificationStateConstant,
        state_variable: FriVerificationStateVariable,
        last_layer_coefficients: Span<felt252>,
    ) -> FactRegistered;

    fn get_all_verifications_for_fact_hash(
        self: @TContractState, fact_hash: felt252
    ) -> Array<VerificationListElement>;
    fn get_verification(self: @TContractState, verification_hash: felt252) -> Option<Verification>;

    fn get_verifier_address(self: @TContractState, version: VerifierProperties) -> ContractAddress;
    fn register_verifier(
        ref self: TContractState, version: VerifierProperties, address: ContractAddress
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
            FactRegistry::{VerifierRegistered, OwnershipTransferred}, VerifierSettings,
            Configuration, FactRegistered, VerificationListElement, Verification, VerifierProperties
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
    use super::IProxy;

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
            ref self: ContractState, settings: Configuration, stark_proof: StarkProofWithSerde,
        ) -> FactRegistered {
            let fact = IFactRegistryDispatcher { contract_address: self.fact_registry.read() }
                .verify_proof_full_and_register_fact(settings, stark_proof);

            self.emit(fact);
            fact
        }

        fn verify_proof_initial(
            ref self: ContractState,
            job_id: felt252,
            settings: Configuration,
            stark_proof: StarkProofWithSerde,
        ) -> InitResult {
            IFactRegistryDispatcher { contract_address: self.fact_registry.read() }
                .verify_proof_initial(job_id, settings, stark_proof)
        }

        fn verify_proof_step(
            ref self: ContractState,
            job_id: felt252,
            state_constant: FriVerificationStateConstant,
            state_variable: FriVerificationStateVariable,
            witness: FriLayerWitness,
        ) -> (FriVerificationStateVariable, u32) {
            IFactRegistryDispatcher { contract_address: self.fact_registry.read() }
                .verify_proof_step(job_id, state_constant, state_variable, witness)
        }

        fn verify_proof_final_and_register_fact(
            ref self: ContractState,
            job_id: felt252,
            state_constant: FriVerificationStateConstant,
            state_variable: FriVerificationStateVariable,
            last_layer_coefficients: Span<felt252>,
        ) -> FactRegistered {
            let fact = IFactRegistryDispatcher { contract_address: self.fact_registry.read() }
                .verify_proof_final_and_register_fact(
                    job_id, state_constant, state_variable, last_layer_coefficients
                );

            self.emit(fact);
            fact
        }

        fn get_all_verifications_for_fact_hash(
            self: @ContractState, fact_hash: felt252
        ) -> Array<VerificationListElement> {
            IFactRegistryDispatcher { contract_address: self.fact_registry.read() }
                .get_all_verifications_for_fact_hash(fact_hash)
        }

        fn get_verification(
            self: @ContractState, verification_hash: felt252
        ) -> Option<Verification> {
            IFactRegistryDispatcher { contract_address: self.fact_registry.read() }
                .get_verification(verification_hash)
        }

        fn get_verifier_address(
            self: @ContractState, version: VerifierProperties
        ) -> ContractAddress {
            IFactRegistryDispatcher { contract_address: self.fact_registry.read() }
                .get_verifier_address(version)
        }

        fn register_verifier(
            ref self: ContractState, version: VerifierProperties, address: ContractAddress
        ) {
            IFactRegistryDispatcher { contract_address: self.fact_registry.read() }
                .register_verifier(version, address);
            self.emit(Event::VerifierRegistered(VerifierRegistered { version, address }));
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
