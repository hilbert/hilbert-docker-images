cups-in-docker (with changes by malex984)
==============

cups 1.7.1 & cups-bsd inside Ubuntu 14.04

```bash
make check CMD=bash
```
* No need to start cups deamon on host just for forwaring everything to remote printer: 
just set CUPS_SERVER to the CUPS server ip/name 
(or add `ServerName ...` to `/etc/cups/client.conf`)

* One can check the connection with server via `telnet $CUPS_SERVER 631`

* One can run `sudo ./config_cups.sh "server ip/name"` in order fix `/etc/cups/client.conf` and test printer status


* check printer data with `lpstat -l -t -v -s -p`
* check pdf printing e.g. with `wget http://www.opensource.apple.com/source/cups/cups-136.9/cups/test/testfile.pdf && lpr testfile.pdf`

* `Error - add '/version=1.1' to server name` means that server does not bind to the ip or hostname that you are using

* See CUPS error log: `http://$CUPS_SERVER:631/admin/log/error_log?`


* Local CUPS server should be network-shared (otherwise visible but not usable)
* it may help to add the following to `/etc/cups/cupsd.conf`:
```
Listen *:613
ServerAlias *
```
* or maybe use `config.vm.network "forwarded_port", guest: 631, host: 631` in order to allow access to local CUPS deamon
* From inside a Vagrant/Virtualbox VM one may want to get the gateway ip: `netstat -rn | grep "^0.0.0.0 " | cut -d " " -f10`
* By default `config_cups.sh` will try to use `dockerhost` and $HIP 
* May be helpfull: http://www.tldp.org/HOWTO/Printing-HOWTO/setup.html
