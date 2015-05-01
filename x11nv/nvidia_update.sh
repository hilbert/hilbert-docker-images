#!/bin/bash

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

VER=$(cat /sys/module/nvidia/version)
echo "Version: '$VER'"

APP=x11

U=malex984
I=dockapp

IMG="$U/$I:$APP"

sed -e "s#[\$]VER#$VER#g" -e "s#[\$]IMG#$IMG#g" Dockerfile.nv > "Dockerfile.nv_$VER"

# --no-cache=true??
docker build --pull=false --force-rm=true --rm=true --tag="$IMG.nv_$VER" --file="Dockerfile.nv_$VER" .

docker rm -fv $(docker ps -aq)
docker rmi $(docker images -qf "dangling=true")

docker images -a
docker ps -a

exit

#ARGS=bash
#OPTS="--skip-startup-files --no-kill-all-on-exit --quiet --skip-runit"

#ID=$(docker create $IMG $OPTS -- $ARGS)
#D="/tmp"
#F="$D/$RUN"
## docker commit --change="COPY $RUN $D/" --change="RUN chmod +x $F" --change="RUN $F -s -N --no-kernel-module" --change="RUN rm $F" "$ID" "$IMG_nv"

#CMD="wget '$URL' -O '$D' && chmod +x '$D' && '$D' -s -N --no-kernel-module" #  && rm $D
#echo "Running '$CMD' in $ID"
#docker start -ai "$ID"
#docker exec -ti "$ID" "$CMD"
#docker commit "$ID" "$IMG_test"




exit 


## TODO: nvidia template?
cat <<EOF > Dockerfile.nv_$VER
FROM $IMG
MAINTAINER Oleksandr Motsak <malex984@googlemail.com>
ENV NVER="$VER"
ENV NRUN="NVIDIA-Linux-x86_64-\$NVER.run"
ENV NURL="http://us.download.nvidia.com/XFree86/Linux-x86_64/\$NVER/\$NRUN"
ENV NFILE="/tmp/\$NRUN"
ADD \$NURL \$NFILE
RUN chmod +x \$NFILE && \$NFILE -s -N --no-kernel-module && rm -f \$NFILE
EOF

