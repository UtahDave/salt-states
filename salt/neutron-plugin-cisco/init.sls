# vi: set ft=yaml.jinja :

include:
  -  neutron-common

neutron-plugin-cisco:
  pkg.installed:   []

/etc/neutron/plugins/cisco/cisco_plugins.ini:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/neutron/plugins/cisco/cisco_plugins.ini
    - user:        root
    - group:       root
    - mode:       '0644'
    - watch:
      - pkg:       neutron-plugin-cisco

/etc/neutron/plugins/cisco/cisco_vpn_agent.ini:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/neutron/plugins/cisco/cisco_vpn_agent.ini
    - user:        root
    - group:       root
    - mode:       '0644'
    - watch:
      - pkg:       neutron-plugin-cisco
