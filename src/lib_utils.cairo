use integrity::{
    settings::{VerifierConfiguration, FactHash, SecurityBits, VerificationHash},
    contracts::fact_registry_interface::{IFactRegistryDispatcher, IFactRegistryDispatcherTrait}
};
use core::poseidon::{Poseidon, PoseidonImpl, HashStateImpl};
use starknet::{ContractAddress, contract_address_const};


fn get_verifier_config_hash(verifier_config: VerifierConfiguration) -> felt252 {
    PoseidonImpl::new()
        .update(verifier_config.layout)
        .update(verifier_config.hasher)
        .update(verifier_config.stone_version)
        .update(verifier_config.memory_verification)
        .finalize()
}

fn get_verification_hash(
    fact_hash: FactHash, verifier_config_hash: felt252, security_bits: u32
) -> VerificationHash {
    PoseidonImpl::new()
        .update(fact_hash)
        .update(verifier_config_hash)
        .update(security_bits.into())
        .finalize()
}

const INTEGRITY_ADDRESS: felt252 =
    0x4ce7851f00b6c3289674841fd7a1b96b6fd41ed1edc248faccd672c26371b8c;
const PROXY_ADDRESS: felt252 = 0x16409cfef9b6c3e6002133b61c59d09484594b37b8e4daef7dcba5495a0ef1a;

#[derive(Drop, Copy, Serde)]
struct IntegrityT {
    dispatcher: IFactRegistryDispatcher,
}

#[generate_trait]
impl Integrity of IntegrityTrait {
    fn new() -> IntegrityT {
        IntegrityT {
            dispatcher: IFactRegistryDispatcher {
                contract_address: contract_address_const::<INTEGRITY_ADDRESS>()
            }
        }
    }

    fn new_proxy() -> IntegrityT {
        IntegrityT {
            dispatcher: IFactRegistryDispatcher {
                contract_address: contract_address_const::<PROXY_ADDRESS>()
            }
        }
    }

    fn from_address(contract_address: ContractAddress) -> IntegrityT {
        IntegrityT { dispatcher: IFactRegistryDispatcher { contract_address } }
    }

    fn is_fact_hash_valid_with_security(
        self: IntegrityT, fact_hash: FactHash, security_bits: SecurityBits
    ) -> bool {
        let mut verifications = self
            .dispatcher
            .get_all_verifications_for_fact_hash(fact_hash)
            .span();
        let mut result = false;
        for verification in verifications {
            if *verification.security_bits >= security_bits {
                result = true;
                break;
            }
        };
        result
    }

    fn is_verification_hash_valid(self: IntegrityT, verification_hash: VerificationHash) -> bool {
        self.dispatcher.get_verification(verification_hash).is_some()
    }

    fn with_config(
        self: IntegrityT, verifier_config: VerifierConfiguration, security_bits: SecurityBits
    ) -> IntegrityWithConfigT {
        IntegrityWithConfigT {
            dispatcher: self.dispatcher,
            verifier_config_hash: get_verifier_config_hash(verifier_config),
            security_bits,
        }
    }

    fn with_hashed_config(
        self: IntegrityT, verifier_config_hash: felt252, security_bits: SecurityBits
    ) -> IntegrityWithConfigT {
        IntegrityWithConfigT { dispatcher: self.dispatcher, verifier_config_hash, security_bits, }
    }
}

#[derive(Drop, Copy, Serde)]
struct IntegrityWithConfigT {
    dispatcher: IFactRegistryDispatcher,
    verifier_config_hash: felt252,
    security_bits: SecurityBits,
}

#[generate_trait]
impl IntegrityWithConfig of IntegrityWithConfigTrait {
    fn is_fact_hash_valid(self: IntegrityWithConfigT, fact_hash: FactHash) -> bool {
        let verification_hash = get_verification_hash(
            fact_hash, self.verifier_config_hash, self.security_bits
        );
        self.dispatcher.get_verification(verification_hash).is_some()
    }
}

fn calculate_fact_hash(program_hash: felt252, output: Span<felt252>) -> felt252 {
    let mut output_hash = PoseidonImpl::new();
    for x in output {
        output_hash = output_hash.update(*x);
    };
    PoseidonImpl::new().update(program_hash).update(output_hash.finalize()).finalize()
}

const SHARP_BOOTLOADER_PROGRAM_HASH: felt252 =
    0x5ab580b04e3532b6b18f81cfa654a05e29dd8e2352d88df1e765a84072db07;
const STONE_BOOTLOADER_PROGRAM_HASH: felt252 =
    0x40519557c48b25e7e7d27cb27297300b94909028c327b385990f0b649920cc3;

fn calculate_bootloaded_fact_hash(
    bootloader_program_hash: felt252, child_program_hash: felt252, child_output: Span<felt252>
) -> felt252 {
    let mut bootloader_output = PoseidonImpl::new()
        .update(0x1)
        .update(child_output.len().into() + 2)
        .update(child_program_hash);
    for x in child_output {
        bootloader_output = bootloader_output.update(*x);
    };
    PoseidonImpl::new()
        .update(bootloader_program_hash)
        .update(bootloader_output.finalize())
        .finalize()
}
