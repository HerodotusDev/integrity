echo -n "FactRegistry address: "
read FACT_REGISTRY

echo -n "Verifier address: "
read VERIFIER

sncast \
    invoke \
    --fee-token eth \
    --contract-address $FACT_REGISTRY \
    --function "register_verifier" \
    --calldata "0x737461726b6e6574 0x6b656363616b $VERIFIER"
