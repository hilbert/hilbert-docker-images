# Management scripts:

![Management structure](mng.png)

## General notes:

* Exit codes may be as follows (see `status.sh`, others will be updated):
  * 0: success
  * 1: detected error which is not our fault (e.g. network / HW etc): user can try again
  * 2: error due to wrong usage of scripts / in config files or some assumption was violated. 
  * other positive values: something unexpected has happened.

* One may need to capture both `STDOUT` and `STDERR`. Error messages (in `STDERR`) that are meant to be presented to users (admins) must be as informative as possible.

## Server-side scripts:

* ALL server-side management scripts (save for `forall.sh` helper) take non-empty `STATION_ID` handle as the 1st argument and require proper station configurations folder `./STATIONS/STATION_ID/`

NOTE: All valid and active station handles are in `./STATIONS/list` (NOTE: leading `#` means a comment)

* Arguments coming AFTER the leading `STATION_ID` argument to server-side management scripts will be forwarded AS IS to the corresponding command run on the station.

* `start.sh STATION_ID [WAKE_UP_ARGS]`: tries to wake-up the station specified by `STATION_ID`
* `deploy.sh STATION_ID`: deploys the content of "./STATIONS/STATION_ID/" to the specified station via `scp` (NOTE: deployment method may change in the future)
* `prepare.sh STATION_ID`: prepare the system for the framework execution. To be run once after system boot-up (or in case of any changes to station configs or management scripts)
* `default.sh STATION_ID`: lunch all BG and FG apps on the specified station
* `topswitch.sh STATION_ID APP2`: stop/kill the current FG app and start to APP2 + update remote lastapp.cfg
* `finishall.sh STATION_ID`: stop/kill all BG and FG apps on the specified station
* `docker.sh STATION_ID ARGS`: run "docker ARGS"  on the specified station via `./remote.sh STATION_ID docker ARGS`
* `luncher.sh STATION_ID COMPOSE_CMD_WITH_ARGS`: run `docker-compose COMPOSE_CMD_WITH_ARGS` on the remote station within corresponding configuration directory (e.g. `~/.config/dockapp/`) with all the deployed configuration files after reading all deployed configs. 

