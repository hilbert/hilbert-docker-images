mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
COPYFILES   := menu.sh appchoo menu.sh txt2jpg.sh FreeMonoBold.ttf
include ../Makefile.inc

clean: 
	rm -f $(mkfile_dir)/$(APP).list $(mkfile_dir)/imgs/*.jpg
	rmdir $(mkfile_dir)/imgs

CH=A_Test_App_A B_Same_Test_App Alsa_Test GUI_Shell Bash_in_Main X11_Shell X11Server Xephyr Iceweasel Q3 Skype Cups_Server Media_Players AppChoo Test QUIT
ARGS="Please choose an app" 200 

RUNTERM=-it -a stdin -a stdout -a stderr
OPTS=--skip-startup-files --no-kill-all-on-exit --quiet --skip-runit

check: $(TS)
	xhost +
	docker run --rm -e DISPLAY ${RUNTERM} --net=none -v /tmp/:/tmp/:rw $(IMG) ${OPTS} -- menu.sh ${ARGS} ${CH} ; echo $$? > .returncode
	cat .returncode && rm .returncode


# $(APP).list imgs
#$(APP).list: txt2jpg.sh
#	./txt2jpg.sh $(CH) > $(APP).list

