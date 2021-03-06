# vi: set ft=yaml.jinja :

{% set minions = salt['roles.list_minions']('postgresql') %}
{% set psls    = sls.split('.')[0] %}

include:
  -  python-psycopg2
  -  salt-minion

{% if minions['postgresql'] %}

/etc/salt/minion.d/postgresql.conf:
  file.managed:
    - template:    jinja
    - source:      salt://{{ psls }}/etc/salt/minion.d/postgresql.conf
    - user:        root
    - group:       root
    - mode:       '0644'
    - require:
      - pkg:       python-psycopg2
      - pkg:       salt-minion
    - watch_in:
      - service:   salt-minion

{% endif %}
