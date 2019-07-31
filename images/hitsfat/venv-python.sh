#!/bin/sh
#
# Start a python script:
# - use python virtual environment and python version as specified by PYTHON_VENV environment variable
# - working directory is the script directory
# - exec so that it receives unix signals

echo "[+] venv-python.sh:"
echo "[+] cwd = $( pwd )"

# python file to start
script=$( readlink -e "$1" )

if [ ! -r "$script" ] ; then
    echo "[+] Error: could not read script '$script'."
    exit 1
fi

# python virtual environment
PYTHON_VENV=${PYTHON_VENV:-/opt/venv2}
activate="$PYTHON_VENV/bin/activate"
if [ ! -r "$activate" ] ; then
    echo "[+] Error: virtual environment '$PYTHON_VENV' not found."
    exit 1
fi
echo "[+] activating virtual environment '$PYTHON_VENV'"
. "$activate"

echo "[+] exec python $@"
echo
exec python $@
