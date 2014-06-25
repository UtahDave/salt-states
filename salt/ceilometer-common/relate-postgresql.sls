# vi: set ft=yaml.jinja :

{% set minions = salt['roles.list_minions']('postgresql') %}

{% if minions['postgresql'] %}

include:
  -  ceilometer-common

/var/lib/ceilometer/ceilometer.sqlite:
  file.absent:
    - watch:
      - pkg:       ceilometer-common

{% endif %}
