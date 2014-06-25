# vi: set ft=yaml.jinja :

include:
  -  neutron-common

neutron-plugin-metaplugin:
  pkg.installed:   []

/etc/neutron/plugins/metaplugin/metaplugin.ini:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/neutron/plugins/metaplugin/metaplugin.ini
    - user:        root
    - group:       root
    - mode:       '0644'
    - watch:
      - pkg:       neutron-plugin-metaplugin
