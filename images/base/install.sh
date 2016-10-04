#! /bin/bash

# ubuntu/debian
DEBIAN_FRONTEND=noninteractive apt-get -y -q install "$@"
# --no-install-recommends
# -fy # fix
