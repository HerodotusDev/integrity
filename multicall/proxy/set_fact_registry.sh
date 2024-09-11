echo -n "Proxy address: "
read PROXY

echo -n "FactRegistry address: "
read FACT_REGISTRY

sncast \
    invoke \
    --fee-token eth \
    --contract-address $PROXY \
    --function "set_fact_registry" \
    --calldata "$FACT_REGISTRY"
