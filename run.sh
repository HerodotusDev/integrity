#!/usr/bin/env bash

scarb build && \
cargo run --release -- ./target/dev/cairo_verifier.sierra.json < ./resources/main_proof.json
