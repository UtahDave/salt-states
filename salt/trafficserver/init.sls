# vi: set ft=yaml.jinja :

trafficserver:
  pkg.installed:   []
  service.running:
    - enable:      True
    - watch:
      - pkg:       trafficserver
