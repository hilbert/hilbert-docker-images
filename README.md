# dockapp
Application with a dynamic choice of docker containers to run 

Run `setup.sh` in order to build all needed docker images.

`main.sh` is the main glue (the only piece which is supposed to be aware of docker) it expects `menu` to exit with some code, 
depending on which it either runs appa or appb, or quits the infinite loop.

`appa`, `appb` images run simple shell scripts saying AAA... or BBB... together with some host data.

`menu` image is a crude shell menu asking the user to choose from AAA, BBB, and QUIT and returns the choice via STDOUT and exit code (201, 202, 203 resp.).


