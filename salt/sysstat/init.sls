# vi: set ft=yaml.jinja :

sysstat:
  pkg.installed:
    - order:      -1
  service.running:
    - enable:      True
    - reload:      True
    - watch:
      - pkg:       sysstat
