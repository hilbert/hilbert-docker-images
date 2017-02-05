#! /bin/bash

U=hilbert
IMAGE_VERSION="${IMAGE_VERSION:-latest}"
IMG="$U/appa:${IMAGE_VERSION}"


# options for running terminal apps via docker run:
RUNTERM="-it -a stdin -a stdout -a stderr"
OPTS="--skip-startup-files --quiet --skip-runit"

ID=$(docker create $RUNTERM --net=none "$IMG" $OPTS -- "/usr/local/bin/A.sh" "$@")
docker start -ai $ID
RET=$?

# docker run --rm $RUNTERM --net=none --name appa "${IMG}" $OPTS -- "/usr/local/bin/A.sh" "$@"

docker stop -t 5 $ID > /dev/null 2>&1
docker rm -f $ID > /dev/null 2>&1 

exit $RET

