# vi: set ft=yaml.jinja :

include:
  -  neutron-common

neutron-plugin-linuxbridge:
  pkg.installed:   []

/etc/neutron/plugins/linuxbridge/linuxbridge_conf.ini:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/neutron/plugins/linuxbridge/linuxbridge_conf.ini
    - user:        root
    - group:       root
    - mode:       '0644'
    - watch:
      - pkg:       neutron-plugin-linuxbridge
