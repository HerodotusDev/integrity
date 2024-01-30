use cairo_lang_runner::{
    build_hints_dict, CairoHintProcessor, RunResult, SierraCasmRunner, StarknetState,
};
use cairo_lang_sierra::program::Program;
use cairo_lang_utils::ordered_hash_map::OrderedHashMap;
use cairo_vm::vm::runners::cairo_runner::RunResources;
use itertools::chain;

pub fn bench(sierra_program: Program, function: &str) -> anyhow::Result<RunResult> {
    let sierra_runner = SierraCasmRunner::new(
        sierra_program,
        Some(Default::default()),
        OrderedHashMap::default(),
        true,
    )?;

    let func = sierra_runner.find_function(function)?;
    let initial_gas = sierra_runner.get_initial_available_gas(func, Some(usize::MAX))?;
    let (entry_code, builtins) = sierra_runner.create_entry_code(func, &[], initial_gas)?;
    let footer = SierraCasmRunner::create_code_footer();
    let (hints_dict, string_to_hint) = build_hints_dict(chain!(
        entry_code.iter(),
        sierra_runner.get_casm_program().instructions.iter()
    ));
    let assembled_program = sierra_runner
        .get_casm_program()
        .assemble_ex(&entry_code, &footer);

    let mut hint_processor = CairoHintProcessor {
        runner: Some(&sierra_runner),
        starknet_state: StarknetState::default(),
        string_to_hint,
        run_resources: RunResources::default(),
    };

    Ok(sierra_runner.run_function(
        func,
        &mut hint_processor,
        hints_dict,
        assembled_program.bytecode.iter(),
        builtins,
    )?)
}
