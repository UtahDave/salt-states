# vi: set ft=yaml.jinja :

{% set minions = salt['roles.list_minions']('mariadb-server') %}

{% if minions['mariadb-server'] %}

include:
  -  glance-registry

/var/lib/glance/glance.sqlite:
  file.absent:
    - watch:
      - pkg:       glance-registry

{% endif %}
