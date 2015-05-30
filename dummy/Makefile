mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
COPYFILES   := 
include ../Makefile.inc

CMD=bash -c 'setup.sh'
ARGS=

RUNTERM=-it -a stdin -a stdout -a stderr --ipc=host --privileged --net=host --pid=host \
        -v /etc/localtime:/etc/localtime:ro -v /tmp/:/tmp/:rw

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
	docker exec c_dummy bash -c "tar czvf /tmp/OGL.tgz --dereference `docker diff c_dummy | grep '^A /usr/' | grep -v '^A /usr/src' | sed 's@^A @@g' | xargs `"
	docker rmi -f --no-prune=false dummy || true
	docker commit c_dummy dummy
	docker rm -vf c_dummy
	docker ps -a

	
clean:
	docker rm -vf c_tmp c_dummy || true
	docker rmi -f --no-prune=false tmp || true

