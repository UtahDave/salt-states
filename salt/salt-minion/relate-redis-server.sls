# vi: set ft=yaml.jinja :

{% set minions = salt['roles.list_minions']('redis-server') %}
{% set psls    = sls.split('.')[0] %}

include:
  -  python-redis
  -  salt-minion

{% if minions['redis-server'] %}

/etc/salt/minion.d/redis-server.conf:
  file.managed:
    - template:    jinja
    - source:      salt://{{ psls }}/etc/salt/minion.d/redis-server.conf
    - user:        root
    - group:       root
    - mode:       '0644'
    - require:
      - pkg:       python-redis
      - pkg:       salt-minion
    - watch_in:
      - service:   salt-minion

{% endif %}
