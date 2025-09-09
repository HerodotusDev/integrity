use integrity::{
    settings::{VerifierConfiguration, FactHash, SecurityBits, VerificationHash},
    contracts::fact_registry_interface::{
        IFactRegistryDispatcher, IFactRegistryDispatcherTrait, IFactRegistryWithMockingDispatcher,
        IFactRegistryWithMockingDispatcherTrait, VerificationListElement, Verification
    }
};
use core::poseidon::{Poseidon, PoseidonImpl, HashStateImpl};
use starknet::{ContractAddress, contract_address_const, get_execution_info};


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

const CHAIN_ID_SEPOLIA: felt252 = 0x534e5f5345504f4c4941; // SN_SEPOLIA
const INTEGRITY_ADDRESS_SEPOLIA: felt252 =
    0x4ce7851f00b6c3289674841fd7a1b96b6fd41ed1edc248faccd672c26371b8c;
const PROXY_ADDRESS_SEPOLIA: felt252 =
    0x16409cfef9b6c3e6002133b61c59d09484594b37b8e4daef7dcba5495a0ef1a;
const SATELLITE_ADDRESS_SEPOLIA: felt252 =
    0x00421cd95f9ddabdd090db74c9429f257cb6bc1ccc339278d1db1de39156676e;

const CHAIN_ID_MAINNET: felt252 = 0x534e5f4d41494e; // SN_MAIN
const INTEGRITY_ADDRESS_MAINNET: felt252 =
    0xcc63a1e8e7824642b89fa6baf996b8ed21fa4707be90ef7605570ca8e4f00b;
const PROXY_ADDRESS_MAINNET: felt252 =
    0x6a8dd26f04cf9bc2f5a72134ec8aa9f4a8b2d0de72a766ebb646c853970beb0;
const SATELLITE_ADDRESS_MAINNET: felt252 =
    0x01ba7d4b5707f8878c22fb335763abfc26c2ae157c434d597f6416fe6a79bf2e;

#[derive(Drop, Copy, Serde)]
struct IntegrityT {
    dispatcher: IFactRegistryDispatcher,
}

#[derive(Drop, Copy, Serde)]
struct SatelliteT {
    dispatcher: IFactRegistryWithMockingDispatcher,
    is_mocked: bool,
}

#[generate_trait]
impl Integrity of IntegrityTrait {
    fn new() -> IntegrityT {
        let chain_id = get_execution_info().tx_info.chain_id;
        let contract_address = if chain_id == CHAIN_ID_SEPOLIA {
            contract_address_const::<INTEGRITY_ADDRESS_SEPOLIA>()
        } else {
            assert!(chain_id == CHAIN_ID_MAINNET, "Invalid chain id");
            contract_address_const::<INTEGRITY_ADDRESS_MAINNET>()
        };
        IntegrityT { dispatcher: IFactRegistryDispatcher { contract_address } }
    }

    fn new_proxy() -> IntegrityT {
        let chain_id = get_execution_info().tx_info.chain_id;
        let contract_address = if chain_id == CHAIN_ID_SEPOLIA {
            contract_address_const::<PROXY_ADDRESS_SEPOLIA>()
        } else {
            assert!(chain_id == CHAIN_ID_MAINNET, "Invalid chain id");
            contract_address_const::<PROXY_ADDRESS_MAINNET>()
        };
        IntegrityT { dispatcher: IFactRegistryDispatcher { contract_address } }
    }

    fn new_satellite(is_mocked: bool) -> SatelliteT {
        let chain_id = get_execution_info().tx_info.chain_id;
        let contract_address = if chain_id == CHAIN_ID_SEPOLIA {
            contract_address_const::<SATELLITE_ADDRESS_SEPOLIA>()
        } else {
            assert!(chain_id == CHAIN_ID_MAINNET, "Invalid chain id");
            contract_address_const::<SATELLITE_ADDRESS_MAINNET>()
        };
        SatelliteT {
            dispatcher: IFactRegistryWithMockingDispatcher { contract_address }, is_mocked
        }
    }

    fn from_address(contract_address: ContractAddress) -> IntegrityT {
        IntegrityT { dispatcher: IFactRegistryDispatcher { contract_address } }
    }

    fn is_fact_hash_valid_with_security<T, +CallFactRegistryTrait<T>>(
        self: T, fact_hash: FactHash, security_bits: SecurityBits
    ) -> bool {
        let mut verifications = self._get_all_verifications_for_fact_hash(fact_hash);
        let mut result = false;
        for verification in verifications {
            if *verification.security_bits >= security_bits {
                result = true;
                break;
            }
        };
        result
    }

    fn is_verification_hash_valid<T, +CallFactRegistryTrait<T>>(
        self: T, verification_hash: VerificationHash
    ) -> bool {
        self._get_verification(verification_hash).is_some()
    }

    fn with_config<Base, +Drop<Base>>(
        self: Base, verifier_config: VerifierConfiguration, security_bits: SecurityBits
    ) -> IntegrityWithConfigT<Base> {
        IntegrityWithConfigT {
            base: self,
            verifier_config_hash: get_verifier_config_hash(verifier_config),
            security_bits,
        }
    }

    fn with_hashed_config<Base, +Drop<Base>>(
        self: Base, verifier_config_hash: felt252, security_bits: SecurityBits
    ) -> IntegrityWithConfigT<Base> {
        IntegrityWithConfigT { base: self, verifier_config_hash, security_bits, }
    }
}

trait CallFactRegistryTrait<T> {
    fn _get_all_verifications_for_fact_hash(
        self: T, fact_hash: FactHash
    ) -> Span<VerificationListElement>;
    fn _get_verification(self: T, verification_hash: VerificationHash) -> Option<Verification>;
}

impl IntegrityCallImpl of CallFactRegistryTrait<IntegrityT> {
    fn _get_all_verifications_for_fact_hash(
        self: IntegrityT, fact_hash: FactHash
    ) -> Span<VerificationListElement> {
        self.dispatcher.get_all_verifications_for_fact_hash(fact_hash).span()
    }
    fn _get_verification(
        self: IntegrityT, verification_hash: VerificationHash
    ) -> Option<Verification> {
        self.dispatcher.get_verification(verification_hash)
    }
}

impl SatelliteCallImpl of CallFactRegistryTrait<SatelliteT> {
    fn _get_all_verifications_for_fact_hash(
        self: SatelliteT, fact_hash: FactHash
    ) -> Span<VerificationListElement> {
        self.dispatcher.get_all_verifications_for_fact_hash(fact_hash, self.is_mocked)
    }
    fn _get_verification(
        self: SatelliteT, verification_hash: VerificationHash
    ) -> Option<Verification> {
        self.dispatcher.get_verification(verification_hash, self.is_mocked)
    }
}

#[derive(Drop, Copy, Serde)]
struct IntegrityWithConfigT<Base> {
    base: Base,
    verifier_config_hash: felt252,
    security_bits: SecurityBits,
}

#[generate_trait]
impl IntegrityWithConfig<
    Base, +Drop<Base>, +CallFactRegistryTrait<Base>
> of IntegrityWithConfigTrait<Base> {
    fn is_fact_hash_valid(self: IntegrityWithConfigT<Base>, fact_hash: FactHash) -> bool {
        let verification_hash = get_verification_hash(
            fact_hash, self.verifier_config_hash, self.security_bits
        );
        self.base._get_verification(verification_hash).is_some()
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
