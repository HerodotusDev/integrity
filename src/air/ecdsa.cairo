use cairo_verifier::air::ec_point::EcPoint;

struct EcdsaSigConfig {
    alpha: felt252,
    beta: felt252,
    shift_point: EcPoint
}
