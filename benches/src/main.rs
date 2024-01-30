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
    "bench_stark_proof_verify",
    "bench_stark_commit",
    "bench_stark_verify",
    "bench_fri_commit",
    "bench_fri_verify",
    "bench_table_commitment_decommit",
    "bench_vector_commitment_commit",
    "bench_vector_commitment_decommit",
];

fn main() -> anyhow::Result<()> {
    let cli = Cli::parse();

    let sierra_program =
        serde_json::from_str::<VersionedProgram>(&fs::read_to_string(cli.target)?)?.into_v1()?;

    BENCH_FUNCTION_LIST.into_iter().for_each(|f_name| {
        let result = bench(sierra_program.program.to_owned(), f_name).unwrap();

        println!("Function: {f_name}");
        // println!("---------------------------------");
        // println!("Gas Used        : {}", result.gas_counter.unwrap());
        println!("Execution Steps : {}", result.memory.len());
        // println!("Return Value    : {:#?}", result.value);
        println!("---------------------------------\n");

        // let profiling_processor = ProfilingInfoProcessor::new(sierra_program.program);
        // let processed_profiling_info = profiling_processor.process(&profiling_info.unwrap());

        // println!("profiling: {}", processed_profiling_info);
    });

    Ok(())
}
