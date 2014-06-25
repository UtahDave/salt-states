# vi: set ft=yaml.jinja :

include:
  -  neutron-common

neutron-plugin-vmware:
  pkg.installed:   []

/etc/neutron/plugins/vmware/nsx.ini:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/neutron/plugins/vmware/nsx.ini
    - user:        root
    - group:       root
    - mode:       '0644'
    - watch:
      - pkg:       neutron-plugin-vmware
