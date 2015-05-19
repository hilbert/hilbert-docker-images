#!/bin/bash

# mkdir -p imgs/

ARGS="$@"


NUM=0
for T in $ARGS ; 
do
   NUM=$(( $NUM + 1 ))

   TT=$(echo "$T" | sed -e 's@[ ]@_@g')
#  N=$( printf "imgs/%02d_$T.jpg" $(($NUM)) )

#### http://www.imagemagick.org/Usage/draw/
#  convert -size 200x240 xc:lightblue -pointsize 25 -gravity center -fill red -stroke black -strokewidth 1 \
#          -draw "translate 0,0 rotate -45 text 0,0 \"$NUM: $TT\"" "$N" 1>&2


#  N=$( printf "\"$T\"")
  echo "\"$TT\" $NUM:$T"

done

   NUM=$(( $NUM + 1 ))
   echo "@NE $NUM:CORNER_NE"
   
   NUM=$(( $NUM + 1 ))
   echo "@NW $NUM:CORNER_NW"

   NUM=$(( $NUM + 1 ))
   echo "@SE $NUM:CORNER_SE"

   NUM=$(( $NUM + 1 ))
   echo "@SW $NUM:CORNER_SW"

