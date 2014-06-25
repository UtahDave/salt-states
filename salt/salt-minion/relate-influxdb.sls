# vi: set ft=yaml.jinja :

{% set minions = salt['roles.list_minions']('influxdb') %}
{% set psls    = sls.split('.')[0] %}

include:
  -  python-influxdb
  -  salt-minion

{% if minions['influxdb'] %}

/etc/salt/minion.d/influxdb.conf:
  file.managed:
    - template:    jinja
    - source:      salt://{{ psls }}/etc/salt/minion.d/influxdb.conf
    - user:        root
    - group:       root
    - mode:       '0644'
    - require:
      - pkg:       python-influxdb
      - pkg:       salt-minion
    - watch_in:
      - service:   salt-minion

{% endif %}
