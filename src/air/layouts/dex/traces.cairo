use cairo_verifier::{
    air::{
        public_input::PublicInput,
        layouts::dex::{
            constants::{NUM_COLUMNS_FIRST, NUM_COLUMNS_SECOND}, global_values::InteractionElements,
        }
    },
    channel::channel::{Channel, ChannelTrait},
    table_commitment::table_commitment::{
        TableCommitment, TableDecommitment, TableCommitmentWitness, table_commit, table_decommit,
        TableCommitmentConfig
    },
    vector_commitment::vector_commitment::VectorCommitmentConfigTrait,
    common::asserts::assert_in_range
};

// A protocol component (see stark.cairo for details about protocol components) for the traces
// of the CPU AIR.
// This component is commonly right before the FRI component.
// In this case:
//   n_queries = n_fri_queries * 2^first_fri_step.
//   decommitment.original.n_queries = n_original_columns * n_queries.
//   decommitment.interaction.n_queries = n_interaction_columns * n_queries.

// Commitment values for the Traces component. Used to generate a commitment by "reading" these
// values from the channel.
#[derive(Drop, Copy, Serde)]
struct TracesUnsentCommitment {
    original: felt252,
    interaction: felt252,
}

// Commitment for the Traces component.
#[derive(Drop, PartialEq, Serde)]
struct TracesCommitment {
    // Commitment to the first trace.
    original: TableCommitment,
    // The interaction elements that were sent to the prover after the first trace commitment (e.g.
    // memory interaction).
    interaction_elements: InteractionElements,
    // Commitment to the second (interaction) trace.
    interaction: TableCommitment,
}

// Responses for queries to the AIR commitment.
// The queries are usually generated by the next component down the line (e.g. FRI).
#[derive(Drop, Copy, Serde)]
struct TracesDecommitment {
    // Responses for queries to the original trace.
    original: TableDecommitment,
    // Responses for queries to the interaction trace.
    interaction: TableDecommitment,
}

// A witness for a decommitment of the AIR traces over queries.
#[derive(Drop, Copy, Serde)]
struct TracesWitness {
    original: TableCommitmentWitness,
    interaction: TableCommitmentWitness,
}

const MAX_N_COLUMNS: felt252 = 128;

// Configuration for the Traces component.
#[derive(Drop, Copy, Serde)]
struct TracesConfig {
    original: TableCommitmentConfig,
    interaction: TableCommitmentConfig,
}

#[generate_trait]
impl TracesConfigImpl of TracesConfigTrait {
    fn validate(
        self: @TracesConfig,
        public_input: @PublicInput,
        log_eval_domain_size: felt252,
        n_verifier_friendly_commitment_layers: felt252,
    ) {
        assert_in_range(*self.original.n_columns, 1, MAX_N_COLUMNS + 1);
        assert_in_range(*self.interaction.n_columns, 1, MAX_N_COLUMNS + 1);
        assert(*self.original.n_columns == NUM_COLUMNS_FIRST.into(), 'Wrong number of columns');
        assert(*self.interaction.n_columns == NUM_COLUMNS_SECOND.into(), 'Wrong number of columns');

        self.original.vector.validate(log_eval_domain_size, n_verifier_friendly_commitment_layers);

        self
            .interaction
            .vector
            .validate(log_eval_domain_size, n_verifier_friendly_commitment_layers);
    }
}

// Reads the traces commitment from the channel.
// Returns the commitment, along with GlobalValue required to evaluate the constraint polynomial.
fn traces_commit(
    ref channel: Channel, unsent_commitment: TracesUnsentCommitment, config: TracesConfig
) -> TracesCommitment {
    // Read original commitment.
    let original_commitment = table_commit(
        ref channel, unsent_commitment.original, config.original
    );
    // Generate interaction elements for the first interaction.
    let interaction_elements = InteractionElements {
        memory_multi_column_perm_perm_interaction_elm: channel.random_felt_to_prover(),
        memory_multi_column_perm_hash_interaction_elm0: channel.random_felt_to_prover(),
        range_check16_perm_interaction_elm: channel.random_felt_to_prover(),
    };
    // Read interaction commitment.
    let interaction_commitment = table_commit(
        ref channel, unsent_commitment.interaction, config.interaction
    );

    TracesCommitment {
        original: original_commitment,
        interaction_elements: interaction_elements,
        interaction: interaction_commitment,
    }
}

// Verifies a decommitment for the traces at the query indices.
// decommitment - holds the commited values of the leaves at the query_indices.
fn traces_decommit(
    queries: Span<felt252>,
    commitment: TracesCommitment,
    decommitment: TracesDecommitment,
    witness: TracesWitness,
) {
    table_decommit(commitment.original, queries, decommitment.original, witness.original);
    table_decommit(commitment.interaction, queries, decommitment.interaction, witness.interaction)
}
