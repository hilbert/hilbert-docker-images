mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
COPYFILES   := 
include ../Makefile.inc

CMD=bash -c 'setup.sh'
ARGS=

# --privileged --ipc=host 
RUNTERM=-it -a stdin -a stdout -a stderr --net=host --pid=host \
        -v /etc/localtime:/etc/localtime:ro -v /tmp/:/tmp/:rw
#	-v /dev/:/dev/:rw

OPTS=--skip-startup-files --no-kill-all-on-exit --quiet --skip-runit

check: $(TS) clean
	docker rm -vf c_tmp c_dummy || true
	docker ps -a
	docker images
	docker run ${RUNTERM} --name c_tmp $(IMG) ${OPTS} -- bash -c 'sleep 1'
	docker diff c_tmp
	docker rmi -f --no-prune=false tmp || true
	docker commit c_tmp tmp
	docker rm -vf c_tmp
	docker ps -a
	docker run ${RUNTERM} --name c_dummy tmp ${OPTS} -- ${CMD} ${ARGS}
	docker start c_dummy
	docker rmi -f --no-prune=false dummy || true
	docker commit c_dummy dummy
	docker diff c_dummy
	docker ps -a
	docker run ${RUNTERM} --rm dummy ${OPTS} -- bash -c "tar czvf /tmp/OGL.tgz --recursion --hard-dereference --dereference /usr/lib/x86_64-linux-gnu/ `docker diff c_dummy | grep -E '^A /(usr|etc|sbin)/' | grep -vE '^A /usr/(src|share/doc|share/man)' | sed 's@^A @@g' | xargs `"
	docker rm -vf c_dummy
	docker rmi -f ogl || true
	cat /tmp/OGL.tgz | docker import --change "VOLUME /usr/" --change "VOLUME /etc/" - dummyogl
	docker images
	docker ps -a


clean:
	docker rm -vf c_tmp c_dummy || true
	docker rmi -f --no-prune=false tmp || true
	docker images -q -f dangling=true | xargs docker rmi || true

