use cairo_lang_runner::{
    ProfilingInfoCollectionConfig, RunResultStarknet, RunnerError, SierraCasmRunner,
};
use cairo_lang_sierra::program::Program;
use cairo_lang_utils::ordered_hash_map::OrderedHashMap;

pub fn bench(sierra_program: Program, function: &str) -> Result<RunResultStarknet, RunnerError> {
    let runner = SierraCasmRunner::new(
        sierra_program.clone(),
        Some(Default::default()),
        OrderedHashMap::default(),
        Some(ProfilingInfoCollectionConfig::default()),
    )
    .unwrap();
    let func = runner.find_function(function).unwrap();
    runner.run_function_with_starknet_context(
        func,
        &[],
        Some(u32::MAX as usize),
        Default::default(),
    )
}
