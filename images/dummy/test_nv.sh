#!/bin/bash

APP="$1"
IMG="$APP" ## $U/$I:$APP"


# Count the number of NVIDIA controllers found.
NVDEVS=`lspci | grep -i NVIDIA`
echo $NVDEVS

N3D=`echo "$NVDEVS" | grep "3D controller" | wc -l`

NVGA=`echo "$NVDEVS" | grep "VGA compatible controller" | wc -l`
N=`expr $N3D + $NVGA - 1`



for i in `seq 0 $N`; do
# mknod -m 666 /dev/nvidia$i c 195 $i
ls -al /dev/nvidia$i
done

# mknod -m 666 /dev/nvidiactl c 195 255
ls -al /dev/nvidiactl

# Find out the major device number used by the nvidia-uvm driver
D=`grep nvidia-uvm /proc/devices | awk '{print $1}'`
# mknod -m 666 /dev/nvidia-uvm c $D 0

ls -la /dev/nvidia-uvm

grep nvidia /proc/devices
