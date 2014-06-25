# vi: set ft=yaml.jinja :

{% set minions = salt['roles.list_minions']('elasticsearch') %}
{% set psls    = sls.split('.')[0] %}

include:
  -  python-elasticsearch
  -  salt-minion

{% if minions['elasticsearch'] %}

/etc/salt/minion.d/elasticsearch.conf:
  file.managed:
    - template:    jinja
    - source:      salt://{{ psls }}/etc/salt/minion.d/elasticsearch.conf
    - user:        root
    - group:       root
    - mode:       '0644'
    - require:
      - pkg:       python-elasticsearch
      - pkg:       salt-minion
    - watch_in:
      - service:   salt-minion

{% endif %}
