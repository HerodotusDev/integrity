use cairo_verifier::{
    StarkProofWithSerde,
    fri::fri::{FriLayerWitness, FriVerificationStateConstant, FriVerificationStateVariable},
    verifier::InitResult, settings::{VerifierSettings, HasherBitLength, StoneVersion, CairoVersion},
};
use starknet::ContractAddress;

// preset that identify the verifier (hardcoded in verifier)
#[derive(Drop, Copy, Serde)]
struct VerifierPreset {
    layout: felt252,
    hasher: felt252,
}

// both preset and settings merged together
#[derive(Drop, Copy, Serde)]
struct VerifierConfiguration {
    layout: felt252, // string encoded as hex
    hasher: felt252, // function and number of bits
    stone_version: felt252, // stone5 or stone6
    cairo_version: felt252, // cairo0 or cairo1
}

fn verifier_configuration_to_tuple(
    verifier_config: VerifierConfiguration
) -> (felt252, felt252, felt252, felt252) {
    (
        verifier_config.layout,
        verifier_config.hasher,
        verifier_config.stone_version,
        verifier_config.cairo_version,
    )
}

fn verifier_configuration_from_tuple(
    tuple: (felt252, felt252, felt252, felt252)
) -> VerifierConfiguration {
    let (layout, hasher, stone_version, cairo_version) = tuple;
    VerifierConfiguration { layout, hasher, stone_version, cairo_version, }
}

fn split_settings(verifier_config: VerifierConfiguration) -> (VerifierSettings, VerifierPreset) {
    let layout = verifier_config.layout;

    let cairo_version = if verifier_config.cairo_version == 'cairo0' {
        CairoVersion::Cairo0
    } else {
        assert(verifier_config.cairo_version == 'cairo1', 'Unsupported variant');
        CairoVersion::Cairo1
    };

    let (hasher, hasher_bit_length) = if verifier_config.hasher == 'keccak_160_lsb' {
        ('keccak', HasherBitLength::Lsb160)
    } else if verifier_config.hasher == 'keccak_248_lsb' {
        ('keccak', HasherBitLength::Lsb248)
    } else if verifier_config.hasher == 'blake2s_160_lsb' {
        ('blake2s', HasherBitLength::Lsb248)
    } else {
        assert(verifier_config.hasher == 'blake2s_248_lsb', 'Unsupported variant');
        ('blake2s', HasherBitLength::Lsb248)
    };

    let stone_version = if verifier_config.stone_version == 'stone5' {
        StoneVersion::Stone5
    } else {
        assert(verifier_config.stone_version == 'stone6', 'Unsupported variant');
        StoneVersion::Stone6
    };

    (
        VerifierSettings { cairo_version, hasher_bit_length, stone_version },
        VerifierPreset { layout, hasher }
    )
}

#[derive(Drop, Copy, Serde)]
struct VerificationListElement {
    verification_hash: felt252,
    security_bits: u32,
    verifier_config: VerifierConfiguration,
}

#[derive(Drop, Copy, Serde)]
struct Verification {
    fact_hash: felt252,
    security_bits: u32,
    verifier_config: VerifierConfiguration,
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
    verifier_config: VerifierConfiguration,
    #[key]
    verification_hash: felt252,
}

#[starknet::interface]
trait IFactRegistry<TContractState> {
    fn verify_proof_full_and_register_fact(
        ref self: TContractState,
        stark_proof: StarkProofWithSerde,
        verifier_config: VerifierConfiguration,
    ) -> FactRegistered;

