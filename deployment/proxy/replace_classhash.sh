echo -n "Proxy address: "
read PROXY

echo -n "Classhash: "
read CLASSHASH

sncast \
    invoke \
    --fee-token eth \
    --contract-address $PROXY \
    --function "replace_classhash" \
    --calldata "$CLASSHASH"
