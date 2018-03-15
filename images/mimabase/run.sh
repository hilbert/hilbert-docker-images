#!/bin/bash

#### http://electron.atom.io/docs/v0.33.0/tutorial/debugging-main-process/

SELFDIR=`dirname "$0"`
SELFDIR=`cd "$SELFDIR" && pwd`

D="$SELFDIR/node_modules/.bin/electron"

if [ ! -x "${D}" ]; then
  D=""
fi

ELECTRON="${ELECTRON:-$D}"
ARGS="$@"

## ???
if [[ ! -v 'LANGUAGE' ]]; then
  [[ -r "$HOME/.show_close_button" ]] && source "$HOME/.show_close_button"
fi
	
# -v 'LANGUAGE' && ??
if [[ -v 'LANG' ]]; then
  export LANGUAGE="${LANG}"
fi
  
  
# cd "$SELFDIR"

if [[ -n "${ELECTRON}" && -r "${SELFDIR}/main.js" && -r "${SELFDIR}/package.json" ]]; then
  echo "Running: '${ELECTRON} ${SELFDIR} $ARGS'"
  exec "${ELECTRON}" "${SELFDIR}" $ARGS
fi

if [[ -x "/opt/kiosk-browser/kiosk-browser" ]]; then
  echo "Note: falling back to '/opt/kiosk-browser/kiosk-browser'"
  exec "/opt/kiosk-browser/kiosk-browser" "--" $ARGS
fi

echo "Sorry: cannot detect electron binary on your system :("
exit 1

### http://blog.soulserv.net/building-a-package-featuring-electron-as-a-stand-alone-application/
