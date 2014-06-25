# vi: set ft=yaml.jinja :

include:
  - .depend-sudo

ironic-common:
  pkg.installed:   []

/etc/ironic/ironic.conf:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/ironic/ironic.conf
    - user:        ironic
    - group:       ironic
    - mode:       '0644'
    - watch:
      - pkg:       ironic-common

/var/lock/ironic:
  file.directory:
    - user:        ironic
    - group:       root
    - mode:       '0755'
    - require:
      - pkg:       ironic-common

/var/run/ironic:
  file.directory:
    - user:        ironic
    - group:       root
    - mode:       '0755'
    - require:
      - pkg:       ironic-common
