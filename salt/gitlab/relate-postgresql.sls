# vi: set ft=yaml.jinja :

{% set minions = salt['roles.list_minions']('postgresql') %}

{% if minions['postgresql'] %}

include:
  -  postgresql

{% endif %}
