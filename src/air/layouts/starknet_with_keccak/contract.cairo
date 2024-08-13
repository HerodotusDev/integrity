use cairo_verifier::air::layouts::starknet_with_keccak::global_values::GlobalValues;


#[starknet::interface]
trait IStarknetWithKeccakLayoutContract1parts<ContractState> {
    fn eval_composition_polynomial_inner(
        self: @ContractState,
        mask_values: Span<felt252>,
        constraint_coefficients: Span<felt252>,
        point: felt252,
        trace_generator: felt252,
        global_values: GlobalValues
    ) -> felt252;
}

#[starknet::interface]
trait IStarknetWithKeccakLayoutContract1<ContractState> {
    fn eval_composition_polynomial_inner(
        self: @ContractState,
        mask_values: Span<felt252>,
        constraint_coefficients: Span<felt252>,
        point: felt252,
        trace_generator: felt252,
        global_values: GlobalValues
    ) -> felt252;

    fn register_evaluation(
        ref self: ContractState,
        mask_values: Span<felt252>,
        constraint_coefficients: Span<felt252>,
        point: felt252,
        trace_generator: felt252,
        global_values: GlobalValues
    );
}

#[starknet::interface]
trait IStarknetWithKeccakLayoutContract2parts<ContractState> {
    fn eval_oods_polynomial_inner(
        self: @ContractState,
        column_values: Span<felt252>,
        oods_values: Span<felt252>,
        constraint_coefficients: Span<felt252>,
        point: felt252,
        oods_point: felt252,
        trace_generator: felt252,
    ) -> felt252;
}

#[starknet::interface]
trait IStarknetWithKeccakLayoutContract2<ContractState> {
    fn eval_oods_polynomial_inner(
        self: @ContractState,
        column_values: Span<felt252>,
        oods_values: Span<felt252>,
        constraint_coefficients: Span<felt252>,
        point: felt252,
        oods_point: felt252,
        trace_generator: felt252,
    ) -> felt252;

    fn register_evaluation(
        ref self: ContractState,
        column_values: Span<felt252>,
        oods_values: Span<felt252>,
        constraint_coefficients: Span<felt252>,
        point: felt252,
        oods_point: felt252,
        trace_generator: felt252,
    );
}

#[starknet::contract]
mod StarknetWithKeccakLayoutContract1 {
    use super::{
        IStarknetWithKeccakLayoutContract1,
        IStarknetWithKeccakLayoutContract1partsDispatcher,
        IStarknetWithKeccakLayoutContract1partsDispatcherTrait,
    };
    use cairo_verifier::air::layouts::starknet_with_keccak::global_values::GlobalValues;
    use starknet::ContractAddress;
    use core::poseidon::{Poseidon, PoseidonImpl, HashStateImpl};

    #[storage]
    struct Storage {
        contracts: LegacyMap::<felt252, ContractAddress>,
        contracts_count: felt252,
        registered: LegacyMap<felt252, Option<felt252>>,
    }

    #[constructor]
    fn constructor(ref self: ContractState, contracts: Array<ContractAddress>) {
        let n: felt252 = contracts.len().into();
        self.contracts_count.write(n);
        let mut i = 0;
        loop {
            if i.into() == n {
                break;
            }
            self.contracts.write(i.into(), *contracts.at(i));
            i += 1;
        };
    }

    #[abi(embed_v0)]
    impl StarknetWithKeccakLayoutContract1 of IStarknetWithKeccakLayoutContract1<ContractState> {
        fn register_evaluation(
            ref self: ContractState,
            mask_values: Span<felt252>,
            constraint_coefficients: Span<felt252>,
            point: felt252,
            trace_generator: felt252,
            global_values: GlobalValues
        ) {
            let mut total_sum = 0;
            let mut i: u32 = 0;
            let n: felt252 = self.contracts_count.read().into();
            let begin = array![
                0,
                95,
                195,
                229,
                260,
                285,
                310,
            ].span();
            let length = array![
                95,
                100,
                34,
                31,
                25,
                25,
                37,
            ].span();
            let result = loop {
                if i.into() == n {
                    break total_sum;
                }
                
                let contract = IStarknetWithKeccakLayoutContract1partsDispatcher {
                    contract_address: self.contracts.read(i.into())
                };
                let coeffs = constraint_coefficients.slice(*begin.at(i), *length.at(i));
                total_sum += contract.eval_composition_polynomial_inner(mask_values, coeffs, point, trace_generator, global_values);
                i += 1;
            };

            let hash = self._hash(mask_values, constraint_coefficients, point, trace_generator, global_values);
            
            self.registered.write(hash, Option::Some(result));
        }

