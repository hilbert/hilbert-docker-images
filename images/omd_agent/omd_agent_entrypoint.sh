#!/bin/bash

/etc/init.d/xinetd restart
python2.7 /usr/local/bin/heartbeat2.py 'server'
#python2.7 /tmp/heartbeat2.py  'server'

