#!/bin/bash

U=malex984
I=dockapp

## the following commands will generate the dependency tree for all our images  (deps.png)
(
 echo "digraph deps{ graph [label=\"an arrow means that its source is based on the arrow's target\", labelloc=b]; node [color=white]; rankdir = RL;";
 git grep -i '^ *FROM .*' */Dockerfile | sed -e 's@/Dockerfile: *FROM *@ @g' -e "s@$U/$I@@g" | awk '{ print "\":" $1 "\" -> \"" $2 "\" ;" }';
# echo '":x11.nv.V.E.R" -> ":x11" ;'
# echo '":x11.vb.V.E.R" -> ":x11" ;'
# echo '":test.nv.V.E.R" -> ":test" ;'
# echo '":test.vb.V.E.R" -> ":test" ;'
# echo '"x11:latest" -> ":x11.nv.V.E.R" [dir=none color="blue" ] ;'
# echo '"test:latest" -> ":test.nv.V.E.R" [dir=none color="blue" ] ;'
# echo '"x11:latest" [color="blue" style="dashed"]; '
# echo '"test:latest" [color="blue" style="dashed"]; '
 echo "}"
) > deps.dot
dot -Tpng -o deps.png deps.dot && echo "See 'deps.png'" || echo "Sorry something went wrong :((("


