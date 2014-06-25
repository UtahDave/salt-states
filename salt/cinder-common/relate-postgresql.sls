# vi: set ft=yaml.jinja :

{% set minions = salt['roles.list_minions']('postgresql') %}

{% if minions['postgresql'] %}

include:
  -  cinder-common

/var/lib/cinder/cinder.sqlite:
  file.absent:
    - watch:
      - pkg:       cinder-common

{% endif %}
