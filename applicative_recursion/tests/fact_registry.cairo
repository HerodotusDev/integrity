use applicative_recursion::fact_registry::{
    IApplicativeRecursionFactRegistryDispatcher, IApplicativeRecursionFactRegistryDispatcherTrait,
};
use applicative_recursion::merkle_tree::hash_leaf;
use integrity::VerifierConfiguration;
use integrity::contracts::fact_registry_interface::{
    IFactRegistryDispatcher, IFactRegistryDispatcherTrait,
};
use integrity::contracts::mocked_fact_registry::{
    IFactRegistryExternalDispatcher, IFactRegistryExternalDispatcherTrait,
};
use openzeppelin::merkle_tree::hashes::PoseidonCHasher;
use snforge_std::{ContractClassTrait, DeclareResultTrait, declare};
use starknet::ContractAddress;


fn deploy_fact_registry() -> (
    IApplicativeRecursionFactRegistryDispatcher,
    ContractAddress,
    IFactRegistryDispatcher,
    IFactRegistryExternalDispatcher,
) {
    let mocked_integrity = declare("MockedFactRegistry").unwrap().contract_class();
    let (mocked_integrity_address, _) = mocked_integrity.deploy(@array![]).unwrap();
    let integrity_dispatcher = IFactRegistryDispatcher {
        contract_address: mocked_integrity_address,
    };
    let integrity_dispatcher_mocking = IFactRegistryExternalDispatcher {
        contract_address: mocked_integrity_address,
    };

    let ar_fact_registry = declare("ApplicativeRecursionFactRegistry").unwrap().contract_class();
    let ar_fact_registry_constructor_calldata = array![
        0x2697ab2f3631993e735ca0e5a8b526b42210f87a3ab0d84276e05ea469f942a, // bootloader program hash
        0x675d09dc6a5a1a2317bee3abcc05074881553e0b88c05c646f384b924aa6445, // aggregator program hash
        mocked_integrity_address.into(), // integrity address
        'recursive_with_poseidon', // layout
        'keccak_160_lsb', // hasher
        'stone6', // stone version
        'relaxed', // memory verification
        96 // security bits
    ];
    let (ar_fact_registry_address, _) = ar_fact_registry
        .deploy(@ar_fact_registry_constructor_calldata)
        .unwrap();
    let ar_fact_registry_dispatcher = IApplicativeRecursionFactRegistryDispatcher {
        contract_address: ar_fact_registry_address,
    };

    (
        ar_fact_registry_dispatcher,
        ar_fact_registry_address,
        integrity_dispatcher,
        integrity_dispatcher_mocking,
    )
}

#[test]
fn test_decommit_tree() {
    let (ar_fact_registry_dispatcher, _, integrity_dispatcher, integrity_dispatcher_mocking) =
        deploy_fact_registry();

    let fact_hash = 0x4843d7fd82b4d3aff0c7da60f6cf4e8cf0f102d44c8c23435359b49df422ecd;
    assert(
        integrity_dispatcher.get_all_verifications_for_fact_hash(fact_hash).len() == 0,
        'Fact is registered too early',
    );
    integrity_dispatcher_mocking
        .register_fact(
            VerifierConfiguration {
                layout: 'recursive_with_poseidon',
                hasher: 'keccak_160_lsb',
                stone_version: 'stone6',
                memory_verification: 'relaxed',
            },
            fact_hash,
            96,
        );
    assert(
        integrity_dispatcher.get_all_verifications_for_fact_hash(fact_hash).len() == 1,
        'Fact is not registered',
    );

    let leaves = array![
        2192746374848038618461766601634824445663766197209859773933337403701948944618,
        432931858001243491244061814990859609195887068876937365828494252357627396127,
        1933513332077687604481787646243020440150686203213384098490085517703747198465,
    ];

    for leaf in leaves.span() {
        assert(!ar_fact_registry_dispatcher.is_valid(*leaf), 'AR Fact is registered too early');
    }
    ar_fact_registry_dispatcher.decommit_tree(leaves.span());
    for leaf in leaves.span() {
        assert(ar_fact_registry_dispatcher.is_valid(*leaf), 'AR Fact is not registered');
    }
}

#[test]
fn test_decommit_leaf() {
    let (ar_fact_registry_dispatcher, _, integrity_dispatcher, integrity_dispatcher_mocking) =
        deploy_fact_registry();

    let fact_hash = 0x4843d7fd82b4d3aff0c7da60f6cf4e8cf0f102d44c8c23435359b49df422ecd;
    assert(
        integrity_dispatcher.get_all_verifications_for_fact_hash(fact_hash).len() == 0,
        'Fact is registered too early',
    );
    integrity_dispatcher_mocking
        .register_fact(
            VerifierConfiguration {
                layout: 'recursive_with_poseidon',
                hasher: 'keccak_160_lsb',
                stone_version: 'stone6',
                memory_verification: 'relaxed',
            },
            fact_hash,
            96,
        );
    assert(
        integrity_dispatcher.get_all_verifications_for_fact_hash(fact_hash).len() == 1,
        'Fact is not registered',
    );

    let leaf_1 = 2192746374848038618461766601634824445663766197209859773933337403701948944618;
    let leaf_2 = 432931858001243491244061814990859609195887068876937365828494252357627396127;
    let leaf_3 = 1933513332077687604481787646243020440150686203213384098490085517703747198465;
    let hash_1 = hash_leaf(leaf_1);
    let hash_2 = hash_leaf(leaf_2);
    let hash_3 = hash_leaf(leaf_3);
    let hash_12 = PoseidonCHasher::commutative_hash(hash_1, hash_2);

    assert(!ar_fact_registry_dispatcher.is_valid(leaf_1), 'AR Fact 1 1');
    assert(!ar_fact_registry_dispatcher.is_valid(leaf_2), 'AR Fact 1 2');
    assert(!ar_fact_registry_dispatcher.is_valid(leaf_3), 'AR Fact 1 3');

    ar_fact_registry_dispatcher.decommit_leaf(leaf_1, [hash_2, hash_3].span());

    assert(ar_fact_registry_dispatcher.is_valid(leaf_1), 'AR Fact 2 1');
    assert(!ar_fact_registry_dispatcher.is_valid(leaf_2), 'AR Fact 2 2');
    assert(!ar_fact_registry_dispatcher.is_valid(leaf_3), 'AR Fact 2 3');

    ar_fact_registry_dispatcher.decommit_leaf(leaf_3, [hash_12].span());

    assert(ar_fact_registry_dispatcher.is_valid(leaf_1), 'AR Fact 3 1');
    assert(!ar_fact_registry_dispatcher.is_valid(leaf_2), 'AR Fact 3 2');
    assert(ar_fact_registry_dispatcher.is_valid(leaf_3), 'AR Fact 3 3');

    ar_fact_registry_dispatcher.decommit_leaf(leaf_2, [hash_1, hash_3].span());

    assert(ar_fact_registry_dispatcher.is_valid(leaf_1), 'AR Fact 4 1');
    assert(ar_fact_registry_dispatcher.is_valid(leaf_2), 'AR Fact 4 2');
    assert(ar_fact_registry_dispatcher.is_valid(leaf_3), 'AR Fact 4 3');
}
