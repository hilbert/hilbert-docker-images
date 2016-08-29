# dockapp
Application with a dynamic choice of docker containers to run .

The goal is to make the whole application as dynamic as possible (and
share images as much as possible).

## Getting Started:

1. `setup.sh`: Pull or build necessary starting images.
    Most of our images are currently available via a different tag in malex984/dockapp repository 
    (https://registry.hub.docker.com/u/malex984/dockapp/).
    Since some of them are quite big please do consider building them instead of pulling!
    Run (and change) `setup.sh` in order to pull the base image and build starting images.
    *We assume the host linux to run docker service.*
2. We are experimenting with different customization approaches:
  * `:dummy` contains `customize.sh` which performs customization to the running :dummy container, 
    these customization changes can than be detected with `docker diff` and 
    archived together (e.g. `/tmp/OGL.tgz`) for later use by `:base/setup_ogl.sh`.
  * (*obsolete*) `:up/customize.sh`: Customize each libGL-needing image (e.g. `:x11` and `:test` by default for now):
    Running `:up/customize.sh` such a host will enable one to detect known hardware or kernel modules (e.g. VirtualBox Guest Additions or NVidia driver)
    in order to localize/customize some starting images  
    under corresponding tag name (e.g. `:test.nv.340.76` or `:x11.vb.4.3.26`),
    which than will be tagged with local names (e.g. `test:latest` or `x11:latest`). 
    *We assume host system to be fully pre-configured (and all necessary kernel modules installed and loaded).*
    Therefore we avoid installing/building kernel modules inside docker container (e.g. using `dkms`).
3. `runme.sh`: Launch this dockapp application.
    The shell script `runme.sh` is supposed to be the dockapp's entry point.
    Using host docker it runs `main` (or its alteration if available) image,
    which contains a glue-together script `main.sh` that 
    now overtakes the control (!) over the host system (docker service and `/dev`).    
    Note that `main.sh` (and its helpers, e.g. `run.sh` ad `sv.sh`) is the only piece which is supposed to be aware of docker!
    The glue gives proposes a choice menu (e.g. via `:menu/menu.sh`), which exits with some return code, 
    depending on which the glue script takes some action or quits the main infinite loop.
4. Choose `X11Server` if your host was not running X11 server in order to witch the host monitor into graphical mode.
    NOTE: please don't do that while using the host monitor in text mode since at the moment 
    `menu.sh` is only suitable for console/text mode (but we are working on a GUI alternative). Better to do that via SSH.
5. Now assuming a running X11 (on host or inside a docker container) one can choose any application to run (e.g. `Test`) or Quit.


## The sequence of actions 3..5 looks approximately as follows:

![Approximate Sequence Diagram](http://www.websequencediagrams.com/cgi-bin/cdraw?lz=dGl0bGUgRHluYW1pYyBEb2NrZXIgQXBwbGljYXRpb24KCnBhcnRpY2lwYW50IEhvc3QKbm90ZSBvdmVyAAoFOiAKSG9zdCBMaW51eCB3aXRoAD8HCmVuZCBub3RlCgoAHQUtPisAKgYuL3J1bm1lLnNoAE8OIjpNYWluIgAmCCoACQc6IHN0YXJ0IDptYWluCgoAHwctPisAFwltYWluAEkFbG9vcCB0aGUADQUgZ2x1ZSAADgVydW4gdW50aWwgUXVpdABlEWVudSIATgsqAAwHAG8KZW51CgAhBwByBgAZBm1lbnUuc2gAEgktPi0AMgl1c2VyJ3MgY2hvaWNlABcLAIFMCWNob3NlbiBBcHAvU2VydmljZSBvcgCBGgZkZXN0cm95AIERCmFsdCBQdWxsL1J1biBkZWFtb24gOgAvBwCCNBAARgciAIFDDQANCDogc3Yuc2ggADQIACUKAIJLBQAcCwCBDQYAgx8FZWxzZQB1CmFuZCBEAIEaBzpBcHBBAIM1EEFwcEEAcA4ADQU6IHJ1bi5zaCAALwUAIAcAg0EFABgHQXBwQQCCSAYAFQYAgkkFADQHZXhpdAAOCwCEEQlleGl0IGNvZGUgAIIqCwB7BgCBMQYAg2oGAIQsCACDGwYAMQoADgsAhUUGAEcJAIJ4DACFCgstPi0AhW0HZW5kCgplbmQK&s=modern-blue)

## Currently we provide the following base images:

* [![](https://badge.imagelayers.io/malex984/dockapp:base.svg)](https://imagelayers.io/?images=malex984/dockapp:base'Get your own badge on imagelayers.io')
`:base` serves as the common root for all our images. Thus it is the only image that will update & upgrade all the packages.
* [![](https://badge.imagelayers.io/malex984/dockapp:dd.svg)](https://imagelayers.io/?images=malex984/dockapp:dd'Get your own badge on imagelayers.io')
`:dd` contains the docker cli and thus serves as a basis for `:main` which in turn pulls and launches further images.
* [![](https://badge.imagelayers.io/malex984/dockapp:alsa.svg)](https://imagelayers.io/?images=malex984/dockapp:alsa'Get your own badge on imagelayers.io')
`:alsa` tests your audio HW using ALSA
* [![](https://badge.imagelayers.io/malex984/dockapp:xeyes.svg)](https://imagelayers.io/?images=malex984/dockapp:xeyes'Get your own badge on imagelayers.io')
`:xeyes` is an image with some X11 client applications (e.g. `xeyes`).
* [![](https://badge.imagelayers.io/malex984/dockapp:gui.svg)](https://imagelayers.io/?images=malex984/dockapp:gui'Get your own badge on imagelayers.io')
`:gui` contains further GUI applications based on GTK and QT. 
* [![](https://badge.imagelayers.io/malex984/dockapp:play.svg)](https://imagelayers.io/?images=malex984/dockapp:play'Get your own badge on imagelayers.io')
`:play` contains several media players like `cmus`, `vlc`, `mplayer`, `xine`.
* [![](https://badge.imagelayers.io/malex984/dockapp:test.svg)](https://imagelayers.io/?images=malex984/dockapp:test'Get your own badge on imagelayers.io')
`:test` for testing HW & GPU and applications that need it
* [![](https://badge.imagelayers.io/malex984/dockapp:webbase.svg)](https://imagelayers.io/?images=malex984/dockapp:webbase'Get your own badge on imagelayers.io')
`:webbase` serves as the common base for all web-browser-related images (hopefully with dbus and multi-touch support).
* [![](https://badge.imagelayers.io/malex984/dockapp:demo.svg)](https://imagelayers.io/?images=malex984/dockapp:demo'Get your own badge on imagelayers.io')
`:demo` provides a choice menu and with luncher of GUI-exhibits
* [![](https://badge.imagelayers.io/malex984/dockapp:kivy.svg)](https://imagelayers.io/?images=malex984/dockapp:kivy'Get your own badge on imagelayers.io')
`:kivy` serves as the common base for all kivy-related images. 

### Services (applications-specific images):

Some applications may need further deamons to run in background. Here is a list of server images:

* [![](https://badge.imagelayers.io/malex984/dockapp:appchoo.svg)](https://imagelayers.io/?images=malex984/dockapp:appchoo'Get your own badge on imagelayers.io')
`:appchoo` image is a crude shell menu asking the user to choose an option and returns the choice via the return code (201, 202, 203 etc... ).
Depending on `MENU_TRY` it can be either GUI or TEXT style.
* [![](https://badge.imagelayers.io/malex984/dockapp:appa.svg)](https://imagelayers.io/?images=malex984/dockapp:appa'Get your own badge on imagelayers.io')
`:appa` image run simple shell scripts saying AAA... or BBB... together with some host data.
* [![](https://badge.imagelayers.io/malex984/dockapp:q3.svg)](https://imagelayers.io/?images=malex984/dockapp:q3'Get your own badge on imagelayers.io')
`:q3` is a standalone (huge!) image with OpenArena (free version of Quake 3 Arena) which works but FPS was a bit low for me :( ALSA sound was good!
* [![](https://badge.imagelayers.io/malex984/dockapp:skype.svg)](https://imagelayers.io/?images=malex984/dockapp:skype'Get your own badge on imagelayers.io')
`:skype` propriatory 32-bit application runs using apulse (emulation of pulseaudio via ALSA), it may also be able to capture video if you are lucky with your camera, its drivers and settings... It starts fine with working sound input/output but may refuse working after a while... :(
* [![](https://badge.imagelayers.io/malex984/dockapp:kiosk.svg)](https://imagelayers.io/?images=malex984/dockapp:kiosk'Get your own badge on imagelayers.io')
`:kiosk` Kiosk-mode web-wrowser using Electron (based on Chromium)
* [![](https://badge.imagelayers.io/malex984/dockapp:iceweasel.svg)](https://imagelayers.io/?images=malex984/dockapp:iceweasel'Get your own badge on imagelayers.io')
`:iceweasel` Firefox & Iceweasel
* [![](https://badge.imagelayers.io/malex984/dockapp:chrome.svg)](https://imagelayers.io/?images=malex984/dockapp:chrome'Get your own badge on imagelayers.io')
`:chrome` Google Chrome & Chromium & Opera
* [![](https://badge.imagelayers.io/malex984/dockapp:nodejs.svg)](https://imagelayers.io/?images=malex984/dockapp:nodejs'Get your own badge on imagelayers.io')
`:nodejs` Pure `Node JS 4`
* [![](https://badge.imagelayers.io/malex984/dockapp:x11.svg)](https://imagelayers.io/?images=malex984/dockapp:x11'Get your own badge on imagelayers.io')
`:x11` is a basis for Xorg/Xephyr service
* [![](https://badge.imagelayers.io/malex984/dockapp:dummy.svg)](https://imagelayers.io/?images=malex984/dockapp:dummy'Get your own badge on imagelayers.io')
`:dummy` is used for running X11 and HW customization for GPU (OpenGL-library)
* [![](https://badge.imagelayers.io/malex984/dockapp:cups.svg)](https://imagelayers.io/?images=malex984/dockapp:cups'Get your own badge on imagelayers.io')
`:cups` is supposed to run CUPS server (:6631) - seems to start but has to be thoughly tested.
* [![](https://badge.imagelayers.io/malex984/dockapp:x11vnc.svg)](https://imagelayers.io/?images=malex984/dockapp:x11vnc'Get your own badge on imagelayers.io')
`:x11vnc` is an `x11vnc` service
* [![](https://badge.imagelayers.io/malex984/dockapp:x11comp.svg)](https://imagelayers.io/?images=malex984/dockapp:x11comp'Get your own badge on imagelayers.io')
`:x11comp` is a service with composing window manager (xcompmgr or compton)
* [![](https://badge.imagelayers.io/malex984/dockapp:ptmx.svg)](https://imagelayers.io/?images=malex984/dockapp:ptmx'Get your own badge on imagelayers.io')
`:ptmx` is a service to try to workarouind the docker problem of permissions to /dev/pts/ptmx
* [![](https://badge.imagelayers.io/malex984/dockapp:omd.svg)](https://imagelayers.io/?images=malex984/dockapp:omd'Get your own badge on imagelayers.io')
`:omd` containes pre-cofigured OMD service instance (**NOTE:** under development).
* [![](https://badge.imagelayers.io/malex984/dockapp:omd_agent.svg)](https://imagelayers.io/?images=malex984/dockapp:omd_agent'Get your own badge on imagelayers.io')
`:omd_agent` containes pre-cofigured OMD/Check_MK Agent (with our addition: `check_dockapp.sh`) and HeartBeat server instance, see [Current Specs](https://gist.github.com/malex984/dbec16e9c7d88f295071) (**NOTE:** under development)
* [![](https://badge.imagelayers.io/malex984/dockapp:qrhandler.svg)](https://imagelayers.io/?images=malex984/dockapp:qrhandler'Get your own badge on imagelayers.io')
`:qrhandler` is a service to exclusively handle QR Reader and take some action upon each new scanned code (show message & takes screenshot)


## The dependencies between images are as follows: 
![Dependencies between docker images](deps.png)

## TODO List:

### DONE:

* `runme.sh` can use the currently running X11 of the host machine.
* `runme.sh` and `main/*.sh` correctly handle DISPLAY comming from host or from x11/xephyr container
* user can start `xephyr` in order to run our apps in a windowed mode
* 3rd party tools are currently insorporated into `:test`

### Further steps:

* switch to GUI menu (appchoo) in case of available X11
* make use of composite X11 manager (e.g. compton) and qclosebutton
* test printing via cups!
* test under Mac OS X whether the user still can use `xsocat.sh` e.g. in case of  `boot2docker`
  (e.g. following: (https://github.com/docker/docker/issues/8710), and
  makeing sure to fix your firewall, and X11 settings to accept incoming connections)
* make a nice logo for the app (e.g. whales following each other while being driven by BASH :) )



## Problems:

### X11 would not create a new terminal with the following error message:

```
xterm: Error 32, errno 2: No such file or directory
Reason: get_pty: not enough ptys
```

It seems that somebody clears permissions on `/dev/pts/ptmx` in the
course of the docker mounting `/dev` or using it by containers... 

Since this problem happens rarely it may be related to unexpected "docker rm -vf" for a running container with allocated pty.
Also the following may be related: 
* https://github.com/docker/docker/issues/4605
* https://github.com/docker/docker/pull/4656

Quick Fix is `sudo chmod a+rw /dev/pts/ptmx`

NOTE: what about `/dev/ptmx`?


### "operation not supported" error when trying to RUN something during docker image building

According to http://stackoverflow.com/a/29546560 : if your machine had
a kernel update but you didn't restart yet then docker freaks out like
that.


## Docker shortcuts:
### Cleanup dangling images
```
docker rmi $(docker images -f "dangling=true" -q)
```

### Cleanup dockapp-related images:
```
docker images | grep malex984/dockapp | awk ' { print $1 ":" $2 } ' | xargs docker rmi -f 
docker rmi -f x11 test dummy
```

### Cleanup all containers:
```
docker ps -aq | xargs docker rm -fv
```

# Dockerization within this framework (cheatsheet?)

1. Each image must reside in an individual sub-folder. Create one named after your image (lowercase, only [a-z0-9] characters should be
used).
2. Copy some simple existing `Dockerfile` (e.g. from `/chrome/`) and change it according to your needs (see below).
3. Same with `Makefile` and `docker-compose.yml`

Now some one can use the framework helpers (`make` should be installed on your host):
* `make pull` will try to pull the desired base image
* `make` will try to (re-)build your image (currently no build arguments are supported)
* `make check` try to run the default command withing your image

## Descrption of the building process for your image is in `Dockerfile`.

For example see `chrome/Dockerfile`.

0. Specify your contact email via `MAINTAINER`

1. Choose a proper base image among already existing (see above) - `FROM`

NOTE: currently we base our images on top of `phusion/baseimage:0.9.18` 
which is based on `ubuntu:14.04` and contains a usefull launcher
wrapper (`myinit`).

2. Install additional SW packages (e.g. see `chrome/Dockerfile`) - `RUN`

NOTE: one may also need to add keys and packages repositories .

NOTE: it may be necessary to update repository caches before
installing some packages.  Also do not forget to clean-up afterwards.

NOTE: The best way to install something is `RUN update.sh && install.sh YOUR_PACKAGE && clean.sh`

3. Add necessary local resources and online resources into your image - `ADD` or `COPY`


NOTE: use `ADD URL_TO_FILE FILE_NAME_IN_IMAGE` to add something from
network in build-time. 

NOTE: use `COPY local_file1 local_file2 ... PATH_IN_IMAGE/` to copy
local files (located alongside with your `Dockerfile`) into the image
(with owner: `root` and the same file permissions).

4. Run any initial configuration (post installation) actions - `RUN`

NOTE: only previouslly installed/added (into the image) executables
can be run.

### Building notes:
* one can have build arguments but we do not use them.
* one can set environment variables within `Dockerfile` and later
override them in run-time.
* exposing network ports may be done either statically inside
`Dockerfile` or dynammically in run-time. 
* Same goes to specification of default command / entry-point script/application and labels.


## Run Your Image (run-time): `Makefile` and `docker-compose.yml`

What can be specified in run-time:

* docker image
* entry-point wrapper and command
* environment variables to be passed to executed command
* exposed (and redirected) ports
* mounted devices
* mounted volumes (local and docker's logical)
* restart policy (e.g. see https://blog.codeship.com/ensuring-containers-are-always-running-with-dockers-restart-policy/)
* labels attached to running container
* working directory
* mode of execution: `privileged` or not
* stdin attachment and tty allocation

See for example `mng/docker-compose.yml` or `mng/Makefile`
