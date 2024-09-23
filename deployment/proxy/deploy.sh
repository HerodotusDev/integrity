echo -n "Owner account address: "
read OWNER

CLASSHASH=0x023158aadc7e83eb968f41d9c747cf1a70bbc22e03244715e4f75855dc2224e8

sncast \
    deploy \
    --fee-token eth \
    --class-hash $CLASSHASH \
    --constructor-calldata "$OWNER"
