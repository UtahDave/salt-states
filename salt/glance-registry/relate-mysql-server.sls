# vi: set ft=yaml.jinja :

{% set minions = salt['roles.list_minions']('mysql-server') %}

{% if minions['mysql-server'] %}

include:
  -  glance-registry

/var/lib/glance/glance.sqlite:
  file.absent:
    - watch:
      - pkg:       glance-registry

{% endif %}
