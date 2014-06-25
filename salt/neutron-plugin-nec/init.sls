# vi: set ft=yaml.jinja :

include:
  -  neutron-common

neutron-plugin-nec:
  pkg.installed:   []

/etc/neutron/plugins/nec/nec.ini:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/neutron/plugins/nec/nec.ini
    - user:        root
    - group:       root
    - mode:       '0644'
    - watch:
      - pkg:       neutron-plugin-nec