        fn eval_composition_polynomial_inner(
            self: @ContractState,
            mask_values: Span<felt252>,
            constraint_coefficients: Span<felt252>,
            point: felt252,
            trace_generator: felt252,
            global_values: GlobalValues
        ) -> felt252 {
            let hash = self._hash(mask_values, constraint_coefficients, point, trace_generator, global_values);
            let mut result = self.registered.read(hash);
            if result.is_none() {
                register_evaluation(mask_values, constraint_coefficients, point, trace_generator, global_values);
                result = self.registered.read(hash);    
            }
            result.unwrap()
        }
    }

    #[generate_trait]
    impl InternalLayoutContractState of InternalLayoutContractTrait {
        fn _hash(
            self: @ContractState,
            mut mask_values: Span<felt252>,
            mut constraint_coefficients: Span<felt252>,
            point: felt252,
            trace_generator: felt252,
            global_values: GlobalValues
        ) -> felt252 {
            let mut hash = PoseidonImpl::new();
            hash = hash.update(mask_values.len().into());
            loop {
                match mask_values.pop_front() {
                    Option::Some(x) => {
                        hash = hash.update(*x);
                    },
                    Option::None => {
                        break;
                    }
                };
            };
            hash = hash.update(constraint_coefficients.len().into());
            loop {
                match constraint_coefficients.pop_front() {
                    Option::Some(x) => {
                        hash = hash.update(*x);
                    },
                    Option::None => {
                        break;
                    }
                };
            };
            hash.update(point)
                .update(trace_generator)
                .update(global_values.trace_length)
                .update(global_values.initial_pc)
                .update(global_values.final_pc)
                .update(global_values.initial_ap)
                .update(global_values.final_ap)
                .update(global_values.initial_pedersen_addr)
                .update(global_values.initial_range_check_addr)
                .update(global_values.initial_ecdsa_addr)
                .update(global_values.initial_bitwise_addr)
                .update(global_values.initial_ec_op_addr)
                .update(global_values.initial_keccak_addr)
                .update(global_values.initial_poseidon_addr)
                .update(global_values.range_check_min)
                .update(global_values.range_check_max)
                .update(global_values.offset_size)
                .update(global_values.half_offset_size)
                .update(global_values.pedersen_shift_point.x)
                .update(global_values.pedersen_shift_point.y)
                .update(global_values.ecdsa_sig_config.alpha)
                .update(global_values.ecdsa_sig_config.beta)
                .update(global_values.ecdsa_sig_config.shift_point.x)
                .update(global_values.ecdsa_sig_config.shift_point.y)
                .update(global_values.ec_op_curve_config.alpha)
                .update(global_values.ec_op_curve_config.beta)
                .update(global_values.pedersen_points_x)
                .update(global_values.pedersen_points_y)
                .update(global_values.ecdsa_generator_points_x)
                .update(global_values.ecdsa_generator_points_y)
                .update(global_values.keccak_keccak_keccak_round_key0)
                .update(global_values.keccak_keccak_keccak_round_key1)
                .update(global_values.keccak_keccak_keccak_round_key3)
                .update(global_values.keccak_keccak_keccak_round_key7)
                .update(global_values.keccak_keccak_keccak_round_key15)
                .update(global_values.keccak_keccak_keccak_round_key31)
                .update(global_values.keccak_keccak_keccak_round_key63)
                .update(global_values.poseidon_poseidon_full_round_key0)
                .update(global_values.poseidon_poseidon_full_round_key1)
                .update(global_values.poseidon_poseidon_full_round_key2)
                .update(global_values.poseidon_poseidon_partial_round_key0)
                .update(global_values.poseidon_poseidon_partial_round_key1)
                .update(global_values.memory_multi_column_perm_perm_interaction_elm)
                .update(global_values.memory_multi_column_perm_hash_interaction_elm0)
                .update(global_values.range_check16_perm_interaction_elm)
                .update(global_values.diluted_check_permutation_interaction_elm)
                .update(global_values.diluted_check_interaction_z)
                .update(global_values.diluted_check_interaction_alpha)
                .update(global_values.memory_multi_column_perm_perm_public_memory_prod)
                .update(global_values.range_check16_perm_public_memory_prod)
                .update(global_values.diluted_check_first_elm)
                .update(global_values.diluted_check_permutation_public_memory_prod)
                .update(global_values.diluted_check_final_cum_val)
                .finalize()
        }
    }
}

