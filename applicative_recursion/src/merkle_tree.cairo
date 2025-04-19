use core::hash::HashStateTrait;
use core::poseidon::PoseidonTrait;
use openzeppelin::merkle_tree::hashes::PoseidonCHasher;

pub fn get_root_hash(leaves: Span<felt252>) -> felt252 {
    let mut nodes = leaves;
    let mut next_nodes = array![];
    loop {
        loop {
            let x = nodes.pop_front();
            if x.is_none() {
                break;
            }
            let x = x.unwrap();

            if let Some(y) = nodes.pop_front() {
                let z = PoseidonCHasher::commutative_hash(*x, *y);
                next_nodes.append(z);
            } else {
                next_nodes.append(*x);
            };
        }
        nodes = next_nodes.span();
        next_nodes = array![];

        if nodes.len() == 1 {
            break *nodes.pop_front().unwrap();
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_root_hash() {
        let leaf_1 = 1073156302979560792221579174510302617030152323580472146146609514826389505953;
        let leaf_2 = 3480373627587233544730874138440391736870787221204167186361820851772543726392;
        let leaf_3 = 3331964270381854350382580527122817180649953314104348840989537158202691620591;
        let leaf_4 = 663603216509782636457470027552452500581997608842766641099217590049269815062;
        let leaf_5 = 3561455703173699215459883981864709246532730017982956264444923577051119991603;

        let expected_root = 0x1ffc48eb9b02993240241d49908bc3d3ad0e21b7a9ab2b2b6b2efa1c1fd93ef;

        let leaves = [leaf_1, leaf_2, leaf_3, leaf_4, leaf_5];
        let root = get_root_hash(leaves.span());

        assert(root == expected_root, 'root hash mismatch');
    }
}

pub fn hash_leaf(leaf: felt252) -> felt252 {
    PoseidonTrait::new().update(leaf).finalize()
}

pub fn hash_leaves(leaves: Span<felt252>) -> Span<felt252> {
    let mut result = array![];
    for leaf in leaves {
        let hash = hash_leaf(*leaf);
        result.append(hash);
    }
    result.span()
}
