#!/usr/bin/env bash

scarb build && \
cargo run --release --bin runner -- ./target/dev/cairo_verifier.sierra.json < ./resources/main_proof.json

scarb build --test && \
cargo run --release --bin benches -- ./target/dev/cairo_verifier.sierra.json
