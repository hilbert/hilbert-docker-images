#! /bin/bash

PS3="Please choose an appplication. 1 -> AAA (A.sh), 2 -> BBB (B.sh), 3 -> quit> "

select choice in AAA BBB QUIT ;
do
 case "$choice" in
  AAA|BBB|QUIT ) echo "Choice $((REPLY)): '$choice'" && exit $((200+REPLY)) ;;
 esac
done
