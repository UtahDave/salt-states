# vi: set ft=yaml.jinja :

{% set minions = salt['roles.list_minions']('mysql-server') %}

{% if minions['mysql-server'] %}

include:
  -  ironic-common

/var/lib/ironic/ironic.sqlite:
  file.absent:
    - watch:
      - pkg:       ironic-common

{% endif %}
