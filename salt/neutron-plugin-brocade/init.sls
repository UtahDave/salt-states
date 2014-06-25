# vi: set ft=yaml.jinja :

include:
  -  neutron-common

neutron-plugin-brocade:
  pkg.installed:   []

/etc/neutron/plugins/brocade/brocade.ini:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/neutron/plugins/brocade/brocade.ini
    - user:        root
    - group:       root
    - mode:       '0644'
    - watch:
      - pkg:       neutron-plugin-brocade
