# vi: set ft=yaml.jinja :

racoon:
  pkg.installed:   []
  service.running:
    - enable:      True
    - reload:      True
    - watch:
      - pkg:       racoon

/etc/racoon/racoon-tool.conf:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/racoon/racoon-tool.conf
    - user:        root
    - group:       root
    - mode:       '0644'
    - watch:
      - pkg:       racoon
    - watch_in:
      - service:   racoon
