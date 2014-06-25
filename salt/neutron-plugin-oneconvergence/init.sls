# vi: set ft=yaml.jinja :

include:
  -  neutron-common

neutron-plugin-oneconvergence:
  pkg.installed:   []

/etc/neutron/plugins/oneconvergence/nvsdplugin.ini:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/neutron/plugins/oneconvergence/nvsdplugin.ini
    - user:        root
    - group:       root
    - mode:       '0644'
    - watch:
      - pkg:       neutron-plugin-oneconvergence
