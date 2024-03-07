use std::fs;

use anyhow::Ok;
use bench::bench;
use cairo_lang_sierra::program::VersionedProgram;
use clap::Parser;

pub mod bench;

#[derive(Parser)]
#[command(author, version, about, long_about = None)]
struct Cli {
    /// Path to compiled sierra file
    target: String,
}

const BENCH_FUNCTION_LIST: &[&str] = &[
    "bench_air_traces_commit",
    "bench_air_traces_decommit",
    "bench_fri_commit",
    "bench_fri_verify",
    "bench_stark_commit",
    "bench_stark_proof_verify",
    "bench_stark_verify",
];

fn main() -> anyhow::Result<()> {
    let cli = Cli::parse();

    let sierra_program =
        serde_json::from_str::<VersionedProgram>(&fs::read_to_string(cli.target)?)?.into_v1()?;

    BENCH_FUNCTION_LIST.iter().for_each(|f_name| {
        let result = bench(sierra_program.program.to_owned(), f_name).unwrap();

        println!("Function: {f_name}");
        // println!("---------------------------------");
        // println!("Gas Used        : {}", result.gas_counter.unwrap());
        println!("Number of steps : {}", result.memory.len());
        // println!("Return Value    : {:#?}", result.value);
        println!("---------------------------------\n");
    });

    Ok(())
}
