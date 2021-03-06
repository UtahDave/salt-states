# vi: set ft=yaml.jinja :

{% set version = '1.4' %}

{% if   salt['config.get']('os_family') == 'RedHat' %}

logstash:
  pkgrepo:
    name:          logstash
    file:         /etc/yum.repos.d/logstash.repo

/etc/default/logstash:
  file:
    name:         /etc/sysconfig/logstash

{% elif salt['config.get']('os_family') == 'Debian' %}

logstash:
  pkgrepo:
    name:          deb http://packages.elasticsearch.org/logstash/{{ version }}/debian stable main
    file:         /etc/apt/sources.list.d/logstash.list

/etc/default/logstash:
  file:
    name:         /etc/default/logstash

{% endif %}
