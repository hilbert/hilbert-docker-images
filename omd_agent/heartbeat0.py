#!/usr/bin/python
from BaseHTTPServer import BaseHTTPRequestHandler,HTTPServer

import sys
import urllib

PORT_NUMBER = 8080
HOST_NAME = 'localhost'

# localhost:8080/hb_init?48&appid=test_client_python =>
#         /hb_init
#         [*] 
#         ['48', 'appid=test_client_python']
#         Accept-Encoding: identity
#         Host: localhost:8080
#         Connection: close
#         User-Agent: Python-urllib/2.7
#         
#         ID: Python-urllib/2.7@127.0.0.1

from time import time

visits = {}

class MyHandler(BaseHTTPRequestHandler):
    def do_GET(s):
        s.send_response(200)
        s.send_header('Content-type','text/html')
       	s.end_headers()
#        print 'GET: '
#        print s.headers
#        s.wfile.write("<pre>Hello " + s.command + ": \n")
        
        ### TODO: FIXME: the following url parsing is not failsafe or secure :((
        path, _, tail = s.path.partition('?')
        path = urllib.unquote(path)

        query = tail.split('&')
        
        T = int(query[0])
        ID = query[1].split('=')[1] + " || " + s.headers['User-Agent'] + " @ " + s.client_address[0]
                
#        print T
#        print ID
        global visits        
        ts = time() 
        
        if path == "/hb_init":
            print "Lookup/Creation: ", ID, " at ", ts
            T = max(10, (T*17)/16)
            visits[ID] = (ts, T)
            s.wfile.write(T) # ?
            
        if path == "/hb_ping":
            print "HEART-BEAT for: ", ID, " at ", ts
            lastts = visits[ID][0]
            lastt  = visits[ID][1]
            
            if (ts - lastts) > lastt:
                s.wfile.write("dead") # ?
            else:    
                T = max(3, (T*11)/8)
                visits[ID] = (ts, T)
                s.wfile.write(T) # ?
            
        return 
    
        s.wfile.write(path)
        s.wfile.write("\n [*] \n")
        s.wfile.write(query)        
        
        s.wfile.write("\n")
        s.wfile.write(s.headers)
        
        s.wfile.write("\n")
        s.wfile.write("ID: " + s.headers['User-Agent'] + "@" + s.client_address[0])
#        print s.command, s.path, s.request_version
#        print s.raw_requestline
#        print s.client_address 
        return



#server_class = BaseHTTPServer.HTTPServer
#httpd = server_class((HOST_NAME, PORT_NUMBER), MyHandler)
#try:
#   httpd.handle_request()
#except KeyboardInterrupt:
#    pass
#print postVars
#httpd.server_close()




def test_server(HandlerClass = MyHandler, ServerClass = HTTPServer, protocol="HTTP/1.0"):
    """Test the HTTP request handler class.

    This runs an HTTP server on port 8000 (or the first command line
    argument).

    """

    if sys.argv[1:]:
        port = int(sys.argv[1])
    else:
        port = PORT_NUMBER
    server_address = (HOST_NAME, port)

    HandlerClass.protocol_version = protocol
    httpd = ServerClass(server_address, HandlerClass)

    sa = httpd.socket.getsockname()
    print "Serving HTTP on", sa[0], "port", sa[1], "..."
    httpd.serve_forever()


from urllib2 import urlopen
from random import randint
from time import sleep

def test_client():
    t = randint(2, 10)
    APP_ID = "test_client_python%" + str(randint(99999999, 9999999999)) # TODO: get unique ID from server?
    tt = urlopen("http://" + HOST_NAME + ":" + str(PORT_NUMBER) + "/hb_init?" + str(t) + "&appid="+ APP_ID ).read()
    print "Initial response: ", tt
    
    for i in xrange(1, 10):
        print "heart-beat: ", i, "............. "
        sleep(randint(0, (int(tt) * 4)/3)) 
        # heartbeat: 
        t = randint(0, 5)
        print "Ping: ", t
        tt = urlopen("http://" + HOST_NAME + ":" + str(PORT_NUMBER) + "/hb_ping?" + str(t) + "&appid="+ APP_ID ).read()
        print "Pong: ", tt
        if tt == "dead":
            print "Ups: we run out of time... sooo long..."
            break
    
    
if __name__ == '__main__':
    test_client()
#    test_server()

