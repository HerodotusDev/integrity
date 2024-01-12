# Cairo Verifier

This document provides steps to build and run the Cairo Verifier.

## Building the Verifier

To build the latest version of the verifier and create a Sierra file, follow these steps:

1. Navigate to the project root directory:

```bash
cd .
```

2. Build the project:

```bash
scarb build
```

## Running the Verifier

## Getting the Parsed Proof

To obtain the parsed proof, follow these steps:

### 1. Download Source Code

- Access the source code at [Cairo1 Parser Repository](https://github.com/neotheprogramist/cairo-lang/tree/parser).

### 2. Install Dependencies

- Execute the command: `pipenv install`.

### 3. Activate Virtual Environment

- Activate the virtual environment with: `pipenv shell`.

### 4. Run the Parser

- Use the parser by running:
  ```
  python src/main.py -l starknet_with_keccak < src/starkware/cairo/stark_verifier/air/example_proof.json > out.txt
  ```

### 5. Access Output File

- The output will be available in the `out.txt` file.

## Using the Parsed Proof

Once you have the parsed proof, you can use it as follows:

### 1. Copy Proof to Input File

- Copy the entire content or a consistent section of `out.txt` to `./resources/in.txt`.

### 3. Execute the Runner Script

- Run: `cargo run --release -- ./target/dev/cairo_verifier.sierra.json < ./resources/in.txt`

- Or run the script using: `./run.sh`.