#[starknet::contract]
mod StarknetWithKeccakLayoutContract1part1 {
    use super::IStarknetWithKeccakLayoutContract1parts;
    use cairo_verifier::air::layouts::starknet_with_keccak::{
        global_values::GlobalValues,
        autogenerated::eval_composition_polynomial_inner_part1,
    };

    #[storage]
    struct Storage {}

    #[abi(embed_v0)]
    impl StarknetWithKeccakLayoutContract1part1 of IStarknetWithKeccakLayoutContract1parts<ContractState> {
        fn eval_composition_polynomial_inner(
            self: @ContractState,
            mask_values: Span<felt252>,
            constraint_coefficients: Span<felt252>,
            point: felt252,
            trace_generator: felt252,
            global_values: GlobalValues
        ) -> felt252 {
            eval_composition_polynomial_inner_part1(
                mask_values,
                constraint_coefficients,
                point,
                trace_generator,
                global_values
            )
        }
    }
}

#[starknet::contract]
mod StarknetWithKeccakLayoutContract1part2 {
    use super::IStarknetWithKeccakLayoutContract1parts;
    use cairo_verifier::air::layouts::starknet_with_keccak::{
        global_values::GlobalValues,
        autogenerated::eval_composition_polynomial_inner_part2,
    };

    #[storage]
    struct Storage {}

    #[abi(embed_v0)]
    impl StarknetWithKeccakLayoutContract1part2 of IStarknetWithKeccakLayoutContract1parts<ContractState> {
        fn eval_composition_polynomial_inner(
            self: @ContractState,
            mask_values: Span<felt252>,
            constraint_coefficients: Span<felt252>,
            point: felt252,
            trace_generator: felt252,
            global_values: GlobalValues
        ) -> felt252 {
            eval_composition_polynomial_inner_part2(
                mask_values,
                constraint_coefficients,
                point,
                trace_generator,
                global_values
            )
        }
    }
}

#[starknet::contract]
mod StarknetWithKeccakLayoutContract1part3 {
    use super::IStarknetWithKeccakLayoutContract1parts;
    use cairo_verifier::air::layouts::starknet_with_keccak::{
        global_values::GlobalValues,
        autogenerated::eval_composition_polynomial_inner_part3,
    };

    #[storage]
    struct Storage {}

    #[abi(embed_v0)]
    impl StarknetWithKeccakLayoutContract1part3 of IStarknetWithKeccakLayoutContract1parts<ContractState> {
        fn eval_composition_polynomial_inner(
            self: @ContractState,
            mask_values: Span<felt252>,
            constraint_coefficients: Span<felt252>,
            point: felt252,
            trace_generator: felt252,
            global_values: GlobalValues
        ) -> felt252 {
            eval_composition_polynomial_inner_part3(
                mask_values,
                constraint_coefficients,
                point,
                trace_generator,
                global_values
            )
        }
    }
}

#[starknet::contract]
mod StarknetWithKeccakLayoutContract1part4 {
    use super::IStarknetWithKeccakLayoutContract1parts;
    use cairo_verifier::air::layouts::starknet_with_keccak::{
        global_values::GlobalValues,
        autogenerated::eval_composition_polynomial_inner_part4,
    };

    #[storage]
    struct Storage {}

    #[abi(embed_v0)]
    impl StarknetWithKeccakLayoutContract1part4 of IStarknetWithKeccakLayoutContract1parts<ContractState> {
        fn eval_composition_polynomial_inner(
            self: @ContractState,
            mask_values: Span<felt252>,
            constraint_coefficients: Span<felt252>,
            point: felt252,
            trace_generator: felt252,
            global_values: GlobalValues
        ) -> felt252 {
            eval_composition_polynomial_inner_part4(
                mask_values,
                constraint_coefficients,
                point,
                trace_generator,
                global_values
            )
        }
    }
}

#[starknet::contract]
mod StarknetWithKeccakLayoutContract1part5 {
    use super::IStarknetWithKeccakLayoutContract1parts;
    use cairo_verifier::air::layouts::starknet_with_keccak::{
        global_values::GlobalValues,
        autogenerated::eval_composition_polynomial_inner_part5,
    };

