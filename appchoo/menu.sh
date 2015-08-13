#!/bin/bash

SELFDIR=`dirname "$0"`
cd "$SELFDIR"

# SELFDIR=`cd "$SELFDIR" && pwd`
#echo -e 'apple_logo.jpg APP\nwindows_logo.jpg WIN\nlinux_logo.jpg LIN\nIMG.jpg IMG\n7.jpg 7\n@NW north_west_corner\n@NE north/east corner\n@SE south/east corner\n@SW south/west corner'

APP=appchoo
PR="$1"
shift

B="$1"
shift

ARGS="$@"

PS3="$PR > "
# "Please choose an appplication. 1 -> AAA (A.sh), 2 -> BBB (B.sh), 3 -> XEYES, 4 -> quit>"

# A=( $L )
# N=${#A[@]}
# echo $N 



if [ -z "$DISPLAY" ]; then 

  select choice in $ARGS ;
  do
  #  echo "Choice $((REPLY)): '$choice'" 
    [ ! -z "$choice" ] && echo "Thanks for choosing '$choice'" && exit $(($B + REPLY)) 
  done

else


  CHOO=$(./txt2jpg.sh $ARGS | ./$APP -p "$PS3")
  choice=$(echo $CHOO | sed 's@^.*:@@g')
  
  echo "Thanks for choosing '$choice'"
  
  REPLY=$(( $(echo "$CHOO" | sed 's@:.*$@@g') ))
  exit $(($B + REPLY)) 
  
fi

