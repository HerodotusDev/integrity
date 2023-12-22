use std::fs::File;
use std::io::BufReader;

use clap::Parser;
use serde_json::Value;

#[derive(Parser)]
#[command(author, version, about, long_about = None)]
struct Cli {
    /// Path to the input file
    #[clap(default_value = "resources/input.json")]
    path: String,
}

fn main() -> anyhow::Result<()> {
    let args = Cli::parse();
    let file = File::open(args.path)?;
    let reader = BufReader::new(file);

    let v: Value = serde_json::from_reader(reader)?;

    let flattened = flatten_recursively(&v);

    println!("{:?}", flattened.collect::<Vec<u64>>());

    Ok(())
}

fn flatten_recursively(v: &Value) -> Box<dyn Iterator<Item = u64> + '_> {
    match v {
        Value::Array(array) => Box::new(array.iter().flat_map(flatten_recursively)),
        Value::Number(v) => Box::new(std::iter::once(v.as_u64().unwrap())),
        _ => Box::new(std::iter::empty()),
    }
}
