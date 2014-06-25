# vi: set ft=yaml.jinja :

{% set minions = salt['roles.list_minions']('mysql-server') %}

{% if minions['mysql-server'] %}

include:
  -  keystone

/var/lib/keystone/keystone.db:
  file.absent:
    - watch:
      - pkg:       keystone

{% endif %}
