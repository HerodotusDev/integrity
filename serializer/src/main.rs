use itertools::chain;
use runner::{transform::StarkProofExprs, VecFelt252};
use std::io::{stdin, Read};
use swiftness_proof_parser::parse;

fn main() -> anyhow::Result<()> {
    let mut input = String::new();
    stdin().read_to_string(&mut input)?;

    let stark_proof: StarkProofExprs = parse(input)?.into();
    let config: VecFelt252 = serde_json::from_str(&stark_proof.config.to_string()).unwrap();
    let public_input: VecFelt252 =
        serde_json::from_str(&stark_proof.public_input.to_string()).unwrap();
    let unsent_commitment: VecFelt252 =
        serde_json::from_str(&stark_proof.unsent_commitment.to_string()).unwrap();
    let witness: VecFelt252 = serde_json::from_str(&stark_proof.witness.to_string()).unwrap();

    let proof = chain!(
        config.into_iter(),
        public_input.into_iter(),
        unsent_commitment.into_iter(),
        witness.into_iter()
    );

    let calldata_string = proof.into_iter()
        .map(|f| f.to_string())
        .collect::<Vec<String>>()
        .join(" ");

    println!("{}", calldata_string);

    Ok(())
}
