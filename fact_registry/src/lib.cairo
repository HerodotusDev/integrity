use cairo_verifier::deserialization::stark::StarkProofWithSerde;

mod component;

#[starknet::interface]
trait IFactRegistry<TContractState> {
    fn verify_and_register_fact(ref self: TContractState, stark_proof: StarkProofWithSerde);
    fn is_valid(self: @TContractState, fact: u256) -> bool;
}

#[starknet::contract]
mod FactRegistry {
    use cairo_verifier::deserialization::stark::{StarkProofWithSerde, StarkProofWithSerdeTrait};
    use core::keccak::keccak_u256s_be_inputs;

    #[storage]
    struct Storage {
        facts: LegacyMap<u256, bool>,
    }

    #[abi(embed_v0)]
    impl FactRegistryImpl of super::IFactRegistry<ContractState> {
        fn verify_and_register_fact(ref self: ContractState, stark_proof: StarkProofWithSerde) {
            let (program_hash, program_output_hash) = stark_proof.verify();
            self
                .facts
                .write(
                    keccak_u256s_be_inputs(array![program_hash, program_output_hash].span()), true
                );
        }
        fn is_valid(self: @ContractState, fact: u256) -> bool {
            self.facts.read(fact)
        }
    }
}
