#!/bin/bash
cd $(dirname $(readlink -f $0))/frozenlight
exec launch.sh java -jar "$PWD/frozenlight-1.2.2.jar" -mu -f
