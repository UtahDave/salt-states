# vi: set ft=yaml.jinja :

include:
  - .depend-supervisor
  -  ceilometer-common

ceilometer-alarm-notifier:
  pkg.installed:   []
{% if salt['config.get']('virtual_subtype') == 'Docker' %}
  service.dead:
    - enable:      False
{% else %}
  service.running:
    - enable:      True
{% endif %}
    - watch:
      - pkg:       ceilometer-alarm-notifier
      - file:     /etc/ceilometer/ceilometer.conf
#     - file:     /etc/ceilometer/pipeline.yaml
#     - file:     /etc/ceilometer/policy.json
#     - file:     /etc/ceilometer/sources.json
