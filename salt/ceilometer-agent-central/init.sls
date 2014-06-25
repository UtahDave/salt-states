# vi: set ft=yaml.jinja :

include:
  - .depend-supervisor
  -  ceilometer-common

ceilometer-agent-central:
  pkg.installed:   []
{% if salt['config.get']('virtual_subtype') == 'Docker' %}
  service.dead:
    - enable:      False
{% else %}
  service.running:
    - enable:      True
{% endif %}
    - watch:
      - pkg:       ceilometer-agent-central
      - file:     /etc/ceilometer/ceilometer.conf
#     - file:     /etc/ceilometer/pipeline.yaml
#     - file:     /etc/ceilometer/policy.json
#     - file:     /etc/ceilometer/sources.json
