use clap::Parser;
use itertools::chain;
use runner::{transform::ParsedStarkProof, CairoVersion, VecFelt252};
use std::io::{stdin, Read};
use swiftness_proof_parser::parse;

#[derive(Parser)]
#[command(author, version, about)]
struct Cli {
    /// Cairo version - public memory pattern
    #[clap(value_enum, short, long, default_value_t=CairoVersion::Cairo0)]
    cairo_version: CairoVersion,
}

fn main() -> anyhow::Result<()> {
    let cli = Cli::parse();
    let mut input = String::new();
    stdin().read_to_string(&mut input)?;

    let parsed: ParsedStarkProof = parse(input)?.into();

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

    let calldata = chain!(proof, vec![cli.cairo_version.into()].into_iter());

    let calldata_string = calldata
        .map(|f| f.to_string())
        .collect::<Vec<String>>()
        .join(" ");

    println!("{}", calldata_string);

    Ok(())
}
