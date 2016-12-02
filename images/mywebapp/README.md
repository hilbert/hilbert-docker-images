# Step-by-step Dockerization of web browser (kiosk) together with heartbeat JS library and sample .html file using it: 

* Create new sub-folder: `/mywebapp/` (the resulting image will be named `hilbert/mywebapp`)

* Specify the base image and your resources in a custom `Dockerfile`:

```
FROM hilbert/kiosk # Base docker image with Web Browser
RUN mkdir -p /usr/local/src/mywebapp # New folder for resources
COPY test_heartbeatjs.html hb.js /usr/local/src/mywebapp/ # copy local files into docker image
```

* Specify how to execute the resulting docker image in `docker-compose.yml`

```
version: '2.0'
services:
  mywebapp:  # Name this service for docker-compose
    build: . # use Dockerfile and resources from this location
    image: hilbert/mywebapp # new docker image
    labels: # framework's  labels:
     - "is_top_app=1"       # This is a top-front GUI appication 
     - "description=MyWebApp: internal HB.JS operation" # Application description for management UI
    environment:
      DISPLAY: "${DISPLAY}" # We will run WebBrowser which is a GUI application
      APP_ID: 'mywebapp'    # Application ID for heartbeat server (will be reported to OMD)
      HB_URL: 'http://127.0.0.1:8888'  # Assume heartbeat server to run on host's port :8888
      HB_INIT_TIMEOUT: 9    # Assume WebBrowser to start suring 9 seconds
    entrypoint:             
    - /sbin/my_init         # Framework's standard start-up wrapper (from phusion/baseimage:0.9.18)
    - --skip-runit          # no runits and no startup files are required for kiosk to run
    - --skip-startup-files  
    - --
    command:
    - hb_wrapper.sh         # HB wrapper (handles init and done messages)
    - launch.sh             # Framework's wrapper adding a close-button (and possibly adding OpenGL lib in run-time)
    - browser.sh            # Wrapper to run Kiosk
    - -l                    # Next is URL to show:
    - file:///usr/local/src/mywebapp/test_heartbeatjs.html?HB_APP_ID=mywebapp&HB_URL=http://127.0.0.1:8888
    network_mode: host      # Use host's network interface (in order to access heartbeat server directly)
    restart: on-failure:5   # Restart only 5 times upon failure
    volumes:
    - /etc/localtime:/etc/localtime:ro # Use host's localtime
    - /tmp:/tmp:rw          # Use host's /tmp (needs for accessing X11 socket file)
```

* Copy-paste/adapt the following `Makefile`:

```
mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST))) # Specify the current path
include ../Makefile.inc                                # Framework's make-rules

build: build_compose                                   # Use docker-compose for building image

# Default command once again:
CMD=hb_wrapper.sh launch.sh browser.sh -l file:///usr/local/src/mywebapp/test_heartbeatjs.html?HB_APP_ID=mywebapp&HB_URL=http://127.0.0.1:8888
#CMD=bash # Use this to go into your image and do something by hand

check: $(TS) ./docker-compose.yml    # make check expects a lock file (created by make build)
	xhost +                      # GUI apps require DISPLAY variable to be set and X11 to accept clients (easy way for now)
	$(COMPOSE) -p $(COMPOSE_PROJECT_NAME) run --rm -e DISPLAY ${APP} ${CMD} # Main run respects CMD variable, which may be set from outside
```

* Now the framework enables the following commands:
 * `make` build your image
 * `make check` run the default command (Kiosk opens file
`test_heartbeatjs.html?HB_APP_ID=mywebapp&HB_URL=http://127.0.0.1:8888`,
which is contained inside the image in `/usr/local/src/mywebapp/`)
 * `make check CMD=bash` run bash within your image
