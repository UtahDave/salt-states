# vi: set ft=yaml.jinja :

{% set minions = salt['roles.list_minions']('graphite-carbon') %}
{% set psls    = sls.split('.')[0] %}

include:
  -  collectd

{% if minions['graphite-carbon'] %}

/etc/collectd.d/{{ psls }}.conf:
  file.managed:
    - source:      salt://{{ psls }}/etc/collectd.d/{{ psls }}.conf
    - user:        root
    - group:       root
    - mode:       '0644'
    - require:
      - pkg:       collectd
    - watch_in:
      - service:   collectd

{% else %}

/etc/collectd.d/{{ psls }}.conf:
  file.absent:
    - watch_in:
      - service:   collectd

{% endif %}
