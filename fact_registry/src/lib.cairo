mod verifier;

// use cairo_verifier::{StarkProofWithSerde, CairoVersion};
// use starknet::ContractAddress;

// #[starknet::interface]
// trait IFactRegistry<TContractState> {
//     fn verify_and_register_fact(
//         ref self: TContractState, stark_proof: StarkProofWithSerde, cairo_version: CairoVersion
//     );
//     fn verify_and_register_fact_from_contract(
//         ref self: TContractState, contract_address: ContractAddress
//     );
//     fn is_valid(self: @TContractState, fact: felt252) -> bool;
// }

// #[starknet::interface]
// trait ISmartProof<TContractState> {
//     fn get_proof(self: @TContractState) -> (Array<felt252>, CairoVersion);
// }

// #[starknet::contract]
// mod FactRegistry {
//     use cairo_verifier::{StarkProofWithSerde, CairoVersion};
//     use starknet::ContractAddress;
//     use core::{
//         poseidon::{Poseidon, PoseidonImpl, HashStateImpl}, keccak::keccak_u256s_be_inputs,
//         starknet::event::EventEmitter
//     };
//     use fact_registry::{verifier::{CairoVerifier, ICairoVerifier, StarkProof}, IFactRegistry};
//     use super::{ISmartProofDispatcher, ISmartProofDispatcherTrait};

//     component!(path: CairoVerifier, storage: cairo_verifier, event: CairoVerifierEvent);

//     #[storage]
//     struct Storage {
//         #[substorage(v0)]
//         cairo_verifier: CairoVerifier::Storage,
//         facts: LegacyMap<felt252, bool>,
//     }

//     #[event]
//     #[derive(Drop, starknet::Event)]
//     enum Event {
//         #[flat]
//         CairoVerifierEvent: CairoVerifier::Event,
//         FactRegistered: FactRegistered,
//     }

//     #[derive(Drop, starknet::Event)]
//     struct FactRegistered {
//         #[key]
//         fact: felt252,
//     }

//     #[abi(embed_v0)]
//     impl FactRegistryImpl of IFactRegistry<ContractState> {
//         fn verify_and_register_fact(
//             ref self: ContractState, stark_proof: StarkProofWithSerde, cairo_version: CairoVersion
//         ) {
//             let (program_hash, output_hash) = self
//                 .cairo_verifier
//                 .verify_proof(stark_proof.into(), cairo_version);
//             self._register_fact(program_hash, output_hash);
//         }

//         fn verify_and_register_fact_from_contract(
//             ref self: ContractState, contract_address: ContractAddress
//         ) {
//             let (proof_array, cairo_version) = ISmartProofDispatcher { contract_address }
//                 .get_proof();
//             let mut proof_array = proof_array.span();
//             let proof = Serde::<StarkProofWithSerde>::deserialize(ref proof_array).unwrap();
//             self.verify_and_register_fact(proof, cairo_version);
//         }

//         fn is_valid(self: @ContractState, fact: felt252) -> bool {
//             self.facts.read(fact)
//         }
//     }

//     #[generate_trait]
//     impl InternalFactRegistry of InternalFactRegistryTrait {
//         fn _register_fact(ref self: ContractState, program_hash: felt252, output_hash: felt252,) {
//             let fact = PoseidonImpl::new().update(program_hash).update(output_hash).finalize();
//             self.emit(Event::FactRegistered(FactRegistered { fact }));
//             self.facts.write(fact, true);
//         }
//     }
// }
