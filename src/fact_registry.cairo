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

fn settings_to_struct(tuple: (felt252, felt252, felt252)) -> VerifierSettings {
    let (layout, hasher, version) = tuple;
    VerifierSettings { layout, hasher, version }
}

fn settings_from_struct(settings: VerifierSettings) -> (felt252, felt252, felt252) {
    (settings.layout, settings.hasher, settings.version)
}

#[derive(Drop, Copy, Serde, starknet::Event)]
struct FactRegistered {
    #[key]
    fact_hash: felt252,
    #[key]
    verifier_address: ContractAddress,
    #[key]
    security_bits: u32,
    #[key]
    settings: VerifierSettings,
    #[key]
    verification_hash: felt252,
}

#[starknet::interface]
trait IFactRegistry<TContractState> {
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
}

#[starknet::contract]
mod FactRegistry {
    use cairo_verifier::{
        StarkProofWithSerde, StarkProof, CairoVersion,
        verifier::{InitResult, ICairoVerifierDispatcher, ICairoVerifierDispatcherTrait},
        fri::fri::{FriLayerWitness, FriVerificationStateConstant, FriVerificationStateVariable},
    };
    use starknet::{ContractAddress, get_caller_address};
    use core::{
        poseidon::{Poseidon, PoseidonImpl, HashStateImpl}, keccak::keccak_u256s_be_inputs,
        starknet::event::EventEmitter
    };
    use super::{
        VerifierSettings, IFactRegistry, FactRegistered, settings_from_struct, settings_to_struct
    };

    #[storage]
    struct Storage {
        owner: ContractAddress,
        verifiers: LegacyMap<felt252, ContractAddress>,
        facts: LegacyMap<felt252, u32>, // fact_hash => number of verifications registered
        fact_verifications: LegacyMap<
            (felt252, u32), felt252
        >, // fact_hash, index => verification_hash
        verification_hashes: LegacyMap<
            felt252, Option<(felt252, u32, (felt252, felt252, felt252))>
        >, // verification_hash => (fact_hash, security_bits, settings)
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        FactRegistered: FactRegistered,
        OwnershipTransferred: OwnershipTransferred,
        VerifierRegistered: VerifierRegistered,
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
        ) -> FactRegistered {
            let verifier_address = self.get_verifier_address(settings);
            let (fact_hash, security_bits) = ICairoVerifierDispatcher {
                contract_address: verifier_address
            }
                .verify_proof_full(stark_proof.into(), cairo_version);

            self._register_fact(fact_hash, verifier_address, security_bits, settings)
        }

        fn verify_proof_initial(
            self: @ContractState,
            job_id: felt252,
            stark_proof_serde: StarkProofWithSerde,
            cairo_version: CairoVersion,
            settings: VerifierSettings,
        ) -> InitResult {
            ICairoVerifierDispatcher { contract_address: self.get_verifier_address(settings) }
                .verify_proof_initial(job_id, stark_proof_serde, cairo_version)
        }

        fn verify_proof_step(
            self: @ContractState,
            job_id: felt252,
            state_constant: FriVerificationStateConstant,
            state_variable: FriVerificationStateVariable,
            witness: FriLayerWitness,
            settings: VerifierSettings,
        ) -> (FriVerificationStateVariable, u32) {
            ICairoVerifierDispatcher { contract_address: self.get_verifier_address(settings) }
                .verify_proof_step(job_id, state_constant, state_variable, witness)
        }

        fn verify_proof_final_and_register_fact(
            ref self: ContractState,
            job_id: felt252,
            state_constant: FriVerificationStateConstant,
            state_variable: FriVerificationStateVariable,
            last_layer_coefficients: Span<felt252>,
            settings: VerifierSettings,
        ) -> FactRegistered {
            let verifier_address = self.get_verifier_address(settings);
            assert(verifier_address.into() != 0, 'VERIFIER_NOT_FOUND');
            let (fact_hash, security_bits) = ICairoVerifierDispatcher {
                contract_address: verifier_address
            }
                .verify_proof_final(
                    job_id, state_constant, state_variable, last_layer_coefficients
                );

            self._register_fact(fact_hash, verifier_address, security_bits, settings)
        }

        fn get_all_verifications_for_fact_hash(
            self: @ContractState, fact_hash: felt252
        ) -> Array<(felt252, u32, VerifierSettings)> {
            let n = self.facts.read(fact_hash);
            let mut i = 0;
            let mut arr = array![];
            loop {
                if i == n {
                    break;
                }
                let verification_hash = self.fact_verifications.read((fact_hash, i));
                let (_, security_bits, settings_tuple) = self
                    .verification_hashes
                    .read(verification_hash)
                    .unwrap();
                let settings = settings_to_struct(settings_tuple);
                arr.append((verification_hash, security_bits, settings));
                i += 1;
            };
            arr
        }

        fn is_verification_hash_registered(
            self: @ContractState, verification_hash: felt252
        ) -> bool {
            self.verification_hashes.read(verification_hash).is_some()
        }

        fn get_verifier_address(
            self: @ContractState, settings: VerifierSettings
        ) -> ContractAddress {
            let verifier_address = self.verifiers.read(self._hash_settings(settings));
            assert(verifier_address.into() != 0, 'VERIFIER_NOT_FOUND');
            verifier_address
        }

        fn register_verifier(
            ref self: ContractState, settings: VerifierSettings, address: ContractAddress
        ) {
            assert(self.owner.read() == get_caller_address(), 'ONLY_OWNER');
            assert(address.into() != 0, 'INVALID_VERIFIER_ADDRESS');
            let settings_hash = self._hash_settings(settings);
            assert(self.verifiers.read(settings_hash).into() == 0, 'VERIFIER_ALREADY_EXISTS');
            self.verifiers.write(settings_hash, address);
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

        fn _register_fact(
            ref self: ContractState,
            fact_hash: felt252,
            verifier_address: ContractAddress,
            security_bits: u32,
            settings: VerifierSettings
        ) -> FactRegistered {
            let settings_hash = self._hash_settings(settings);
            let verification_hash = PoseidonImpl::new()
                .update(fact_hash)
                .update(settings_hash)
                .update(security_bits.into())
                .finalize();

            let event = FactRegistered {
                fact_hash, verifier_address, security_bits, settings, verification_hash
            };
            self.emit(Event::FactRegistered(event));

            if self.verification_hashes.read(verification_hash).is_none() {
                let next_index = self.facts.read(fact_hash);
                self.fact_verifications.write((fact_hash, next_index), verification_hash);
                self
                    .verification_hashes
                    .write(
                        verification_hash,
                        Option::Some((fact_hash, security_bits, settings_from_struct(settings)))
                    );
                self.facts.write(fact_hash, next_index + 1);
            }
            event
        }
    }
}
