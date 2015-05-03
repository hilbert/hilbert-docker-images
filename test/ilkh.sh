#!/bin/bash

KR=$(uname -r)
KV=$(echo $KR | sed 's@-generic@@')

echo "Linux kernel: $KV, $KR"
DEBIAN_FRONTEND=noninteractive apt-get -q -y install build-essential dkms "linux-headers-$KV" "linux-headers-$KR"

