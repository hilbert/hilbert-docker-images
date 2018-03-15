#!/bin/bash

APP="$1"
IMG="$APP" # $U/$I:$APP"

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


# Find out the major device number used by the nvidia-uvm driver
#D=`grep nvidia-uvm /proc/devices | awk '{print $1}'`
# mknod -m 666 /dev/nvidia-uvm c $D 0

# ls -la /dev/nvidia-uvm
sudo cat /proc/devices
#grep nvidia /proc/devices

sudo ls -la /sys/module/vbox*

sudo lsmod | grep -i 'vbox'

sudo VBoxControl guestproperty  enumerate | sort

