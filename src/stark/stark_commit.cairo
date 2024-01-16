use core::traits::TryInto;
use core::array::ArrayTrait;
use core::option::OptionTrait;
use core::traits::Into;
use cairo_verifier::channel::channel::ChannelTrait;
use cairo_verifier::{
    air::{
        constants::{CONSTRAINT_DEGREE, N_CONSTRAINTS, N_INTERACTION_ELEMENTS, MASK_SIZE},
        global_values::InteractionElements, public_input::PublicInput, traces::traces_commit,
    },
    channel::channel::Channel, common::powers_array::powers_array, domains::StarkDomains,
    oods::OodsValues, fri::fri::fri_commit,
    stark::{StarkUnsentCommitment, StarkConfig, StarkCommitment},
    proof_of_work::proof_of_work::proof_of_work_commit, table_commitment::table_commitment::table_commit,
    oods::verify_oods,
};


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

    let composition_commitment = table_commit(ref channel, *unsent_commitment.composition, *config.composition,);

    let interaction_after_composition = channel.random_felt_to_prover();

    let n_oods_values = MASK_SIZE + CONSTRAINT_DEGREE.into();
    channel.read_felts_from_prover(*unsent_commitment.oods_values);

    let interaction_elements = InteractionElements {
        memory_multi_column_perm_perm_interaction_elm: 0,
        memory_multi_column_perm_hash_interaction_elm0: 0,
        rc16_perm_interaction_elm: 0,
        diluted_check_permutation_interaction_elm: 0,
        diluted_check_interaction_z: 0,
        diluted_check_interaction_alpha: 0,
    };

    let oods = *unsent_commitment.oods_values;
    let mut mask_values = array![];
    let mut i = 0;
    loop {
        if i == oods.len() - 2 {
            break;
        }

        mask_values.append(*oods.at(i));

        i += 1;
    };
    let split_polynomials = array![*oods.at(i), *oods.at(i + 1)];
    let oods_values = OodsValues { mask_values, split_polynomials };

    verify_oods(
        oods_values,
        interaction_elements,
        public_input,
        traces_coefficients,
        interaction_after_composition,
        *stark_domains.trace_generator,
        *stark_domains.trace_domain_size
    );

    let oods_alpha = channel.random_felt_to_prover();
    let oods_coefficients = powers_array(1, oods_alpha, n_oods_values.try_into().unwrap());

    let fri_commitment = fri_commit(ref channel, *unsent_commitment.fri, *config.fri);

    proof_of_work_commit(ref channel, *unsent_commitment.proof_of_work, *config.proof_of_work);

    StarkCommitment {
        traces: traces_commitment,
        composition: composition_commitment,
        interaction_after_composition: interaction_after_composition,
        oods_values: *unsent_commitment.oods_values,
        interaction_after_oods: oods_coefficients.span(),
        fri: fri_commitment,
    }
}
