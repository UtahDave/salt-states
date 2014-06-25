# vi: set ft=yaml.jinja :

{% set minions = salt['roles.list_minions']('mariadb-server') %}

{% if minions['mariadb-server'] %}

include:
  -  nova-common

/var/lib/nova/nova.sqlite:
  file.absent:
    - watch:
      - pkg:       nova-common

{% endif %}
