mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
COPYFILES   := 
include ../Makefile.inc

# --privileged --ipc=host  --net=host --pid=host
RUNTERM=-it -a stdin -a stdout -a stderr  --ipc=host  --net=host --pid=host \
        -v /etc/localtime:/etc/localtime:ro -v /tmp/:/tmp/:rw
#	-v /dev/:/dev/:rw

OPTS=--skip-startup-files --no-kill-all-on-exit --quiet --skip-runit


D  := dummy
C  := c_${D}
DS := ${mkfile_dir}/${APP}_${D}.timestamp
GL := /tmp/OGL

EXECFILES := 
#/bin/true /lib/x86_64-linux-gnu/libc.so.6 /lib64/ld-linux-x86-64.so.2 /usr/lib/x86_64-linux-gnu/ 

# , ${DS}
${GL}.tgz: clean ${TS}
	docker ps -a
	docker images
	docker run ${RUNTERM} --name $C ${IMG} ${OPTS} -- bash -c 'setup.sh' #	docker start $C && sleep 1
	docker commit --change "VOLUME /usr/" --change "VOLUME /etc/" --change "VOLUME /opt/" $C $D
	docker diff $C > ${mkfile_dir}/${APP}_${D}.diff
	docker run ${RUNTERM} --rm $D ${OPTS} -- bash -c "tar czvf $(GL).tgz --recursion --hard-dereference --dereference ${EXECFILES} `docker diff c_dummy | grep -E '^A /(usr|etc|sbin)/' | grep -vE '^A /usr/(src|share/doc|share/man)' | sed 's@^A @@g' | xargs `"
	docker rm -vf $C
	docker ps -a
	docker images
	$(DOCKER) images | $(GREP) "^${D} " | $(GREP) ${APP} > ${DS}
	ls -la ${GL}.tgz

#	docker rmi -f ogl || true
check: ${TS} ${GL}.tgz
	mkdir -p ${GL} && tar xzvf ${GL}.tgz -C ${GL}
	docker ps -a
	docker run ${RUNTERM} --rm malex984/dockapp:dummy ${OPTS} -- bash -c "ls -lR $(GL)/ | grep -i vbox" 
	docker ps -a

clean:
	docker rm -vf $C || true
	docker rmi -f --no-prune=false $D || true
	rm -f ${DS} ${mkfile_dir}/${APP}_${D}.diff || true
	rm -Rf ${GL}* || true 
	docker images -q -f dangling=true | xargs docker rmi || true
