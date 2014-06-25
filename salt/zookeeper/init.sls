# vi: set ft=yaml.jinja :

{% set codename =  salt['config.get']('lsb_distrib_codename') %}
{% set codename = 'precise' %}
{% set version  = 'cdh4' %}

include:
  -  cloudera-{{ version }}

zookeeper:
  pkg.installed:
   {% if salt['config.get']('os') == 'Ubuntu' %}
    - fromrepo: {{ codename }}-{{ version }}
   {% endif %}
    - require:
      - pkgrepo:   cloudera-{{ version }}

/usr/lib/zookeeper/bin/zkEnv.sh:
  file.append:
    - text:        []
    - watch:
      - pkg:       zookeeper
