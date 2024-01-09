use cairo_verifier::vector_commitment::vector_commitment::VectorCommitmentConfigTrait;
use cairo_verifier::{common::asserts::assert_in_range, table_commitment::TableCommitmentConfig};

const MAX_N_COLUMNS: felt252 = 128;
const AIR_LAYOUT_N_ORIGINAL_COLUMNS: felt252 = 12;
const AIR_LAYOUT_N_INTERACTION_COLUMNS: felt252 = 3;

// Configuration for the Traces component.
#[derive(Drop, Copy)]
struct TracesConfig {
    original: TableCommitmentConfig,
    interaction: TableCommitmentConfig,
}

#[generate_trait]
impl TracesConfigImpl of TracesConfigTrait {
    fn validate(
        self: @TracesConfig,
        log_eval_domain_size: felt252,
        n_verifier_friendly_commitment_layers: felt252,
    ) {
        assert_in_range(*self.original.n_columns, 1, MAX_N_COLUMNS + 1);
        assert_in_range(*self.interaction.n_columns, 1, MAX_N_COLUMNS + 1);
        assert(
            *self.original.n_columns == AIR_LAYOUT_N_ORIGINAL_COLUMNS, 'Wrong number of columns'
        );
        assert(
            *self.interaction.n_columns == AIR_LAYOUT_N_INTERACTION_COLUMNS,
            'Wrong number of columns'
        );

        self.original.vector.validate(log_eval_domain_size, n_verifier_friendly_commitment_layers);

        self
            .interaction
            .vector
            .validate(log_eval_domain_size, n_verifier_friendly_commitment_layers);
    }
}
// Validates the configuration of the traces.
// log_eval_domain_size - Log2 of the evaluation domain size.

