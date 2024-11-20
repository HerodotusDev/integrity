echo -n "Owner account address: "
read OWNER

CLASSHASH=0x42e2c9fcdaac0d8d368b1665ff220bbf2203080229f0f506d1a9b84966ca497

sncast \
    deploy \
    --fee-token eth \
    --class-hash $CLASSHASH \
    --constructor-calldata "$OWNER"
