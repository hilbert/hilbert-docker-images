# http://owen.sj.ca.us/~rk/howto/slides/make/slides/makeshell.html

#include Makefile.inc

# TODO: use shell ls to get all sub-folders
DIRS = \
base \
dd \
main \
appa \
appchoo \
alsa \
cups \
xeyes \
gui \
play \
q3 \
test \
up \
x11 \
xbmc \
iceweasel \
skype



#clean :
#$(ECHO) cleaning up in .
###-$(RM) -f $(EXE) $(OBJS) $(OBJLIBS)
#-for d in $(DIRS); do (cd $$d; $(MAKE) clean ); done

all: build

build: phusion_baseimage_0.9.18.timestamp

# docker_compose_1.6.2.timestamp

phusion_baseimage_0.9.18.timestamp: 
	docker pull 'phusion/baseimage:0.9.18'
	docker images | grep -E 'phusion[\/]baseimage *0[\.]9[\.]18 ' > $@


#docker_compose_1.6.2.timestamp:
#	docker pull 'docker/compose:1.6.2'
#	docker images | grep -E 'docker[\/]compose *1[\.]6[\.]2 ' > $@

force_look:
	true

