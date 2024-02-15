use std::{io::{stdin, Read}, str::FromStr};

use cairo_args_runner::{run, Arg, Felt252};
use cairo_proof_parser::{parse, Expr};
use clap::Parser;

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

    let parsed = parse(input)?;
    let target = cli.target;
    let function = "main";

    let args: Vec<Arg> = parsed.iter().map(|x| {
        match x {
            Expr::Value(v) => {
                let v = num_bigint::BigUint::from_str(v).unwrap();
                Arg::Value(Felt252::from_bytes_be(&v.to_bytes_be()))
            }
            Expr::Array(v) => {
                let v = v.into_iter().map(|x| {
                    match x {
                        Expr::Value(v) => {
                            let v = num_bigint::BigUint::from_str(v).unwrap();
                            Felt252::from_bytes_be(&v.to_bytes_be())
                        }
                        _ => panic!("Invalid array element")
                    }
                }).collect();
                Arg::Array(v)
            }
        }
    }).collect();

    let result = run(&target, function, &args)?;

    println!("{result:?}");
    Ok(())
}
