// Starknet with keccak layout
const BITWISE_RATIO: felt252 = 64;
const BITWISE_ROW_RATIO: felt252 = 1024;
const BITWISE_TOTAL_N_BITS: felt252 = 251;
const CONSTRAINT_DEGREE: u32 = 2;
const CPU_COMPONENT_HEIGHT: felt252 = 16;
const CPU_COMPONENT_STEP: felt252 = 1;
const DILUTED_N_BITS: felt252 = 16;
const DILUTED_SPACING: felt252 = 4;
const EC_OP_BUILTIN_RATIO: felt252 = 1024;
const EC_OP_BUILTIN_ROW_RATIO: felt252 = 16384;
const EC_OP_N_BITS: felt252 = 252;
const EC_OP_SCALAR_HEIGHT: felt252 = 256;
const ECDSA_BUILTIN_RATIO: felt252 = 2048;
const ECDSA_BUILTIN_REPETITIONS: felt252 = 1;
const ECDSA_BUILTIN_ROW_RATIO: felt252 = 32768;
const ECDSA_ELEMENT_BITS: felt252 = 251;
const ECDSA_ELEMENT_HEIGHT: felt252 = 256;
const HAS_BITWISE_BUILTIN: felt252 = 1;
const HAS_DILUTED_POOL: felt252 = 1;
const HAS_EC_OP_BUILTIN: felt252 = 1;
const HAS_ECDSA_BUILTIN: felt252 = 1;
const HAS_KECCAK_BUILTIN: felt252 = 1;
const HAS_OUTPUT_BUILTIN: felt252 = 1;
const HAS_PEDERSEN_BUILTIN: felt252 = 1;
const HAS_POSEIDON_BUILTIN: felt252 = 1;
const HAS_RANGE_CHECK_BUILTIN: felt252 = 1;
const HAS_RANGE_CHECK96_BUILTIN: felt252 = 0;
const IS_DYNAMIC_AIR: felt252 = 0;
const KECCAK_RATIO: felt252 = 2048;
const KECCAK_ROW_RATIO: felt252 = 32768;
const LAYOUT_CODE: felt252 = 0x737461726b6e65745f776974685f6b656363616b;
const LOG_CPU_COMPONENT_HEIGHT: felt252 = 4;
const MASK_SIZE: u32 = 734;
const N_CONSTRAINTS: u32 = 347;
const N_DYNAMIC_PARAMS: felt252 = 0;
const NUM_COLUMNS_FIRST: u32 = 12;
const NUM_COLUMNS_SECOND: u32 = 3;
const PEDERSEN_BUILTIN_RATIO: felt252 = 32;
const PEDERSEN_BUILTIN_REPETITIONS: felt252 = 1;
const PEDERSEN_BUILTIN_ROW_RATIO: felt252 = 512;
const POSEIDON_M: felt252 = 3;
const POSEIDON_RATIO: felt252 = 32;
const POSEIDON_ROUNDS_FULL: felt252 = 8;
const POSEIDON_ROUNDS_PARTIAL: felt252 = 83;
const POSEIDON_ROW_RATIO: felt252 = 512;
const PUBLIC_MEMORY_STEP: felt252 = 8;
const RANGE_CHECK_BUILTIN_RATIO: felt252 = 16;
const RANGE_CHECK_BUILTIN_ROW_RATIO: felt252 = 256;
const RANGE_CHECK_N_PARTS: felt252 = 8;

mod segments {
    const BITWISE: usize = 6;
    const EC_OP: usize = 7;
    const ECDSA: usize = 5;
    const EXECUTION: usize = 1;
    const KECCAK: usize = 8;
    const N_SEGMENTS: usize = 10;
    const OUTPUT: usize = 2;
    const PEDERSEN: usize = 3;
    const POSEIDON: usize = 9;
    const PROGRAM: usize = 0;
    const RANGE_CHECK: usize = 4;
}

fn get_builtins() -> Array<felt252> {
    array!['output', 'pedersen', 'range_check', 'ecdsa', 'bitwise', 'ec_op', 'keccak', 'poseidon']
}
