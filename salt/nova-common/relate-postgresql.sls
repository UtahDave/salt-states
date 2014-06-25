# vi: set ft=yaml.jinja :

{% set minions = salt['roles.list_minions']('postgresql') %}

{% if minions['postgresql'] %}

include:
  -  nova-common

/var/lib/nova/nova.sqlite:
  file.absent:
    - watch:
      - pkg:       nova-common

{% endif %}
