#!/bin/bash

if [ ! -d /sys/module/vboxvideo/ ]; then 
  echo "Sorry: no vboxvideo kernel module is currently loaded! please modprob/insmod vboxvideo!"
  exit 0
fi

SELFDIR=`dirname "$0"`
cd "$SELFDIR"
SELFDIR=`pwd`

U=malex984
I=dockapp

APP="$1"

ID=$(docker images | awk '{ print "[" $1 ":" $2 "]" }' | sort | uniq | grep "\[$APP\]" )

if [ ! -z "$ID" ]; then  
  IMG="$APP"
  APP=$(echo "$IMG" | sed 's@^.*:@@g')  
  if [ "$APP" = "latest" ]; then
    APP=$(echo "$IMG" | sed -e 's@:.*$@@g' -e 's@/@_@g')  
  fi
else
  ID=$(docker images | awk '{ print "[" $1 "]" }' | sort | uniq | grep "\[$APP\]" )
  
  if [ ! -z "$ID" ]; then  
    IMG="$APP:latest"
  else
    IMG="$U/$I:$APP"
  fi  
fi



VER=$(cat /sys/module/vboxvideo/version)
echo "Current Virtual Box 'vboxvideo'-module version: '$VER'"


IN="$SELFDIR/Dockerfile_vb"
OUT="$SELFDIR/Dockerfile_vb.$VER"


if [ -f $IN ]; then 

  sed -e "s#[\$]VER#$VER#g" -e "s#[\$]IMG#$IMG#g" "$IN" > "$OUT" 

else

  cat >"$OUT" <<EOF
###############################################################
FROM $IMG

MAINTAINER Oleksandr Motsak <malex984@googlemail.com>

# RUN DEBIAN_FRONTEND=noninteractive apt-get -y update

RUN DEBIAN_FRONTEND=noninteractive apt-get  -q -y install p7zip-full wget

COPY ilkh.sh /usr/local/bin/

ENV VBOX_VERSION="$VER"

RUN cd /tmp/ && \
    wget -q "http://download.virtualbox.org/virtualbox/$VER/VBoxGuestAdditions_$VER.iso" && \
    7z x "VBoxGuestAdditions_$VER.iso" -y -bd -ir'!VBoxLinuxAdditions.run'

RUN sh /tmp/VBoxLinuxAdditions.run || cat /var/log/vboxadd-install.log
RUN mkdir -p /usr/lib/xorg/modules/drivers/ /usr/lib/x86_64-linux-gnu/dri/ && \
    chmod go+rx /usr/lib/xorg/modules/drivers/ /usr/lib/x86_64-linux-gnu/dri/ && \
    ln -s /usr/lib/x86_64-linux-gnu/VBoxOGL.so /usr/lib/x86_64-linux-gnu/dri/vboxvideo_dri.so && \
    ln -s /usr/lib/x86_64-linux-gnu/VBoxGuestAdditions/vboxvideo_drv_115.so /usr/lib/xorg/modules/drivers/vboxvideo_drv.so

RUN DEBIAN_FRONTEND=noninteractive apt-get purge -qqy --auto-remove p7zip-full && \
    rm -f  /tmp/VBoxGuestAdditions_$VER.iso && mv /tmp/VBoxLinuxAdditions.run /usr/src

# Clean up APT when done.
# RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


#### https://gist.github.com/mattes/2d0ffd027cb16571895c
#  mkdir x86 && cd x86 && tar xvjf ../VBoxGuestAdditions-x86.tar.bz2 && cd .. && \
#  mkdir amd64 && cd amd64 && tar xvjf ../VBoxGuestAdditions-amd64.tar.bz2 && cd .. && \
#  cd amd64/src/vboxguest-$VER && KERN_DIR=/linux-kernel/ make && cd ../../.. && \
#  cp amd64/src/vboxguest-$VER/*.ko \$ROOTFS/lib/modules/\$KERNEL_VERSION-tinycore64 && \
#  mkdir -p \$ROOTFS/sbin && cp x86/lib/VBoxGuestAdditions/mount.vboxsf \$ROOTFS/sbin/

EOF

fi
		      


# --no-cache=true??
docker build --pull=false --force-rm=true --rm=true --tag="$IMG.vb.$VER" --file="$OUT" "$SELFDIR"  || exit 1
docker tag "$IMG.vb.$VER" "$APP"


docker rm -fv $(docker ps -aq)
docker rmi $(docker images -qf "dangling=true")

# docker images -a
# docker ps -a

echo "Please check for image '$IMG.vb_$VER'"
exit 0

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

