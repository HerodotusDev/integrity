#!/usr/bin/env bash

scarb build
cd runner
cargo run --release -- ../target/dev/cairo_verifier.sierra < resources/parserin.txt
