use applicative_recursion::merkle_tree::{get_root_hash, hash_leaf, hash_leaves};
use integrity::{
    Integrity, IntegrityWithConfig, SHARP_BOOTLOADER_PROGRAM_HASH, VerifierConfiguration,
    calculate_bootloaded_fact_hash, get_verifier_config_hash,
};
use openzeppelin::merkle_tree::hashes::PoseidonCHasher;
use openzeppelin::merkle_tree::merkle_proof::process_proof;

#[starknet::interface]
pub trait IApplicativeRecursionFactRegistry<TContractState> {
    fn decommit_leaf(ref self: TContractState, leaf: felt252, proof: Span<felt252>);
    fn decommit_tree(ref self: TContractState, leaves: Span<felt252>);

    fn is_valid(self: @TContractState, fact_hash: felt252) -> bool;
}

#[starknet::contract]
pub mod ApplicativeRecursionFactRegistry {
    use starknet::ContractAddress;
    use starknet::storage::{
        Map, StoragePathEntry, StoragePointerReadAccess, StoragePointerWriteAccess,
    };
    use super::*;

    #[storage]
    struct Storage {
        bootloader_program_hash: felt252,
        aggregator_program_hash: felt252,
        integrity_address: ContractAddress,
        integrity_config_hash: felt252,
        integrity_security_bits: u32,
        fact_hashes: Map<felt252, bool>,
    }

    #[constructor]
    fn constructor(
        ref self: ContractState,
        bootloader_program_hash: felt252,
        aggregator_program_hash: felt252,
        integrity_address: ContractAddress,
        integrity_config: VerifierConfiguration,
        integrity_security_bits: u32,
    ) {
        self.bootloader_program_hash.write(bootloader_program_hash);
        self.aggregator_program_hash.write(aggregator_program_hash);
        self.integrity_address.write(integrity_address);
        self.integrity_config_hash.write(get_verifier_config_hash(integrity_config));
        self.integrity_security_bits.write(integrity_security_bits);
    }

    #[generate_trait]
    impl ApplicativeRecursionFactRegistryInternal of IApplicativeRecursionFactRegistryInternal {
        fn get_fact_hash(self: @ContractState, root_hash: felt252) -> felt252 {
            let output = [self.aggregator_program_hash.read(), root_hash, 0x0].span();
            let program_hash = self.bootloader_program_hash.read();

            calculate_bootloaded_fact_hash(SHARP_BOOTLOADER_PROGRAM_HASH, program_hash, output)
        }

        fn is_fact_hash_valid(self: @ContractState, fact_hash: felt252) -> bool {
            let integrity = Integrity::from_address(self.integrity_address.read());

            let config_hash = self.integrity_config_hash.read();
            let security_bits = self.integrity_security_bits.read();

            integrity.with_hashed_config(config_hash, security_bits).is_fact_hash_valid(fact_hash)
        }
    }

    #[abi(embed_v0)]
    impl ApplicativeRecursionFactRegistryImpl of IApplicativeRecursionFactRegistry<ContractState> {
        fn decommit_leaf(ref self: ContractState, leaf: felt252, proof: Span<felt252>) {
            let hashed_leaf = hash_leaf(leaf);
            let root_hash = process_proof::<PoseidonCHasher>(proof, hashed_leaf);

            let fact_hash = self.get_fact_hash(root_hash);
            let is_valid = self.is_fact_hash_valid(fact_hash);
            assert(is_valid, 'Fact hash is not registered');

            self.fact_hashes.entry(leaf).write(true);
        }

        fn decommit_tree(ref self: ContractState, leaves: Span<felt252>) {
            let hashed_leaves = hash_leaves(leaves);
            let root_hash = get_root_hash(hashed_leaves);

            let fact_hash = self.get_fact_hash(root_hash);
            let is_valid = self.is_fact_hash_valid(fact_hash);
            assert(is_valid, 'Fact hash is not registered');

            for leaf in leaves {
                self.fact_hashes.entry(*leaf).write(true);
            }
        }

        fn is_valid(self: @ContractState, fact_hash: felt252) -> bool {
            self.fact_hashes.entry(fact_hash).read()
        }
    }
}
