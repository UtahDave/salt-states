# vi: set ft=yaml.jinja :

include:
  -  fleet.depend-golang-go

extend:
  /usr/bin/fleetctl:
    file:
      - target:   /usr/local/src/fleet/bin/fleetctl
      - watch:
        - cmd:    /usr/local/src/fleet/build
