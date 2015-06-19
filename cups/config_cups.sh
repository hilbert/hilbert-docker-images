#!/bin/bash

I="$@"

if [ -z "$I" ]; then
   if [ ! -z "$PRINTER" ]; then 
     I="$PRINTER"
   else
    if [ ! -z "$HIP" ]; then 
       I="$HIP" 
     else
        I=$(ping -c 3 dockerhost | head -n 4 | tail -n 1 | sed -e 's@^.*(@@g'  -e 's@).*$@@g')
        I="$I:631/version=1.1"
     fi
   fi
fi

echo "Server: '$I'"
echo

echo "ServerName $I" >> /etc/cups/client.conf

lpstat -l -t -v -s -p 

P=$(lpstat -p 2>&1 | grep '^printer ' | head -n 1 | sed -e 's@^printer @@g' -e 's@ .*@@g')

echo "Default printer: '$P'"


lpoptions -d "$P"

lpstat -d
