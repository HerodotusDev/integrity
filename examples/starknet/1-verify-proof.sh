#!/usr/bin/env bash

# Check if the arguments are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <contract_address> <calldata_file>"
    exit 1
fi

# Assign arguments to variables
contract_address=$1
calldata_file=$2

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
    --function "verify_and_register_fact" \
    --calldata $calldata
