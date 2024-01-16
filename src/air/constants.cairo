// Recursive layout
const BITWISE_RATIO: felt252 = 8;
const BITWISE_TOTAL_N_BITS: felt252 = 251;
const CONSTRAINT_DEGREE: u32 = 2;
const CPU_COMPONENT_HEIGHT: felt252 = 16;
const DILUTED_N_BITS: felt252 = 16;
const DILUTED_SPACING: felt252 = 4;
const HAS_BITWISE_BUILTIN: felt252 = 1;
const HAS_DILUTED_POOL: felt252 = 1;
const HAS_EC_OP_BUILTIN: felt252 = 0;
const HAS_ECDSA_BUILTIN: felt252 = 0;
const HAS_KECCAK_BUILTIN: felt252 = 0;
const HAS_OUTPUT_BUILTIN: felt252 = 1;
const HAS_PEDERSEN_BUILTIN: felt252 = 1;
const HAS_POSEIDON_BUILTIN: felt252 = 0;
const HAS_RANGE_CHECK_BUILTIN: felt252 = 1;
const IS_DYNAMIC_AIR: felt252 = 0;
const LAYOUT_CODE: felt252 = 0x726563757273697665;
const LOG_CPU_COMPONENT_HEIGHT: felt252 = 4;
const MASK_SIZE: u32 = 133;
const MEMORY_STEP: felt252 = 2;
const N_CONSTRAINTS: felt252 = 93;
const N_DYNAMIC_PARAMS: felt252 = 0;
const NUM_COLUMNS_FIRST: u32 = 7;
const NUM_COLUMNS_SECOND: u32 = 3;
const PEDERSEN_BUILTIN_RATIO: felt252 = 128;
const PEDERSEN_BUILTIN_REPETITIONS: felt252 = 1;
const PUBLIC_MEMORY_STEP: felt252 = 16;
const RC_BUILTIN_RATIO: felt252 = 8;
const RC_N_PARTS: felt252 = 8;

const MAX_LOG_N_STEPS: felt252 = 50;
const MAX_RANGE_CHECK: felt252 = 0xffff; // 2 ** 16 - 1

mod segments {
    const BITWISE: usize = 5;
    const EXECUTION: usize = 1;
    const N_SEGMENTS: usize = 6;
    const OUTPUT: usize = 2;
    const PEDERSEN: usize = 3;
    const PROGRAM: usize = 0;
    const RANGE_CHECK: usize = 4;
}
