echo -n "Owner account address: "
read OWNER

CLASSHASH=0x1890dd57c85c08c56f452a68801a969afb9eb9bdc337d336c37d7670723bb4e

sncast \
    deploy \
    --fee-token eth \
    --class-hash $CLASSHASH \
    --constructor-calldata "$OWNER"
