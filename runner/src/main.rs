use std::io::{stdin, Read};

use cairo_args_runner::{run, WrappedArg};
use clap::Parser;
use lalrpop_util::lalrpop_mod;

mod ast;

lalrpop_mod!(pub parser);

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

    let parsed = parser::ExprParser::new()
        .parse(&input)
        .map_err(|e| anyhow::anyhow!("{}", e))?;
    let result = format!("{parsed}");

    let target = cli.target;
    let function = "main";
    let args: WrappedArg = serde_json::from_str(&result).unwrap();

    let result = run(&target, &function, &args)?;

    println!("{result:?}");
    Ok(())
}
