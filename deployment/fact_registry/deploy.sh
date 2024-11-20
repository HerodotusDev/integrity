echo -n "Owner account address: "
read OWNER

CLASSHASH=0x4f69207c1c0ca1085fc3989027dcd4d7415e075dd6c061520775657e3018956

sncast \
    deploy \
    --fee-token eth \
    --class-hash $CLASSHASH \
    --constructor-calldata "$OWNER"
