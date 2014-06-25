# vi: set ft=yaml.jinja :

include:
  -  neutron-common

neutron-plugin-ryu:
  pkg.installed:   []

/etc/neutron/plugins/ryu/ryu.ini:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/neutron/plugins/ryu/ryu.ini
    - user:        root
    - group:       root
    - mode:       '0644'
    - watch:
      - pkg:       neutron-plugin-ryu