    #[storage]
    struct Storage {}

    #[abi(embed_v0)]
    impl StarknetWithKeccakLayoutContract1part5 of IStarknetWithKeccakLayoutContract1parts<ContractState> {
        fn eval_composition_polynomial_inner(
            self: @ContractState,
            mask_values: Span<felt252>,
            constraint_coefficients: Span<felt252>,
            point: felt252,
            trace_generator: felt252,
            global_values: GlobalValues
        ) -> felt252 {
            eval_composition_polynomial_inner_part5(
                mask_values,
                constraint_coefficients,
                point,
                trace_generator,
                global_values
            )
        }
    }
}

#[starknet::contract]
mod StarknetWithKeccakLayoutContract1part6 {
    use super::IStarknetWithKeccakLayoutContract1parts;
    use cairo_verifier::air::layouts::starknet_with_keccak::{
        global_values::GlobalValues,
        autogenerated::eval_composition_polynomial_inner_part6,
    };

    #[storage]
    struct Storage {}

    #[abi(embed_v0)]
    impl StarknetWithKeccakLayoutContract1part6 of IStarknetWithKeccakLayoutContract1parts<ContractState> {
        fn eval_composition_polynomial_inner(
            self: @ContractState,
            mask_values: Span<felt252>,
            constraint_coefficients: Span<felt252>,
            point: felt252,
            trace_generator: felt252,
            global_values: GlobalValues
        ) -> felt252 {
            eval_composition_polynomial_inner_part6(
                mask_values,
                constraint_coefficients,
                point,
                trace_generator,
                global_values
            )
        }
    }
}

#[starknet::contract]
mod StarknetWithKeccakLayoutContract1part7 {
    use super::IStarknetWithKeccakLayoutContract1parts;
    use cairo_verifier::air::layouts::starknet_with_keccak::{
        global_values::GlobalValues,
        autogenerated::eval_composition_polynomial_inner_part7,
    };

    #[storage]
    struct Storage {}

    #[abi(embed_v0)]
    impl StarknetWithKeccakLayoutContract1part7 of IStarknetWithKeccakLayoutContract1parts<ContractState> {
        fn eval_composition_polynomial_inner(
            self: @ContractState,
            mask_values: Span<felt252>,
            constraint_coefficients: Span<felt252>,
            point: felt252,
            trace_generator: felt252,
            global_values: GlobalValues
        ) -> felt252 {
            eval_composition_polynomial_inner_part7(
                mask_values,
                constraint_coefficients,
                point,
                trace_generator,
                global_values
            )
        }
    }
}

#[starknet::contract]
mod StarknetWithKeccakLayoutContract2part1 {
    use super::IStarknetWithKeccakLayoutContract2;
    use cairo_verifier::air::layouts::starknet_with_keccak::{
        global_values::GlobalValues,
        autogenerated::eval_oods_polynomial_inner_part1,
    };

    #[storage]
    struct Storage {}

    #[abi(embed_v0)]
    impl StarknetWithKeccakLayoutContract2part1 of IStarknetWithKeccakLayoutContract2parts<ContractState> {
        fn eval_oods_polynomial_inner(
            self: @ContractState,
            column_values: Span<felt252>,
            oods_values: Span<felt252>,
            constraint_coefficients: Span<felt252>,
            point: felt252,
            oods_point: felt252,
            trace_generator: felt252,
        ) -> felt252 {
            eval_oods_polynomial_inner_part1(
                column_values,
                oods_values,
                constraint_coefficients,
                point,
                oods_point,
                trace_generator,
            )
        }
    }
}

#[starknet::contract]
mod StarknetWithKeccakLayoutContract2part2 {
    use super::IStarknetWithKeccakLayoutContract2;
    use cairo_verifier::air::layouts::starknet_with_keccak::{
        global_values::GlobalValues,
        autogenerated::eval_oods_polynomial_inner_part2,
    };

    #[storage]
    struct Storage {}

    #[abi(embed_v0)]
    impl StarknetWithKeccakLayoutContract2part2 of IStarknetWithKeccakLayoutContract2parts<ContractState> {
        fn eval_oods_polynomial_inner(
            self: @ContractState,
            column_values: Span<felt252>,
            oods_values: Span<felt252>,
            constraint_coefficients: Span<felt252>,
            point: felt252,
            oods_point: felt252,
            trace_generator: felt252,
        ) -> felt252 {
            eval_oods_polynomial_inner_part2(
                column_values,
                oods_values,
                constraint_coefficients,
                point,
                oods_point,
                trace_generator,
            )
        }
    }
}

