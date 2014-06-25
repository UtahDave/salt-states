# vi: set ft=yaml.jinja :

smartmontools:
  pkg.installed:   []
  service.running:
    - name:        smartd
    - enable:      True
    - watch:
      - pkg:       smartmontools
