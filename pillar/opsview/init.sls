# vi: set ft=yaml.jinja :

{% set codename =  salt['config.get']('lsb_distrib_codename') %}
{% set codename = 'precise' %}

{% if   salt['config.get']('os_family') == 'RedHat' %}

opsview:
  pkgrepo:
    name:          opsview
    file:         /etc/yum.repos.d/opsview.repo
    key_url:       http://archive.cloudera.com/cdh4/redhat/6/x86_64/cdh/RPM-GPG-KEY-cloudera

{% elif salt['config.get']('os_family') == 'Debian' %}

opsview:
  pkgrepo:
    name:          deb [arch=amd64] http://downloads.opsview.com/opsview-core/latest/apt {{ codename }} main
    file:         /etc/apt/sources.list.d/opsview.list
    key_url:       http://archive.cloudera.com/cdh4/ubuntu/{{ codename }}/amd64/cdh/archive.key

{% endif %}
