mod ast;
mod vec252;

use std::{
    collections::HashMap,
    fs,
    io::{stdin, Read},
};

use clap::Parser;
use lalrpop_util::lalrpop_mod;

use cairo_felt::Felt252;
use cairo_lang_runner::{
    build_hints_dict, casm_run::RunFunctionContext, initialize_vm, profiling::ProfilingInfoProcessor, Arg, CairoHintProcessor, RunResult, SierraCasmRunner, StarknetState
};
use cairo_lang_sierra::program::VersionedProgram;
use cairo_lang_utils::ordered_hash_map::OrderedHashMap;
use cairo_vm::{
    serde::deserialize_program::ReferenceManager,
    types::{program::Program, relocatable::MaybeRelocatable},
    vm::{
        errors::cairo_run_errors::CairoRunError, runners::cairo_runner::CairoRunner,
        runners::cairo_runner::RunResources, vm_core::VirtualMachine,
    },
};
use itertools::chain;

use crate::vec252::VecFelt252;
// use vec252::VecFelt252;

lalrpop_mod!(pub parser);

#[derive(Parser)]
#[command(author, version, about, long_about = None)]
struct Cli {
    /// Path to compiled sierra file
    target: String,
}

fn main() -> anyhow::Result<()> {
    let cli = Cli::parse();
    let mut input = String::new();
    stdin().read_to_string(&mut input)?;

    let parsed = parser::CairoParserOutputParser::new()
        .parse(&input)
        .map_err(|e| anyhow::anyhow!("{}", e))?;
    let result = parsed.to_string();

    let target = cli.target;
    let function = "main";
    let args: VecFelt252 = serde_json::from_str(&result)?;

    let sierra_program =
        serde_json::from_str::<VersionedProgram>(&fs::read_to_string(target)?)?.into_v1()?;

    let sierra_runner = SierraCasmRunner::new(
        sierra_program.program.clone(),
        Some(Default::default()),
        OrderedHashMap::default(),
        true,
    )?;

    let func = sierra_runner.find_function(function)?;
    let initial_gas = sierra_runner.get_initial_available_gas(func, Some(usize::MAX))?;
    let (entry_code, builtins) =
        sierra_runner.create_entry_code(func, &[Arg::Array(args.to_vec())], initial_gas)?;
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

    let RunResult { gas_counter, memory, value, profiling_info } = sierra_runner.run_function(
        func,
        &mut hint_processor,
        hints_dict,
        assembled_program.bytecode.iter(),
        builtins,
    )?;

    println!("gas: {}", gas_counter.unwrap());
    println!("n_steps: {}", memory.len());
    println!("return: {:#?}", value);
    // println!("{:#?}", profiling_info);

    let profiling_processor = ProfilingInfoProcessor::new(sierra_program.program);
    let processed_profiling_info = profiling_processor.process(&profiling_info.unwrap());

    println!("profiling: {}", processed_profiling_info);

    Ok(())
}
