#!/bin/bash

echo "User:"
id
groups

echo "Host:"

echo "Kernel modules (`uname -a`)?"
sudo lsmod | grep -i -E "(video|vidia)"

cat $(sudo lspci | grep VGA | awk ' { print "/run/udev/data/+pci:0000:" $1 } ')

echo "Running X11?"
ls -lR /tmp/.X*-lock /tmp/.X11-unix

ls -lR /usr/lib/x86_64-linux-gnu/dri/
ls -lR /usr/lib/xorg/modules/drivers/

if [ -f /var/log/Xorg.0.log ]; then
  grep -C1 -n -E -i "(nvid|vbox|swrast|GLX|[\(][EW\?\+][EW\?\+][\)])" /var/log/Xorg.0.log
fi

if [ ! -z $DISPLAY ]; then
  echo "DISPLAY: $DISPLAY"
  
# xcompmgr -c &
# transset-df
# hsetroot -solid "#000000"

  export LIBGL_DEBUG=verbose
  
  xprop -root
  
  ( glxinfo -l | grep "\(\(renderer\|vendor\|version\) string\)\|direct rendering" ) 2>&1 
  /usr/lib/nux/unity_support_test -p 2>&1
  glmark2 -d --validate 2>&1
  
  glxgears -info 2>&1
fi



