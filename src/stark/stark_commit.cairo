use core::array::ArrayTrait;
use core::option::OptionTrait;
use core::traits::Into;
use cairo_verifier::channel::channel::ChannelTrait;
use cairo_verifier::{
    air::{layout::{AirWithLayout, Layout}, public_input::PublicInput, traces::traces_commit,},
    channel::channel::Channel, common::powers_array::powers_array, domains::StarkDomains,
    fri::fri::fri_commit, stark::{StarkUnsentCommitment, StarkConfig, StarkCommitment},
    proof_of_work::proof_of_work::proof_of_work_commit, table_commitment::table_commit,
    oods::verify_oods,
};

struct InteractionValuesAfterTraces {
    // n_constraints Coefficients for the AIR constraints.
    coefficients: Span<felt252>,
}

struct InteractionValuesAfterOods {
    // n_oods_values coefficients for the boundary polynomial validating the OODS values.
    coefficients: Span<felt252>,
}

// STARK commitment phase.
fn stark_commit(
    ref channel: Channel,
    air: @AirWithLayout,
    public_input: @PublicInput,
    unsent_commitment: @StarkUnsentCommitment,
    config: @StarkConfig,
    stark_domains: @StarkDomains,
) -> StarkCommitment {
    // alloc_locals;

    // Read the commitment of the 'traces' component.
    // let (traces_commitment) = traces_commit(
    //     air=air,
    //     public_input=public_input,
    //     unsent_commitment=unsent_commitment.traces,
    //     config=config.traces,
    // );
    let traces_commitment = traces_commit(
        ref channel,
        *air.layout.n_interaction_elements,
        *public_input,
        *unsent_commitment.traces,
        *config.traces,
    );

    // Generate interaction values after traces commitment.
    // let (composition_alpha: felt*) = alloc();
    // random_felts_to_prover(n_elements=1, elements=composition_alpha);
    // let (traces_coefficients: felt*) = alloc();
    // compute_powers_array(
    //     data_ptr=traces_coefficients, alpha=[composition_alpha], cur=1, n=air.n_constraints
    // );
    let composition_alpha = channel.random_felt_to_prover();
    let traces_coefficients = powers_array(
        1, composition_alpha, (*air.air.n_constraints).try_into().unwrap()
    );

    // let (interaction_after_traces: InteractionValuesAfterTraces*) = alloc();
    // assert [interaction_after_traces] = InteractionValuesAfterTraces(
    //     coefficients=traces_coefficients
    // );
    let interaction_after_traces = InteractionValuesAfterTraces {
        coefficients: traces_coefficients.span(),
    };

    // Read composition commitment.
    // let (composition_commitment: TableCommitment*) = table_commit(
    //     unsent_commitment=unsent_commitment.composition, config=config.composition
    // );
    let composition_commitment = table_commit(*unsent_commitment.composition, *config.composition,);

    // Generate interaction values after composition.
    // let (interaction_after_composition: InteractionValuesAfterComposition*) = alloc();
    // random_felts_to_prover(
    //     n_elements=InteractionValuesAfterComposition.SIZE,
    //     elements=cast(interaction_after_composition, felt*),
    // );
    let interaction_after_composition = channel.random_felt_to_prover();

    // Read OODS values.
    // local n_oods_values = air.mask_size + air.constraint_degree;
    // let (sent_oods_values) = read_felts_from_prover(
    //     n_values=n_oods_values, values=unsent_commitment.oods_values
    // );
    let n_oods_values = *air.air.mask_size + *air.air.constraint_degree;
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
    verify_oods(sent_oods_values);

    // Generate interaction values after OODS.
    // let (oods_alpha: felt*) = alloc();
    // random_felts_to_prover(n_elements=1, elements=oods_alpha);
    // let (oods_coefficients: felt*) = alloc();
    // compute_powers_array(data_ptr=oods_coefficients, alpha=[oods_alpha], cur=1, n=n_oods_values);
    // tempvar interaction_after_oods = new InteractionValuesAfterOods(coefficients=oods_coefficients);
    let oods_alpha = channel.random_felt_to_prover();
    let oods_coefficients = powers_array(1, oods_alpha, n_oods_values.try_into().unwrap());
    let interaction_after_oods = InteractionValuesAfterOods {
        coefficients: oods_coefficients.span()
    };

    // Read fri commitment.
    // let (fri_commitment) = fri_commit(unsent_commitment=unsent_commitment.fri, config=config.fri);
    let fri_commitment = fri_commit(ref channel, *unsent_commitment.fri, *config.fri);

    // Proof of work commitment phase.
    // proof_of_work_commit(
    //     unsent_commitment=unsent_commitment.proof_of_work, config=config.proof_of_work
    // );
    proof_of_work_commit(ref channel, *unsent_commitment.proof_of_work, *config.proof_of_work);

    // Return commitment.
    // return (
    //     res=new StarkCommitment(
    //         traces=traces_commitment,
    //         composition=composition_commitment,
    //         interaction_after_composition=interaction_after_composition,
    //         oods_values=sent_oods_values,
    //         interaction_after_oods=interaction_after_oods,
    //         fri=fri_commitment,
    //     ),
    // );
    StarkCommitment {
        traces: traces_commitment,
        composition: composition_commitment,
        interaction_after_composition: interaction_after_composition,
        oods_values: sent_oods_values,
        interaction_after_oods: interaction_after_oods.coefficients,
        fri: fri_commitment,
    }
}
