#!/bin/bash

if [ ! -d /sys/module/nvidia/ ]; then 
  echo "Sorry: no nvidia kernel module is currently loaded! please modprob/insmod nvidia!"
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


VER=$(cat /sys/module/nvidia/version)

$(SELFDIR)/test_nv.sh


echo "NV Version: '$VER'"

IN="$SELFDIR/Dockerfile_nv"
OUT="$SELFDIR/Dockerfile_nv.$VER"

if [ -f $IN ]; then 

  sed -e "s#[\$]VER#$VER#g" -e "s#[\$]IMG#$IMG#g" "$IN" > "$OUT"
  
else

  cat >"$OUT" <<EOF
###############################################################
FROM $IMG

MAINTAINER Oleksandr Motsak <malex984@googlemail.com>

# RUN DEBIAN_FRONTEND=noninteractive apt-get -y update

COPY ilkh.sh /usr/local/bin/

ENV NVIDIA_VERSION="$VER"

RUN curl "http://us.download.nvidia.com/XFree86/Linux-x86_64/$VER/NVIDIA-Linux-x86_64-$VER.run" \
    -o /tmp/nv && chmod +x /tmp/nv && /tmp/nv -s -N --no-kernel-module
        
RUN mv /tmp/nv "/usr/src/NVIDIA-Linux-x86_64-$VER.run"
        
# Clean up APT when done.
# RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
EOF

fi

# --no-cache=true??
docker build --pull=false --force-rm=true --rm=true --tag="$IMG.nv.$VER" --file="$OUT" "$SELFDIR"  || exit 1
docker tag "$IMG.nv.$VER" "$APP"



docker rm -fv $(docker ps -aq)
docker rmi $(docker images -qf "dangling=true")

#docker images -a
#docker ps -a

echo "Please check for image '$IMG.nv_$VER'"

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

