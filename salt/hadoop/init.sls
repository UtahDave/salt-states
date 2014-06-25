# vi: set ft=yaml.jinja :

{% set codename =  salt['config.get']('lsb_distrib_codename') %}
{% set codename = 'precise' %}
{% set version  = 'cdh4' %}

include:
  -  cloudera-{{ version }}

hadoop:
  pkg.installed:
   {% if salt['config.get']('os') == 'Ubuntu' %}
    - fromrepo: {{ codename }}-{{ version }}
   {% endif %}
    - require:
      - pkgrepo:   cloudera-{{ version }}

/etc/hadoop/conf.empty/core-site.xml:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/hadoop/conf.empty/core-site.xml
    - user:        root
    - group:       hadoop
    - mode:       '0644'
    - require:
      - pkg:       hadoop

/etc/hadoop/conf.empty/hadoop-env.sh:
  file.managed:
    - watch:
      - pkg:       hadoop

/etc/hadoop/conf.empty/masters:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/hadoop/conf.empty/masters
    - user:        root
    - group:       hadoop
    - mode:       '0644'
    - require:
      - pkg:       hadoop
