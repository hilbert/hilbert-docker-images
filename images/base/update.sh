#! /bin/sh

# ubuntu/debian
DEBIAN_FRONTEND=noninteractive apt-get -y -q update -qqy --force-yes "$@"

