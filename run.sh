#!/usr/bin/env bash

cargo run --release -- ./target/dev/cairo_verifier.sierra.json < ./resources/in.txt
