# vi: set ft=yaml.jinja :

privoxy:
  pkg.installed:   []
  service.running:
    - enable:      True
    - watch:
      - pkg:       privoxy

/etc/privoxy/config:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/privoxy/config
    - user:        root
    - group:       root
    - mode:       '0644'
    - watch:
      - pkg:       privoxy
    - watch_in:
      - service:   privoxy
