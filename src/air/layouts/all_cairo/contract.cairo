use cairo_verifier::air::layouts::all_cairo::global_values::GlobalValues;

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
    use super::{
        ILayoutCompositionContract, ILayoutCompositionContractDispatcher,
        ILayoutCompositionContractDispatcherTrait
    };
    use cairo_verifier::air::layouts::all_cairo::{global_values::GlobalValues,};
    use starknet::ContractAddress;


    #[storage]
    struct Storage {
        contract_1: ContractAddress,
        contract_2: ContractAddress,
        contract_3: ContractAddress,
    }

    #[constructor]
    fn constructor(
        ref self: ContractState,
        contract_1: ContractAddress,
        contract_2: ContractAddress,
        contract_3: ContractAddress
    ) {
        self.contract_1.write(contract_1);
        self.contract_2.write(contract_2);
        self.contract_3.write(contract_3);
    }

    #[abi(embed_v0)]
    impl LayoutCompositionContract of ILayoutCompositionContract<ContractState> {
        fn eval_composition_polynomial_inner(
            self: @ContractState,
            mask_values: Span<felt252>,
            mut constraint_coefficients: Span<felt252>,
            point: felt252,
            trace_generator: felt252,
            global_values: GlobalValues
        ) -> felt252 {
            let mut total_sum = 0;

            total_sum +=
                ILayoutCompositionContractDispatcher { contract_address: self.contract_1.read(), }
                .eval_composition_polynomial_inner(
                    mask_values,
                    (*constraint_coefficients.multi_pop_front::<219>().unwrap()).unbox().span(),
                    point,
                    trace_generator,
                    global_values,
                );

            total_sum +=
                ILayoutCompositionContractDispatcher { contract_address: self.contract_2.read(), }
                .eval_composition_polynomial_inner(
                    mask_values,
                    (*constraint_coefficients.multi_pop_front::<69>().unwrap()).unbox().span(),
                    point,
                    trace_generator,
                    global_values,
                );

            total_sum +=
                ILayoutCompositionContractDispatcher { contract_address: self.contract_3.read(), }
                .eval_composition_polynomial_inner(
                    mask_values,
                    (*constraint_coefficients.multi_pop_front::<59>().unwrap()).unbox().span(),
                    point,
                    trace_generator,
                    global_values,
                );

            assert(constraint_coefficients.len() == 0, 'constraint_coeffs too long');
            total_sum
        }
    }
}

#[starknet::contract]
mod LayoutCompositionPart1Contract {
    use super::ILayoutCompositionContract;
    use cairo_verifier::air::layouts::all_cairo::{
        global_values::GlobalValues, autogenerated::eval_composition_polynomial_inner_part1,
    };
    use starknet::ContractAddress;


    #[storage]
    struct Storage {}

    #[abi(embed_v0)]
    impl LayoutCompositionPart1Contract of ILayoutCompositionContract<ContractState> {
        fn eval_composition_polynomial_inner(
            self: @ContractState,
            mask_values: Span<felt252>,
            constraint_coefficients: Span<felt252>,
            point: felt252,
            trace_generator: felt252,
            global_values: GlobalValues
        ) -> felt252 {
            eval_composition_polynomial_inner_part1(
                mask_values, constraint_coefficients, point, trace_generator, global_values,
            )
        }
    }
}

#[starknet::contract]
mod LayoutCompositionPart2Contract {
    use super::ILayoutCompositionContract;
    use cairo_verifier::air::layouts::all_cairo::{
        global_values::GlobalValues, autogenerated::eval_composition_polynomial_inner_part2,
    };
    use starknet::ContractAddress;


    #[storage]
    struct Storage {}

    #[abi(embed_v0)]
    impl LayoutCompositionPart2Contract of ILayoutCompositionContract<ContractState> {
        fn eval_composition_polynomial_inner(
            self: @ContractState,
            mask_values: Span<felt252>,
            constraint_coefficients: Span<felt252>,
            point: felt252,
            trace_generator: felt252,
            global_values: GlobalValues
        ) -> felt252 {
            eval_composition_polynomial_inner_part2(
                mask_values, constraint_coefficients, point, trace_generator, global_values,
            )
        }
    }
}

#[starknet::contract]
mod LayoutCompositionPart3Contract {
    use super::ILayoutCompositionContract;
    use cairo_verifier::air::layouts::all_cairo::{
        global_values::GlobalValues, autogenerated::eval_composition_polynomial_inner_part3,
    };
    use starknet::ContractAddress;


    #[storage]
    struct Storage {}

    #[abi(embed_v0)]
    impl LayoutCompositionPart3Contract of ILayoutCompositionContract<ContractState> {
        fn eval_composition_polynomial_inner(
            self: @ContractState,
            mask_values: Span<felt252>,
            constraint_coefficients: Span<felt252>,
            point: felt252,
            trace_generator: felt252,
            global_values: GlobalValues
        ) -> felt252 {
            eval_composition_polynomial_inner_part3(
                mask_values, constraint_coefficients, point, trace_generator, global_values,
            )
        }
    }
}

#[starknet::contract]
mod LayoutOodsContract {
    use super::{ILayoutOodsContract};
    use cairo_verifier::air::layouts::all_cairo::{
        global_values::GlobalValues, autogenerated::eval_oods_polynomial_inner,
    };
    use starknet::ContractAddress;

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
            eval_oods_polynomial_inner(
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
