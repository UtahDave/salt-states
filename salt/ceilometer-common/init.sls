# vi: set ft=yaml.jinja :

ceilometer-common:
  pkg.installed:   []

/etc/ceilometer/ceilometer.conf:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/ceilometer/ceilometer.conf
    - user:        ceilometer
    - group:       ceilometer
    - mode:       '0644'
    - watch:
      - pkg:       ceilometer-common

/var/lock/ceilometer:
  file.directory:
    - user:        ceilometer
    - group:       ceilometer
    - mode:       '0755'
    - require:
      - pkg:       ceilometer-common

/var/run/ceilometer:
  file.directory:
    - user:        ceilometer
    - group:       ceilometer
    - mode:       '0755'
    - require:
      - pkg:       ceilometer-common
