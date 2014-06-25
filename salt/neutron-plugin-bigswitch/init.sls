# vi: set ft=yaml.jinja :

include:
  -  neutron-common

neutron-plugin-bigswitch:
  pkg.installed:   []

/etc/neutron/plugins/bigswitch/restproxy.ini:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/neutron/plugins/bigswitch/restproxy.ini
    - user:        root
    - group:       root
    - mode:       '0644'
    - watch:
      - pkg:       neutron-plugin-bigswitch
