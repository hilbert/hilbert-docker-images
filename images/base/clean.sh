#! /bin/sh

# ubuntu/debian
DEBIAN_FRONTEND=noninteractive apt-get -y -q clean "$@" && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

