# vi: set ft=yaml.jinja :

{% set minions = salt['roles.list_minions']('logstash') %}

{% if minions['logstash'] %}

include:
  -  beaver
  -  libzmq3-dev

{% endif %}
