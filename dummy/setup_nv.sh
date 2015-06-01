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


test -e "/tmp/nv" || \
(curl "http://us.download.nvidia.com/XFree86/Linux-x86_64/$VER/NVIDIA-Linux-x86_64-$VER.run" -o /tmp/nv || exit 1; )

chmod +x /tmp/nv

mkdir -p /usr/lib/xorg/modules/drivers/ /usr/lib/x86_64-linux-gnu/dri/ && \
chmod go+rx /usr/lib/xorg/modules/drivers/ /usr/lib/x86_64-linux-gnu/dri/

/tmp/nv -s -N --no-kernel-module 2>&1 || true
cat /var/log/nvidia-installer.log

#rm -f /tmp/nv

DEBIAN_FRONTEND=noninteractive apt-get install -fy

ls -la /usr/lib/xorg/modules/drivers/ /usr/lib/x86_64-linux-gnu/dri/

#test -e /usr/lib/x86_64-linux-gnu/dri/vboxvideo_dri.so || \
#    ln -s /usr/lib/x86_64-linux-gnu/VBoxOGL.so \
#            /usr/lib/x86_64-linux-gnu/dri/vboxvideo_dri.so

test -e /usr/lib/xorg/modules/drivers/nvidia_drv.so || \
    ln -s /usr/X11R6/lib/modules/drivers/nvidia_drv.so
            /usr/lib/xorg/modules/drivers/nvidia_drv.so

# NVIDIA_VERSION="$VER"

echo "Setting up Nvidia LIBGL: '$VER' is done!"

exit 0

