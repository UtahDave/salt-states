# vi: set ft=yaml.jinja :

ebtables:
  pkg.installed:   []
  service.running:
    - enable:      True
    - reload:      True
    - watch:
      - pkg:       ebtables

/etc/ethertypes:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/ethertypes
    - user:        root
    - group:       root
    - mode:       '0644'
    - watch:
      - pkg:       ebtables
    - watch_in:
      - service:   ebtables
