#!/bin/bash

ARGS="$@"


if [[ ! -v 'SHOW_CLOSE_BUTTON' ]]; then
  # read ~/.show_close_button as fallback
  [[ -r "$HOME/.show_close_button" ]] && source "$HOME/.show_close_button"
fi


if [[ "${SHOW_CLOSE_BUTTON}" = "1" ]]; then 

  BASE="/usr/local/bin/"

  [[ ! -x "${BASE}/qclosebutton" ]] && echo "WARNING: missing executable '${BASE}/qclosebutton'!"
  [[ ! -r "${BASE}/x_64x64.png" ]]  && echo "WARNING: missing readable   '${BASE}/x_64x64.png'!"

  exec "${BASE}/qclosebutton" "${BASE}/x_64x64.png" ${ARGS}
fi

# [[ "${SHOW_CLOSE_BUTTON}" = "0" ]] && 
exec ${ARGS}


