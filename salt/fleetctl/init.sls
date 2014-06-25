# vi: set ft=yaml.jinja :

include:
# - .depend-golang-go
  -  fleet-common

/usr/bin/fleetctl:
  file.symlink:
    - target:     /usr/share/fleet/fleetctl
    - watch:
      - file:     /usr/share/fleet
