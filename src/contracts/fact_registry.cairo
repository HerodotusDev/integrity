use integrity::{
    StarkProofWithSerde,
    fri::fri::{FriLayerWitness, FriVerificationStateConstant, FriVerificationStateVariable},
    contracts::{
        fact_registry_interface::{VerificationListElement, Verification}, verifier::InitResult,
    },
    settings::{
        VerifierSettings, VerificationHash, HasherBitLength, StoneVersion, CairoVersion,
        SecurityBits, FactHash, JobId, VerifierConfiguration, VerifierPreset,
    },
};
use starknet::ContractAddress;


#[derive(Drop, Copy, Serde, starknet::Event)]
struct FactRegistered {
    #[key]
    fact_hash: FactHash,
    #[key]
    verifier_address: ContractAddress,
    #[key]
    security_bits: SecurityBits,
    #[key]
    verifier_config: VerifierConfiguration,
    #[key]
    verification_hash: VerificationHash,
}

#[starknet::interface]
trait IFactRegistryExternal<TContractState> {
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

    fn register_verifier(
        ref self: TContractState, preset: VerifierPreset, address: ContractAddress
    );

    fn transfer_ownership(ref self: TContractState, new_owner: ContractAddress);
}

#[starknet::contract]
mod FactRegistry {
    use integrity::{
        StarkProofWithSerde, StarkProof, CairoVersion,
        contracts::verifier::{InitResult, ICairoVerifierDispatcher, ICairoVerifierDispatcherTrait},
        fri::fri::{FriLayerWitness, FriVerificationStateConstant, FriVerificationStateVariable},
        settings::{
            VerifierPreset, VerifierConfiguration, split_settings, JobId, FactHash,
            VerificationHash, PresetHash, SecurityBits,
        },
        contracts::{
            fact_registry::{
                VerificationListElement, Verification, IFactRegistryExternal, FactRegistered
            },
            fact_registry_interface::IFactRegistry,
        }
    };
    use starknet::{
        ContractAddress, get_caller_address,
        storage::{
            StoragePointerReadAccess, StoragePointerWriteAccess, StoragePathEntry, Map, Vec,
            VecTrait, MutableVecTrait
        },
    };
    use core::{
        poseidon::{Poseidon, PoseidonImpl, HashStateImpl}, keccak::keccak_u256s_be_inputs,
        starknet::event::EventEmitter,
    };

    #[storage]
    struct Storage {
        owner: ContractAddress,
        verifiers: Map<PresetHash, ContractAddress>,
        fact_verifications: Map<FactHash, Vec<VerificationHash>>,
        verification_hashes: Map<VerificationHash, Option<Verification>>,
        verifier_configs: Map<JobId, Option<VerifierConfiguration>>,
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
        address: ContractAddress,
        #[key]
        preset: VerifierPreset,
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
    impl FactRegistryExternalImpl of IFactRegistryExternal<ContractState> {
        fn verify_proof_full_and_register_fact(
            ref self: ContractState,
            verifier_config: VerifierConfiguration,
            stark_proof: StarkProofWithSerde,
        ) -> FactRegistered {
            let (verifier_settings, verifier_preset) = split_settings(verifier_config);

            let verifier_address = self.get_verifier_address(verifier_preset);
            let result = ICairoVerifierDispatcher { contract_address: verifier_address }
                .verify_proof_full(verifier_settings, stark_proof.into());

            self
                ._register_fact(
                    result.fact, verifier_address, result.security_bits, verifier_config
                )
        }

        fn verify_proof_initial(
            ref self: ContractState,
            job_id: JobId,
            verifier_config: VerifierConfiguration,
            stark_proof: StarkProofWithSerde,
        ) -> InitResult {
            self.verifier_configs.entry(job_id).write(Option::Some(verifier_config));
            let (verifier_settings, verifier_preset) = split_settings(verifier_config);
            ICairoVerifierDispatcher {
                contract_address: self.get_verifier_address(verifier_preset)
            }
                .verify_proof_initial(job_id, verifier_settings, stark_proof)
        }

