# vi: set ft=yaml.jinja :

include:
  - .depend-sudo
  -  netbase

nova-common:
  pkg.installed:   []

/etc/nova/nova.conf:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/nova/nova.conf
    - user:        nova
    - group:       nova
    - mode:       '0640'
    - watch:
      - pkg:       nova-common

/var/lock/nova:
  file.directory:
    - user:        nova
    - group:       root
    - mode:       '0755'
    - require:
      - pkg:       nova-common

/var/run/nova:
  file.directory:
    - user:        nova
    - group:       root
    - mode:       '0755'
    - require:
      - pkg:       nova-common
