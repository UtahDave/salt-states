# vi: set ft=yaml.jinja :

{% set minions = salt['roles.list_minions']('mysql-server') %}

{% if minions['mysql-server'] %}

include:
  -  glance-api

/var/lib/glance/glance.sqlite:
  file.absent:
    - watch:
      - pkg:       glance-api

{% endif %}
