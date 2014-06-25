# vi: set ft=yaml.jinja :

{% set repository  = 'https://github.com/khrisrichardson/salt-states.git' %}
{% set refs        =  salt['cmd.run']('git ls-remote --heads ' + repository + ' | rev | cut -d/ -f1 | rev').split('\n') %}
{% if                 salt['grains.get']('environment') in refs %}
{% set environment =  salt['grains.get']('environment') %}
{% else %}
{% set environment = 'base' %}
{% endif %}

{{ environment }}:
  '*':
    - apache2
    - base-files
    - bash
    - ceph-common
    - cloudera-cdh4
    - cloudera-cdh5
    - cloudera-cm4
    - cloudera-cm5
    - cloudera-cm4-api
    - cloudera-cm5-api
    - collectd
    - cron
    - elasticsearch
    - graphite-carbon
    - graphite-web
    - gunicorn
    - incron
    - libvirt-bin
    - libzmq3-dev
    - logstash
    - multipath-tools
    - mysql-common
    - mysql-server
    - nagios-plugins-basic
    - netbase
    - netcat
    - nginx
    - nginx-common
    - ntp
    - openssh-server
    - oracle-j2sdk1_6
    - oracle-j2sdk1_7
    - oracle-java6-installer
    - oracle-java7-installer
    - php5
    - php5-cli
    - php5-curl
    - php5-fpm
    - php5-json
    - php5-mbstring
    - php5-mcrypt
    - postgresql
    - procps
    - python-openssl
    - radosgw
    - redis-server
    - salt-minion
    - salt-ssh
    - sensu
    - supervisor
    - uuid-runtime
    - vim