#[starknet::contract]
mod StarknetWithKeccakLayoutContract2 {
    use super::{IStarknetWithKeccakLayoutContract2, IStarknetWithKeccakLayoutContract2partsDispatcher, IStarknetWithKeccakLayoutContract2partsDispatcherTrait};
    use cairo_verifier::air::layouts::starknet_with_keccak::global_values::GlobalValues;
    use starknet::ContractAddress;
    use core::poseidon::{Poseidon, PoseidonImpl, HashStateImpl};

    #[storage]
    struct Storage {
        contract_address_1: ContractAddress,
        contract_address_2: ContractAddress,
        registered: LegacyMap<felt252, Option<felt252>>,
    }

    #[constructor]
    fn constructor(ref self: ContractState, contract_address_1: ContractAddress, contract_address_2: ContractAddress) {
        self.contract_address_1.write(contract_address_1);
        self.contract_address_2.write(contract_address_2);
    }

    #[abi(embed_v0)]
    impl StarknetWithKeccakLayoutContract2 of IStarknetWithKeccakLayoutContract2<ContractState> {
        fn register_evaluation(
            ref self: ContractState,
            column_values: Span<felt252>,
            oods_values: Span<felt252>,
            constraint_coefficients: Span<felt252>,
            point: felt252,
            oods_point: felt252,
            trace_generator: felt252,
        ) {
            let coeffs1 = constraint_coefficients.slice(0, 349);
            let coeffs2 = constraint_coefficients.slice(349, constraint_coefficients.len() - 349);
            let oods1 = oods_values.slice(0, 349);
            let oods2 = oods_values.slice(349, oods_values.len() - 349);

            let sum1 = IStarknetWithKeccakLayoutContract2partsDispatcher {
                contract_address: self.contract_address_1.read()
            }.eval_oods_polynomial_inner(column_values, oods1, coeffs1, point, oods_point, trace_generator);
            let sum2 = IStarknetWithKeccakLayoutContract2partsDispatcher {
                contract_address: self.contract_address_2.read()
            }.eval_oods_polynomial_inner(column_values, oods2, coeffs2, point, oods_point, trace_generator);

            let hash = self._hash(column_values, oods_values, constraint_coefficients, point, oods_point, trace_generator);
            
            self.registered.write(hash, Option::Some(sum1 + sum2));
        }

        fn eval_oods_polynomial_inner(
            self: @ContractState,
            column_values: Span<felt252>,
            oods_values: Span<felt252>,
            constraint_coefficients: Span<felt252>,
            point: felt252,
            oods_point: felt252,
            trace_generator: felt252,
        ) -> felt252 {
            let hash = self._hash(column_values, oods_values, constraint_coefficients, point, oods_point, trace_generator);
            let mut result = self.registered.read(hash);
            if result.is_none() {
                register_evaluation(column_values, oods_values, constraint_coefficients, point, oods_point, trace_generator);
                result = self.registered.read(hash);    
            }
            result.unwrap()
        }
    }

    #[generate_trait]
    impl InternalLayoutContractState of InternalLayoutContractTrait {
        fn _hash(
            self: @ContractState,
            mut column_values: Span<felt252>,
            mut oods_values: Span<felt252>,
            mut constraint_coefficients: Span<felt252>,
            point: felt252,
            oods_point: felt252,
            trace_generator: felt252,
        ) -> felt252 {
            let mut hash = PoseidonImpl::new();
            hash = hash.update(column_values.len().into());
            loop {
                match column_values.pop_front() {
                    Option::Some(x) => {
                        hash = hash.update(*x);
                    },
                    Option::None => {
                        break;
                    }
                };
            };
            hash = hash.update(oods_values.len().into());
            loop {
                match oods_values.pop_front() {
                    Option::Some(x) => {
                        hash = hash.update(*x);
                    },
                    Option::None => {
                        break;
                    }
                };
            };
            hash = hash.update(constraint_coefficients.len().into());
            loop {
                match constraint_coefficients.pop_front() {
                    Option::Some(x) => {
                        hash = hash.update(*x);
                    },
                    Option::None => {
                        break;
                    }
                };
            };
            hash.update(point)
                .update(oods_point)
                .update(trace_generator)
                .finalize()
        }
    }
}
