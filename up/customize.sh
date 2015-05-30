
#!/bin/bash

SELFDIR=`dirname "$0"`
SELFDIR=`cd "$SELFDIR" && pwd`

cd "$SELFDIR"

ARGS="$@"

if [ -z "$ARGS" ]; then 
  ARGS=x11 test
fi

U=malex984
I=dockapp

docker images -a
docker ps -a -s

## TODO: another for loop for customizable images

for d in $ARGS ;
do
  echo
  echo "Updating $U/$I:$d...."
  docker rmi --no-prune=true "$d"
  "$SELFDIR/up_vb.sh" "$U/$I:$d" || exit 1
  "$SELFDIR/up_nv.sh" "$U/$I:$d" || exit 1
  docker tag "$U/$I:$d" "$d" 
  docker rmi $(docker images -q -f dangling=true)
done

docker images -a
docker ps -a
