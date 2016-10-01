#!/bin/bash

echo "User:"
id
groups


echo "Host:"

lsb_release -a

echo "Kernel modules (`uname -a`)?"
sudo lsmod | grep -i -E "(video|vidia)"

sudo ls -lR /dev | grep -i video
sudo ls -l /dev/dri/card*
sudo ls -l /sys/module

sudo lspci | grep VGA
cat $(sudo lspci | grep VGA | awk ' { print "/run/udev/data/+pci:0000:" $1 } ')

sudo cat /proc/devices


