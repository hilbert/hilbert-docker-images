#!/bin/sh

[ -f /etc/nginx/sites-enabled/default ] && rm -f /etc/nginx/sites-enabled/default
[ -f /etc/nginx/sites-available/default ] && rm -f /etc/nginx/sites-available/default

nginx -t || exit 1

(nginx -s stop; nginx -s quit) 1>>/dev/null 2>&1

nginx

# exec /usr/sbin/nginx -g "daemon off;" # for service

