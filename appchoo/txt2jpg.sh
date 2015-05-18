#!/bin/bash

# http://www.imagemagick.org/Usage/draw/
mkdir -p imgs/

NUM=0

ARGS="$@"

for T in $ARGS ; 
do

  TT=$(echo "$T" | sed -e 's@[_]@ @g')
  N=$( printf "imgs/%02d_$T.jpg" $(($NUM)) )
  
  convert -size 200x240 xc:lightblue -pointsize 30 -gravity center -fill red -stroke black -strokewidth 1 \
          -draw "translate 0,0 rotate -45 text 0,0 \"$NUM: $TT\"" "$N" 1>&2

   echo "$N $(( 200 + $NUM ))"

   NUM=$(( $NUM + 1 ))
done

   NUM=$(( $NUM - 1 ))

   echo "@NE $(( 200 + $NUM ))"
   echo "@NW $(( 200 + $NUM ))"
   echo "@SE $(( 200 + $NUM ))"
echo -n "@SW $(( 200 + $NUM ))"

## exit $((200+REPLY))
