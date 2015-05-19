U=malex984
I=dockapp
APP=appchoo
IMG=$U/$I:$(APP)

RUNTERM=-it -a stdin -a stdout -a stderr
OPTS=--skip-startup-files --no-kill-all-on-exit --quiet --skip-runit

all: build

build: .timestamp

# $(APP).list imgs

.timestamp: Dockerfile menu.sh 
	docker build -t $(IMG) .
	docker images -a $(IMG) > .timestamp


clean: 
	rm -f $(APP).list imgs/*.jpg
	rmdir imgs

CH=A_Test_App_A B_Same_Test_App Alsa_Test GUI_Shell Bash_in_Main X11_Shell X11Server Xephyr Iceweasel Q3 Skype Cups_Server Media_Players AppChoo Test QUIT
ARGS="Please choose an app" 200 

#$(APP).list: txt2jpg.sh
#	./txt2jpg.sh $(CH) > $(APP).list

check:
	### [ -z "${DISPLAY}" ] && exit 1
	xhost + || exit 1
	docker run --rm -e DISPLAY ${RUNTERM} --net=none -v /tmp/:/tmp/:rw $(IMG) ${OPTS} -- menu.sh ${ARGS} ${CH} ; echo $$? > .returncode
	cat .returncode && rm .returncode
	
	

