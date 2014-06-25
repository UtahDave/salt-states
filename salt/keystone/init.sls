# vi: set ft=yaml.jinja :

include:
# - .depend-haproxy
  - .depend-supervisor

keystone:
  pkg.installed:   []
{% if salt['config.get']('virtual_subtype') == 'Docker' %}
  service.dead:
    - enable:      False
{% else %}
  service.running:
    - enable:      True
{% endif %}
    - watch:
      - pkg:       keystone

/etc/keystone/keystone.conf:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/keystone/keystone.conf
    - user:        root
    - group:       root
    - mode:       '0644'
    - watch:
      - pkg:       keystone
    - watch_in:
      - service:   keystone
