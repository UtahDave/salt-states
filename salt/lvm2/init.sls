# vi: set ft=yaml.jinja :

lvm2:
  pkg.installed:   []

/etc/lvm/lvm.conf:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/lvm/lvm.conf
    - user:        root
    - group:       root
    - mode:       '0644'
    - watch:
      - pkg:       lvm2
