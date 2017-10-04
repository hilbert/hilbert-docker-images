#!/bin/bash
#
# Install kivy into virtual environments
# Volker Gaibler, 2017
#
# module combinations
# https://kivy.org/docs/installation/installation-linux.html#ubuntu-11-10-or-newer#common-dependencies
# [note: numpy is not a dependency, only added because install may be slow]
#
# use them as always, e.g. for the python2 version of kivy 1.9.1 call
# . /opt/kivy/venv/py2-1.9.1


# setup virtual environments under this directory: can be activated at user's convenience
prefix=/opt/kivy/venv

setup_venv () {
    (
    # versions as parameters:
    local v=$1  # python
    local k=$2  # kivy
    local c=$3  # cython
    local n=$4  # numpy

    local dir="$prefix/py$v-$k"
    echo "##################### Setting up new virtual environment: #####################"
    echo "  dir=$dir"
    echo "  kivy=$k"
    echo "  cython=$c"
    echo "  numpy=$n"

    virtualenv -p /usr/bin/python$v $dir
    source $dir/bin/activate
    pip$v install Cython==$c
    pip$v install kivy==$k
    pip$v install numpy==$n
    deactivate
    )
}


mkdir -p $prefix

# python/pip versions
for v in 2 3 ; do

    # tested version combinations:
    #          python  kivy    cython  numpy
    setup_venv $v      1.8.0   0.20.2  1.13.3
    setup_venv $v      1.9.1   0.23    1.13.3
    setup_venv $v      1.10.0  0.25.2  1.13.3

done
