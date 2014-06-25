# vi: set ft=yaml.jinja :

{% set codename =  salt['config.get']('lsb_distrib_codename') %}
{% set codename = 'precise' %}
{% set version  = 'cdh4' %}

include:
  - .depend-e2fsprogs
  - .depend-mount
  - .depend-parted
  -  hadoop

hadoop-hdfs:
  pkg.installed:
   {% if salt['config.get']('os') == 'Ubuntu' %}
    - fromrepo: {{ codename }}-{{ version }}
   {% endif %}
    - require:
      - pkgrepo:   cloudera-{{ version }}

/etc/hadoop/conf.empty/hdfs-site.xml:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/hadoop/conf.empty/hdfs-site.xml
    - user:        root
    - group:       root
    - mode:       '0644'
    - watch:
      - pkg:       hadoop-hdfs

/var/lib/hadoop-hdfs/cache/hdfs:
  file.directory:
    - user:        hdfs
    - group:       hadoop
    - mode:       '0755'
    - require:
      - pkg:       hadoop-hdfs

/var/lib/hadoop-hdfs/cache/hdfs/dfs:
  file.directory:
    - user:        hdfs
    - group:       hadoop
    - mode:       '0755'
    - require:
      - file:     /var/lib/hadoop-hdfs/cache/hdfs
