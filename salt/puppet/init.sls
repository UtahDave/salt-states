# vi: set ft=yaml.jinja :

puppet:
  pkg.installed:   []
  service.running:
    - enable:      True
    - watch:
      - pkg:       puppet
