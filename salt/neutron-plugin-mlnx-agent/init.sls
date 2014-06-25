# vi: set ft=yaml.jinja :

include:
  - .depend-supervisor
  -  neutron-plugin-mlnx

neutron-plugin-mlnx-agent:
  pkg.installed:   []
{% if salt['config.get']('virtual_subtype') == 'Docker' %}
  service.dead:
    - enable:      False
{% else %}
  service.running:
    - enable:      True
{% endif %}
    - watch:
      - pkg:       neutron-plugin-mlnx-agent
#     - file:     /etc/neutron/api-paste.ini
      - file:     /etc/neutron/fwaas_driver.ini
      - file:     /etc/neutron/l3_agent.ini
      - file:     /etc/neutron/neutron.conf
#     - file:     /etc/neutron/policy.json
      - file:     /etc/neutron/vpn_agent.ini
      - file:     /etc/neutron/plugins/mlnx/mlnx_conf.ini
