# vi: set ft=yaml.jinja :

{% set minions = salt['roles.list_minions']('mariadb-server') %}

{% if minions['mariadb-server'] %}

include:
  -  keystone

/var/lib/keystone/keystone.db:
  file.absent:
    - watch:
      - pkg:       keystone

{% endif %}