        fn verify_proof_step(
            ref self: ContractState,
            job_id: JobId,
            state_constant: FriVerificationStateConstant,
            state_variable: FriVerificationStateVariable,
            witness: FriLayerWitness,
        ) -> (FriVerificationStateVariable, u32) {
            let verifier_config = self
                .verifier_configs
                .entry(job_id)
                .read()
                .expect('Job id not found');
            let (_, verifier_preset) = split_settings(verifier_config);
            let verifier_address = self.get_verifier_address(verifier_preset);
            ICairoVerifierDispatcher { contract_address: verifier_address }
                .verify_proof_step(job_id, state_constant, state_variable, witness)
        }

        fn verify_proof_final_and_register_fact(
            ref self: ContractState,
            job_id: JobId,
            state_constant: FriVerificationStateConstant,
            state_variable: FriVerificationStateVariable,
            last_layer_coefficients: Span<felt252>,
        ) -> FactRegistered {
            let verifier_config = self
                .verifier_configs
                .entry(job_id)
                .read()
                .expect('Job id not found');
            let (_, verifier_preset) = split_settings(verifier_config);
            let verifier_address = self.get_verifier_address(verifier_preset);
            let result = ICairoVerifierDispatcher { contract_address: verifier_address }
                .verify_proof_final(
                    job_id, state_constant, state_variable, last_layer_coefficients
                );

            self
                ._register_fact(
                    result.fact, verifier_address, result.security_bits, verifier_config
                )
        }

        fn register_verifier(
            ref self: ContractState, preset: VerifierPreset, address: ContractAddress
        ) {
            assert(self.owner.read() == get_caller_address(), 'ONLY_OWNER');
            assert(address.into() != 0, 'INVALID_VERIFIER_ADDRESS');
            let preset_hash = self._hash_preset(preset);
            assert(self.verifiers.entry(preset_hash).read().into() == 0, 'VERIFIER_ALREADY_EXISTS');
            self.verifiers.entry(preset_hash).write(address);
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
    }

    impl FactRegistryImpl of IFactRegistry<ContractState> {
        fn get_all_verifications_for_fact_hash(
            self: @ContractState, fact_hash: FactHash
        ) -> Array<VerificationListElement> {
            let verifications = self.fact_verifications.entry(fact_hash);
            let n = verifications.len();
            let mut i = 0;
            let mut arr = array![];
            loop {
                if i == n {
                    break;
                }
                let verification_hash = verifications.at(i).read();
                let verification = self
                    .verification_hashes
                    .entry(verification_hash)
                    .read()
                    .unwrap();
                arr
                    .append(
                        VerificationListElement {
                            verification_hash,
                            security_bits: verification.security_bits,
                            verifier_config: verification.verifier_config
                        }
                    );
                i += 1;
            };
            arr
        }

        fn get_verification(
            self: @ContractState, verification_hash: VerificationHash
        ) -> Option<Verification> {
            self.verification_hashes.entry(verification_hash).read()
        }

        fn get_verifier_address(self: @ContractState, preset: VerifierPreset) -> ContractAddress {
            let verifier_address = self.verifiers.entry(self._hash_preset(preset)).read();
            assert(verifier_address.into() != 0, 'VERIFIER_NOT_FOUND');
            verifier_address
        }
    }

    #[generate_trait]
    impl InternalFactRegistry of InternalFactRegistryTrait {
        fn _hash_preset(self: @ContractState, preset: VerifierPreset) -> PresetHash {
            PoseidonImpl::new().update(preset.layout).update(preset.hasher).finalize()
        }

        fn _register_fact(
            ref self: ContractState,
            fact_hash: FactHash,
            verifier_address: ContractAddress,
            security_bits: SecurityBits,
            verifier_config: VerifierConfiguration,
        ) -> FactRegistered {
            let verifier_config_hash = PoseidonImpl::new()
                .update(verifier_config.layout)
                .update(verifier_config.hasher)
                .update(verifier_config.stone_version)
                .update(verifier_config.cairo_version)
                .finalize();

            let verification_hash = PoseidonImpl::new()
                .update(fact_hash)
                .update(verifier_config_hash)
                .update(security_bits.into())
                .finalize();

            let event = FactRegistered {
                fact_hash, verifier_address, security_bits, verifier_config, verification_hash
            };
            self.emit(Event::FactRegistered(event));

            let verification_hash_entry = self.verification_hashes.entry(verification_hash);
            if verification_hash_entry.read().is_none() {
                self.fact_verifications.entry(fact_hash).append().write(verification_hash);
                verification_hash_entry
                    .write(
                        Option::Some(Verification { fact_hash, security_bits, verifier_config })
                    );
            }
            event
        }
    }
}
