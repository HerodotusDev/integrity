#!/usr/bin/env bash

sncast \
  --url "https://starknet-testnet.public.blastapi.io/rpc/v0_6" \
  --wait \
  call \
  --contract-address 0x3ba45c52dfa67d8c85f75001706f9fd5e34ab582b87d7f536f347ce35584ffc \
  --function "is_valid" \
  --calldata 445823447123287751287981979498500300811127658881386060964830033994686629467
