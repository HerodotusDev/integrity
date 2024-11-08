echo -n "Owner account address: "
read OWNER

CLASSHASH=0x1fae2572ca0fb3c068d5f19242ebbb6868d926147fc0a1b36ac0fafaee1f0c8

sncast \
    deploy \
    --fee-token eth \
    --class-hash $CLASSHASH \
    --constructor-calldata "$OWNER"
