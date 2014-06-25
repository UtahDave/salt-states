# vi: set ft=yaml.jinja :

{% set codename =  salt['config.get']('lsb_distrib_codename') %}
{% set codename = 'precise' %}
{% set version  = 'cdh4' %}
{% set roles    = [] %}
{% do  roles.append('cloudera-cm4-server') %}
{% do  roles.append('cloudera-cm5-server') %}
{% set minions = salt['roles.list_minions'](roles) %}

include:
  {% if   minions['cloudera-cm4-server'] %}
  -  cloudera-cm4-agent
  {% elif minions['cloudera-cm5-server'] %}
  -  cloudera-cm5-agent
  {% else %}
  -  hbase
  -  oracle-j2sdk1_6
  {% endif %}

{% if minions['cloudera-cm4-server']
   or minions['cloudera-cm5-server'] %}

hbase-regionserver:
  pkg.removed:
    - require:
      - service:   hbase-regionserver
    - require_in:
      - cloudera_parcel:     CDH
  service.dead:
    - enable:      False

{% else %}

hbase-regionserver:
  pkg.installed:
   {% if   salt['config.get']('os') == 'Ubuntu' %}
    - fromrepo: {{ codename }}-{{ version }}
   {% endif %}
    - require:
      - pkgrepo:   cloudera-{{ version }}
  service.running:
    - enable:      True
    - reload:      True
    - watch:
      - pkg:       hbase-regionserver
      - file:     /etc/hbase/conf.dist/hbase-site.xml

{% endif %}
