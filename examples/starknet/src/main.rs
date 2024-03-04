use cairo_args_runner::VecFelt252;
use cairo_proof_parser::parse;
use std::io::{stdin, Read};

fn main() -> anyhow::Result<()> {
    let mut input = String::new();
    stdin().read_to_string(&mut input)?;

    let exprs = parse(input)?.to_string();
    let proof: VecFelt252 = serde_json::from_str(&exprs).unwrap();

    let proof_string = proof
        .iter()
        .map(|f| f.to_string())
        .collect::<Vec<String>>()
        .join(" ");

    println!("{}", proof_string);

    Ok(())
}
