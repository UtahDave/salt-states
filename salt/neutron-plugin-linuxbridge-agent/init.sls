# vi: set ft=yaml.jinja :

include:
  - .depend-supervisor
  -  bridge-utils
  -  neutron-common
  -  neutron-plugin-linuxbridge

neutron-plugin-linuxbridge-agent:
  pkg.installed:   []
{% if salt['config.get']('virtual_subtype') == 'Docker' %}
  service.dead:
    - enable:      False
{% else %}
  service.running:
    - enable:      True
{% endif %}
    - watch:
      - pkg:       neutron-plugin-linuxbridge-agent
#     - file:     /etc/neutron/api-paste.ini
      - file:     /etc/neutron/fwaas_driver.ini
      - file:     /etc/neutron/l3_agent.ini
      - file:     /etc/neutron/neutron.conf
#     - file:     /etc/neutron/policy.json
      - file:     /etc/neutron/vpn_agent.ini
      - file:     /etc/neutron/plugins/linuxbridge/linuxbridge_conf.ini

/etc/neutron/rootwrap.d/linuxbridge-plugin.filters:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/neutron/rootwrap.d/linuxbridge-plugin.filters
    - user:        root
    - group:       root
    - mode:       '0644'
    - watch:
      - pkg:       neutron-plugin-linuxbridge-agent
