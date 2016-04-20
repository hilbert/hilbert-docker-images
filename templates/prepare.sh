#! /bin/sh

SELFDIR=`dirname "$0"`
SELFDIR=`cd "$SELFDIR" && pwd`

### set -e

if [ -z "$CFG_DIR" ]; then
    export CFG_DIR="$HOME/.config/dockapp"
fi

#### TODO: needs some safety check to avoid multiple runs...

## install Docker Volume 'local-persist' plugin following https://github.com/CWSpear/local-persist
##curl -fsSL https://raw.githubusercontent.com/CWSpear/local-persist/master/scripts/install.sh | sudo bash

cd $CFG_DIR

## cd ./tmp/
### TODO: add the plugin for global installation?
#curl -fsSL https://github.com/CWSpear/local-persist/releases/download/v1.1.0/local-persist-linux-amd64 > ./local-persist-linux-amd64
#chmod +x ./local-persist-linux-amd64
#sudo ./local-persist-linux-amd64 1>./local-persist-linux-amd64.log 2>&1 &

### add me to all the necessary groups etc ...
#if [ ! -L "$CFG_DIR/CFG" ]; then
#   ln -sf "$CFG_DIR" "$CFG_DIR/CFG"
#fi

#docker volume create -d local-persist -o mountpoint="$CFG_DIR/KV" --name=KV
#docker volume create -d local-persist -o mountpoint="$CFG_DIR/OMD" --name=OMD
#docker volume create -d local-persist -o mountpoint="$CFG_DIR/CFG" --name=CFG

cd -
