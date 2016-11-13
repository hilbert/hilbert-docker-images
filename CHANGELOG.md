# Change Log

## [Unreleased]

### Added
- [Semantic Versioning](http://semver.org/)
- Changelog according to (http://keepachangelog.com/)
- License: Apache v2
- Git branching model

### Changed
- Restructurization/migration of older `malex984/dockapp` to `hilbert/hilbert-*`

### Security 
- Starting to remove `sudo` and `privileged` requirements 

### Deprecated
- Outdated images
- Scripts from POC Demo
- Vagrant/VirtualBox-related scripts


## [0.1.0] - 2016-09-02
### Added
- Monitoring server and agents
- Heartbeat Server and Clients + wrapper scripts
- Basic back-end management scripts for server and staions
- Integration of management scripts with the Dashboard's back-end server within `:mng`
- First working system prototype using manual configurations
- Kiosk: Web-Browser based on Electron

### Changed
- Switch of run-time from docker to docker-compose
- Station images can be pulled from a private registry

### Deprecated
- Outdated images

## 0.0.1 - 2015-08-13
### Added
- Run-time using docker
- General testing images with services and applications
- Proof-of-concept demo


[Unreleased]: https://github.com/hilbert/hilbert-docker-images/compare/v0.1.0...HEAD
[0.1.0]: https://github.com/hilbert/hilbert-docker-images/compare/v0.0.1...v0.1.0
