# vi: set ft=yaml.jinja :

include:
  -  neutron-common

neutron-plugin-ibm:
  pkg.installed:   []

/etc/neutron/plugins/ibm/sdnve_neutron_plugin.ini:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/neutron/plugins/ibm/sdnve_neutron_plugin.ini
    - user:        root
    - group:       root
    - mode:       '0644'
    - watch:
      - pkg:       neutron-plugin-ibm
