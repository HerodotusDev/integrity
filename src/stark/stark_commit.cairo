#[cfg(feature: 'dex')]
use integrity::air::layouts::dex::constants::{CONSTRAINT_DEGREE, MASK_SIZE, N_CONSTRAINTS};
#[cfg(feature: 'dex')]
use integrity::air::layouts::dex::public_input::PublicInput;
#[cfg(feature: 'dex')]
use integrity::air::layouts::dex::traces::traces_commit;
#[cfg(feature: 'recursive')]
use integrity::air::layouts::recursive::constants::{CONSTRAINT_DEGREE, MASK_SIZE, N_CONSTRAINTS};
#[cfg(feature: 'recursive')]
use integrity::air::layouts::recursive::public_input::PublicInput;
#[cfg(feature: 'recursive')]
use integrity::air::layouts::recursive::traces::traces_commit;
#[cfg(feature: 'recursive_with_poseidon')]
use integrity::air::layouts::recursive_with_poseidon::constants::{
    CONSTRAINT_DEGREE, MASK_SIZE, N_CONSTRAINTS,
};
#[cfg(feature: 'recursive_with_poseidon')]
use integrity::air::layouts::recursive_with_poseidon::public_input::PublicInput;
#[cfg(feature: 'recursive_with_poseidon')]
use integrity::air::layouts::recursive_with_poseidon::traces::traces_commit;
#[cfg(feature: 'small')]
use integrity::air::layouts::small::constants::{CONSTRAINT_DEGREE, MASK_SIZE, N_CONSTRAINTS};
#[cfg(feature: 'small')]
use integrity::air::layouts::small::public_input::PublicInput;
#[cfg(feature: 'small')]
use integrity::air::layouts::small::traces::traces_commit;
#[cfg(feature: 'starknet')]
use integrity::air::layouts::starknet::constants::{CONSTRAINT_DEGREE, MASK_SIZE, N_CONSTRAINTS};
#[cfg(feature: 'starknet')]
use integrity::air::layouts::starknet::public_input::PublicInput;
#[cfg(feature: 'starknet')]
use integrity::air::layouts::starknet::traces::traces_commit;
#[cfg(feature: 'starknet_with_keccak')]
use integrity::air::layouts::starknet_with_keccak::constants::{
    CONSTRAINT_DEGREE, MASK_SIZE, N_CONSTRAINTS,
};
#[cfg(feature: 'starknet_with_keccak')]
use integrity::air::layouts::starknet_with_keccak::public_input::PublicInput;
#[cfg(feature: 'starknet_with_keccak')]
use integrity::air::layouts::starknet_with_keccak::traces::traces_commit;
use integrity::channel::channel::{Channel, ChannelTrait};
use integrity::common::powers_array::powers_array;
use integrity::domains::StarkDomains;
use integrity::fri::fri::fri_commit;
use integrity::oods::verify_oods;
use integrity::proof_of_work::proof_of_work::proof_of_work_commit;
use integrity::stark::{StarkCommitment, StarkConfig, StarkUnsentCommitment};
use integrity::table_commitment::table_commitment::table_commit;
use starknet::ContractAddress;

// STARK commitment phase.
fn stark_commit(
    ref channel: Channel,
    public_input: @PublicInput,
    unsent_commitment: @StarkUnsentCommitment,
    config: @StarkConfig,
    stark_domains: @StarkDomains,
    contract_address: ContractAddress,
) -> StarkCommitment {
    // Read the commitment of the 'traces' component.
    let traces_commitment = traces_commit(ref channel, *unsent_commitment.traces, *config.traces);

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
        contract_address,
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
