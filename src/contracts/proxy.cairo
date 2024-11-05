use integrity::{
    StarkProofWithSerde, CairoVersion,
    fri::fri::{FriLayerWitness, FriVerificationStateConstant, FriVerificationStateVariable},
    contracts::{
        verifier::InitResult,
        fact_registry::{
            FactRegistered, VerifierConfiguration, VerificationListElement, Verification,
            VerifierPreset
        },
    },
    settings::{JobId, FactHash, VerificationHash},
};
use starknet::{ContractAddress, ClassHash};

#[starknet::interface]
trait IProxy<TContractState> {
    fn verify_proof_full_and_register_fact(
        ref self: TContractState,
        verifier_config: VerifierConfiguration,
        stark_proof: StarkProofWithSerde,
    ) -> FactRegistered;

    fn verify_proof_initial(
        ref self: TContractState,
        job_id: JobId,
        verifier_config: VerifierConfiguration,
        stark_proof: StarkProofWithSerde,
    ) -> InitResult;

    fn verify_proof_step(
        ref self: TContractState,
        job_id: JobId,
        state_constant: FriVerificationStateConstant,
        state_variable: FriVerificationStateVariable,
        witness: FriLayerWitness,
    ) -> (FriVerificationStateVariable, u32);

    fn verify_proof_final_and_register_fact(
        ref self: TContractState,
        job_id: JobId,
        state_constant: FriVerificationStateConstant,
        state_variable: FriVerificationStateVariable,
        last_layer_coefficients: Span<felt252>,
    ) -> FactRegistered;

    fn get_all_verifications_for_fact_hash(
        self: @TContractState, fact_hash: FactHash
    ) -> Array<VerificationListElement>;
    fn get_verification(
        self: @TContractState, verification_hash: VerificationHash
    ) -> Option<Verification>;

    fn get_verifier_address(self: @TContractState, preset: VerifierPreset) -> ContractAddress;
    fn register_verifier(
        ref self: TContractState, preset: VerifierPreset, address: ContractAddress
    );
    fn transfer_ownership(ref self: TContractState, new_owner: ContractAddress);

    fn set_fact_registry(ref self: TContractState, fact_registry: ContractAddress);
    fn replace_classhash(ref self: TContractState, classhash: ClassHash);
}

#[starknet::contract]
mod Proxy {
    use integrity::{
        contracts::{
            verifier::{InitResult, ICairoVerifierDispatcher, ICairoVerifierDispatcherTrait},
            fact_registry::{
                IFactRegistryExternalDispatcher, IFactRegistryExternalDispatcherTrait,
                FactRegistry::{VerifierRegistered, OwnershipTransferred}, VerifierSettings,
                VerifierConfiguration, FactRegistered, VerificationListElement, Verification,
                VerifierPreset
            },
            fact_registry_interface::{IFactRegistryDispatcher, IFactRegistryDispatcherTrait,}
        },
        StarkProofWithSerde, StarkProof, CairoVersion,
        fri::fri::{FriLayerWitness, FriVerificationStateConstant, FriVerificationStateVariable},
        settings::{JobId, FactHash, VerificationHash},
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
            ref self: ContractState,
            verifier_config: VerifierConfiguration,
            stark_proof: StarkProofWithSerde,
        ) -> FactRegistered {
            let fact = IFactRegistryExternalDispatcher {
                contract_address: self.fact_registry.read()
            }
                .verify_proof_full_and_register_fact(verifier_config, stark_proof);

            self.emit(fact);
            fact
        }

        fn verify_proof_initial(
            ref self: ContractState,
            job_id: JobId,
            verifier_config: VerifierConfiguration,
            stark_proof: StarkProofWithSerde,
        ) -> InitResult {
            IFactRegistryExternalDispatcher { contract_address: self.fact_registry.read() }
                .verify_proof_initial(job_id, verifier_config, stark_proof)
        }

        fn verify_proof_step(
            ref self: ContractState,
            job_id: JobId,
            state_constant: FriVerificationStateConstant,
            state_variable: FriVerificationStateVariable,
            witness: FriLayerWitness,
        ) -> (FriVerificationStateVariable, u32) {
            IFactRegistryExternalDispatcher { contract_address: self.fact_registry.read() }
                .verify_proof_step(job_id, state_constant, state_variable, witness)
        }

        fn verify_proof_final_and_register_fact(
            ref self: ContractState,
            job_id: JobId,
            state_constant: FriVerificationStateConstant,
            state_variable: FriVerificationStateVariable,
            last_layer_coefficients: Span<felt252>,
        ) -> FactRegistered {
            let fact = IFactRegistryExternalDispatcher {
                contract_address: self.fact_registry.read()
            }
                .verify_proof_final_and_register_fact(
                    job_id, state_constant, state_variable, last_layer_coefficients
                );

            self.emit(fact);
            fact
        }

        fn get_all_verifications_for_fact_hash(
            self: @ContractState, fact_hash: FactHash
        ) -> Array<VerificationListElement> {
            IFactRegistryDispatcher { contract_address: self.fact_registry.read() }
                .get_all_verifications_for_fact_hash(fact_hash)
        }

        fn get_verification(
            self: @ContractState, verification_hash: VerificationHash
        ) -> Option<Verification> {
            IFactRegistryDispatcher { contract_address: self.fact_registry.read() }
                .get_verification(verification_hash)
        }

        fn get_verifier_address(self: @ContractState, preset: VerifierPreset) -> ContractAddress {
            IFactRegistryDispatcher { contract_address: self.fact_registry.read() }
                .get_verifier_address(preset)
        }

        fn register_verifier(
            ref self: ContractState, preset: VerifierPreset, address: ContractAddress
        ) {
            IFactRegistryExternalDispatcher { contract_address: self.fact_registry.read() }
                .register_verifier(preset, address);
            self.emit(Event::VerifierRegistered(VerifierRegistered { address, preset }));
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
