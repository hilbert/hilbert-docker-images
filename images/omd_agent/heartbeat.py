#!/usr/bin/python

### Heartbeat:
###	webgl: add to render loop (initiate)
###	multithread / asynchron sending (should not block the application)
###     non-blocking i/o
###     how often: 1 beat per second (or less)?
###     TCPIP connection: leave open?
###
###     GET request
###     sending: add into URL "ID exhibit, heartbeat expectation" (selbstverpflichtung)
###     The server knows the IP (computer).
###
###     initial setup for monitoring software (also list of programs which run on which host)
###     startup via Nagios?
###
###     ----
###     maintenance mode could be added (you put station on maintenance), if a station is not expected to be running (in order to avoid automatic restart during maintenance)

### Heartbeat protocol:
### * pass protocol parameters into container via ENVIRONMENT VARIABLES, e.g.
###
###   - HEARTBEART_HTTP=http//IP:PORT/heartbeat.html?container=pong&next=%n
###     = application substitutes %n with minimal time until next heartbeart	(milliseconds) and sends GET request
###     = server answers with maximal time for next heartbeart (>minimal heartbeat time) (otherwise it will take some action)
###
###   - HEARTBEART_TCP=IP:PORT
###     = CLIENT: send minimal time until next heartbeat (ms)
###     = SERVER: send maximal time until next heartbeat (ms)
### 
### * ENVIRONMENT PARAMETERS are passed by url parameters into browser based applications some API exposed by electron for kiosk applications?
### 
### * when container is starting, the management system is waiting for some predefined time (15 seconds? same as regular waiting time when the app is running properly) before expecting the first heartbeat; afterwards the protocol is self tuning

### Heartbeat protocol implementation:
### 
### * asynchronous HTTP requests in JS
### * provide a JS library the ???

from time import time
from time import sleep
from urllib2 import urlopen
from random import randint
from BaseHTTPServer import BaseHTTPRequestHandler,HTTPServer

import sys # what? 
import urllib # what? why?

PORT_NUMBER = 8080
HOST_NAME = 'localhost'

# localhost:8080/hb_init?48&appid=test_client_python =>
#         /init
#         [*] 
#         ['48', 'appid=test_client_python']
#         Accept-Encoding: identity
#         Host: localhost:8080
#         Connection: close
#         User-Agent: Python-urllib/2.7
#         
#         ID: Python-urllib/2.7@127.0.0.1

visits = {}
overdue = 0 # Just for now... TODO: FIXME?: should be a part of visit data, right?!

class MyHandler(BaseHTTPRequestHandler):
#        s.headers, s.client_address, s.command, s.path, s.request_version, s.raw_requestline
    def do_GET(s):
        global visits
        global overdue
        
        s.send_response(200)
        s.send_header('Content-type','text/html')
       	s.end_headers()
        
        ### TODO: FIXME: the following url parsing is neither failsafe nor secure! :-(
        path, _, tail = s.path.partition('?')
        path = urllib.unquote(path)

       
        if path == "/list":
            for k, v in visits.iteritems():
                s.wfile.write(str(k) + "\n")
            return

        query = tail.split('&')
        
        if path == "/status":
            if tail != "":
                ID = query[0].split('=')[1] # + " @ " + s.client_address[0] # " || " + s.headers['User-Agent']
                if ID in visits:
                    v = visits[ID]
                    s.wfile.write(str(v))
                else:
                    s.wfile.write("Sorry: no record for: " + str(ID))
            else:
                if len(visits) != 1:
                    s.wfile.write("WARNING - " + str(len(visits)) + " apps" )
                else:
                    v = visits.itervalues().next()
                    
                    lastts = v[0]
                    lastt  = v[1]
                    

                    
                
