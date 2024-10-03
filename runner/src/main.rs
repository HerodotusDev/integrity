mod transform;
mod vec252;

use crate::vec252::VecFelt252;
use cairo_lang_runner::{Arg, ProfilingInfoCollectionConfig, RunResultValue, SierraCasmRunner};
use cairo_lang_sierra::program::VersionedProgram;
use cairo_lang_utils::ordered_hash_map::OrderedHashMap;
use cairo_vm::Felt252;
use clap::Parser;
use itertools::{chain, Itertools};
use runner::{CairoVersion, HasherBitLength, StoneVersion};
use std::{
    fs,
    io::{stdin, Read},
};
use swiftness_proof_parser::parse;
use transform::{Expr, StarkProofExprs};

const ENTRYPOINT: &str = "get_calldata";

#[derive(Parser)]
#[command(author, version, about)]
struct Cli {
    /// Path to compiled sierra file
    #[clap(short, long)]
    program: String,
    /// Cairo version - public memory pattern
    #[clap(value_enum, short, long)]
    cairo_version: CairoVersion,
    /// Stone version
    #[clap(value_enum, short, long)]
    stone_version: StoneVersion,
    /// Hasher bit length
    #[clap(value_enum, short, long)]
    hasher_bit_length: HasherBitLength,
}

fn main() -> anyhow::Result<()> {
    let cli = Cli::parse();
    let mut input = String::new();
    stdin().read_to_string(&mut input)?;

    let stark_proof: StarkProofExprs = parse(input)?.into();
    let config: VecFelt252 = serde_json::from_str(&stark_proof.config.to_string()).unwrap();
    let public_input: VecFelt252 =
        serde_json::from_str(&stark_proof.public_input.to_string()).unwrap();
    let unsent_commitment: VecFelt252 =
        serde_json::from_str(&stark_proof.unsent_commitment.to_string()).unwrap();
    let last_layer_commitment: VecFelt252 =
        serde_json::from_str(&stark_proof.unsent_commitment[5].to_string()).unwrap();

    let fri_witness = stark_proof.witness.last().expect("No fri witness").clone();
    let fri_witness = split_array(fri_witness);
    let steps = fri_witness.chunks(2).map(|chunk| {
        chunk
            .into_iter()
            .flatten()
            .map(|s| Felt252::from_dec_str(s).unwrap().to_hex_string())
            .join(" ")
    }).collect_vec();

    let witness: VecFelt252 = serde_json::from_str(&stark_proof.witness.to_string()).unwrap();

    let proof = chain!(
        config.into_iter(),
        public_input.into_iter(),
        unsent_commitment.into_iter(),
        witness.into_iter()
    )
    .collect_vec();

    println!("proof size: {} felts", proof.len());

    let sierra_program =
        serde_json::from_str::<VersionedProgram>(&fs::read_to_string(cli.program)?)?.into_v1()?;

    let runner = SierraCasmRunner::new(
        sierra_program.program.clone(),
        Some(Default::default()),
        OrderedHashMap::default(),
        Some(ProfilingInfoCollectionConfig::default()),
    )
    .unwrap();

    let func = runner.find_function(ENTRYPOINT).unwrap();
    let args = &[
        Arg::Array(proof.into_iter().map(Arg::Value).collect_vec()),
        Arg::Value(cli.cairo_version.into()),
        Arg::Value(cli.hasher_bit_length.into()),
        Arg::Value(cli.stone_version.into()),
    ];
    let result = runner
        .run_function_with_starknet_context(func, args, Some(u32::MAX as usize), Default::default())
        .unwrap();

    println!("gas_counter: {}", result.gas_counter.unwrap());
    println!("n_steps: {}", result.memory.len());

    match result.value {
        RunResultValue::Success(msg) => {
            let (const_state, mut variable_state, fact_hash) = extract_calldata_from_memory(result.memory, &msg);

            let const_state_str = const_state.iter().map(|x| x.to_hex_string()).join(" ");

            let last_variable_state = variable_state.pop().unwrap();

            for (var, step) in variable_state.iter().zip_eq(steps.iter()) {
                let v = var.iter().map(|x| x.to_hex_string()).join(" ");
                println!("\nSTEP");
                println!("{} {} {}", const_state_str, v, step);
            }

            println!("\nFINAL");
            println!("{} {} 0x{:x} {}",
                const_state_str,
                last_variable_state.iter().map(|x| x.to_hex_string()).join(" "),
                last_layer_commitment.len(),
                last_layer_commitment.iter().map(|x| x.to_hex_string()).join(" ")
            );
        }
        RunResultValue::Panic(msg) => {
            panic!("{:?}", msg);
        }
    }

    Ok(())
}

