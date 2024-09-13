use cairo_verifier::air::layouts::starknet_with_keccak::global_values::GlobalValues;

#[starknet::interface]
trait ILayoutCompositionContract<ContractState> {
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
trait ILayoutOodsContract<ContractState> {
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

#[starknet::contract]
mod LayoutCompositionContract {
<<<<<<< HEAD
    use super::{
        ILayoutCompositionContract, ILayoutCompositionContractDispatcher,
        ILayoutCompositionContractDispatcherTrait
    };
=======
    use super::ILayoutCompositionContract;
>>>>>>> autogenerated_split
    use cairo_verifier::air::layouts::starknet_with_keccak::{global_values::GlobalValues,};
    use starknet::ContractAddress;

    #[storage]
    struct Storage {
<<<<<<< HEAD
        continuation_contract1: ContractAddress,
        continuation_contract2: ContractAddress,
        continuation_contract3: ContractAddress,
        continuation_contract4: ContractAddress,
        continuation_contract5: ContractAddress,
        continuation_contract6: ContractAddress,
        continuation_contract7: ContractAddress,
=======
        continuation_contracts: Array<ContractAddress>,
>>>>>>> autogenerated_split
    }

    #[abi(embed_v0)]
    impl LayoutCompositionContract of ILayoutCompositionContract<ContractState> {
        fn eval_composition_polynomial_inner(
            self: @ContractState,
            mask_values: Span<felt252>,
            constraint_coefficients: Span<felt252>,
            point: felt252,
            trace_generator: felt252,
            global_values: GlobalValues
        ) -> felt252 {
            let mut total_sum = ILayoutCompositionContractDispatcher {
<<<<<<< HEAD
                contract_address: self.continuation_contract1.read()
=======
                contract_address: continuation_contracts[0]
>>>>>>> autogenerated_split
            }
                .eval_composition_polynomial_inner(
                    mask_values,
                    constraint_coefficients.slice(0, 95),
                    point,
                    trace_generator,
                    global_values
                );

            total_sum +=
<<<<<<< HEAD
                ILayoutCompositionContractDispatcher {
                    contract_address: self.continuation_contract2.read()
                }
=======
                ILayoutCompositionContractDispatcher { contract_address: continuation_contracts[1] }
>>>>>>> autogenerated_split
                .eval_composition_polynomial_inner(
                    mask_values,
                    constraint_coefficients.slice(95, 100),
                    point,
                    trace_generator,
                    global_values
                );

            total_sum +=
<<<<<<< HEAD
                ILayoutCompositionContractDispatcher {
                    contract_address: self.continuation_contract3.read()
                }
=======
                ILayoutCompositionContractDispatcher { contract_address: continuation_contracts[2] }
>>>>>>> autogenerated_split
                .eval_composition_polynomial_inner(
                    mask_values,
                    constraint_coefficients.slice(195, 34),
                    point,
                    trace_generator,
                    global_values
                );

            total_sum +=
<<<<<<< HEAD
                ILayoutCompositionContractDispatcher {
                    contract_address: self.continuation_contract4.read()
                }
=======
                ILayoutCompositionContractDispatcher { contract_address: continuation_contracts[3] }
>>>>>>> autogenerated_split
                .eval_composition_polynomial_inner(
                    mask_values,
                    constraint_coefficients.slice(229, 31),
                    point,
                    trace_generator,
                    global_values
                );

            total_sum +=
<<<<<<< HEAD
                ILayoutCompositionContractDispatcher {
                    contract_address: self.continuation_contract5.read()
                }
=======
                ILayoutCompositionContractDispatcher { contract_address: continuation_contracts[4] }
>>>>>>> autogenerated_split
                .eval_composition_polynomial_inner(
                    mask_values,
                    constraint_coefficients.slice(260, 25),
                    point,
                    trace_generator,
                    global_values
                );

            total_sum +=
<<<<<<< HEAD
                ILayoutCompositionContractDispatcher {
                    contract_address: self.continuation_contract6.read()
                }
=======
                ILayoutCompositionContractDispatcher { contract_address: continuation_contracts[5] }
>>>>>>> autogenerated_split
                .eval_composition_polynomial_inner(
                    mask_values,
                    constraint_coefficients.slice(285, 25),
                    point,
                    trace_generator,
                    global_values
                );

            total_sum +=
<<<<<<< HEAD
                ILayoutCompositionContractDispatcher {
                    contract_address: self.continuation_contract7.read()
                }
=======
                ILayoutCompositionContractDispatcher { contract_address: continuation_contracts[6] }
>>>>>>> autogenerated_split
                .eval_composition_polynomial_inner(
                    mask_values,
                    constraint_coefficients.slice(310, 37),
                    point,
                    trace_generator,
                    global_values
                );
            total_sum
        }
    }
}

#[starknet::contract]
mod LayoutCompositionContract1 {
    use super::ILayoutCompositionContract;
    use cairo_verifier::air::layouts::starknet_with_keccak::{
        global_values::GlobalValues, autogenerated::eval_composition_polynomial_inner_part_1,
    };
<<<<<<< HEAD
    use starknet::ContractAddress;
=======
>>>>>>> autogenerated_split

