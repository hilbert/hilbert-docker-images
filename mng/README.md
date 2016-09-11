# Management scripts

![Management structure](mng.png)

## General notes:

* Exit codes may be as follows (see `status.sh`, others will be updated):
  * 0: success
  * 1: detected error which is not our fault (e.g. network / HW etc): user can try again
  * 2: error due to wrong usage of scripts / in config files or some assumption was violated. 
  * other positive values: something unexpected has happened.

* One may need to capture both `STDOUT` and `STDERR`. Error messages (in `STDERR`) that are meant to be presented to users (admins) must be as informative as possible.

## UI Back-end: high-level action scripts (see `dockapp_dashboard/server/scripts/`)

* `list_stations.sh`: reads current config cache (`STATIONS/`)

* `start_station.sh`: start stopped station
  1. `start.sh $station_id`: initiates station power-on (e.g. via WOL)
  2. `deploy.sh $station_id`: transfer neccessary configs/scripts if update is necessary (station may have nothing yet)
  3. `prepare.sh $station_id`: post-action upon changes due to above deployment
  4. `default_update.sh $station_id`: default framework start on the station (all BG services and GUI application) + updates server's copy of station's `lastapp.cfg`

* `appchange_station.sh`: switch GUI applicaiton running on the station
  1. `topswitch_update.sh $station_id $app_id`: switches GUI app. on the station + updates server's copy of station's `lastapp.cfg`

* `stop_station.sh`: stop station
  1. `finishall.sh $station_id`: gracefully finish (stop / kill / remove) all running framework' services
  2. `shutdown.sh $station_id -h now`: initiate system shutdown (with power-off) of the station (alternative: `poweroff.sh $station_id`)

NOTE: rebooting the station can be done with: `shutdown.sh STATION -r now` or `reboot.sh STATION`

* TODO(?): To be done once before front-end starts & upon request from CMS (external trigger!):
  1. `sync.sh` (to synchronize local cache `STATIONS/` with station configs & scripts from CMS) 

## Server-side scripts (wrappers for generic interface):

* these scripts are to be directly accessible by high-level action scripts (described above) only. 
* they all currently require server's config cache (`./STATIONS/`) to be alongside with them.
* All server-side management scripts (save for `forall.sh` helper) take non-empty `STATION_ID` handle as the 1st argument and require proper station configurations folder `./STATIONS/STATION_ID/`
* All valid and active station handles are listed in `./STATIONS/list` (leading `#` means a commented-out line)
* Arguments coming AFTER the leading `STATION_ID` argument to server-side management scripts will be forwarded AS IS to the corresponding command run on the station.

