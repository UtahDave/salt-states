# vi: set ft=yaml.jinja :

include:
  - .depend-supervisor
  -  neutron-common
  -  neutron-plugin-nec

neutron-plugin-nec-agent:
  pkg.installed:   []
{% if salt['config.get']('virtual_subtype') == 'Docker' %}
  service.dead:
    - enable:      False
{% else %}
  service.running:
    - enable:      True
{% endif %}
    - watch:
      - pkg:       neutron-plugin-nec-agent
#     - file:     /etc/neutron/api-paste.ini
      - file:     /etc/neutron/fwaas_driver.ini
      - file:     /etc/neutron/l3_agent.ini
      - file:     /etc/neutron/neutron.conf
#     - file:     /etc/neutron/policy.json
      - file:     /etc/neutron/vpn_agent.ini
      - file:     /etc/neutron/plugins/nec/nec.ini

/etc/neutron/rootwrap.d/nec-plugin.filters:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/neutron/rootwrap.d/nec-plugin.filters
    - user:        root
    - group:       root
    - mode:       '0644'
    - watch:
      - pkg:       neutron-plugin-nec-agent
