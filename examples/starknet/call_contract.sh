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
  --contract-address 0x314277dca0fdac09e92f63c244d2b35d5d6efb2c32cf71289029bc5d8310ae5 \
  --function "verify_and_register_fact" \
  --calldata $calldata
