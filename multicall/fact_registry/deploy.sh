echo -n "Owner account address: "
read OWNER

CLASSHASH=0x00b80ebfe09f5400d6e7fe49526d088b45f8bb0831c7262901f4d66c6aa03cf4

sncast \
    deploy \
    --fee-token eth \
    --class-hash $CLASSHASH \
    --constructor-calldata "$OWNER"
