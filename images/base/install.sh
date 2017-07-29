#! /bin/sh

# ubuntu/debian
DEBIAN_FRONTEND=noninteractive apt-get -y install -fy --no-install-recommends "$@"
