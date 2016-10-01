#!/bin/bash

APP="$1"
#U=malex984
#I=dockapp

IMG="$APP"
# $U/$I:$APP"

# Count the number of NVIDIA controllers found.
NVDEVS=`lspci | grep -i VirtualBox`
echo $NVDEVS

N3D=`echo "$NVDEVS" | grep "3D controller" | wc -l`

NVGA=`echo "$NVDEVS" | grep "VGA compatible controller" | wc -l`
N=`expr $N3D + $NVGA - 1`

sudo ls -laR /dev/* | grep -i video


for i in `seq 0 $N`; do
# mknod -m 666 /dev/nvidia$i c 195 $i
ls -al /dev/dri/card$i
done

# mknod -m 666 /dev/nvidiactl c 195 255
sudo ls -laR /dev/* | grep vbox
# ls -al /dev/nvidiactl


sudo grep vbox /proc/devices

sudo ls -la /sys/module/vbox*

sudo lsmod | grep -i 'vbox'

sudo grep vbox /proc/modules

sudo VBoxControl guestproperty  enumerate | sort


ls -l /usr/lib/x86_64-linux-gnu/VBoxGuestAdditions/98vboxadd-xclient

