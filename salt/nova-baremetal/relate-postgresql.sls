# vi: set ft=yaml.jinja :

{% set minions = salt['roles.list_minions']('postgresql') %}

{% if minions['postgresql'] %}

include:
  -  nova-baremetal

/var/lib/nova/baremetal-nova.sqlite:
  file.absent:
    - watch:
      - pkg:       nova-baremetal

{% endif %}
