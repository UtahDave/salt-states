# vi: set ft=yaml.jinja :

{% set minions = salt['roles.list_minions']('mongodb-server') %}
{% set psls    = sls.split('.')[0] %}

include:
  -  python-pymongo
  -  salt-minion

{% if minions['mongodb-server'] %}

/etc/salt/minion.d/mongodb-server.conf:
  file.managed:
    - template:    jinja
    - source:      salt://{{ psls }}/etc/salt/minion.d/mongodb-server.conf
    - user:        root
    - group:       root
    - mode:       '0644'
    - require:
      - pkg:       python-pymongo
      - pkg:       salt-minion
    - watch_in:
      - service:   salt-minion

{% endif %}
