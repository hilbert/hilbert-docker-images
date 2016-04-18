#! /bin/bash

WORKDIR="$PWD"

#SELFDIR=`dirname "$0"`
#SELFDIR=`cd "$SELFDIR" && pwd`
#cd $SELFDIR

python2.7 -c 'import SimpleHTTPServer,BaseHTTPServer; BaseHTTPServer.HTTPServer(("", 8080), SimpleHTTPServer.SimpleHTTPRequestHandler).serve_forever()' 
