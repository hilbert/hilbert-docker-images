#! /usr/bin/env bash
# for emacs: -*-sh-*-

# current local timestamp
TIME=`date +"%s_%N"`

#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

## Get current Application ID:

# Please see the header of get_top.sh for more details on its usage
# See http://stackoverflow.com/a/26827443 for the following construction:
. <({ berr=$({ bout=$(get_top.sh); ret=$?; } 2>&1; declare -p ret >&2; declare -p bout >&2); declare -p berr; } 2>&1)

#echo "return code: [${ret}], error message: [${berr}], output: [${bout}]"

if [[ ${ret} -ne 0 || -n "${berr}" ]]; then
  echo "There was an error: '$berr' (ret.code: $ret) during TOP application detection"
fi

APP="${bout:-UNKNOWN_OR_NO_APPLICATION}"

#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

# QR code is passed as an argument to this scripts:
QR="$@"

# compute md5 hash of QR code:
MD5=`echo -E "$QR" | md5sum -t - | sed 's@ .*$@@g'`

# Output screenshot 
S="${qr_uploadlocs}/SCROT.${APP}.${TIME}.${MD5}.png"

# Logging for debug: 
echo -E "'${QR}' => '${S}'" 1>&2

#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

# Display a message about screenshot
xmessage -buttons "OK:0" -center -timeout 4 "Taking Screenshot in 5 sec..." > /dev/null 2>&1 &

# Schedule screenshot in 5 sec.
scrot -u -m -cd 5 "${S}" 

# Display final message for 1 sec:
qrs_screenshot_message="${qrs_screenshot_message:-IMAGE: $S}"
xmessage -buttons "OK:0" -center -timeout 1 "${qrs_screenshot_message}" > /dev/null 2>&1 &

exit 0

# https://wiki.archlinux.org/index.php/taking_a_screenshot 

# http://askubuntu.com/questions/226829/how-to-take-screenshot-of-an-x11-based-gui-from-a-text-terminal-such-as-tty1

#!? xwd -root -out screenshot.xwd, xwd -root -display :0 | convert - jpg:- | jp2a - --colors
# reuires x11-apps for xwd, imagemagick for convert and jp2a.)

# with imagemagick:
# shutter -f -e -n -o "$HOME/Pictures/screenshot.png" # screenshot
# import -window root ~/Pictures/$(date '+%Y%m%d-%H%M%S').png
