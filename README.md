# dockapp
Application with a dynamic choice of docker containers to run .

The goal was to share parts of images as much as possible while keeping the whole application as dynamic as possible. 

Most of our images are currently available as different tag in malex984/dockapp repository (https://registry.hub.docker.com/u/malex984/dockapp/).
Since some of them are quite big please do consider building them instead of pulling!
Run (and change) `setup.sh` in order to build docker images.

The dependencies between images are as follows: 
![Dependencies between docker images](deps.png)

The sequence of actions looks approximately as follows:
![Approximate Sequence Diagram](http://www.websequencediagrams.com/cgi-bin/cdraw?lz=dGl0bGUgRHluYW1pYyBEb2NrZXIgQXBwbGljYXRpb24KCnBhcnRpY2lwYW50IEhvc3QKbm90ZSBvdmVyAAoFOiAKSG9zdCBMaW51eCB3aXRoAD8HCmVuZCBub3RlCgoAHQUtPisAKgYuL3J1bm1lLnNoCgBQDiI6TWFpbiIAJgkACQc6IDptYWluL21haW4AMAVsb29wIHRoZSBtYWluIGdsdWUgAA4FcnVuIHVudGlsIFF1aXQASxFlbnUiCgoAXgcAWQZlbnUAWgVlbnUvbWVudS5zaAoAIwctLT4tAHgJY2hvc2VuIEFwcC9TZXJ2aWNlIG9yAGAGZGVzdHJveQBXCmFsdCBQdWxsL1J1biBkZWFtb24gOgAvBwCBYBAARgciAIEMCgAKCgCBbwhzdgCBEAYAJAgAghQFABsKZXhlYyAAVgllbHNlAHQKYW5kIEQAgRkHOkFwcEEAgmAQQXBwQQBwDQAMBQCCaQhydQCCawUAIAcAgwwFABkHAHAFAEwFABUIAIIiDGV4aXQgY29kZSAAghMLAGUGAIEbBgCDGQYAgwIILT4tAIRDBgAvCQCCSQwAhAwGZW5kCgplbmQKCgoKCgoK&s=modern-blue)

The shell script `runme.sh` is supposed to be the dockapp's entry pointr. 
It pulls the :main image and runs the glue (`main.sh`) inside it while passing it the whole control (!) over the host system. 

`:main/main.sh` is the main glue (the only piece which is supposed to be aware of docker) it expects `:menu/menu.sh` to exit with some return code, depending on which it takes some action or quits the infinite loop.

* `:base` serves as the common root for all my images. Thus it is the only image that needs to update & upgrade packages.
* `:dd` contains the docker cli and thus serves as a basis for `:main` which in turn pulls and launches further images.
* `:menu` image is a crude shell menu asking the user to choose an option and returns the choice via the retunr code (201, 202, 203 etc... ).
* `:appa` image run simple shell scripts saying AAA... or BBB... together with some host data.
* `:alsa` tests your audio HW using ALSA
* `:xeyes` is an image with some X11 client applications (e.g. `xeyes`).
* `:gui` contains further GUI applications based on GTK and QT. 
* `:q3` is a standalone (huge!) image with OpenArena (free version of Quake 3 Arena) which works but FPS was a bit low for me :( ALSA sound was good!
* `:skype` propriatory 32-bit application runs using apulse (emulation of pulseaudio via ALSA), it may also be able to capture video if you are lucky with your camera, its drivers and settings... It starts fine with working sound input/output but may refuse working after a while... :(
* `:iceweasel` Firefox but flash may fail. 
* `:play` contains several media players like `cmus`, `vlc`, `mplayer`, `xine`.

Some applications may need further deamons to run in background. Here is a list of server images:
* `:x11` is an Xorg deamon
* `:x11vb` X11 server image with VirtualBox Guest Additions installed.
* `:cups` is supposed to run CUPS server (:6631) - seems to start but has to be thoughly tested.

Further steps:
* *make sure it can use the currently running X11 of the host machine* (!)
* correct DISPLAY handling in `runme` and `main/*.sh` (NOTE: Dockfiles should NOT set any such variables!)
* make use of `Xephyr` / file descriptors
* test everything (printing via cups!?) 
* build 3rd party tools (currently insorporated via git submodules)
* switch to X11 menu by default
* make use of composite X11 & 3rd party tools for X11 menu



NOTE: under Mac OS X the user may need to use `xsocat.sh` from under an X11-Terminal (as it needs to know `$DISPLAY`). 
NOTE: i previously used `boot2docker` under Mac OS X, with X11 setup
following: `https://github.com/docker/docker/issues/8710` (make sure to
fix your firewall, and X11 settings), but after the recent changes it may be incompatible with boot2docker anymore... Sorry!

TODO: make a nice logo for the app (e.g. whales following each other while being driven by BASH :) )
