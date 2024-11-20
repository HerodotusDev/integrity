use integrity::{
    settings::{FactHash, VerifierPreset, VerificationHash, SecurityBits, VerifierConfiguration,},
};
use starknet::ContractAddress;

#[derive(Drop, Copy, Serde)]
struct VerificationListElement {
    verification_hash: VerificationHash,
    security_bits: SecurityBits,
    verifier_config: VerifierConfiguration,
}

#[derive(Drop, Copy, Serde, starknet::Store)]
struct Verification {
    fact_hash: FactHash,
    security_bits: SecurityBits,
    verifier_config: VerifierConfiguration,
}

#[starknet::interface]
trait IFactRegistry<TContractState> {
    fn get_all_verifications_for_fact_hash(
        self: @TContractState, fact_hash: FactHash
    ) -> Array<VerificationListElement>;

    fn get_verification(
        self: @TContractState, verification_hash: VerificationHash
    ) -> Option<Verification>;

    fn get_verifier_address(self: @TContractState, preset: VerifierPreset) -> ContractAddress;
}
