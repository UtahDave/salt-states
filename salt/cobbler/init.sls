# vi: set ft=yaml.jinja :

include:
  -  cobbler-common

cobbler:
  pkg.installed:   []
  service.running:
    - enable:      True
    - watch:
      - pkg:       cobbler
