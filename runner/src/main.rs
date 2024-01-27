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
    build_hints_dict, casm_run::RunFunctionContext, initialize_vm, Arg, CairoHintProcessor,
    SierraCasmRunner, StarknetState,
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

    let mut vm = VirtualMachine::new(true);

    let data: Vec<MaybeRelocatable> = assembled_program
        .bytecode
        .iter()
        .map(Felt252::from)
        .map(MaybeRelocatable::from)
        .collect();
    let data_len = data.len();

    let program = Program::new(
        builtins,
        data,
        Some(0),
        hints_dict,
        ReferenceManager {
            references: Vec::new(),
        },
        HashMap::new(),
        vec![],
        None,
    )
    .map_err(CairoRunError::from)?;
    let mut cairo_runner = CairoRunner::new(&program, "all_cairo", false)
        .map_err(CairoRunError::from)
        .map_err(Box::new)?;

    let end = cairo_runner
        .initialize(&mut vm)
        .map_err(CairoRunError::from)?;

    initialize_vm(RunFunctionContext {
        vm: &mut vm,
        data_len,
    })?;

    cairo_runner
        .run_until_pc(end, &mut vm, &mut hint_processor)
        .map_err(CairoRunError::from)?;
    cairo_runner
        .end_run(true, false, &mut vm, &mut hint_processor)
        .map_err(CairoRunError::from)?;
    cairo_runner
        .relocate(&mut vm, true)
        .map_err(CairoRunError::from)?;

    let resources = cairo_runner.get_execution_resources(&vm)?;
    println!("{:#?}", resources);

    Ok(())
}
