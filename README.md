# dockapp
Application with a dynamic choice of docker containers to run 

Run `setup.sh` in order to build all needed docker images.

`main.sh` is the main glue (the only piece which is supposed to be aware of docker) it expects `menu` to exit with some code, 
depending on which it either runs appa or appb, or quits the infinite loop.

`appa`, `appb` images run simple shell scripts saying AAA... or BBB... together with some host data.

`menu` image is a crude shell menu asking the user to choose from AAA, BBB, and QUIT and returns the choice via STDOUT and exit code (201, 202, 203 resp.).

`xeyes` is an image with GUI (X11 client) application (`xeyes`).

NOTE: since i use `boot2docker` under Mac OS X the current X11 setup
follows: `https://github.com/docker/docker/issues/8710` (make sure to
fix your firewall).

Other possibilities include `ssh -X`, `vnc` and sharing X11-sockets
between Linux host (running X11 server) and docker container (see
`http://stackoverflow.com/a/25280523` and
`http://stackoverflow.com/questions/24095968/docker-for-gui-based-environments`).

