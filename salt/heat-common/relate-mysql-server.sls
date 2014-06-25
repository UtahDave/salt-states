# vi: set ft=yaml.jinja :

{% set minions = salt['roles.list_minions']('mysql-server') %}

{% if minions['mysql-server'] %}

include:
  -  heat-common

/var/lib/heat/heat.sqlite:
  file.absent:
    - watch:
      - pkg:       heat-common

{% endif %}
