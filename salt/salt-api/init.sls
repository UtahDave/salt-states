# vi: set ft=yaml.jinja :

salt-api:
  pkg.installed:   []
  service.running:
    - enable:      True
    - watch:
      - pkg:       salt-api
