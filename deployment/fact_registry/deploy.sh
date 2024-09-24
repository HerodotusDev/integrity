echo -n "Owner account address: "
read OWNER

CLASSHASH=0x4012cfd3e1d5d7d10bf28ff0865a45572e4016734642adc39d87d5b653f2467

sncast \
    deploy \
    --fee-token eth \
    --class-hash $CLASSHASH \
    --constructor-calldata "$OWNER"
