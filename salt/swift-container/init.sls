# vi: set ft=yaml.jinja :

include:
  - .depend-supervisor
  -  swift

swift-container:
  pkg.installed:   []
{% if salt['config.get']('virtual_subtype') == 'Docker' %}
  service.dead:
    - enable:      False
{% else %}
  service.running:
    - enable:      True
{% endif %}
    - watch:
      - pkg:       swift-container

/etc/swift/container-server.conf:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/swift/container-server.conf
    - user:        root
    - group:       root
    - mode:       '0644'
    - watch:
      - pkg:       swift-container
    - watch_in:
      - service:   swift-container
