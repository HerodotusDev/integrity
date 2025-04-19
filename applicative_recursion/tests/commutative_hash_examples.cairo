use openzeppelin::merkle_tree::hashes::PoseidonCHasher;
use openzeppelin::merkle_tree::merkle_proof::verify_poseidon;
#[test]
fn test_commutative_hash_1() {
    let a = 456;
    let b = 123;

    let hash_1 = PoseidonCHasher::commutative_hash(a, b);
    let hash_2 = PoseidonCHasher::commutative_hash(b, a);

    assert(hash_1 == hash_2, 'hash is commutative');

    let expected_hash =
        3078496434882079937724388459505675842932410179539421134160956316828903534704;

    assert(hash_1 == expected_hash, 'hash is correct');
}

#[test]
fn test_commutative_hash_2() {
    let a = 333;
    let b = 777;

    let hash_1 = PoseidonCHasher::commutative_hash(a, b);
    let hash_2 = PoseidonCHasher::commutative_hash(b, a);

    assert(hash_1 == hash_2, 'hash is commutative');

    let expected_hash =
        1017701663674692302284486978715800544092472980770764352782885215049839179458;

    assert(hash_1 == expected_hash, 'hash is correct');
}

#[test]
fn test_merkle_root_hash_5_leaves() {
    let leaf_1 = 1073156302979560792221579174510302617030152323580472146146609514826389505953;
    let leaf_2 = 3480373627587233544730874138440391736870787221204167186361820851772543726392;
    let leaf_3 = 3331964270381854350382580527122817180649953314104348840989537158202691620591;
    let leaf_4 = 663603216509782636457470027552452500581997608842766641099217590049269815062;
    let leaf_5 = 3561455703173699215459883981864709246532730017982956264444923577051119991603;

    let n_12 = PoseidonCHasher::commutative_hash(leaf_1, leaf_2);
    let n_34 = PoseidonCHasher::commutative_hash(leaf_3, leaf_4);
    let n_1234 = PoseidonCHasher::commutative_hash(n_12, n_34);
    let root = PoseidonCHasher::commutative_hash(n_1234, leaf_5);

    let expected_root = 0x1ffc48eb9b02993240241d49908bc3d3ad0e21b7a9ab2b2b6b2efa1c1fd93ef;

    assert(root == expected_root, 'root hash mismatch');
}

#[test]
fn test_merkle_root_hash_3_leaves() {
    let leaf_1 = 1073156302979560792221579174510302617030152323580472146146609514826389505953;
    let leaf_2 = 3480373627587233544730874138440391736870787221204167186361820851772543726392;
    let leaf_3 = 3331964270381854350382580527122817180649953314104348840989537158202691620591;

    let n_12 = PoseidonCHasher::commutative_hash(leaf_1, leaf_2);
    let root = PoseidonCHasher::commutative_hash(n_12, leaf_3);

    let expected_root = 0x73157cc972c93294c21e00de0ff54bcfd34129c99466b842090949fe650b992;

    assert(root == expected_root, 'root hash mismatch');
}

#[test]
fn test_merkle_proof_5_leaves() {
    let leaf_1 = 1073156302979560792221579174510302617030152323580472146146609514826389505953;
    let leaf_2 = 3480373627587233544730874138440391736870787221204167186361820851772543726392;
    let leaf_3 = 3331964270381854350382580527122817180649953314104348840989537158202691620591;
    let leaf_4 = 663603216509782636457470027552452500581997608842766641099217590049269815062;
    let leaf_5 = 3561455703173699215459883981864709246532730017982956264444923577051119991603;

    let n_12 = PoseidonCHasher::commutative_hash(leaf_1, leaf_2);
    let n_34 = PoseidonCHasher::commutative_hash(leaf_3, leaf_4);
    let n_1234 = PoseidonCHasher::commutative_hash(n_12, n_34);
    let root = PoseidonCHasher::commutative_hash(n_1234, leaf_5);

    assert(verify_poseidon([leaf_2, n_34, leaf_5].span(), root, leaf_1), 'proof is incorrect');
    assert(verify_poseidon([leaf_1, n_34, leaf_5].span(), root, leaf_2), 'proof is incorrect');
    assert(verify_poseidon([leaf_4, n_12, leaf_5].span(), root, leaf_3), 'proof is incorrect');
    assert(verify_poseidon([leaf_3, n_12, leaf_5].span(), root, leaf_4), 'proof is incorrect');
    assert(verify_poseidon([n_1234].span(), root, leaf_5), 'proof is incorrect');
}
