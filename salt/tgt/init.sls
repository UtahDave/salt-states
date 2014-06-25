# vi: set ft=yaml.jinja :

tgt:
  pkg.installed:   []
  service.running:
    - enable:      True
    - reload:      True
    - watch:
      - pkg:       tgt

/etc/tgt/targets.conf:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/tgt/targets.conf
    - user:        root
    - group:       root
    - mode:       '0644'
    - watch:
      - pkg:       tgt
    - watch_in:
      - service:   tgt
