# vi: set ft=yaml.jinja :

apt-cacher-ng:
  pkg.installed:   []
  service.running:
    - enable:      True
    - watch:
      - pkg:       apt-cacher-ng
