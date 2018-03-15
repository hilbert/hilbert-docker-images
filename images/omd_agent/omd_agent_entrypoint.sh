#!/bin/bash

/etc/init.d/xinetd restart
exec python3 /usr/local/bin/heartbeat.py 
# 'server'
#python2.7 /tmp/heartbeat2.py  'server'

