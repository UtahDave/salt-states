# vi: set ft=yaml.jinja :

open-iscsi:
  pkg.installed:   []
  service.running:
    - enable:      True
    - reload:      True
    - watch:
      - pkg:       open-iscsi

/etc/iscsi/iscsid.conf:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/iscsi/iscsid.conf
    - user:        root
    - group:       root
    - mode:       '0644'
    - watch:
      - pkg:       open-iscsi
    - watch_in:
      - service:   open-iscsi
