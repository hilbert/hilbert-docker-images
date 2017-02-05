#! /bin/bash

ARGS=$@
[ -z "${ARGS}" ] && ARGS=--private-window http://localhost:8080/

#usr=`whoami`
#user=`echo $usr`

F=${FIREFOX:-firefox}
#firefox-trunk?
#iceweasel?

## Firefox Settings
# start and kill in order to create .mozilla folder:

if [ ! -f $HOME/.mozilla/$F/*.default/prefs.js ]; then 

  $F & 
  PID=$!

  while : ; do
    sleep 0.5
    [ -f $HOME/.mozilla/$F/*.default/prefs.js ] && break
    # [[ ps -o pid | grep -q "^[[:space:]]*"$PID"[[:space:]]*$" ]] && break
  done

  sleep 0.5
  kill "$PID" 
  
fi

#ps -fu $user | grep -E "/firefox/$F$" | grep -v -E "(bash|grep)"
#ps -fu $user | grep -E "/firefox/$F$" | grep -v -E "(bash|grep)" | cut -d":" -f1 | sed "s/$user *//g" | cut -d" " -f1 | sed ':a;N;$!ba;s/\n/ /g'
#kill `ps -fu $user | grep -E "/firefox/$F$" | grep -v -E "(bash|grep)" | cut -d":" -f1 | sed "s/$user *//g" | cut -d" " -f1 | sed ':a;N;$!ba;s/\n/ /g'`

ls -la $HOME/.mozilla/$F/*.default/prefs.js

cat <<EOF | tee -a $HOME/.mozilla/$F/*.default/prefs.js

user_pref("browser.cache.disk.parent_directory", "/tmp");
user_pref("browser.tabs.autoHide", false);
user_pref("browser.download.manager.closeWhenDone", true);
user_pref("browser.download.useDownloadDir", false);

user_pref("browser.snapshots.limit", 5);
user_pref("browser.gesture.pinch.threshold", 100);
user_pref("browser.gesture.twist.threshold", 13);

user_pref("gestures.enable_single_finger_input", true);
user_pref("browser.gesture.pinch.latched", false);
user_pref("browser.gesture.twist.latched", false);

user_pref("browser.gesture.pinch.in", "cmd_fullZoomReduce");
user_pref("browser.gesture.pinch.out", "cmd_fullZoomEnlarge");

user_pref("browser.gesture.tap", "cmd_fullZoomReset");

user_pref("toolkit.telemetry.unified", false); 
user_pref("datareporting.healthreport.service.enabled", false);
user_pref("datareporting.healthreport.uploadEnabled", false); 
user_pref("datareporting.policy.dataSubmissionEnabled", false); 
user_pref("datareporting.policy.dataSubmissionPolicyResponseType", "accepted-info-bar-dismissed");

EOF

# user_pref("browser.gesture.pinch.in", "cmd_fullZoomReduce");
# user_pref("browser.gesture.pinch.out", "cmd_fullZoomEnlarge");
# user_pref("browser.gesture.pinch.threshold", 20);
# user_pref("browser.gesture.twist.latched", true);
# user_pref("browser.gesture.twist.threshold", 25);
# user_pref("gestures.enable_single_finger_input", false);


export MOZ_USE_XINPUT2=1 
exec $F ${ARGS} 2>&1 
exit $?
# &

PID=$!
sleep 1 # hehehe
xdotool key F11 # hit full screen

# fg # "$PID"

  while : ; do
    sleep 2
    P=`ps -o pid | grep -q "^ *$PID *$"`
    [ -z "$P" ] && break
  done

exit $?


browser.gesture.twist.left        cmd_gestureRotateLeft
browser.gesture.twist.right       cmd_gestureRotateRight

browser.gesture.swipe.left  Browser:PrevTab
browser.gesture.swipe.right Browser:NextTab
browser.gesture.swipe.up    cmd_newNavigatorTab

# browser.gesture.pinch.in.shift    
# browser.gesture.pinch.out.shift   
# browser.gesture.swipe.down 


