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

After building the verifier, you can run it with the following steps:

1. Navigate to the runner directory:

```bash
cd runner
```

2. Run the verifier:

```bash
cargo run --release -- ../target/dev/cairo_verifier.sierra < resources/parserin.txt
```
