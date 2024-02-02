use cairo_verifier::deserialization::stark::StarkProofWithSerde;

mod component;

#[starknet::interface]
trait IFactRegistry<TContractState> {
    fn verify_and_register_fact(ref self: TContractState, stark_proof: StarkProofWithSerde);
    fn is_valid(self: @TContractState, fact: felt252) -> bool;
}

#[starknet::contract]
mod FactRegistry {
    use cairo_verifier::{
        deserialization::stark::StarkProofWithSerde, stark::{StarkProof, StarkProofTrait},
    };
    use core::poseidon::{Poseidon, PoseidonImpl, HashStateImpl};

    #[storage]
    struct Storage {
        facts: LegacyMap<felt252, bool>,
    }

    #[abi(embed_v0)]
    impl FactRegistryImpl of super::IFactRegistry<ContractState> {
        fn verify_and_register_fact(ref self: ContractState, stark_proof: StarkProofWithSerde) {
            let stark_proof: StarkProof = stark_proof.into();
            let (program_hash, program_output_hash) = stark_proof.verify();
            let fact = PoseidonImpl::new()
                .update(program_hash)
                .update(program_output_hash)
                .finalize();
            self.facts.write(fact, true);
        }
        fn is_valid(self: @ContractState, fact: felt252) -> bool {
            self.facts.read(fact)
        }
    }
}
