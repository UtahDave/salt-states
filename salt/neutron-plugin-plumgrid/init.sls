# vi: set ft=yaml.jinja :

include:
  -  neutron-common

neutron-plugin-plumgrid:
  pkg.installed:   []

/etc/neutron/plugins/plumgrid/plumgrid.ini:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/neutron/plugins/plumgrid/plumgrid.ini
    - user:        root
    - group:       root
    - mode:       '0644'
    - watch:
      - pkg:       neutron-plugin-plumgrid
