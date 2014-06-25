# vi: set ft=yaml.jinja :

{% set nodename = salt['config.get']('nodename') %}

netbase:
  pkg.installed:
    - name:     {{ salt['config.get']('netbase:pkg:name') }}

127.0.0.1:
  host.absent:
    - name:     {{ nodename }}
    - ip:          127.0.0.1

127.0.1.1:
  host.absent:
    - name:     {{ nodename }}
    - ip:          127.0.1.1
