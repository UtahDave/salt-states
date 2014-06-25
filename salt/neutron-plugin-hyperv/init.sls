# vi: set ft=yaml.jinja :

include:
  -  neutron-common

neutron-plugin-hyperv:
  pkg.installed:   []

/etc/neutron/plugins/hyperv/hyperv_neutron_plugin.ini:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/neutron/plugins/hyperv/hyperv_neutron_plugin.ini
    - user:        root
    - group:       root
    - mode:       '0644'
    - watch:
      - pkg:       neutron-plugin-hyperv
