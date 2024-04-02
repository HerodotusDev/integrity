# Cairo Verifier

![Integrity](.github/readme.png)

[![Continuous Integration - tests](https://github.com/HerodotusDev/cairo-verifier/actions/workflows/tests.yml/badge.svg)](https://github.com/HerodotusDev/cairo-verifier/actions/workflows/tests.yml)

[![Continuous Integration - proof verification tests](https://github.com/HerodotusDev/cairo-verifier/actions/workflows/proof_verification_tests.yml/badge.svg)](https://github.com/HerodotusDev/cairo-verifier/actions/workflows/proof_verification_tests.yml)

## Building the Verifier

To build the Cairo Verifier, follow these steps:

1. Build the project by running the following command in your terminal:

```bash
scarb build
```

2. (Optional) Test the project to ensure everything works correctly:

```bash
scarb test
```

## Running the Verifier on Example Proof

### Local Proof Verification

For local proof verification, follow these steps:

1. Run the verifier locally on example proof using the following command:

```bash
cargo run --release --bin runner -- target/dev/cairo_verifier.sierra.json < examples/proofs/recursive/example_proof.json
```

### Starknet Proof Verification

To verify proofs on Starknet, proceed with the following steps:

1. Prepare calldata of example proof for sncast:

```bash
cargo run --release --bin snfoundry_proof_serializer < examples/proofs/recursive/example_proof.json > examples/starknet/calldata
```

2. Call the function with calldata on the Starknet contract:

```bash
cd examples/starknet
./1-verify-proof.sh 0x487810706cc0dfdba0c82403d98e9d32dc36793ed2b731231e5ea19f00c5861 calldata
```

[List of deployed Verifier Contracts](deployed_contracts.md)

## Configure Verifier

By default, the verifier is configured for recursive layout and keccak hash for verifier unfriendly commitment layers. You can easily change that by using the configure python script (this script is in Experimental stage):

```bash
python configure.py -l recursive -s keccak
```

layout types: [dex, recursive, recursive_with_poseidon, small, starknet, starknet_with_keccak]  
hash types: [keccak, blake2s]

## Benchmarking

In order to launch benchmarking, just run this (it requires recursive layout configuration):

```bash
cargo run --release --bin benches -- target/dev/cairo_verifier.sierra.json
```

## Creating a Proof

### Stone Prover Instructions

For detailed instructions and examples, refer to the Stone Prover [documentation](https://github.com/starkware-libs/stone-prover?tab=readme-ov-file#creating-and-verifying-a-proof-of-a-cairozero-program).

### Stone Prover SDK Tool

For information on how to use the Stone Prover SDK tool, please refer to the [documentation](https://github.com/Moonsong-Labs/stone-prover-sdk).