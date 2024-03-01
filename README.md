# Cairo Verifier

![Cairo Verifier](https://github.com/HerodotusDev/cairo-verifier/assets/46165861/8692dfc1-f267-4c7e-9af0-4ceaeec84207)

Welcome to the Cairo Verifier repository! This document provides instructions for building and running the Cairo Verifier.

## Building the Verifier

To build the Cairo Verifier, follow these steps:

1. Build the project by running the following command in your terminal:

```bash
scarb build
```

2. Test the project to ensure everything works correctly:

```bash
scarb test
```

## Running the Verifier

### Local Proof Verification

For local proof verification, perform the following steps:

1. Build the verifier:

```bash
scarb build
```

2. Run the verifier locally using the following command:

```bash
cargo run --release --bin runner -- target/dev/cairo_verifier.sierra.json < examples/proofs/fibonacci_proof.json
```

### Starknet Proof Verification

To verify proofs on Starknet, follow these steps:

1. Prepare calldata for sncast:

```bash
cargo run --release --bin snfoundry_proof_serializer < examples/proofs/fibonacci_proof.json > examples/starknet/calldata
```

2. Call the function with calldata on the Starknet contract:

```bash
cd examples/starknet
./call_contract.sh calldata
```

## Changing the Hasher

By default, the verifier uses Pedersen for verifier-friendly layers and Keccak for unfriendly layers. You can change the hasher for unfriendly layers by running the provided Python script:

### Change to Blake2s

To change the hasher for unfriendly layers to Blake2s, run the following command:

```bash
python3 change_hasher.py -t blake
```

### Change to Keccak256

To change the hasher for unfriendly layers to Keccak256, run the following command:

```bash
python3 change_hasher.py -t keccak
```