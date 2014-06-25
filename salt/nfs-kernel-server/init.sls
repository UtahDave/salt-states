# vi: set ft=yaml.jinja :

nfs-kernel-server:
  pkg.installed:   []
  service.running:
    - enable:      True
    - watch:
      - pkg:       nfs-kernel-server
