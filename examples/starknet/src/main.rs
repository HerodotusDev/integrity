mod vec252;
use crate::vec252::VecFelt252;
use cairo_proof_parser::parse;
use itertools::{chain, Itertools};
use std::{
    io::{stdin, Read},
};

fn main() -> anyhow::Result<()> {
    let mut input = String::new();
    stdin().read_to_string(&mut input)?;
    let parsed = parse(input)?;

    let config: VecFelt252 = serde_json::from_str(&parsed.config.to_string())?;
    let public_input: VecFelt252 = serde_json::from_str(&parsed.public_input.to_string())?;
    let unsent_commitment: VecFelt252 =
        serde_json::from_str(&parsed.unsent_commitment.to_string())?;
    let witness: VecFelt252 = serde_json::from_str(&parsed.witness.to_string())?;

    let proof = chain!(
        config.to_vec(),
        public_input.to_vec(),
        unsent_commitment.to_vec(),
        witness.to_vec()
    )
    .collect_vec();

    let proof_string = proof
        .iter()
        .map(|f| f.to_string())
        .collect::<Vec<String>>()
        .join(" ");

    println!("{}", proof_string);

    Ok(())
}
