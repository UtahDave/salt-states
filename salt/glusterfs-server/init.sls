# vi: set ft=yaml.jinja :

glusterfs-server:
  pkg.installed:   []
  service.running:
    - enable:      True
    - watch:
      - pkg:       glusterfs-server
