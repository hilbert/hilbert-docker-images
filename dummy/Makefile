mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
COPYFILES   := 
include ../Makefile.inc

CMD=bash -c 'setup.sh'
ARGS=

# --privileged --ipc=host  --net=host --pid=host
RUNTERM=-it -a stdin -a stdout -a stderr  --ipc=host  --net=host --pid=host \
        -v /etc/localtime:/etc/localtime:ro -v /tmp/:/tmp/:rw
#	-v /dev/:/dev/:rw

OPTS=--skip-startup-files --no-kill-all-on-exit --quiet --skip-runit

check: $(TS) clean
	docker ps -a
	docker images
	docker run ${RUNTERM} --name c_dummy $(IMG) ${OPTS} -- ${CMD} ${ARGS}
	docker start c_dummy
	docker commit --change "VOLUME /usr/" --change "VOLUME /etc/" --change "VOLUME /opt/" c_dummy dummy
	docker diff c_dummy
	docker ps -a
	docker run ${RUNTERM} --rm dummy ${OPTS} -- bash -c "tar czvf /tmp/OGL.tgz --recursion --hard-dereference --dereference /bin/true /lib/x86_64-linux-gnu/libc.so.6 /lib64/ld-linux-x86-64.so.2 /usr/lib/x86_64-linux-gnu/ `docker diff c_dummy | grep -E '^A /(usr|etc|sbin)/' | grep -vE '^A /usr/(src|share/doc|share/man)' | sed 's@^A @@g' | xargs `"
	docker rm -vf c_dummy
	docker rmi -f ogl || true
	cat /tmp/OGL.tgz | docker import --change "VOLUME /usr/" --change "VOLUME /etc/" - dummyogl
	docker images
	docker ps -a
	docker create --name c_ogl dummyogl /bin/true
	docker run ${RUNTERM} --volumes-from c_ogl --rm malex984/dockapp:dummy ${OPTS} -- bash -c "ls -lR /opt/; mount" 
	docker ps -a
	docker rm -vf c_ogl || true


	


clean:
	docker rm -vf c_dummy || true
	docker rm -vf c_ogl || true
	docker rmi -f --no-prune=false dummy dummyogl || true
	docker images -q -f dangling=true | xargs docker rmi || true
