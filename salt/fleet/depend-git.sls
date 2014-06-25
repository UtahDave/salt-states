# vi: set ft=yaml.jinja :

include:
  -  git
  -  fleet

extend:
  /usr/local/src/fleet/build:
    cmd:
      - watch:
        - git:     https://github.com/coreos/fleet.git

https://github.com/coreos/fleet.git:
  git.latest:
    - rev:         master
    - target:     /usr/local/src/fleet
    - require:
      - pkg:       git
      - file:     /usr/local/src/fleet
