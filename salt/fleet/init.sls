# vi: set ft=yaml.jinja :

include:
# - .depend-golang-go
  - .depend-supervisor
  -  fleet-common

/etc/fleet:
  file.directory:
    - user:        root
    - group:       root
    - mode:       '0755'

/etc/fleet/fleet.conf:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/fleet/fleet.conf
    - user:        root
    - group:       root
    - mode:       '0644'
    - require:
      - file:     /etc/fleet

/usr/bin/fleet:
  file.symlink:
    - target:     /usr/share/fleet/fleet
    - watch:
      - file:     /usr/share/fleet
