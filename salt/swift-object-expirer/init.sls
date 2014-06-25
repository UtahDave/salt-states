# vi: set ft=yaml.jinja :

include:
  - .depend-supervisor
  -  swift

swift-object-expirer:
  pkg.installed:   []
{% if salt['config.get']('virtual_subtype') == 'Docker' %}
  service.dead:
    - enable:      False
{% else %}
  service.running:
    - enable:      True
{% endif %}
    - watch:
      - pkg:       swift-object-expirer

/etc/swift/object-expirer.conf:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/swift/object-expirer.conf
    - user:        root
    - group:       root
    - mode:       '0644'
    - watch:
      - pkg:       swift-object-expirer
    - watch_in:
      - service:   swift-object-expirer
