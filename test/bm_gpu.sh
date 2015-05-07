#!/bin/bash          


export LIBGL_DEBUG=verbose

glxgears -fullscreen -info >> bm_glxgears.log 2>&1

GpuTest-all.sh >> bm_gputest.log 2>&1

glmark2 --annotate --fullscreen --off-screen >> bm_glmark2.log 2>&1

x11perf -sync -repeat 1 -all >> bm_x11perf.log 2>&1
#### x11perf -sync -repeat 1 -dot -line100 -rect100 -circle100 -scroll100 -shmput100 -ftext >> bm_x11perf.log 2>&1


exit $?


