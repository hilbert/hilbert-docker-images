NOTE: this is currently just a demo.

It currently:
 * overtakes a specified input device (USB HID Keyboard) like _AT Translated Set 2 keyboard_ (my laptop keyboard), 
 * grabs it exclusively 
and runs action.sh on each ENTER'ed string as a main loop.
 
In turn `action.sh`:
 * displays a message and 
 * takes a screenshot with scrot.

Just pass the device name or ID (displayed by xinput) as a single string argument to `qrhandler.sh`
