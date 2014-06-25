# vi: set ft=yaml.jinja :

include:
  - .depend-supervisor
  -  neutron-common
  -  neutron-plugin-ml2

neutron-plugin-openflow-agent:
  pkg.installed:   []
{% if salt['config.get']('virtual_subtype') == 'Docker' %}
  service.dead:
    - enable:      False
{% else %}
  service.running:
    - enable:      True
{% endif %}
    - watch:
      - pkg:       neutron-plugin-openflow-agent
#     - file:     /etc/neutron/api-paste.ini
      - file:     /etc/neutron/fwaas_driver.ini
      - file:     /etc/neutron/l3_agent.ini
      - file:     /etc/neutron/neutron.conf
#     - file:     /etc/neutron/policy.json
      - file:     /etc/neutron/vpn_agent.ini
      - file:     /etc/neutron/plugins/ml2/ml2_conf.ini
      - file:     /etc/neutron/plugins/ml2/ml2_conf_arista.ini
      - file:     /etc/neutron/plugins/ml2/ml2_conf_brocade.ini
      - file:     /etc/neutron/plugins/ml2/ml2_conf_cisco.ini
      - file:     /etc/neutron/plugins/ml2/ml2_conf_mlnx.ini
      - file:     /etc/neutron/plugins/ml2/ml2_conf_ncs.ini
      - file:     /etc/neutron/plugins/ml2/ml2_conf_odl.ini
      - file:     /etc/neutron/plugins/ml2/ml2_conf_ofa.ini
