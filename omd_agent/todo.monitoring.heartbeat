Monitoring:

centralized service, 
star architecture, 
management server in the center use built-in “container startup loop” (bash script to fire up the program)

what to survey:

system level:
computer on/off
cpu (how many for how long)
memory use


container level:
container on/off
cpu (how many for how long)
memory use

application level:
heartbeat (CRITICAL - defines colour, red, green, yellow)
if it cannot be implemented: controlling through other program
(python) which controls certain things (changing CPU use, etc.)

general:
log files (Nagios) of everything happening


heartbeat:
webgl: add to render loop (initiate)
multithread / asynchron sending (should not block the application)
non-blocking i/o
how often: 1 beat per second (or less)?
TCPIP connection: leave open?  

GET request
sending: add into URL “ID exhibit, heartbeat expectation” (selbstverpflichtung)
The server knows the IP (computer).

initial setup for monitoring software (also list of programs which run on which host)
startup via Nagios?

----
maintenance mode could be added (you put station on maintenance), if a
station is not expected to be running (in order to avoid automatic
restart during maintenance)

heartbeat protocol:


pass protocol parameters into container via ENVIRONMENT VARIABLES, 
e.g. HEARTBEART_HTTP=http//IP:PORT/heartbeat.html?container=pong&next=%n

application substitutes %n with minimal time until next heartbeart(milliseconds) and sends GET request 

server answers with maximal time for next heartbeart (>minimal heartbeat time) (otherwise it will take some action)
HEARTBEART_TCP=IP:PORT

CLIENT: send minimal time until next heartbeat (ms)
SERVER: send maximal time until next heartbeat (ms)

ENVIRONMENT PARAMETERS are passed by url parameters into browser based applications some API exposed by electron for kiosk applications?


when container is starting, the management system is waiting for some predefined time 
(15 seconds? same as regular waiting time when the app is running properly) before expecting the first heartbeat; 
afterwards the protocol is self tuning


heartbeat protocol implementation:

* asynchronous HTTP requests in JS
* provide a JS library



