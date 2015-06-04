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

cd /tmp/

ISO="VBoxGuestAdditions_$VER.iso"
RUN="VBoxGuestAdditions_$VER.run"

echo "Temps:"
ls -la "/tmp/$RUN" "/tmp/$ISO"

if [ ! -e "/tmp/$RUN" ]; then
   echo "Downloading $ISO..."

   test -e "/tmp/$ISO" || \
   (  wget "http://download.virtualbox.org/virtualbox/$VER/$ISO"  || exit 1; )

   echo "Extracting .RUN from `ls /tmp/$ISO`..."
   rm -f /tmp/VBoxLinuxAdditions.run || true
   7z x "/tmp/$ISO" -y -bd -ir'!VBoxLinuxAdditions.run' || exit 1
   mv "/tmp/VBoxLinuxAdditions.run" "/tmp/$RUN"
fi

echo "Running $RUN..."
sh "/tmp/$RUN" 2>&1 || true
cat /var/log/vboxadd-install.log

DEBIAN_FRONTEND=noninteractive apt-get install -fy

# DEBIAN_FRONTEND=noninteractive apt-get -q -y install 
# libx11-6 libxcomposite1 libxdamage1 libxext6 libxfixes3 libxmu6 libxt6 xserver-xorg-core
# xorg-video-abi-18

/etc/init.d/vboxadd-x11 restart

#mkdir -p /usr/lib/xorg/modules/drivers/ /usr/lib/x86_64-linux-gnu/dri/ && \
#    chmod go+rx /usr/lib/xorg/modules/drivers/ /usr/lib/x86_64-linux-gnu/dri/

#test -e /usr/lib/x86_64-linux-gnu/dri/vboxvideo_dri.so || \
#    ln -s /usr/lib/x86_64-linux-gnu/VBoxOGL.so \
#            /usr/lib/x86_64-linux-gnu/dri/vboxvideo_dri.so

#test -e /usr/lib/xorg/modules/drivers/vboxvideo_drv.so || \
#    ln -s /usr/lib/x86_64-linux-gnu/VBoxGuestAdditions/vboxvideo_drv_115.so \
#            /usr/lib/xorg/modules/drivers/vboxvideo_drv.so

echo "Temps:"
ls -la "/tmp/$RUN" "/tmp/$ISO"

#rm -f "/tmp/$RUN" "/tmp/$ISO"

# VBOX_VERSION="$VER"
echo "Setting up VBox LIBGL: '$VER' is done!" 

exit 0
