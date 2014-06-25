# vi: set ft=yaml.jinja :

{% set psls = sls.split('.')[0] %}

include:
  -  haproxy

extend:
  /etc/haproxy/haproxy.cfg:
    file:
      - source:    salt://{{ psls }}/etc/haproxy/haproxy.cfg
