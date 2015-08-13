# http://owen.sj.ca.us/~rk/howto/slides/make/slides/makeshell.html

#include Makefile.inc

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

build: phusion_baseimage_0.9.16.timestamp

phusion_baseimage_0.9.16.timestamp: 
	docker pull 'phusion/baseimage:0.9.16'
	docker images | grep -E 'phusion[\/]baseimage *0[\.]9[\.]16 ' > $@

force_look :
	true

