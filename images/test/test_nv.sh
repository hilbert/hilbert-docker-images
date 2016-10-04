#!/bin/bash

APP="$1"

#U=malex984
#I=dockapp

IMG="$APP"
## $U/$I:$APP"


# Count the number of NVIDIA controllers found.
NVDEVS=`lspci | grep -i NVIDIA`
echo $NVDEVS

N3D=`echo "$NVDEVS" | grep "3D controller" | wc -l`

NVGA=`echo "$NVDEVS" | grep "VGA compatible controller" | wc -l`
N=`expr $N3D + $NVGA - 1`



for i in `seq 0 $N`; do
# mknod -m 666 /dev/nvidia$i c 195 $i
  sudo ls -al /dev/nvidia$i
done

# mknod -m 666 /dev/nvidiactl c 195 255
sudo ls -al /dev/nvidiactl

# Find out the major device number used by the nvidia-uvm driver
#D=`sudo grep nvidia-uvm /proc/devices | awk '{print $1}'`
# mknod -m 666 /dev/nvidia-uvm c $D 0

sudo ls -la /dev/nvidia-uvm

sudo grep nvidia /proc/devices

sudo grep nvidia /proc/modules

