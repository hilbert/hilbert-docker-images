#!/bin/bash

SELFDIR=`dirname "$0"`
SELFDIR=`cd "$SELFDIR" && pwd`

cd $SELFDIR

python main.py
