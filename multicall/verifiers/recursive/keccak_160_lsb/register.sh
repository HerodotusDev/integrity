echo -n "FactRegistry address: "
read FACT_REGISTRY

echo -n "Verifier address: "
read VERIFIER

sncast \
    invoke \
    --fee-token eth \
    --contract-address $FACT_REGISTRY \
    --function "register_verifier" \
    --calldata "0x726563757273697665 0x6b656363616b5f3136305f6c7362 0x73746f6e6535 $VERIFIER"
