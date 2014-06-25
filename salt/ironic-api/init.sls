# vi: set ft=yaml.jinja :

include:
  - .depend-supervisor
  -  ironic-common

ironic-api:
  pkg.installed:   []
{% if salt['config.get']('virtual_subtype') == 'Docker' %}
  service.dead:
    - enable:      False
{% else %}
  service.running:
    - enable:      True
{% endif %}
    - watch:
      - pkg:       ironic-api
      - file:     /etc/ironic/ironic.conf
#     - file:     /etc/ironic/policy.json
