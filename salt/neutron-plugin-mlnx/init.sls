# vi: set ft=yaml.jinja :

include:
  -  neutron-common

neutron-plugin-mlnx:
  pkg.installed:   []

/etc/neutron/plugins/mlnx/mlnx_conf.ini:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/neutron/plugins/mlnx/mlnx_conf.ini
    - user:        root
    - group:       root
    - mode:       '0644'
    - watch:
      - pkg:       neutron-plugin-mlnx
