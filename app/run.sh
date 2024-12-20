#!/bin/bash

if [ -d /root/.local/share/storj/identity/storagenode ]; then
    echo "storagenode folder exists"
    exit 1
fi

curl -L https://github.com/storj/storj/releases/latest/download/identity_linux_$TARGETARCH.zip -o identity_linux.zip

unzip -o identity_linux.zip

rm identity_linux.zip

chmod +x identity

./identity create storagenode

./identity authorize storagenode $EMAIL_TOKEN

# check grep -c BEGIN ~/.local/share/storj/identity/storagenode/ca.cert is 2
if [ $(grep -c BEGIN /root/.local/share/storj/identity/storagenode/ca.cert) -ne 2 ]; then
    echo "ca.cert is invalid"
    exit 1
fi

# check grep -c BEGIN ~/.local/share/storj/identity/storagenode/identity.cert is 3
if [ $(grep -c BEGIN /root/.local/share/storj/identity/storagenode/identity.cert) -ne 3 ]; then
    echo "identity.cert is invalid"
    exit 1
fi


echo "-----------identity successfully created !!-------------"