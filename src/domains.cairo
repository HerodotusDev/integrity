use cairo_verifier::{
    common::{consts::{FIELD_GENERATOR, STARK_PRIME_MINUS_ONE}, math::{pow, Felt252Div}},
    stark::StarkConfig,
};

// Information about the domains that are used in the stark proof.
#[derive(Drop, Copy, PartialEq)]
struct StarkDomains {
    // Log2 of the evaluation domain size.
    log_eval_domain_size: felt252,
    // The evaluation domain size.
    eval_domain_size: felt252,
    // The generator of the evaluation domain (a primitive root of unity of order eval_domain_size).
    eval_generator: felt252,
    // Log2 of the trace domain size.
    log_trace_domain_size: felt252,
    // The trace domain size.
    trace_domain_size: felt252,
    // The generator of the trace domain (a primitive root of unity of order trace_domain_size).
    trace_generator: felt252,
}

#[generate_trait]
impl StarkDomainsImpl of StarkDomainsTrait {
    fn new(log_trace_domain_size: felt252, log_n_cosets: felt252) -> StarkDomains {
        // Compute stark_domains.
        let log_eval_domain_size = log_trace_domain_size + log_n_cosets;
        let eval_domain_size = pow(2, log_eval_domain_size);
        let eval_generator = pow(FIELD_GENERATOR, STARK_PRIME_MINUS_ONE * 1 / eval_domain_size);
        let trace_domain_size = pow(2, log_trace_domain_size);
        let trace_generator = pow(FIELD_GENERATOR, STARK_PRIME_MINUS_ONE * 1 / trace_domain_size);

        StarkDomains {
            log_eval_domain_size,
            eval_domain_size,
            eval_generator,
            log_trace_domain_size,
            trace_domain_size,
            trace_generator,
        }
    }
}

#[cfg(test)]
mod tests {
    use cairo_verifier::{domains::{StarkDomains, StarkDomainsTrait}, tests::stone_proof_fibonacci,};
    // test data from cairo0-verifier keccak-native run on stone-prover generated proof
    #[test]
    #[available_gas(9999999999)]
    fn test_domain_creation() {
        let log_trace_domain_size = 0x12;
        let log_n_cosets = 0x4;

        assert(
            StarkDomainsTrait::new(
                log_trace_domain_size, log_n_cosets
            ) == stone_proof_fibonacci::stark::domains::get(),
            'Domain creation failed'
        )
    }
}