    fn verify_proof_initial(
        ref self: TContractState,
        job_id: felt252,
        stark_proof: StarkProofWithSerde,
        verifier_config: VerifierConfiguration,
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

    fn get_verifier_address(self: @TContractState, preset: VerifierPreset) -> ContractAddress;
    fn register_verifier(
        ref self: TContractState, address: ContractAddress, preset: VerifierPreset
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
    use starknet::{
        ContractAddress, get_caller_address,
        storage::{StoragePointerReadAccess, StoragePointerWriteAccess, StoragePathEntry, Map},
    };
    use core::{
        poseidon::{Poseidon, PoseidonImpl, HashStateImpl}, keccak::keccak_u256s_be_inputs,
        starknet::event::EventEmitter
    };
    use super::{
        VerifierPreset, VerificationListElement, Verification, IFactRegistry, FactRegistered,
        VerifierConfiguration, split_settings, verifier_configuration_from_tuple,
        verifier_configuration_to_tuple
    };

    #[storage]
    struct Storage {
        owner: ContractAddress,
        verifiers: Map<felt252, ContractAddress>,
        facts: Map<felt252, u32>, // fact_hash => number of verifications registered
        fact_verifications: Map<(felt252, u32), felt252>, // fact_hash, index => verification_hash
        verification_hashes: Map<
            felt252, Option<(felt252, u32, (felt252, felt252, felt252, felt252))>
        >, // verification_hash => (fact_hash, security_bits, VerifierConfiguration)
        verifier_configs: Map<
            felt252, Option<(felt252, felt252, felt252, felt252)>
        >, // job_id => VerifierConfiguration
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
    impl FactRegistryImpl of IFactRegistry<ContractState> {
        fn verify_proof_full_and_register_fact(
            ref self: ContractState,
            stark_proof: StarkProofWithSerde,
            verifier_config: VerifierConfiguration,
        ) -> FactRegistered {
            let (verifier_settings, verifier_preset) = split_settings(verifier_config);

            let verifier_address = self.get_verifier_address(verifier_preset);
            let result = ICairoVerifierDispatcher { contract_address: verifier_address }
                .verify_proof_full(stark_proof.into(), verifier_settings);

            self
                ._register_fact(
                    result.fact, verifier_address, result.security_bits, verifier_config
                )
        }

        fn verify_proof_initial(
            ref self: ContractState,
            job_id: felt252,
            stark_proof: StarkProofWithSerde,
            verifier_config: VerifierConfiguration,
        ) -> InitResult {
            self
                .verifier_configs
                .entry(job_id)
                .write(Option::Some(verifier_configuration_to_tuple(verifier_config)));
            let (verifier_settings, verifier_preset) = split_settings(verifier_config);
            ICairoVerifierDispatcher {
                contract_address: self.get_verifier_address(verifier_preset)
            }
                .verify_proof_initial(job_id, stark_proof, verifier_settings)
        }

        fn verify_proof_step(
            ref self: ContractState,
            job_id: felt252,
            state_constant: FriVerificationStateConstant,
            state_variable: FriVerificationStateVariable,
            witness: FriLayerWitness,
        ) -> (FriVerificationStateVariable, u32) {
            let verifier_config = verifier_configuration_from_tuple(
                self.verifier_configs.entry(job_id).read().expect('Job id not found')
            );
            let (_, verifier_preset) = split_settings(verifier_config);
            let verifier_address = self.get_verifier_address(verifier_preset);
            ICairoVerifierDispatcher { contract_address: verifier_address }
                .verify_proof_step(job_id, state_constant, state_variable, witness)
        }

        fn verify_proof_final_and_register_fact(
            ref self: ContractState,
            job_id: felt252,
            state_constant: FriVerificationStateConstant,
            state_variable: FriVerificationStateVariable,
            last_layer_coefficients: Span<felt252>,
        ) -> FactRegistered {
            let verifier_config = verifier_configuration_from_tuple(
                self.verifier_configs.entry(job_id).read().expect('Job id not found')
            );
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

        fn get_all_verifications_for_fact_hash(
            self: @ContractState, fact_hash: felt252
        ) -> Array<VerificationListElement> {
            let n = self.facts.entry(fact_hash).read();
            let mut i = 0;
            let mut arr = array![];
            loop {
                if i == n {
                    break;
                }
                let verification_hash = self.fact_verifications.entry((fact_hash, i)).read();
                let (_, security_bits, verifier_config_tuple) = self
                    .verification_hashes
                    .entry(verification_hash)
                    .read()
                    .unwrap();
                let verifier_config = verifier_configuration_from_tuple(verifier_config_tuple);
                arr
                    .append(
                        VerificationListElement {
                            verification_hash, security_bits, verifier_config
                        }
                    );
                i += 1;
            };
            arr
        }

        fn get_verification(
            self: @ContractState, verification_hash: felt252
        ) -> Option<Verification> {
            match self.verification_hashes.entry(verification_hash).read() {
                Option::Some(x) => {
                    let (fact_hash, security_bits, verifier_config_tuple) = x;
                    let verifier_config = verifier_configuration_from_tuple(verifier_config_tuple);
                    Option::Some(Verification { fact_hash, security_bits, verifier_config })
                },
                Option::None => { Option::None }
            }
        }

        fn get_verifier_address(self: @ContractState, preset: VerifierPreset) -> ContractAddress {
            let verifier_address = self.verifiers.entry(self._hash_preset(preset)).read();
            assert(verifier_address.into() != 0, 'VERIFIER_NOT_FOUND');
            verifier_address
        }

        fn register_verifier(
            ref self: ContractState, address: ContractAddress, preset: VerifierPreset
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

    #[generate_trait]
    impl InternalFactRegistry of InternalFactRegistryTrait {
        fn _hash_configuration(self: @ContractState, config: VerifierConfiguration) -> felt252 {
            PoseidonImpl::new()
                .update(config.layout)
                .update(config.hasher)
                .update(config.stone_version)
                .update(config.cairo_version)
                .finalize()
        }

        fn _hash_preset(self: @ContractState, preset: VerifierPreset) -> felt252 {
            PoseidonImpl::new().update(preset.layout).update(preset.hasher).finalize()
        }

        fn _register_fact(
            ref self: ContractState,
            fact_hash: felt252,
            verifier_address: ContractAddress,
            security_bits: u32,
            verifier_config: VerifierConfiguration,
        ) -> FactRegistered {
            let verifier_config_hash = self._hash_configuration(verifier_config);
            let verification_hash = PoseidonImpl::new()
                .update(fact_hash)
                .update(verifier_config_hash)
                .update(security_bits.into())
                .finalize();

            let event = FactRegistered {
                fact_hash, verifier_address, security_bits, verifier_config, verification_hash
            };
            self.emit(Event::FactRegistered(event));

            if self.verification_hashes.entry(verification_hash).read().is_none() {
                let next_index = self.facts.entry(fact_hash).read();
                self.fact_verifications.entry((fact_hash, next_index)).write(verification_hash);
                self
                    .verification_hashes
                    .entry(verification_hash)
                    .write(
                        Option::Some(
                            (
                                fact_hash,
                                security_bits,
                                verifier_configuration_to_tuple(verifier_config)
                            )
                        )
                    );
                self.facts.entry(fact_hash).write(next_index + 1);
            }
            event
        }
    }
}
