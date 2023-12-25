#!/usr/bin/env bash

scarb build
cd runner
cargo run -- ../target/dev/cairo_verifier.sierra < resources/parserin.txt
