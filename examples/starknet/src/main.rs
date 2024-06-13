use cairo_proof_parser::parse;
use itertools::chain;
use runner::VecFelt252;
use std::io::{stdin, Read};

fn main() -> anyhow::Result<()> {
    let mut input = String::new();
    stdin().read_to_string(&mut input)?;

    let parsed = parse(input)?;

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
    );

    let cairo_version = 0; // TODO: pass as argument

    let calldata = chain!(proof, vec![cairo_version.into()].into_iter());

    let calldata_string = calldata
        .map(|f| f.to_string())
        .collect::<Vec<String>>()
        .join(" ");

    println!("{}", calldata_string);

    Ok(())
}