fn extract_calldata_from_memory(memory: Vec<Option<Felt252>>, output: &Vec<Felt252>) -> (Vec<Felt252>, Vec<Vec<Felt252>>, Felt252) {
    let mut output_iter = output.iter();

    let mut calldata_constant_state: Vec<Felt252> = vec![];
    calldata_constant_state.push(*output_iter.next().unwrap()); // n_layers
    append_memory_segment(&mut calldata_constant_state, &memory, output_iter.next_tuple().unwrap(), 6); // commitment
    append_memory_segment(&mut calldata_constant_state, &memory, output_iter.next_tuple().unwrap(), 1); // eval_points
    append_memory_segment(&mut calldata_constant_state, &memory, output_iter.next_tuple().unwrap(), 1); // step_sizes
    calldata_constant_state.push(*output_iter.next().unwrap()); // last_layer_coefficients_hash

    let mut variable_state_ptr: Vec<Felt252> = vec![];
    append_memory_segment(&mut variable_state_ptr, &memory, output_iter.next_tuple().unwrap(), 1); // variable_state
    let variable_state_iter = variable_state_ptr.iter().skip(1);
    let mut calldata_variable_state: Vec<Vec<Felt252>> = vec![];
    for mut x in &variable_state_iter.chunks(3) {
        let (iteration, begin, end) = x.next_tuple().unwrap();
        let begin: usize = begin.to_biguint().try_into().unwrap();
        let end: usize = end.to_biguint().try_into().unwrap();
        let len = (end - begin) / 3;
        let mut calldata = vec![];
        calldata.push(*iteration);
        calldata.push(len.into());
        for x in memory[begin..end].iter() {
            calldata.push(x.unwrap());
        }
        calldata_variable_state.push(calldata);
    }

    let fact_hash = *output_iter.next().unwrap();

    (calldata_constant_state, calldata_variable_state, fact_hash)
}

fn append_memory_segment(calldata: &mut Vec<Felt252>, memory: &Vec<Option<Felt252>>, (&start, &end): (&Felt252, &Felt252), size: usize) {
    let start: usize = start.to_biguint().try_into().unwrap();
    let end: usize = end.to_biguint().try_into().unwrap();
    let len = (end - start) / size;
    calldata.push(len.into());
    for addr in start..end {
        calldata.push(memory[addr].unwrap());
    }
}

fn split_array(expr: Expr) -> Vec<Vec<String>> {
    match expr {
        Expr::Array(arr) => {
            let mut acc: Vec<Vec<String>> = vec![];
            let mut curr: Vec<String> = vec![];
            let mut it: u32 = 0;
            for elem in arr {
                if let Expr::Value(val) = elem {
                    if it == 0 {
                        if curr.len() > 0 {
                            acc.push(curr);
                        }
                        it = val.parse().expect("Not a number");
                        curr = vec![val];
                    } else {
                        curr.push(val);
                        it -= 1;
                    }
                }
            }
            if curr.len() > 0 {
                acc.push(curr);
            }
            acc
        }
        _ => panic!("Not an array"),
    }
}
