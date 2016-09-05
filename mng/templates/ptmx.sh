#! /bin/sh  -xv

unset DISPLAY

while : 
do
  ls -la /dev/pts/ptmx
  chmod a+rw /dev/pts/ptmx
  sleep 20
done

