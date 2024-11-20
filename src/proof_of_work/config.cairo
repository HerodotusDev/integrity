use integrity::common::asserts::assert_in_range;

const MAX_PROOF_OF_WORK_BITS: felt252 = 50;
const MIN_PROOF_OF_WORK_BITS: felt252 = 20;

#[derive(Drop, Copy, Serde)]
struct ProofOfWorkConfig {
    // Proof of work difficulty (number of bits required to be 0).
    n_bits: u8,
}

#[generate_trait]
impl ProofOfWorkConfigImpl of ProofOfWorkConfigTrait {
    fn validate(self: @ProofOfWorkConfig) {
        assert_in_range((*self.n_bits).into(), MIN_PROOF_OF_WORK_BITS, MAX_PROOF_OF_WORK_BITS);
    }
}
