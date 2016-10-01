#!/bin/bash          


export LIBGL_DEBUG=verbose
#export LIBGL_ALWAYS_INDIRECT="1"
#export LIBGL_ALWAYS_SOFTWARE="1"

#LIBGL_SHOW_FPS

SELFDIR=`dirname "$0"`
SELFDIR=`cd "$SELFDIR" && pwd`

# cd "$SELFDIR"

glxgears -fullscreen -info >> /tmp/bm_glxgears.log 2>&1

### The following 2 tests fail under VirtualBox with Guest Additions installed (and used for direct rendering)
### due to insufficient LIBGL implementation of OpenGL :((( Using software rendering (MESA) will work but it is very slow!
sh "$SELFDIR/GpuTest_Linux_x64_0.7.0/GpuTest-all.sh" >> /tmp/bm_gputest.log 2>&1
mv $SELFDIR/GpuTest_Linux_x64_0.7.0/_geeks3d_gputest_scores.csv $SELFDIR/GpuTest_Linux_x64_0.7.0/_geeks3d_gputest_log.txt /tmp/


# offscreen
glmark2 --annotate --off-screen >> /tmp/bm_glmark2.log 2>&1

# onscreen
glmark2 --annotate >> /tmp/bm_glmark2.log 2>&1
# --fullscreen 


x11perf -sync -repeat 1 -dot -line100 -rect100 -circle100 -scroll100 -shmput100 -ftext >> /tmp/bm_x11perf.log 2>&1
### x11perf -sync -repeat 1 -all >> /tmp/bm_x11perf.log 2>&1

test_sys.sh >> /tmp/test.log 2>&1
test_x11.sh >> /tmp/test.log 2>&1
test_vbox.sh >> /tmp/test.log 2>&1
test_nv.sh >> /tmp/test.log 2>&1

ls -al /tmp/*.log

exit $?


