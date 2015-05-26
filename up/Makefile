mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
COPYFILES   := customize.sh Dockerfile_nv Dockerfile_vb ilkh.sh test_nv.sh test_vbox.sh up_nv.sh up_vb.sh
include ../Makefile.inc

clean: 
	rm -f $(mkfile_dir)/Dockerfile_vb.* $(mkfile_dir)/Dockerfile_nv.*


CMD=customize.sh
ARGS=test x11

##HIP=`ip route show 0.0.0.0/0 | grep -Eo 'via \S+' | awk '{ print \$1 }'`
#        --add-host=dockerhost:$(HIP) 

RUNTERM=-it -a stdin -a stdout -a stderr --ipc=host --privileged --net=host --pid=host \
        -v /etc/localtime:/etc/localtime:ro -v /tmp/:/tmp/:rw \
        -v /var/run/docker.sock:/var/run/docker.sock

#	-e DOCKER_HOST=unix:///var/run/docker.sock -e NO_PROXY=/var/run/docker.sock

### TODO: switch to remote docker / networking!?

OPTS=--skip-startup-files --no-kill-all-on-exit --quiet --skip-runit

check:
	docker ps -a
	docker run --rm ${RUNTERM} $(IMG) ${OPTS} -- ${CMD} ${ARGS}
	


