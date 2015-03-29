#! /bin/bash

PS3="Please choose an appplication. 1 -> AAA (A.sh), 2 -> BBB (B.sh), 3 -> XEYES, 4 -> quit> "

select choice in AAA BBB XEYES QUIT ;
do
 case "$choice" in
  AAA|BBB|XEYES|QUIT ) echo "Choice $((REPLY)): '$choice'" && exit $((200+REPLY)) ;;
 esac
done
