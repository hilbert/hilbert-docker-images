#!/usr/bin/env bash

# The start script for the docker container.

echo "IP ADDR: `ip addr`"

echo "** Starting OMD **"
/etc/init.d/apache2 start 2>&1
/etc/init.d/xinetd start 2>&1

omd start default 2>&1
service apache2 restart 2>&1

curl -L -XGET -u "omdadmin:omd" -- \
"http://localhost:5000/default/check_mk/wato.py?mode=edit_configvar&varname=wato_upload_insecure_snapshots&site=&folder=" > /tmp/globs.html
ID=`grep '_transid' /tmp/globs.html | sed -e 's|^.*_transid" value="\([0-9]*/[0-9]*\)".*$|\1|gi'`

### Configuration GUI (WATO) / Allow upload of insecure WATO snapshots: OFF -> ON
curl -L -XGET -u "omdadmin:omd" -- \
"http://localhost:5000/default/check_mk/wato.py?folder=&mode=globalvars&_action=toggle&_varname=wato_upload_insecure_snapshots&_transid=$ID" > /tmp/wato_toggle.html

#omdadmin/omd
### http://stackoverflow.com/questions/12667797/using-curl-to-upload-post-data-with-files :(
### TODO: FIXME: clean stop with backup????
### TODO: FIXME: restore previous state?  TODO: updloate and restore...? or shared docker volume?
# cmk -R ??

# exit 0

SLEEP_TIME=60
MAX_TRIES=5

tries=0

while /bin/true; do
  sleep $SLEEP_TIME
  omd status 2>&1 | grep -q "stopped" && {
    if [ $tries -gt $MAX_TRIES ]; then
      echo "** ERROR: Stopped service found; aborting (after $tries tries) **"
      exit 1
    fi
    tries=$(( tries + 1 ))
    echo "** ERROR: Stopped service found; trying to start again **"
    omd start 2>&1
  }
done

exit 0
