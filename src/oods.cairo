use cairo_verifier::air::composition::eval_composition_polynomial;
use cairo_verifier::air::global_values::InteractionElements;
use cairo_verifier::air::public_input::PublicInput;

struct OodsValues {
    mask_values: Array<felt252>,
    split_polynomials: Array<felt252>
}

fn verify_oods(
    oods: OodsValues,
    interaction_elements: InteractionElements,
    public_input: PublicInput,
    constraint_coefficients: Array<felt252>,
    oods_point: felt252,
    trace_domain_size: felt252,
    trace_generator: felt252
) {
    let composition_from_trace = eval_composition_polynomial(
        interaction_elements,
        public_input,
        oods.mask_values,
        constraint_coefficients,
        oods_point,
        trace_domain_size,
        trace_generator
    );

    // TODO support degree > 2?
    let claimed_composition = *oods.split_polynomials.at(0)
        + *oods.split_polynomials.at(1) * oods_point;

    assert(composition_from_trace == claimed_composition, 'Invalid OODS');
}
