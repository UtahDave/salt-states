# vi: set ft=yaml.jinja :

include:
  - .depend-supervisor
  -  haproxy
  -  neutron-common

neutron-lbaas-agent:
  pkg.installed:   []
{% if salt['config.get']('virtual_subtype') == 'Docker' %}
  service.dead:
    - enable:      False
{% else %}
  service.running:
    - enable:      True
{% endif %}
    - watch:
      - pkg:       neutron-lbaas-agent
#     - file:     /etc/neutron/api-paste.ini
      - file:     /etc/neutron/fwaas_driver.ini
      - file:     /etc/neutron/l3_agent.ini
      - file:     /etc/neutron/neutron.conf
#     - file:     /etc/neutron/policy.json
      - file:     /etc/neutron/vpn_agent.ini

/etc/neutron/lbaas_agent.ini:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/neutron/lbaas_agent.ini
    - user:        root
    - group:       neutron
    - mode:       '0644'
    - watch:
      - pkg:       neutron-lbaas-agent
    - watch_in:
      - service:   neutron-lbaas-agent

/etc/neutron/rootwrap.d/lbaas-haproxy.filters:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/neutron/rootwrap.d/lbaas-haproxy.filters
    - user:        root
    - group:       root
    - mode:       '0644'
    - watch:
      - pkg:       neutron-lbaas-agent
