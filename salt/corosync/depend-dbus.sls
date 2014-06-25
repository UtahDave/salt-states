# vi: set ft=yaml.jinja :

include:
  -  corosync

/etc/dbus-1/system.d/corosync-signals.conf:
  file.managed:
    - user:        root
    - group:       root
    - mode:       '0644'
    - watch:
      - pkg:       corosync
