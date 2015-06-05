#!/bin/bash

#SELFDIR=`dirname "$0"`
#SELFDIR=`cd "$SELFDIR" && pwd`
#cd "$SELFDIR"

I="$1"
shift

G="$1"
shift

#D=$1
D=dummyx11
C="c_$D"


## pre-cleanup
docker rm -vf $C 1>&2 || true
docker rmi -f --no-prune=false $D 1>&2 || true


R="-it -a stdin -a stdout -a stderr --ipc=host --net=host --pid=host -v /etc/localtime:/etc/localtime:ro -v /tmp/:/tmp/:rw"
O="--skip-startup-files --no-kill-all-on-exit --quiet --skip-runit"

## Create $C conainer out of $I and run customization script in it:
docker run $R --name $C $I $O -- bash -c 'customize.sh' 1>&2
# --privileged --ipc=host  --net=host --pid=host -v /dev/:/dev/:rw


#	docker start $C && sleep 1
#	docker commit --change "VOLUME /usr/" --change "VOLUME /etc/" --change "VOLUME /opt/" $C $D
#	docker diff $C > ${mkfile_dir}/${APP}_${D}.diff


## Output the effects of customization procedure:
docker diff $C

## Select necessary added/changed customizing files:
A=`docker diff $C |grep -E '^A /(usr|etc|sbin)/' |grep -vE ' (/usr/src|/usr/lib/python[23]|/usr/share/doc|/usr/share/man|/etc/container_environment)' |sed 's@^[CA] @@g'|xargs`

docker commit $C $D

## pre-cleaup:
docker rm -vf $C 1>&2
rm -Rf $G 1>&2 || true

## generate target archive $G:
# TODO: --recursion ? ADDEDFILES=/bin/true /lib/x86_64-linux-gnu/libc.so.6 /lib64/ld-linux-x86-64.so.2 /usr/lib/x86_64-linux-gnu/ ?
docker run $R --rm $D $O -- bash -c "tar czvf $G --hard-dereference --dereference $A && chmod a+rw $G"

## post-cleanup:
docker rmi -f --no-prune=false $D 1>&2 || true
