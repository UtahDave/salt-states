# vi: set ft=yaml.jinja :

oozie:
  pkg.installed:   []
  service.running:
    - enable:      True
    - watch:
      - pkg:       oozie
