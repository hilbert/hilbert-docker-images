#!/bin/bash

#export LIBGL_ALWAYS_INDIRECT=1

ARG=" "

# TODO: Check global LANGUAGE setting?!
ARG+=" ui.languages:en:de:fr:kor "
ARG+=" ui.screen.mode:fullscreen "

if [[ ! -v 'SHOW_CLOSE_BUTTON' ]]; then
  # read ~/.show_close_button as fallback
  [[ -r "$HOME/.show_close_button" ]] && source "$HOME/.show_close_button"
fi


if [[ "${SHOW_CLOSE_BUTTON}" = "1" ]]; then 
  ARG+=" ui.allowquit:true "
else
   ARG+=" ui.allowquit:false "
fi

### sudo -n -u kiosk -g kiosk 
exec dune-ash-ui $ARG "$@"
#/opt/launch.sh 

exit $?

# [[ "${SHOW_CLOSE_BUTTON}" = "0" ]] && 
#exec "$@"



## /opt/launch.sh 



# ui.allowquit:"false" \
# "ui.screen.mode:window" \

# exec bash -c "LIBGL_ALWAYS_INDIRECT=1 dune-ash"



exit 0
quit

There are two options for this tasks.

1) change /usr/bin/dune-ash line 2 into

/usr/bin/dune-ash-ui "ui.languages:de" "ui.screen.mode:window"  "ui.allowquit:false" "$@"

2) change the above parameters in file /etc/dune-ash/ui.param

At the moment only english german and korean are supported. 
In Window mode you can choose the resolution by specifying the parameters "ui.screen.width" and "ui.screen.hight" see also /etc/dune-ash/ui.param lines 74 and 75.

In case you run dune-ash in a virtual machine you might reduce "ui.screen.framespersecond" a bit.
In VMs usually software rendering is used. 

You can deactivate the mouse cursor by setting:
"ui.screen.cursor: empty.cur"

????????????????????????????????
1. specify the default language 
2. toggle close button
3. toggle fullscreen mode
