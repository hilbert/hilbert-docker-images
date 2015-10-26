#! /bin/sh

while : 
do

  ls -la /dev/pts/ptmx
  chmod a+rw /dev/pts/ptmx
  sleep 10
  
done

