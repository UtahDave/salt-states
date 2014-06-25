# vi: set ft=yaml.jinja :

pacemaker:
  pkg.installed:   []
  service.running:
    - enable:      True
    - reload:      True
    - watch:
      - pkg:       pacemaker
