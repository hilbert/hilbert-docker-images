# http://owen.sj.ca.us/~rk/howto/slides/make/slides/makeshell.html

#include Makefile.inc

DIRS = ptmx base appa dd \
omd_agent gui nodejs mng omd \
x11vnc x11comp \
qrhandler alsa xeyes cc \
kiosk iceweasel chrome \
x11 dummy \
kivy surfer \
appchoo main demo q3 cups play test skype xbmc mywebapp


#clean :
#$(ECHO) cleaning up in .
###-$(RM) -f $(EXE) $(OBJS) $(OBJLIBS)

build: 
	-for d in $(DIRS); do (cd $$d; $(MAKE) $@ || exit 1); done

cleanup: 
	-for d in $(DIRS); do (cd $$d; $(MAKE) $@ || exit 1); done

pull:
	-for d in $(DIRS); do (cd $$d; $(MAKE) $@ || exit 1); done


#build: docker_compose_1.6.2.timestamp
#docker_compose_1.6.2.timestamp:
#	docker pull 'docker/compose:1.6.2'
#	docker images | grep -E 'docker[\/]compose *1[\.]6[\.]2 ' > $@

force_look:
	true

