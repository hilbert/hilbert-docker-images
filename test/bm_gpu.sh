#!/bin/bash          


export LIBGL_DEBUG=verbose

x11perf -repeat 2 -dot -line100 -rect100 -circle100 -scroll100 -shmput100 -ftext >> bm_x11perf.log 2>&1

glmark2 --annotate >> bm_glmark2.log 2>&1


#fur = furmark
#gi = gimark

#tess_x8, 16, 32, 64
### triangle
#tess
#### OpenGL 3.3.0
## triangle
## plot3d
#### 1fps?
## fur
## gi
#### 0fps :(
### pixmark_piano 
### pixmark_volplosion

#tessmark
#./GpuTest /test=tess_x8 /width=1920 /height=1080 /fullscreen /benchmark
#./GpuTest /test=tess_x16 /width=1920 /height=1080 /fullscreen /benchmark
#./GpuTest /test=tess_x32 /width=1920 /height=1080 /fullscreen /benchmark
#./GpuTest /test=tess_x64 /width=1920 /height=1080 /fullscreen /benchmark



# 1024
W=1280
# 640
H=1024

ARG="/fullscreen /benchmark /gpumon_terminal /print_score"

for TEST in triangle plot3d fur gi pixmark_piano pixmark_volplosion tess_x32 ;
do
  echo
  echo $TEST
  
  ./GpuTest /test=$TEST /width=$W /height=$H $ARG  >> bm_GpuTest.log 2>&1
  
  echo
  
done

exit $?


