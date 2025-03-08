use integrity::{
    contracts::{fact_registry_interface::{VerificationListElement, Verification},},
    settings::{
        VerifierSettings, VerificationHash, HasherBitLength, StoneVersion, SecurityBits, FactHash,
        JobId, VerifierConfiguration, VerifierPreset,
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
    fn register_fact(
        ref self: TContractState,
        verifier_config: VerifierConfiguration,
        fact_hash: FactHash,
        security_bits: SecurityBits,
    ) -> FactRegistered;
}

#[starknet::contract]
mod MockedFactRegistry {
    use integrity::{
        settings::{
            VerifierPreset, VerifierConfiguration, split_settings, JobId, FactHash,
            VerificationHash, PresetHash, SecurityBits,
        },
        contracts::{
            mocked_fact_registry::{IFactRegistryExternal, FactRegistered},
            fact_registry_interface::{IFactRegistry, VerificationListElement, Verification},
        },
        lib_utils::{get_verifier_config_hash, get_verification_hash},
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
        fact_verifications: Map<FactHash, Vec<VerificationHash>>,
        verification_hashes: Map<VerificationHash, Option<Verification>>,
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        FactRegistered: FactRegistered,
    }

    #[abi(embed_v0)]
    impl FactRegistryExternalImpl of IFactRegistryExternal<ContractState> {
        fn register_fact(
            ref self: ContractState,
            verifier_config: VerifierConfiguration,
            fact_hash: FactHash,
            security_bits: SecurityBits,
        ) -> FactRegistered {
            self._register_fact(fact_hash, 0x0.try_into().unwrap(), security_bits, verifier_config)
        }
    }

    #[abi(embed_v0)]
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
            0x0.try_into().unwrap()
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
            let verifier_config_hash = get_verifier_config_hash(verifier_config);
            let verification_hash = get_verification_hash(
                fact_hash, verifier_config_hash, security_bits
            );

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
