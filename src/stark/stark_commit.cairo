use core::traits::TryInto;
use core::array::ArrayTrait;
use core::option::OptionTrait;
use core::traits::Into;
use cairo_verifier::channel::channel::ChannelTrait;
use cairo_verifier::{
    air::{
        constants::{CONSTRAINT_DEGREE, N_CONSTRAINTS, N_INTERACTION_ELEMENTS, MASK_SIZE},
        public_input::PublicInput, traces::traces_commit,
    },
    channel::channel::Channel, common::powers_array::powers_array, domains::StarkDomains,
    fri::fri::fri_commit, stark::{StarkUnsentCommitment, StarkConfig, StarkCommitment},
    proof_of_work::proof_of_work::proof_of_work_commit, table_commitment::table_commit,
    oods::verify_oods,
};

#[derive(Drop, Copy)]
struct InteractionValuesAfterTraces {
    // n_constraints Coefficients for the AIR constraints.
    coefficients: Span<felt252>,
}

#[derive(Drop, Copy)]
struct InteractionValuesAfterOods {
    // n_oods_values coefficients for the boundary polynomial validating the OODS values.
    coefficients: Span<felt252>,
}

// STARK commitment phase.
fn stark_commit(
    ref channel: Channel,
    public_input: @PublicInput,
    unsent_commitment: @StarkUnsentCommitment,
    config: @StarkConfig,
    stark_domains: @StarkDomains,
) -> StarkCommitment {
    let traces_commitment = traces_commit(
        ref channel,
        N_INTERACTION_ELEMENTS,
        public_input,
        *unsent_commitment.traces,
        *config.traces,
    );

    let composition_alpha = channel.random_felt_to_prover();
    let traces_coefficients = powers_array(
        1, composition_alpha, N_CONSTRAINTS.try_into().unwrap(),
    );

    let interaction_after_traces = InteractionValuesAfterTraces {
        coefficients: traces_coefficients.span(),
    };

    let composition_commitment = table_commit(*unsent_commitment.composition, *config.composition,);

    let interaction_after_composition = channel.random_felt_to_prover();

    let n_oods_values = MASK_SIZE + CONSTRAINT_DEGREE.into();
    let sent_oods_values = channel.read_felts_from_prover(*unsent_commitment.oods_values);

    // Check that the trace and the composition agree at oods_point.
    // verify_oods(
    //     air=air,
    //     oods_values=sent_oods_values,
    //     traces_commitment=traces_commitment,
    //     traces_coefficients=traces_coefficients,
    //     oods_point=interaction_after_composition.oods_point,
    //     trace_domain_size=stark_domains.trace_domain_size,
    //     trace_generator=stark_domains.trace_generator,
    // );
    // verify_oods(sent_oods_values);

    let oods_alpha = channel.random_felt_to_prover();
    let oods_coefficients = powers_array(1, oods_alpha, n_oods_values.try_into().unwrap());
    let interaction_after_oods = InteractionValuesAfterOods {
        coefficients: oods_coefficients.span()
    };

    let fri_commitment = fri_commit(ref channel, *unsent_commitment.fri, *config.fri);

    proof_of_work_commit(ref channel, *unsent_commitment.proof_of_work, *config.proof_of_work);

    StarkCommitment {
        traces: traces_commitment,
        composition: composition_commitment,
        interaction_after_composition: interaction_after_composition,
        oods_values: array![].span(),
        interaction_after_oods: interaction_after_oods.coefficients,
        fri: fri_commitment,
    }
}