    #[storage]
    struct Storage {}

    #[abi(embed_v0)]
    impl LayoutCompositionContract of ILayoutCompositionContract<ContractState> {
        fn eval_composition_polynomial_inner(
            self: @ContractState,
            mask_values: Span<felt252>,
            constraint_coefficients: Span<felt252>,
            point: felt252,
            trace_generator: felt252,
            global_values: GlobalValues
        ) -> felt252 {
            eval_composition_polynomial_inner_part_1(
                mask_values, constraint_coefficients, point, trace_generator, global_values
            )
        }
    }
}

#[starknet::contract]
mod LayoutCompositionContract2 {
    use super::ILayoutCompositionContract;
    use cairo_verifier::air::layouts::starknet_with_keccak::{
        global_values::GlobalValues, autogenerated::eval_composition_polynomial_inner_part_2,
    };
<<<<<<< HEAD
    use starknet::ContractAddress;
=======
>>>>>>> autogenerated_split

    #[storage]
    struct Storage {}

    #[abi(embed_v0)]
    impl LayoutCompositionContract of ILayoutCompositionContract<ContractState> {
        fn eval_composition_polynomial_inner(
            self: @ContractState,
            mask_values: Span<felt252>,
            constraint_coefficients: Span<felt252>,
            point: felt252,
            trace_generator: felt252,
            global_values: GlobalValues
        ) -> felt252 {
            eval_composition_polynomial_inner_part_2(
                mask_values, constraint_coefficients, point, trace_generator, global_values
            )
        }
    }
}

#[starknet::contract]
mod LayoutCompositionContract3 {
    use super::ILayoutCompositionContract;
    use cairo_verifier::air::layouts::starknet_with_keccak::{
        global_values::GlobalValues, autogenerated::eval_composition_polynomial_inner_part_3,
    };
<<<<<<< HEAD
    use starknet::ContractAddress;
=======
>>>>>>> autogenerated_split

    #[storage]
    struct Storage {}

    #[abi(embed_v0)]
    impl LayoutCompositionContract of ILayoutCompositionContract<ContractState> {
        fn eval_composition_polynomial_inner(
            self: @ContractState,
            mask_values: Span<felt252>,
            constraint_coefficients: Span<felt252>,
            point: felt252,
            trace_generator: felt252,
            global_values: GlobalValues
        ) -> felt252 {
            eval_composition_polynomial_inner_part_3(
                mask_values, constraint_coefficients, point, trace_generator, global_values
            )
        }
    }
}

#[starknet::contract]
mod LayoutCompositionContract4 {
    use super::ILayoutCompositionContract;
    use cairo_verifier::air::layouts::starknet_with_keccak::{
        global_values::GlobalValues, autogenerated::eval_composition_polynomial_inner_part_4,
    };
<<<<<<< HEAD
    use starknet::ContractAddress;
=======
>>>>>>> autogenerated_split

    #[storage]
    struct Storage {}

    #[abi(embed_v0)]
    impl LayoutCompositionContract of ILayoutCompositionContract<ContractState> {
        fn eval_composition_polynomial_inner(
            self: @ContractState,
            mask_values: Span<felt252>,
            constraint_coefficients: Span<felt252>,
            point: felt252,
            trace_generator: felt252,
            global_values: GlobalValues
        ) -> felt252 {
            eval_composition_polynomial_inner_part_4(
                mask_values, constraint_coefficients, point, trace_generator, global_values
            )
        }
    }
}

#[starknet::contract]
mod LayoutCompositionContract5 {
    use super::ILayoutCompositionContract;
    use cairo_verifier::air::layouts::starknet_with_keccak::{
        global_values::GlobalValues, autogenerated::eval_composition_polynomial_inner_part_5,
    };
<<<<<<< HEAD
    use starknet::ContractAddress;
=======
>>>>>>> autogenerated_split

    #[storage]
    struct Storage {}

    #[abi(embed_v0)]
    impl LayoutCompositionContract of ILayoutCompositionContract<ContractState> {
        fn eval_composition_polynomial_inner(
            self: @ContractState,
            mask_values: Span<felt252>,
            constraint_coefficients: Span<felt252>,
            point: felt252,
            trace_generator: felt252,
            global_values: GlobalValues
        ) -> felt252 {
            eval_composition_polynomial_inner_part_5(
                mask_values, constraint_coefficients, point, trace_generator, global_values
            )
        }
    }
}

#[starknet::contract]
mod LayoutCompositionContract6 {
    use super::ILayoutCompositionContract;
    use cairo_verifier::air::layouts::starknet_with_keccak::{
        global_values::GlobalValues, autogenerated::eval_composition_polynomial_inner_part_6,
    };
<<<<<<< HEAD
    use starknet::ContractAddress;
=======
>>>>>>> autogenerated_split

    #[storage]
    struct Storage {}

