# vi: set ft=yaml.jinja :

{% set minions = salt['roles.list_minions']('logstash') %}
{% set psls    = sls.split('.')[0] %}

include:
  -  salt-minion

{% if minions['logstash'] %}

/etc/salt/minion.d/log.conf:
  file.managed:
    - template:    jinja
    - source:      salt://{{ psls }}/etc/salt/minion.d/log.conf
    - user:        root
    - group:       root
    - mode:       '0644'
    - require:
      - pkg:       salt-minion
    - watch_in:
      - service:   salt-minion

{% else %}

/etc/salt/minion.d/log.conf:
  file.absent:
    - watch_in:
      - service:   salt-minion

{% endif %}
