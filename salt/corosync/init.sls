# vi: set ft=yaml.jinja :

include:
  - .depend-dbus

corosync:
  pkg.installed:   []
  service.running:
    - enable:      True
    - watch:
      - pkg:       corosync

/etc/corosync/corosync.conf:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/corosync/corosync.conf
    - user:        root
    - group:       root
    - mode:       '0644'
    - watch:
      - pkg:       corosync
    - watch_in:
      - service:   corosync
