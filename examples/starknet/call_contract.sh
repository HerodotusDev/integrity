#!/usr/bin/env bash

# Check if the argument is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <calldata_file>"
    exit 1
fi

# Check if the file exists
if [ ! -f "$1" ]; then
    echo "Error: File '$1' not found."
    exit 1
fi

# Read calldata from the specified file
calldata=$(<$1)

# Pass the calldata to the sncast command
sncast --profile testnet \
  --wait \
  invoke \
  --contract-address 0x3ba45c52dfa67d8c85f75001706f9fd5e34ab582b87d7f536f347ce35584ffc \
  --function "verify_and_register_fact" \
  --calldata $calldata
