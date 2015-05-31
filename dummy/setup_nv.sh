#!/bin/bash

if [ ! -d /sys/module/nvidia/ ]; then 
  echo "Sorry: no nvidia kernel module is currently loaded! please modprob/insmod nvidia!"
  exit 0
fi

SELFDIR=`dirname "$0"`
cd "$SELFDIR"
SELFDIR=`pwd`

VER=$(cat /sys/module/nvidia/version)

# "$(SELFDIR)/test_nv.sh"

echo "NV Version: '$VER'"

curl "http://us.download.nvidia.com/XFree86/Linux-x86_64/$VER/NVIDIA-Linux-x86_64-$VER.run" -o /tmp/nv && \
chmod +x /tmp/nv

mkdir -p /usr/lib/xorg/modules/drivers/ /usr/lib/x86_64-linux-gnu/dri/ && \
chmod go+rx /usr/lib/xorg/modules/drivers/ /usr/lib/x86_64-linux-gnu/dri/

/tmp/nv -s -N --no-kernel-module 2>&1 || true

rm -f /tmp/nv

DEBIAN_FRONTEND=noninteractive apt-get install -fy

# NVIDIA_VERSION="$VER"

echo "Setting up Nvidia LIBGL: '$VER' is done!"

exit 0

