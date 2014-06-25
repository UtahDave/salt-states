# vi: set ft=yaml.jinja :

keepalived:
  pkg.installed:   []
  service.running:
    - enable:      True
    - watch:
      - pkg:       keepalived

/etc/keepalived/keepalived.conf:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/keepalived/keepalived.conf
    - user:        root
    - group:       root
    - mode:       '0644'
    - watch:
      - pkg:       keepalived
    - watch_in:
      - service:   keepalived