#                for k, v in .iteritems():
 #                   str(k) + ":" + str(v) +"\n")
            
            return
        
       
        # PARSING: s.path -->>> path ? T & appid = ID        
	ID = query[1].split('=')[1] + " @ " + s.client_address[0] # " || " + s.headers['User-Agent']
                
        ts = time() 
            
        if path == "/done":
            print "Destruction: ", ID, " at ", ts
            del visits[ID]
            s.wfile.write("So Long, and Thanks for All the Fish!")
            return 
        
        T = int(query[0])
        
        if path == "/init":
            # Hello little brother! Big Brother is watching you!		
            print "Lookup/Creation: ", ID, " at ", ts 
            T = T + 1 #max(10, (T*17)/16)
            visits[ID] = (ts, T)
            s.wfile.write(T) # ?
            return 

        
        
        
	
        if path == "/ping": #
            # TODO: make sure visits[ID] exists!
            print "HEART-BEAT for: ", ID, " at ", ts  # Here i come again... 
            lastts = visits[ID][0]
            lastt  = visits[ID][1]
            
            if (ts - lastts) > lastt: # Sorry Sir, but you are too late :-(
                overdue += 1
             
            if overdue > 2:
                print("overdue!") # TODO: early detection of overdue clients!!???
                s.wfile.write("dead") # ?
                del visits[ID]
            else:
                T = T + 1 # max(3, (T*11)/8)
                visits[ID] = (ts, T)
                s.wfile.write(T) # ?
           
        return 

def test_server(HandlerClass = MyHandler, ServerClass = HTTPServer, protocol="HTTP/1.0"):
    """Test the HTTP request handler class.
    """

    port = PORT_NUMBER
    server_address = (HOST_NAME, port)

    HandlerClass.protocol_version = protocol
    httpd = ServerClass(server_address, HandlerClass)

    sa = httpd.socket.getsockname()
    print "Serving HTTP on", sa[0], "port", sa[1], "..."
    httpd.serve_forever()


def test_client():
    t = randint(2, 5)
    APP_ID = "test_client_python%" + str(randint(99999999, 9999999999)) # TODO: get unique ID from server?
    
    
    print "List HB apps: " + urlopen("http://" + HOST_NAME + ":" + str(PORT_NUMBER) + "/list" ).read()
    print "APP HB Status: " + urlopen("http://" + HOST_NAME + ":" + str(PORT_NUMBER) + "/status" ).read()
    
    tt = urlopen("http://" + HOST_NAME + ":" + str(PORT_NUMBER) + "/init?" + str(t) + "&appid="+ APP_ID ).read()
    print "Initial response: ", tt

    print "List HB apps: " + urlopen("http://" + HOST_NAME + ":" + str(PORT_NUMBER) + "/list" ).read()
    print "APP HB Status: " + urlopen("http://" + HOST_NAME + ":" + str(PORT_NUMBER) + "/status" ).read()
    
    for i in xrange(1, 20):
        d = randint(0, (int(tt) * 3)/2)
        print "heart-beat: ", i, "! Will sleep for ", d, " sec........ "
        sleep(d)
        # heartbeat: 
        t = randint(0, 5)
        
        print "List HB apps: " + urlopen("http://" + HOST_NAME + ":" + str(PORT_NUMBER) + "/list" ).read()
        print "APP HB Status: " + urlopen("http://" + HOST_NAME + ":" + str(PORT_NUMBER) + "/status" ).read()
        
        print "Ping: ", t
        tt = urlopen("http://" + HOST_NAME + ":" + str(PORT_NUMBER) + "/ping?" + str(t) + "&appid="+ APP_ID ).read()
        print "Pong: ", tt
        if tt == "dead":

            print "List HB apps: " + urlopen("http://" + HOST_NAME + ":" + str(PORT_NUMBER) + "/list" ).read()
            print "APP HB Status: " + urlopen("http://" + HOST_NAME + ":" + str(PORT_NUMBER) + "/status" ).read()
            # "?appid="+ APP_ID
            print "Ups: we run out of time..."
            tt = urlopen("http://" + HOST_NAME + ":" + str(PORT_NUMBER) + "/done?0&appid="+ APP_ID ).read()

            print "List HB apps: " + urlopen("http://" + HOST_NAME + ":" + str(PORT_NUMBER) + "/list" ).read()
            print "APP HB Status: " + urlopen("http://" + HOST_NAME + ":" + str(PORT_NUMBER) + "/status" ).read()
            break
    
    
# port = int(sys.argv[1])
if __name__ == '__main__':
    print(sys.argv)
    if (len(sys.argv) == 1):
        test_client()
    else:
#        if (sys.argv[1] == "-s"):
        test_server()