### Helpers: 
* `remote.sh STATION_ID CMD ARGS` (runs the command specified by `CMD ARGS` on the specified remote station via ssh. This is the main working-horse for the rest of management scripts.

NOTE: uses `SSH_OPTS` from Station configuration folder (see `station.cfg` and `access.cfg`) to do password-less command execution via `ssh`. 

NOTE: it is assumed that the station's user has (sudo password-less) permissions to run the commands.

* `remote_cmd.sh` - helper for the following scripts that will remotely run the deployed (with the same name) script (see `./template/*.sh`). Runs `./remote.sh ...`
* `remote_sbin.sh` - helper for the following scripts that will remotely run corresponding system command (based on `remote.sh`):
  * `reboot.sh STATION_ID [ARGS]` (run `sudo -n -P /usr/sbin/reboot ARGS` on the specified station)
  * `poweroff.sh STATION_ID [ARGS]` (run `sudo -n -P /usr/sbin/poweroff ARGS` on the specified station)
  * `shutdown.sh STATION_ID [ARGS]` (run `sudo -n -P /usr/sbin/shutdown ARGS` on the specified station)
  NOTE that these system commands require password-less permissions on the target system.
* `./forall.sh SERVER_SIDE_SCRIPT_BASENAME ADDITIONAL_ARGUMENTS_FOR_SCRIPT`: for all valid STATION_ID in ./STATIONS/list runs: `./SERVER_SIDE_SCRIPT_BASENAME.sh $STATION_ID ADDITIONAL_ARGUMENTS_FOR_SCRIPT`

NOTE: `forall.sh` may be replaced with argument to server-side scripts instead of leading station-id argument.

# Adding new station / Initial generation:

## Details on station configuration file `STATIONS/` StationID `/station.cfg` (under development)

see the current template in `dockapp/mng/templates/station.cfg`

* Generate initial configuration folder: `init.sh station [STATION_TYPE]`
  1. e.g. `init.sh new-station-id simple` (station type/profile: `simple`)
  1. `init.sh new-station-id simple docker-machine` (same but for accessing it via `docker-machine`)
  * Refresh station configuration in case of template/station-side-scripts changes: `refresh.sh StationID`?

* transfer all the configs to corresponding station: `deploy.sh StationID` + 
port-deployment action: `prepare.sh StationID`

* start with default services and TOP GUI app.: `default.sh StationID`

* One can now add 'StationID' (by its fixed host-name or IP if static) to OMD (**local** URL: supernova.mfo.de/default) according to http://blog.unicsolution.com/2014/02/how-to-setup-omd-in-1-hour.html (section: Start Monitoring Target Hosts)


# Server side scripts:


## Front-end :

* To be done once before front-end starts & upon request from CMS (external trigger!):
  1. `sync.sh` (to synchronize local cache `STATIONS/` with station configs & scripts from CMS) 

* Starting STATION means (in worst case):
  1. start.sh STATION   (wake-up or start the station)
  2. deploy.sh STATION (transfer configs and scripts to the station if update is necessary)
  3. prepare.sh STATION  (do port-deployment action on the station)
  4. default_update.sh STATION (start all our services and GUI application + get lastapp.cfg)

* Switch GUI on STATION:
  1. topswitch_update.sh STATION app (switch  GUI app + get lastapp.cfg)

* Stopping STATION means: 
  1. `finishall.sh STATION` (stop / remove running docker containers)
  2. shutting the station down (with power-off) can be done with:
    * `shutdown.sh STATION -h now` (to power-off it) or
    * `poweroff.sh STATION`
  3. rebooting the station can be done with: 
    * `shutdown.sh STATION -r now` (to reboot it)
    * `reboot.sh STATION`


# short general OVERVIEW of the current back-end management scripts and involved configuration files.

## Initialization (will create/refresh ./STATIONS/STATION_ID/* out of
./templates/*):

* `./init.sh STATION_ID [STATION_TYPE]` (create initial configs with defaults from templates)
* `./refresh.sh STATION_ID` (refresh existing configs due to changes in templates)

## Current configuration files and scripts (originally in ./templates/
and after transformation in each subfolder of ./STATIONS/, to be
deployed into '~/.config/dockapp/' on each station):

* station.cfg  # Main variables about the station. Should be set and
fixed forever.

NOTE: the rest of configs and scripts should be removed from here once
the development is finished.

* `startup.cfg` # determine BG & default FG out of station_type  (from
station.cfg)
* `access.cfg` # determine system access parameters for the station
* `compose.cfg`, `docker.cfg`, `docker-compose.yml` # determine station local SW configuration (docker, X11, pulseaudio etc) for proper docker-compose functioning.
* `luncher.sh`, `finishall.sh`, `default.sh`, `prepare.sh`, `topswitch.sh` # actual action scripts to be deployed to the station. 
* `ptmx.sh` # workaround for docker glitch. To be run by prepare.sh



# Dia. sources

## Logical actions (dockapp_dashboard/server/scripts/)

* list_stations.sh -> STATIONS

* start_station.sh
  1. start.sh $station_id
  2. deploy.sh $station_id
  3. prepare.sh $station_id
  4. default_update.sh $station_id

* appchange_station.sh
  1. topswitch_update.sh $station_id $app_id

* stop_station.sh
  1. finishall.sh $station_id
  2. shutdown.sh $station_id -h now


## Server-side back-end (generic interface):

NOTE: all these are directly accessible for logical action scripts only
NOTE: they all require Server's local config cache: STATIONS

### Virtual Methods

default.sh -> remote_cmd.sh
luncher.sh -> remote_cmd.sh
prepare.sh -> remote_cmd.sh
topswitch.sh -> remote_cmd.sh
finishall.sh -> remote_cmd.sh
reboot.sh -> remote_sbin.sh
poweroff.sh -> remote_sbin.sh
shutdown.sh -> remote_sbin.sh

### Management back-end 

start.sh -> wake-on-lan
deploy.sh ->
docker.sh
lastapp.sh -> remote.sh scp
remote.sh -> ssh   (Main working horse)
remote_cmd.sh
remote_sbin.sh
default_update.sh
topswitch_update.sh

### Helpers:
* forall.sh
* init.sh
* refresh.sh -> init.sh
* sync.sh -> ssh, rsync or lftp
* status.sh -> remote.sh, ping
start.sh -> [?? remote.sh ??]

deploy.sh -> remote.sh, [?? sync.sh / rsync ??] scp
docker.sh -> remote.sh
lastapp.sh -> status.sh + ssh
remote_cmd.sh -> remote.sh
remote_sbin.sh -> remote.sh
default_update.sh -> default.sh
default_update.sh -> lastapp.sh

topswitch_update.sh -> topswitch.sh
topswitch_update.sh -> lastapp.sh

status.sh -> remote.sh + ssh

refresh.sh -> init.sh

remote.sh -> ssh

lastapp.sh -> ssh 

sync.sh -> lftp, ssh, rsync


## Station-side low-level implementations (only accessible via SSH):

NOTE: all of the following work with Station's config cache (e.g. ~/.config/dockapp/)

* luncher.sh -> docker-compose (Main working horse) + lastapp.cfg
This is usually the basis for higher-level scripts like `default.sh`, `finishall.sh`, `topswitch.sh`.

* default.sh   -> luncher.sh + lastapp.cfg
* finishall.sh -> luncher.sh + lastapp.cfg
* topswitch.sh -> luncher.sh + lastapp.cfg
* prepare.sh   -> luncher.sh + lastapp.cfg [?? +finishall.sh ?? +ptmx.sh ??]
[* ptmx.sh (misc. helper)]




