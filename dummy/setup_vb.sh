#!/bin/bash

if [ ! -d /sys/module/vboxvideo/ ]; then 
  echo "Sorry: no vboxvideo kernel module is currently loaded! please modprob/insmod vboxvideo!"
  exit 0
fi

SELFDIR=`dirname "$0"`
cd "$SELFDIR"
SELFDIR=`pwd`

VER=$(cat /sys/module/vboxvideo/version)

# "$SELFDIR/test_vbox.sh"

echo "Current Virtual Box 'vboxvideo'-module version: '$VER'"
cd /tmp/ ;

if [ ! -e "/tmp/VBoxLinuxAdditions.run" ]; then
   echo "Downloading .iso..."

   test -e "/tmp/VBoxGuestAdditions_$VER.iso" || \
   (  wget "http://download.virtualbox.org/virtualbox/$VER/VBoxGuestAdditions_$VER.iso"  || exit 1; )

   echo "Extracting .run..."
   7z x "/tmp/VBoxGuestAdditions_$VER.iso" -y -bd -ir'!VBoxLinuxAdditions.run' || exit 1

fi 


mkdir -p /usr/lib/xorg/modules/drivers/ /usr/lib/x86_64-linux-gnu/dri/ && \
    chmod go+rx /usr/lib/xorg/modules/drivers/ /usr/lib/x86_64-linux-gnu/dri/

echo "Running .run..."
sh /tmp/VBoxLinuxAdditions.run 2>&1 || true
cat /var/log/vboxadd-install.log

DEBIAN_FRONTEND=noninteractive apt-get install -fy

# DEBIAN_FRONTEND=noninteractive apt-get -q -y install 
# libx11-6 libxcomposite1 libxdamage1 libxext6 libxfixes3 libxmu6 libxt6 xserver-xorg-core
# xorg-video-abi-18

test -e /usr/lib/x86_64-linux-gnu/dri/vboxvideo_dri.so || \
    ln -s /usr/lib/x86_64-linux-gnu/VBoxOGL.so \
            /usr/lib/x86_64-linux-gnu/dri/vboxvideo_dri.so

test -e /usr/lib/xorg/modules/drivers/vboxvideo_drv.so || \
    ln -s /usr/lib/x86_64-linux-gnu/VBoxGuestAdditions/vboxvideo_drv_115.so \
            /usr/lib/xorg/modules/drivers/vboxvideo_drv.so

#echo "Cleaning up:" 
#ls -la /tmp/VBoxLinuxAdditions.run "/tmp/VBoxGuestAdditions_$VER.iso"
# rm -f /tmp/VBoxLinuxAdditions.run "/tmp/VBoxGuestAdditions_$VER.iso"

# VBOX_VERSION="$VER"
echo "Setting up VBox LIBGL: '$VER' is done!" 

exit 0
