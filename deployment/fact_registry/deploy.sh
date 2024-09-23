echo -n "Owner account address: "
read OWNER

CLASSHASH=0x5d4c3018e4c829a93bd4ae6c433399172ec33b41d55c61c3c16d708b05fcee9

sncast \
    deploy \
    --fee-token eth \
    --class-hash $CLASSHASH \
    --constructor-calldata "$OWNER"
