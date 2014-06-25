# vi: set ft=yaml.jinja :

include:
  -  neutron-common

neutron-plugin-midonet:
  pkg.installed:   []

/etc/neutron/plugins/midonet/midonet.ini:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/neutron/plugins/midonet/midonet.ini
    - user:        root
    - group:       root
    - mode:       '0644'
    - watch:
      - pkg:       neutron-plugin-midonet
