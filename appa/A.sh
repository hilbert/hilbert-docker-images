#! /bin/bash
APP="$0"
ARGS="$@"
echo
echo "This is application '$APP', called with arguments: '$ARGS'"
echo
echo "We are running on the following host (${HOSTNAME}, hostid: `hostid`): `uname -a`"
echo "Current users: "
id
echo
echo "Press ENTER to continue..."
read
exit 0
