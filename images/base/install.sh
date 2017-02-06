#! /bin/sh

# ubuntu/debian
DEBIAN_FRONTEND=noninteractive apt-get -y -q install -fy --no-install-recommends "$@"
