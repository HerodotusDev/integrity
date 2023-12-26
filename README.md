# Cairo1 Verifier

## Overview

The Cairo1 Verifier is a tool designed for parsing and utilizing proofs in the Cairo language. This document provides instructions on how to get and use the parsed proof.

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
  python src/main.py -l starknet_with_keccak < src/starkware/cairo/stark_verifier/air/example_proof.json > parseout.txt
  ```

### 5. Access Output File

- The output will be available in the `parseout.txt` file.

## Using the Parsed Proof

Once you have the parsed proof, you can use it as follows:

### 1. Copy Proof to Input File

- Copy the entire content or a consistent section of `parseout.txt` to `runner/resources/parsein.txt`.

### 2. Adjust Input Structures

- Modify the structures in `src/input_structs` to match the copied content.

### 3. Execute the Runner Script

- Run the script using: `./run.sh`.
