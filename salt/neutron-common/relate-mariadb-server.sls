# vi: set ft=yaml.jinja :

{% set minions = salt['roles.list_minions']('mariadb-server') %}

{% if minions['mariadb-server'] %}

include:
  -  neutron-common

/var/lib/neutron/neutron.sqlite:
  file.absent:
    - watch:
      - pkg:       neutron-common

{% endif %}
