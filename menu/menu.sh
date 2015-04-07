#! /bin/bash


PS3="$1 > "
# "Please choose an appplication. 1 -> AAA (A.sh), 2 -> BBB (B.sh), 3 -> XEYES, 4 -> quit>"
shift

L="$@"

# A=( $L )
# N=${#A[@]}
# echo $N 

select choice in $L ;
do
#  echo "Choice $((REPLY)): '$choice'" 
  [ ! -z "$choice" ] && echo "Thanks for choosing '$choice'" && exit $((200+REPLY)) 
done
