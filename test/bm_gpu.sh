#!/bin/bash          


export LIBGL_DEBUG=verbose

SELFDIR=`dirname "$0"`
SELFDIR=`cd "$SELFDIR" && pwd`

# cd "$SELFDIR"

test_x11.sh >> /tmp/.test.log 2>&1
test_vbox.sh >> /tmp/.test.log 2>&1

glxgears -fullscreen -info >> /tmp/bm_glxgears.log 2>&1

### The following 2 tests fail under VirtualBox with Guest Additions installed (and used for direct rendering)
### due to insufficient LIBGL implementation of OpenGL :((( Using software rendering (MESA) will work but it is very slow!
sh "$SELFDIR/GpuTest_Linux_x64_0.7.0/GpuTest-all.sh" >> /tmp/bm_gputest.log 2>&1
glmark2 --annotate --fullscreen --off-screen >> /tmp/bm_glmark2.log 2>&1

x11perf -sync -repeat 1 -dot -line100 -rect100 -circle100 -scroll100 -shmput100 -ftext >> /tmp/bm_x11perf.log 2>&1
### x11perf -sync -repeat 1 -all >> /tmp/bm_x11perf.log 2>&1

ls -al /tmp/*.log

exit $?


