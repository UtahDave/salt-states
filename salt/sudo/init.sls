# vi: set ft=yaml.jinja :

sudo:
  pkg.installed:   []
  service.running:
    - enable:      True
    - reload:      True
    - watch:
      - pkg:       sudo

/etc/sudoers:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/sudoers
    - user:        root
    - group:       root
    - mode:       '0440'
    - watch:
      - pkg:       sudo
    - watch_in:
      - service:   sudo
