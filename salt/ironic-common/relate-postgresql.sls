# vi: set ft=yaml.jinja :

{% set minions = salt['roles.list_minions']('postgresql') %}

{% if minions['postgresql'] %}

include:
  -  ironic-common

/var/lib/ironic/ironic.sqlite:
  file.absent:
    - watch:
      - pkg:       ironic-common

{% endif %}
