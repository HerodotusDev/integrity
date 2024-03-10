// StarkCurve
mod StarkCurve {
    const ALPHA: felt252 = 1;
    const BETA: felt252 = 0x6f21413efbe40de150e596d72f7a8c5609ad26c15c915c1f4cdfcb99cee9e89;
    const ORDER: felt252 = 0x800000000000010ffffffffffffffffb781126dcae7b2321e66a241adc64d2f;
    const GEN_X: felt252 = 0x1ef15c18599971b7beced415a40f0c7deacfd9b0d1819e03d723d8bc943cfca;
    const GEN_Y: felt252 = 0x5668060aa49730b7be4801df46ec62de53ecd11abe43a32873000c36e8dc1f;
}

// Pedersen builtin
const SHIFT_POINT_X: felt252 = 0x49ee3eba8c1600700ee1b87eb599f16716b0b1022947733551fde4050ca6804;
const SHIFT_POINT_Y: felt252 = 0x3ca0cfe4b3bc6ddf346d49d06ea0ed34e621062c0e056c1d0405d266e10268a;

const MAX_ADDRESS: felt252 = 0xffffffffffffffff;
const INITIAL_PC: felt252 = 1;

const MAX_LOG_N_STEPS: felt252 = 50;
const MAX_RANGE_CHECK: felt252 = 0xffff; // 2 ** 16 - 1
