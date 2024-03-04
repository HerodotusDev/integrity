use std::io::{stdin, Read};

use cairo_args_runner::{Arg, Felt252, VecFelt252};
use clap::Parser;

use cairo_proof_parser::parse;
use itertools::chain;
use itertools::Itertools;

#[derive(Parser)]
#[command(author, version, about, long_about = None)]
struct Cli {
    /// Path to compiled sierra file
    target: String,
}

fn main() -> anyhow::Result<()> {
    let args = Cli::parse();
    let mut input = String::new();
    stdin().read_to_string(&mut input)?;
    let parsed = parse(input)?;

    let config: VecFelt252 = serde_json::from_str(&parsed.config.to_string()).unwrap();
    let public_input: VecFelt252 = serde_json::from_str(&parsed.public_input.to_string()).unwrap();
    let unsent_commitment: VecFelt252 =
        serde_json::from_str(&parsed.unsent_commitment.to_string()).unwrap();
    let witness: VecFelt252 = serde_json::from_str(&parsed.witness.to_string()).unwrap();

    let proof = chain!(
        config.to_vec(),
        public_input.to_vec(),
        unsent_commitment.to_vec(),
        witness.to_vec()
    )
    .collect_vec();

    // println!("{:?}", unsent_commitment);

    let target = args.target;
    let function = "main";
    
    let result = cairo_args_runner::run(
        &target,
        function,
        &[Arg::Array(proof)],
    );

    println!("{result:?}");

    Ok(())
}