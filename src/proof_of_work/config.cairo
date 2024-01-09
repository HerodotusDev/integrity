const MIN_PROOF_OF_WORK_BITS: u256 = 30;
const MAX_PROOF_OF_WORK_BITS: u256 = 50;

#[derive(Drop, Copy)]
struct ProofOfWorkConfig {
    // Proof of work difficulty (number of bits required to be 0).
    n_bits: u8,
}

#[generate_trait]
impl ProofOfWorkConfigImpl of ProofOfWorkConfigTrait {
    fn config_validate(ref self: ProofOfWorkConfig) {
        assert(self.n_bits.into() >= MIN_PROOF_OF_WORK_BITS, 'value proof of work bits to low');
        assert(self.n_bits.into() <= MAX_PROOF_OF_WORK_BITS, 'value proof of work bits to big');
    }
}