* `start.sh STATION_ID [WAKE_UP_ARGS]`: tries to initiate a powering-on (e.g. via wake-on-lan) for the station specified by `STATION_ID`
* `deploy.sh STATION_ID`: deploys the content of config cache (`./STATIONS/STATION_ID/)` to the specified station via `scp` (or `sync.sh`)
* `prepare.sh STATION_ID`: prepares the station for framework execution. To be run once after any changes to station configs or management scripts (e.g. due to deployment/package installation)
* `default.sh STATION_ID`: lunch all BG services and the specified (by default or cached choice) GUI app. on the station
* `topswitch.sh STATION_ID APP2`: stop/kill the current GUI .app and start APP2
* `finishall.sh STATION_ID`: stop/kill all BG services and the current GUI app on the station
* `lastapp.sh STATION_ID`: retrieve station's `lastapp.cfg` and cache it on the server (in `./STATIONS/STATION_ID/`)

### Helpers: 
* `remote.sh STATION_ID CMD ARGS`: runs the command specified by `CMD ARGS` on the station via `ssh`. This is the main working-horse for the rest of management scripts. 
* `docker.sh STATION_ID ARGS`: run `docker ARGS` on the station
* `launcher.sh STATION_ID COMPOSE_CMD_WITH_ARGS`: run `docker-compose COMPOSE_CMD_WITH_ARGS` on the remote station within corresponding configuration directory (e.g. `~/.config/dockapp/`) with all the deployed configuration files after reading the necessary station configs.

NOTE: uses `SSH_OPTS` from Station configuration folder (see `station.cfg` and `access.cfg`) to do password-less command execution via `ssh`. 

NOTE: it is assumed that the station's user has password-less permissions to run the commands.

* `remote_cmd.sh`: helper to run station-side scripts with the same name (see `./template/*.sh`)
* `remote_sbin.sh`: helper for running corresponding system commands on the station:
  * `reboot.sh STATION_ID [ARGS]` (run `sudo -n -P /usr/sbin/reboot ARGS` on the station)
  * `poweroff.sh STATION_ID [ARGS]` (run `sudo -n -P /usr/sbin/poweroff ARGS` on the station)
  * `shutdown.sh STATION_ID [ARGS]` (run `sudo -n -P /usr/sbin/shutdown ARGS` on the station)
 NOTE that these system commands require password-less permissions on the target station.
* `./forall.sh SERVER_SIDE_SCRIPT_BASENAME ADDITIONAL_ARGUMENTS_FOR_SCRIPT`: for all valid and active `STATION_ID` in `./STATIONS/list` runs: `./SERVER_SIDE_SCRIPT_BASENAME.sh $STATION_ID ADDITIONAL_ARGUMENTS_FOR_SCRIPT`. 

NOTE: the last helper may be replaced with argument to server-side scripts instead of leading station-id argument.

## Station-side low-level implementations (only accessible via SSH):

NOTE: all of the following start from within station's config. cache (e.g. `~/.config/dockapp/`)

* `prepare.sh`: prepares the station for framework execution. To be run once after any changes to station configs or management scripts (e.g. due to deployment/package installation). May update station's `lastapp.cfg`.
* `default.sh`: lunch all BG services and the specified (by default or cached choice) GUI app. on the station. May update station's `lastapp.cfg`.
* `topswitch.sh APP2`: stop/kill the current GUI .app and start APP2. May update station's `lastapp.cfg`.
* `finishall.sh`: stop/kill all BG services and the current GUI app on the station. May update station's `lastapp.cfg`.
* `launcher.sh COMPOSE_CMD_WITH_ARGS`: run `docker-compose COMPOSE_CMD_WITH_ARGS` within corresponding configuration directory (e.g. `~/.config/dockapp/`) with all the config files after reading the necessary ones.
This is the basis for higher-level scripts (`default.sh`, `finishall.sh`, `topswitch.sh` and `prepare.sh`).
* `ptmx.sh`: misc. helper to try workaround docker setting wrong permissions on system's `/dev/pts/ptmx`

NOTE: currently `lastapp.cfg` is in `/tmp/` and exports a single shell env. variable specifying the current GUI app.

# Current configuration files and scripts 

NOTE: these files are originally in `./templates/`, for each station will be put into an individual subfolder of `./STATIONS/`, to be deployed into `~/.config/dockapp/` on each station.

* `station.cfg`: main data fields (as shell variables) about the station. May only be changed manually via CMS.

NOTE: the rest of configs and scripts should be removed from here once the development is finished.

* `startup.cfg`: determine BG & default FG out of station_type  (from `station.cfg`)
* `access.cfg`: determine system access parameters for the station
* `compose.cfg`, `docker.cfg`, `docker-compose.yml`: determine station local SW configuration (docker, X11, pulseaudio etc) for proper docker-compose functioning.
* `luncher.sh`, `finishall.sh`, `default.sh`, `prepare.sh`, `topswitch.sh`: actual action scripts to be deployed to the station. 
* `ptmx.sh`: workaround for docker glitch. To be run by prepare.sh


# Server management back-end (other deps):

start.sh -> wake-on-lan
lastapp.sh -> remote.sh, scp / sync?
remote.sh -> ssh
status.sh -> remote.sh + ping  (+ssh?)
start.sh -> [?? remote.sh ??]
deploy.sh -> remote.sh, [?? sync.sh / rsync ??] scp
lastapp.sh -> status.sh + ssh
remote.sh -> ssh
lastapp.sh -> ssh 
sync.sh -> ssh, rsync or lftp

# Virtual Methods: generic interface

default.sh -> remote_cmd.sh
luncher.sh -> remote_cmd.sh
prepare.sh -> remote_cmd.sh
topswitch.sh -> remote_cmd.sh
finishall.sh -> remote_cmd.sh

reboot.sh -> remote_sbin.sh
poweroff.sh -> remote_sbin.sh
shutdown.sh -> remote_sbin.sh


# Adding new station / Initial generation:

## Details on station configuration file `STATIONS/` StationID `/station.cfg` (under development)

see the current template in `dockapp/mng/templates/station.cfg`

* Generate initial configuration folder: `init.sh station [STATION_TYPE]`
  1. e.g. `init.sh new-station-id simple` (station type/profile: `simple`)
  1. `init.sh new-station-id simple`
* Refresh station configuration in case of template/station-side-scripts changes: `refresh.sh StationID`?

* transfer all the configs to corresponding station: `deploy.sh StationID` + 
port-deployment action: `prepare.sh StationID`

* start with default services and TOP GUI app.: `default.sh StationID`

* One can now add 'StationID' (by its fixed host-name or IP if static) to OMD (**local** URL: supernova.mfo.de/default) according to http://blog.unicsolution.com/2014/02/how-to-setup-omd-in-1-hour.html (section: Start Monitoring Target Hosts)

