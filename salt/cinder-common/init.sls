# vi: set ft=yaml.jinja :

include:
  - .depend-sudo

cinder-common:
  pkg.installed:   []

/etc/cinder/cinder.conf:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/cinder/cinder.conf
    - user:        cinder
    - group:       cinder
    - mode:       '0644'
    - watch:
      - pkg:       cinder-common

/var/lock/cinder:
  file.directory:
    - user:        cinder
    - group:       root
    - mode:       '0755'
    - require:
      - pkg:       cinder-common

/var/run/cinder:
  file.directory:
    - user:        cinder
    - group:       cinder
    - mode:       '0755'
    - require:
      - pkg:       cinder-common
