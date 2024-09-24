echo -n "Owner account address: "
read OWNER

CLASSHASH=0x5f5c798412f0f0e9760440a83f86ef5ff08f8de87a7f9de279edc09faa2e8dd

sncast \
    deploy \
    --fee-token eth \
    --class-hash $CLASSHASH \
    --constructor-calldata "$OWNER"
