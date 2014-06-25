# vi: set ft=yaml.jinja :

{% set codename =  salt['config.get']('lsb_distrib_codename') %}
{% set codename = 'precise' %}
{% set version  = 'cdh4' %}

include:
  - .depend-cron
  -  cloudera-{{ version }}

hbase:
  pkg.installed:
   {% if salt['config.get']('os') == 'Ubuntu' %}
    - fromrepo: {{ codename }}-{{ version }}
   {% endif %}
    - require:
      - pkgrepo:   cloudera-{{ version }}

/etc/hbase/conf.dist/hbase-env.sh:
  file.append:
    - text:        []
    - watch:
      - pkg:       hbase

/etc/hbase/conf.dist/hbase-site.xml:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/hbase/conf.dist/hbase-site.xml
    - user:        root
    - group:       root
    - mode:       '0644'
    - watch:
      - pkg:       hbase

/etc/hbase/conf.dist/regionservers:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/hbase/conf.dist/regionservers
    - user:        root
    - group:       root
    - mode:       '0644'
    - watch:
      - pkg:       hbase

/usr/lib/hbase/bin/snapshot.rb:
  file.managed:
    - source:      salt://{{ sls }}/usr/lib/hbase/bin/snapshot.rb
    - user:        root
    - group:       root
    - mode:       '0644'
    - require:
      - pkg:       hbase
