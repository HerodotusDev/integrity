#!/usr/bin/env bash

# Check if the arguments are provided
if [ $# -ne 6 ]; then
    echo "Usage: $0 <fact_registry_address> <calldata_file> <layout> <hasher> <stone_version> <memory_verification>"
    exit 1
fi

string_to_hex() {
    input_string="$1"
    hex_string="0x"
    for ((i = 0; i < ${#input_string}; i++)); do
        hex_char=$(printf "%x" "'${input_string:$i:1}")
        hex_string+=$hex_char
    done
    echo "$hex_string"
}

# Assign arguments to variables
contract_address=$1
calldata_file=$2
layout=$(string_to_hex $3)
hasher=$(string_to_hex $4)
stone_version=$(string_to_hex $5)
memory_verification=$(string_to_hex $6)

# Check if the file exists
if [ ! -f "$calldata_file" ]; then
    echo "Error: File '$calldata_file' not found."
    exit 1
fi

# Read calldata from the specified file
calldata=$(<$calldata_file)

# Pass the calldata to the sncast command
sncast \
    --wait \
    invoke \
    --contract-address "$contract_address" \
    --function "verify_proof_full_and_register_fact" \
    --calldata $layout $hasher $stone_version $memory_verification $calldata \
