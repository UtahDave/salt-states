# vi: set ft=yaml.jinja :

include:
  - .depend-supervisor
  -  swift

swift-object:
  pkg.installed:   []
{% if salt['config.get']('virtual_subtype') == 'Docker' %}
  service.dead:
    - enable:      False
{% else %}
  service.running:
    - enable:      True
{% endif %}
    - watch:
      - pkg:       swift-object

/etc/swift/object-server.conf:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/swift/object-server.conf
    - user:        root
    - group:       root
    - mode:       '0644'
    - watch:
      - pkg:       swift-object
    - watch_in:
      - service:   swift-object
