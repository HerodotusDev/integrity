use cairo_verifier::{
    StarkProofWithSerde, CairoVersion,
    fri::fri::{FriLayerWitness, FriVerificationStateConstant, FriVerificationStateVariable},
    verifier::InitResult,
    settings::{
        // settings accepted by verifier (parameters for verification)
        VerifierSettings,
        HasherBitLength, StoneVersion,
    },
};
use starknet::ContractAddress;

// settings that identify the verifier (hardcoded in verifier)
#[derive(Drop, Copy, Serde)]
struct VerifierVersion {
    layout: felt252,
    hasher: felt252,
}

// both hardcoded settings and parameters merged together
#[derive(Drop, Copy, Serde)]
struct Settings {
    layout: felt252, // string encoded as hex
    hasher: felt252, // function and number of bits
    stone_version: felt252, // stone5 or stone6
    cairo_version: CairoVersion, // 0 or 1
}

fn tuple_to_settings(tuple: (felt252, felt252, felt252, felt252)) -> Settings {
    let (layout, hasher, stone_version, cairo_version) = tuple;
    let cairo_version = if cairo_version == 0 {
        CairoVersion::Cairo0
    } else {
        assert(cairo_version == 1, 'Invalid cairo version');
        CairoVersion::Cairo1
    };
    Settings { layout, hasher, stone_version, cairo_version }
}

fn settings_to_tuple(settings: Settings) -> (felt252, felt252, felt252, felt252) {
    let cairo_version = match settings.cairo_version {
        CairoVersion::Cairo0 => 0,
        CairoVersion::Cairo1 => 1,
    };
    (settings.layout, settings.hasher, settings.stone_version, cairo_version )
}

fn split_settings(settings: Settings) -> (VerifierSettings, VerifierVersion) {
    let (hash_function, hash_bits) = if settings.layout == 'keccak_160_lsb' {
        ('keccak', HasherBitLength::Lsb160)
    } else if settings.layout == 'keccak_248_lsb' {
        ('keccak', HasherBitLength::Lsb248)
    } else if settings.layout == 'blake2s_160_lsb' {
        ('blake2s', HasherBitLength::Lsb160)
    } else {
        assert(settings.layout == 'blake2s_248_lsb', 'Invalid hasher');
        ('blake2s', HasherBitLength::Lsb248)
    };
    let stone_version = if settings.stone_version == 'stone5' {
        StoneVersion::Stone5
    } else {
        assert(settings.stone_version == 'stone6', 'Invalid stone version');
        StoneVersion::Stone6
    };
    (
        VerifierSettings {
            cairo_version: settings.cairo_version,
            hasher_bit_length: hash_bits,
            stone_version: stone_version,
        },
        VerifierVersion {
            layout: settings.layout,
            hasher: hash_function,
        }
    )
}

#[derive(Drop, Copy, Serde)]
struct VerificationListElement {
    verification_hash: felt252,
    security_bits: u32,
    settings: Settings,
}

#[derive(Drop, Copy, Serde)]
struct Verification {
    fact_hash: felt252,
    security_bits: u32,
    settings: Settings,
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
    settings: Settings,
    #[key]
    verification_hash: felt252,
}

#[starknet::interface]
trait IFactRegistry<TContractState> {
    fn verify_proof_full_and_register_fact(
        ref self: TContractState,
        settings: Settings,
        stark_proof: StarkProofWithSerde,
    ) -> FactRegistered;

