#! /bin/bash

A="$@"

### http://openarena.ws/board/index.php?topic=3699.0
#  r_intensity
ARGS="+set cg_drawFPS 1 +set cg_drawStatus 1 +set r_fullscreen 1 +set r_mode -1 +set r_overbrightbits 1 +set r_gamma 1.3 +set r_mapoverbrightbits 1"
# http://manpages.ubuntu.com/manpages/saucy/man6/openarena.6.html
# [ -n "${ARGS}" ] && ARGS="+set cg_drawFPS 1 +set cg_drawStatus 1 +set r_fullscreen 1 ${ARGS}"
# "+timedemo 1 +set demodone 'quit' +set demoloop1 'demo demo088-test1; set nextdemo vstr demodone' +vstr demoloop1"

setup_ogl.sh

echo "ARGS: "
echo ${ARGS}
echo "A: "
echo ${A}

/usr/games/openarena ${ARGS} ${A}
