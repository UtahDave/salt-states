# vi: set ft=yaml.jinja :

include:
  -  fleet.depend-git
  -  golang-go

extend:
  /usr/bin/fleet:
    file:
      - target:   /usr/local/src/fleet/bin/fleet
      - watch:
        - cmd:    /usr/local/src/fleet/build

/usr/local/src/fleet:
  file.directory:
    - user:        root
    - group:       root
    - mode:       '0755'

/usr/local/src/fleet/build:
  cmd.wait:
    - cwd:        /usr/local/src/fleet
    - env:
      - GOPATH:   /usr/local
    - require:
      - pkg:       golang-go
