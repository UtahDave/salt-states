# vi: set ft = ini.jinja :

sheepdog:
  pkg.installed:   []
  service.running:
    - enable:      True
    - watch:
      - pkg:       sheepdog
