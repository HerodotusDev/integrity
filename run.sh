#!/usr/bin/env bash

scarb build && \
cargo run --release -- ./target/dev/cairo_verifier.sierra.json < ./resources/in.txt

scarb build && \
cargo run --release --bin benches -- ./target/dev/cairo_verifier.sierra.json
