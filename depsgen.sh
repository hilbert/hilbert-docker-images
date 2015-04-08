#!/bin/bash

U=malex984
I=dockapp

## the following commands will generate the dependency tree for all our images  (deps.png)
(
 echo "digraph deps{ graph [label=\"an arrow means that its source is based on the arrow's target\", labelloc=b]; node [color=white]; rankdir = RL;";
 git grep -i 'FROM .*/.*' */Dockerfile | sed -e 's@/Dockerfile: *FROM *@ @ig' -e "s@$U/$I@@g" | awk '{ print "\":" $1 "\" -> \"" $2 "\" ;" }';
 echo "}"
) > deps.dot
dot -Tpng -o deps.png deps.dot && echo "See 'deps.png'" || echo "Sorry something went wrong :((("
