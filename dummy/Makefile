mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
COPYFILES   := 
include ../Makefile.inc

# --privileged --ipc=host  --net=host --pid=host
RUNTERM=-it -a stdin -a stdout -a stderr  --ipc=host  --net=host --pid=host \
        -v /etc/localtime:/etc/localtime:ro -v /tmp/:/tmp/:rw
#	-v /dev/:/dev/:rw

OPTS=--skip-startup-files --no-kill-all-on-exit --quiet --skip-runit


D  := dummyx11
C  := c_${D}
DS := ${mkfile_dir}/${APP}_${D}.timestamp
GL := /tmp/OGL.tgz

ADDFILES := 
#/bin/true /lib/x86_64-linux-gnu/libc.so.6 /lib64/ld-linux-x86-64.so.2 /usr/lib/x86_64-linux-gnu/ 

# --recursion
# , ${DS}
${GL}: ${TS} ${mkfile_dir}/../main/generate_ogl.sh
	docker images
	docker ps -a
	echo "Customizing with '${mkfile_dir}/generate_ogl.sh "${IMG}" "${GL}" > ${mkfile_dir}/${APP}_${D}.diff'"
	${mkfile_dir}/../main/generate_ogl.sh "${IMG}" "${GL}" > ${mkfile_dir}/${APP}_${D}.diff
	docker images
	docker ps -a
	ls -la ${GL} > ${DS}

#	docker rm -vf $C || true
#	docker rmi -f --no-prune=false $D || true
#	sudo rm -Rf ${GL} || true 
#	docker run ${RUNTERM} --name $C ${IMG} ${OPTS} -- bash -c 'customize.sh' #	docker start $C && sleep 1
#	docker commit --change "VOLUME /usr/" --change "VOLUME /etc/" --change "VOLUME /opt/" $C $D
#	docker diff $C > ${mkfile_dir}/${APP}_${D}.diff
#	docker run ${RUNTERM} --rm $D ${OPTS} -- bash -c "tar czvf $(GL) --hard-dereference --dereference ${ADDFILES} `docker diff $C | grep -E '^A /(usr|etc|sbin)/' | grep -vE '^A /usr/(src|share/doc|share/man)' | sed 's@^A @@g' | xargs `"
#	docker rm -vf $C
#	$(DOCKER) images | $(GREP) "^${D} " > ${DS}



#	docker rmi -f ogl || true
	# mkdir -p ${GL} && tar xzvf ${GL}.tgz -C ${GL}
check: ${TS} ${GL}
	$(DOCKER) ps -a
	$(DOCKER) run ${RUNTERM} --rm malex984/dockapp:xeyes ${OPTS} -- bash -c "which setup_ogl.sh; setup_ogl.sh $(GZ); sleep 1" 
	$(DOCKER) ps -a

clean:
	rm -f ${DS} ${mkfile_dir}/${APP}_${D}.diff || true
	sudo rm -Rf "$(GL)" || true 
	docker rm -vf $C || true
	docker rmi -f --no-prune=false $D || true
	docker images -q -f dangling=true | xargs docker rmi || true
