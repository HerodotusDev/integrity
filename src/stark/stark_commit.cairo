use cairo_verifier::{
    // === DEX BEGIN ===
    // air::layouts::dex::{
    // constants::{CONSTRAINT_DEGREE, N_CONSTRAINTS, MASK_SIZE}, public_input::PublicInput,
    // traces::traces_commit,
    // },
    // === DEX END ===
    // === RECURSIVE BEGIN ===
    air::layouts::recursive::{
        constants::{CONSTRAINT_DEGREE, N_CONSTRAINTS, MASK_SIZE}, public_input::PublicInput,
        traces::traces_commit,
    },
    // === RECURSIVE END ===
    // === RECURSIVE_WITH_POSEIDON BEGIN ===
    // air::layouts::recursive_with_poseidon::{
    // constants::{CONSTRAINT_DEGREE, N_CONSTRAINTS, MASK_SIZE}, public_input::PublicInput,
    // traces::traces_commit,
    // },
    // === RECURSIVE_WITH_POSEIDON END ===
    // === SMALL BEGIN ===
    // air::layouts::small::{
    // constants::{CONSTRAINT_DEGREE, N_CONSTRAINTS, MASK_SIZE}, public_input::PublicInput,
    // traces::traces_commit,
    // },
    // === SMALL END ===
    // === STARKNET BEGIN ===
    // air::layouts::starknet::{
    // constants::{CONSTRAINT_DEGREE, N_CONSTRAINTS, MASK_SIZE}, public_input::PublicInput,
    // traces::traces_commit,
    // },
    // === STARKNET END ===
    // === STARKNET_WITH_KECCAK BEGIN ===
    // air::layouts::starknet_with_keccak::{
    // constants::{CONSTRAINT_DEGREE, N_CONSTRAINTS, MASK_SIZE}, public_input::PublicInput,
    // traces::traces_commit,
    // },
    // === STARKNET_WITH_KECCAK END ===
    // === DYNAMIC BEGIN ===
    // air::layouts::dynamic::{
    // constants::{CONSTRAINT_DEGREE, N_CONSTRAINTS, MASK_SIZE}, public_input::PublicInput,
    // traces::traces_commit,
    // },
    // === DYNAMIC END ===
    channel::channel::{Channel, ChannelTrait}, common::powers_array::powers_array,
    domains::StarkDomains, fri::fri::fri_commit,
    stark::{StarkUnsentCommitment, StarkConfig, StarkCommitment},
    proof_of_work::proof_of_work::proof_of_work_commit,
    table_commitment::table_commitment::table_commit, oods::verify_oods,
};


// STARK commitment phase.
fn stark_commit(
    ref channel: Channel,
    public_input: @PublicInput,
    unsent_commitment: @StarkUnsentCommitment,
    config: @StarkConfig,
    stark_domains: @StarkDomains,
) -> StarkCommitment {
    // Read the commitment of the 'traces' component.
    let traces_commitment = traces_commit(ref channel, *unsent_commitment.traces, *config.traces,);

    // Generate interaction values after traces commitment.
    let composition_alpha = channel.random_felt_to_prover();
    let traces_coefficients = powers_array(1, composition_alpha, N_CONSTRAINTS).span();

    // Read composition commitment.
    let composition_commitment = table_commit(
        ref channel, *unsent_commitment.composition, *config.composition,
    );

    // Generate interaction values after composition.
    let interaction_after_composition = channel.random_felt_to_prover();

    // Read OODS values.
    channel.read_felt_vector_from_prover(*unsent_commitment.oods_values);

    // Check that the trace and the composition agree at oods_point.
    verify_oods(
        *unsent_commitment.oods_values,
        traces_commitment.interaction_elements,
        public_input,
        traces_coefficients,
        interaction_after_composition,
        *stark_domains.trace_domain_size,
        *stark_domains.trace_generator,
    );

    // Generate interaction values after OODS.
    let oods_alpha = channel.random_felt_to_prover();
    let oods_coefficients = powers_array(1, oods_alpha, MASK_SIZE + CONSTRAINT_DEGREE);

    // Read fri commitment.
    let fri_commitment = fri_commit(ref channel, *unsent_commitment.fri, *config.fri);

    // Proof of work commitment phase.
    proof_of_work_commit(ref channel, *unsent_commitment.proof_of_work, *config.proof_of_work);

    // Return commitment.
    StarkCommitment {
        traces: traces_commitment,
        composition: composition_commitment,
        interaction_after_composition: interaction_after_composition,
        oods_values: *unsent_commitment.oods_values,
        interaction_after_oods: oods_coefficients.span(),
        fri: fri_commitment,
    }
}
