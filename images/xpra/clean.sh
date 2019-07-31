#! /bin/sh

# ubuntu/debian
DEBIAN_FRONTEND=noninteractive apt-get -y clean "$@" && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

