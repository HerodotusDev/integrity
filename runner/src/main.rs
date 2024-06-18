mod vec252;
use crate::vec252::VecFelt252;

use cairo_lang_runner::{Arg, ProfilingInfoCollectionConfig, RunResultValue, SierraCasmRunner};
use cairo_lang_sierra::program::VersionedProgram;
use cairo_lang_utils::ordered_hash_map::OrderedHashMap;
use cairo_proof_parser::parse;
use clap::Parser;
use itertools::{chain, Itertools};
use runner::CairoVersion;
use std::{
    fs,
    io::{stdin, Read},
};

#[derive(Parser)]
#[command(author, version, about)]
struct Cli {
    /// Path to compiled sierra file
    #[clap(short, long)]
    program: String,
    /// Cairo version - public memory pattern
    #[clap(value_enum, short, long, default_value_t=CairoVersion::Cairo0)]
    cairo_version: CairoVersion,
}

fn main() -> anyhow::Result<()> {
    let cli = Cli::parse();
    let mut input = String::new();
    stdin().read_to_string(&mut input)?;
    let parsed = parse(input)?;

    let function = "main";

    let config: VecFelt252 = serde_json::from_str(&parsed.config.to_string()).unwrap();
    let public_input: VecFelt252 = serde_json::from_str(&parsed.public_input.to_string()).unwrap();
    let unsent_commitment: VecFelt252 =
        serde_json::from_str(&parsed.unsent_commitment.to_string()).unwrap();
    let witness: VecFelt252 = serde_json::from_str(&parsed.witness.to_string()).unwrap();

    let proof = chain!(
        config.into_iter(),
        public_input.into_iter(),
        unsent_commitment.into_iter(),
        witness.into_iter()
    )
    .collect_vec();

    println!("proof size: {} felts", proof.len());

    let sierra_program =
        serde_json::from_str::<VersionedProgram>(&fs::read_to_string(cli.program)?)?.into_v1()?;

    let runner = SierraCasmRunner::new(
        sierra_program.program.clone(),
        Some(Default::default()),
        OrderedHashMap::default(),
        Some(ProfilingInfoCollectionConfig::default()),
    )
    .unwrap();

    let func = runner.find_function(function).unwrap();
    let proof_arg = Arg::Array(proof.into_iter().map(Arg::Value).collect_vec());
    let cairo_version_arg = Arg::Value(cli.cairo_version.into());
    let args = &[proof_arg, cairo_version_arg];
    let result = runner
        .run_function_with_starknet_context(func, args, Some(u32::MAX as usize), Default::default())
        .unwrap();
    // let profiling_processor =
    //     ProfilingInfoProcessor::new(None, sierra_program.program, UnorderedHashMap::default());
    // let processed_profiling_info = profiling_processor.process(&result.profiling_info.unwrap());

    println!("gas_counter: {}", result.gas_counter.unwrap());
    println!("n_steps: {}", result.memory.len());

    match result.value {
        RunResultValue::Success(msg) => {
            println!("{:?}", msg);
        }
        RunResultValue::Panic(msg) => {
            panic!("{:?}", msg);
        }
    }

    Ok(())
}
