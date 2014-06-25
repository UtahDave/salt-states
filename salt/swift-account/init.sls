# vi: set ft=yaml.jinja :

include:
  - .depend-supervisor
  -  swift

swift-account:
  pkg.installed:   []
{% if salt['config.get']('virtual_subtype') == 'Docker' %}
  service.dead:
    - enable:      False
{% else %}
  service.running:
    - enable:      True
{% endif %}
    - watch:
      - pkg:       swift-account

/etc/swift/account-server.conf:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/swift/account-server.conf
    - user:        root
    - group:       root
    - mode:       '0644'
    - watch:
      - pkg:       swift-account
    - watch_in:
      - service:   swift-account