    #[abi(embed_v0)]
    impl LayoutCompositionContract of ILayoutCompositionContract<ContractState> {
        fn eval_composition_polynomial_inner(
            self: @ContractState,
            mask_values: Span<felt252>,
            constraint_coefficients: Span<felt252>,
            point: felt252,
            trace_generator: felt252,
            global_values: GlobalValues
        ) -> felt252 {
            eval_composition_polynomial_inner_part_6(
                mask_values, constraint_coefficients, point, trace_generator, global_values
            )
        }
    }
}

#[starknet::contract]
mod LayoutCompositionContract7 {
    use super::ILayoutCompositionContract;
    use cairo_verifier::air::layouts::starknet_with_keccak::{
        global_values::GlobalValues, autogenerated::eval_composition_polynomial_inner_part_7,
    };
<<<<<<< HEAD
    use starknet::ContractAddress;
=======
>>>>>>> autogenerated_split

    #[storage]
    struct Storage {}

    #[abi(embed_v0)]
    impl LayoutCompositionContract of ILayoutCompositionContract<ContractState> {
        fn eval_composition_polynomial_inner(
            self: @ContractState,
            mask_values: Span<felt252>,
            constraint_coefficients: Span<felt252>,
            point: felt252,
            trace_generator: felt252,
            global_values: GlobalValues
        ) -> felt252 {
            eval_composition_polynomial_inner_part_7(
                mask_values, constraint_coefficients, point, trace_generator, global_values
            )
        }
    }
}

#[starknet::contract]
<<<<<<< HEAD
mod LayoutOodsContract {
    use super::{
        ILayoutOodsContract, ILayoutOodsContractDispatcher, ILayoutOodsContractDispatcherTrait
    };
    use cairo_verifier::air::layouts::starknet_with_keccak::global_values::GlobalValues;
    use starknet::ContractAddress;

    #[storage]
    struct Storage {
        continuation_contract1: ContractAddress,
        continuation_contract2: ContractAddress,
=======
mod LayoutOodsContract1 {
    use super::ILayoutOodsContract;
    use cairo_verifier::air::layouts::starknet_with_keccak::{global_values::GlobalValues,};

    #[storage]
    struct Storage {
        continuation_contracts: Array<ContractAddress>,
>>>>>>> autogenerated_split
    }

    #[abi(embed_v0)]
    impl LayoutOodsContract of ILayoutOodsContract<ContractState> {
        fn eval_oods_polynomial_inner(
            self: @ContractState,
            column_values: Span<felt252>,
            oods_values: Span<felt252>,
            constraint_coefficients: Span<felt252>,
            point: felt252,
            oods_point: felt252,
            trace_generator: felt252,
        ) -> felt252 {
            let mut total_sum = ILayoutOodsContractDispatcher {
<<<<<<< HEAD
                contract_address: self.continuation_contract1.read()
=======
                contract_address: continuation_contracts[0]
>>>>>>> autogenerated_split
            }
                .eval_oods_polynomial_inner(
                    column_values,
                    oods_values.slice(0, 349),
                    constraint_coefficients.slice(0, 349),
                    point,
                    oods_point,
                    trace_generator,
                );

            total_sum +=
<<<<<<< HEAD
                ILayoutOodsContractDispatcher {
                    contract_address: self.continuation_contract2.read()
                }
=======
                ILayoutOodsContractDispatcher { contract_address: continuation_contracts[1] }
>>>>>>> autogenerated_split
                .eval_oods_polynomial_inner(
                    column_values,
                    oods_values.slice(349, oods_values.len() - 349),
                    constraint_coefficients.slice(349, constraint_coefficients.len() - 349),
                    point,
                    oods_point,
                    trace_generator,
                );

            total_sum
        }
    }
}

#[starknet::contract]
mod LayoutOodsContract1 {
    use super::ILayoutOodsContract;
    use cairo_verifier::air::layouts::starknet_with_keccak::{
        global_values::GlobalValues, autogenerated::eval_oods_polynomial_inner_part_1,
    };

    #[storage]
    struct Storage {}

    #[abi(embed_v0)]
    impl LayoutOodsContract of ILayoutOodsContract<ContractState> {
        fn eval_oods_polynomial_inner(
            self: @ContractState,
            column_values: Span<felt252>,
            oods_values: Span<felt252>,
            constraint_coefficients: Span<felt252>,
            point: felt252,
            oods_point: felt252,
            trace_generator: felt252,
        ) -> felt252 {
            eval_oods_polynomial_inner_part_1(
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
mod LayoutOodsContract2 {
    use super::ILayoutOodsContract;
    use cairo_verifier::air::layouts::starknet_with_keccak::{
        global_values::GlobalValues, autogenerated::eval_oods_polynomial_inner_part_2,
    };

    #[storage]
    struct Storage {}

    #[abi(embed_v0)]
    impl LayoutOodsContract of ILayoutOodsContract<ContractState> {
        fn eval_oods_polynomial_inner(
            self: @ContractState,
            column_values: Span<felt252>,
            oods_values: Span<felt252>,
            constraint_coefficients: Span<felt252>,
            point: felt252,
            oods_point: felt252,
            trace_generator: felt252,
        ) -> felt252 {
            eval_oods_polynomial_inner_part_2(
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