    fn verify_proof_initial(
        ref self: TContractState,
        job_id: felt252,
        settings: Settings,
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

    fn get_verifier_address(self: @TContractState, version: VerifierVersion) -> ContractAddress;
    fn register_verifier(
        ref self: TContractState, version: VerifierVersion, address: ContractAddress
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
        VerifierVersion, VerificationListElement, Verification, IFactRegistry, FactRegistered, Settings,
        settings_to_tuple, tuple_to_settings, split_settings
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
            felt252, Option<(felt252, u32, (felt252, felt252, felt252, felt252))>
        >, // verification_hash => (fact_hash, security_bits, settings)
        settings: LegacyMap<felt252, Option<(felt252, felt252, felt252, felt252)>>, // job_id => Settings
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
        version: VerifierVersion,
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
            settings: Settings,
            stark_proof: StarkProofWithSerde,
        ) -> FactRegistered {
            let (verifier_settings, version) = split_settings(settings);

            let verifier_address = self.get_verifier_address(version);
            let result = ICairoVerifierDispatcher {
                contract_address: verifier_address
            }
                .verify_proof_full(stark_proof.into(), verifier_settings);

            self._register_fact(result.fact, verifier_address, result.security_bits, settings)
        }

        fn verify_proof_initial(
            ref self: ContractState,
            job_id: felt252,
            settings: Settings,
            stark_proof: StarkProofWithSerde,
        ) -> InitResult {
            self.settings.write(job_id, Option::Some(settings_to_tuple(settings)));
            let (verifier_settings, version) = split_settings(settings);
            ICairoVerifierDispatcher { contract_address: self.get_verifier_address(version) }
                .verify_proof_initial(job_id, stark_proof, verifier_settings)
        }

        fn verify_proof_step(
            ref self: ContractState,
            job_id: felt252,
            state_constant: FriVerificationStateConstant,
            state_variable: FriVerificationStateVariable,
            witness: FriLayerWitness,
        ) -> (FriVerificationStateVariable, u32) {
            let settings = tuple_to_settings(self.settings.read(job_id).expect('Job id not found'));
            let (_, version) = split_settings(settings);
            ICairoVerifierDispatcher { contract_address: self.get_verifier_address(version) }
                .verify_proof_step(job_id, state_constant, state_variable, witness)
        }

        fn verify_proof_final_and_register_fact(
            ref self: ContractState,
            job_id: felt252,
            state_constant: FriVerificationStateConstant,
            state_variable: FriVerificationStateVariable,
            last_layer_coefficients: Span<felt252>,
        ) -> FactRegistered {
            let settings = tuple_to_settings(self.settings.read(job_id).expect('Job id not found'));
            let (_, version) = split_settings(settings);
            let verifier_address = self.get_verifier_address(version);
            assert(verifier_address.into() != 0, 'VERIFIER_NOT_FOUND');
            let result = ICairoVerifierDispatcher {
                contract_address: verifier_address
            }
                .verify_proof_final(
                    job_id, state_constant, state_variable, last_layer_coefficients
                );

            self._register_fact(result.fact, verifier_address, result.security_bits, settings)
        }

        fn get_all_verifications_for_fact_hash(
            self: @ContractState, fact_hash: felt252
        ) -> Array<VerificationListElement> {
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
                let settings = tuple_to_settings(settings_tuple);
                arr.append(VerificationListElement { verification_hash, security_bits, settings });
                i += 1;
            };
            arr
        }

        fn get_verification(
            self: @ContractState, verification_hash: felt252
        ) -> Option<Verification> {
            match self.verification_hashes.read(verification_hash) {
                Option::Some(x) => {
                    let (fact_hash, security_bits, settings_tuple) = x;
                    let settings = tuple_to_settings(settings_tuple);
                    Option::Some(Verification { fact_hash, security_bits, settings })
                },
                Option::None => { Option::None }
            }
        }

        fn get_verifier_address(
            self: @ContractState, version: VerifierVersion
        ) -> ContractAddress {
            let verifier_address = self.verifiers.read(self._hash_version(version));
            assert(verifier_address.into() != 0, 'VERIFIER_NOT_FOUND');
            verifier_address
        }

        fn register_verifier(
            ref self: ContractState, version: VerifierVersion, address: ContractAddress
        ) {
            assert(self.owner.read() == get_caller_address(), 'ONLY_OWNER');
            assert(address.into() != 0, 'INVALID_VERIFIER_ADDRESS');
            let version_hash = self._hash_version(version);
            assert(self.verifiers.read(version_hash).into() == 0, 'VERIFIER_ALREADY_EXISTS');
            self.verifiers.write(version_hash, address);
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
    }

    #[generate_trait]
    impl InternalFactRegistry of InternalFactRegistryTrait {
        fn _hash_settings(self: @ContractState, settings: Settings) -> felt252 {
            let cairo_version = match settings.cairo_version {
                CairoVersion::Cairo0 => 0,
                CairoVersion::Cairo1 => 1,
            };
            PoseidonImpl::new()
                .update(settings.layout)
                .update(settings.hasher)
                .update(settings.stone_version)
                .update(cairo_version)
                .finalize()
        }

        fn _hash_version(self: @ContractState, version: VerifierVersion) -> felt252 {
            PoseidonImpl::new()
                .update(version.layout)
                .update(version.hasher)
                .finalize()
        }

        fn _register_fact(
            ref self: ContractState,
            fact_hash: felt252,
            verifier_address: ContractAddress,
            security_bits: u32,
            settings: Settings
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
                        Option::Some((fact_hash, security_bits, settings_to_tuple(settings)))
                    );
                self.facts.write(fact_hash, next_index + 1);
            }
            event
        }
    }
}
