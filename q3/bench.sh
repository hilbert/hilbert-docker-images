#! /bin/bash


# http://manpages.ubuntu.com/manpages/saucy/man6/openarena.6.html
setup_ogl.sh

# xgamma -gamma 1.6

# +set r_fullscreen 1 +set r_mode -1 
/usr/games/openarena \
+set cg_drawFPS 1 +set cg_drawStatus 1 \
+set r_overbrightbits 1 +set r_gamma 1.3 +set r_mapoverbrightbits 1 \
+timedemo 1 +set demodone 'quit' +set demoloop1 'demo demo088-test1; set nextdemo vstr demodone' +vstr demoloop1

# +set demoloop1 "demo demo088-test1" +vstr demoloop1
# q3.sh $@

